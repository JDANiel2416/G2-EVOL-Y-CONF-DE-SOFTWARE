<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1); 
error_reporting(E_ALL);

// Dependencias
require_once "db.php";
require_once "contextos/master-context.php";


// --- HERRAMIENTAS DEL BOT ---

function verificarDisponibilidad($conexion, $fecha_inicio, $fecha_fin, $tipo_habitacion = null)
{
    $subquery = "SELECT DISTINCT id_habitacion FROM reservas WHERE fecha_salida > ? AND fecha_ingreso < ?";
    $stmt_ocupadas = $conexion->prepare($subquery);
    if (!$stmt_ocupadas) return [];
    $stmt_ocupadas->bind_param("ss", $fecha_inicio, $fecha_fin);
    $stmt_ocupadas->execute();
    $res_ocupadas = $stmt_ocupadas->get_result();
    $ids_ocupadas = [];
    while ($row = $res_ocupadas->fetch_assoc()) {
        $ids_ocupadas[] = $row['id_habitacion'];
    }
    $stmt_ocupadas->close();

    $query = "SELECT 
                    h.id, 
                    c.categoria,
                    h.capacidad, 
                    c.precio
                FROM 
                    habitaciones h
                JOIN 
                    categorias c ON h.id_categoria = c.id
                WHERE 
                    h.estado = 1 AND c.estado = 1";

    $params = [];
    $types = "";

    if (!empty($ids_ocupadas)) {
        $placeholders = implode(',', array_fill(0, count($ids_ocupadas), '?'));
        $query .= " AND h.id NOT IN ($placeholders)"; // Usamos el alias 'h'
        $params = array_merge($params, $ids_ocupadas);
        $types .= str_repeat('i', count($ids_ocupadas));
    }

    if ($tipo_habitacion) {
        $query .= " AND c.categoria LIKE ?";
        $tipo_habitacion_limpio = str_replace(['habitación', 'habitacion'], '', $tipo_habitacion);
        $params[] = "%" . trim($tipo_habitacion_limpio) . "%";
        $types .= "s";
    }

    $query .= " ORDER BY c.precio ASC";
    $stmt_disponibles = $conexion->prepare($query);

    if (!$stmt_disponibles) return [];

    if (!empty($params)) {
        $stmt_disponibles->bind_param($types, ...$params);
    }

    $stmt_disponibles->execute();
    $res_disponibles = $stmt_disponibles->get_result();

    $habitaciones_disponibles = [];
    while ($row = $res_disponibles->fetch_assoc()) {
        $habitaciones_disponibles[] = $row;
    }
    $stmt_disponibles->close();
    return $habitaciones_disponibles;
}

function llamarAGemini($prompt_texto)
{
    $gemini_url = "https://generativelanguage.googleapis.com/v1beta/models/" . GEMINI_MODEL . ":generateContent?key=" . GEMINI_API_KEY;
    $payload = json_encode([
        "contents" => [["parts" => [["text" => $prompt_texto]]]],
        "generationConfig" => ["temperature" => 0.7, "topP" => 0.9, "topK" => 20, "maxOutputTokens" => 1024]
    ]);
    
    $ch = curl_init($gemini_url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_HTTPHEADER => ["Content-Type: application/json"], CURLOPT_POSTFIELDS => $payload, CURLOPT_TIMEOUT => 30]);
    
    $response_raw = curl_exec($ch);
    $curl_error = curl_error($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($curl_error || $http_code !== 200) {
        $log_message = date('Y-m-d H:i:s') . " - cURL Error: " . $curl_error . " | HTTP Code: " . $http_code . "\n";
        file_put_contents(__DIR__ . '/logs/gemini_errors.log', $log_message, FILE_APPEND);
        return json_encode(["error" => "Problema de conexión con el asistente."]);
    }
    
    $decoded = json_decode($response_raw, true);
    return $decoded['candidates'][0]['content']['parts'][0]['text'] ?? json_encode(["error" => "Respuesta inesperada del asistente."]);
}

function limpiarRespuesta($respuesta) {
    // Remueve bloques de código markdown como ```text o ```json
    $respuesta = preg_replace('/^```[a-z]*\s*|\s*```$/m', '', $respuesta);
    return trim($respuesta);
}


// --- LÓGICA PRINCIPAL ---
session_start();

$db_user_id = "NULL";
if (isset($_SESSION['user_id']) && is_numeric($_SESSION['user_id'])) {
    $db_user_id = (int)$_SESSION['user_id'];
}

$mensaje = mb_strtolower(trim($_POST['mensaje'] ?? ''), 'UTF-8');
if (empty($mensaje)) {
    echo "Por favor, escribe un mensaje.";
    exit;
}

$mensaje_esc = $conexion->real_escape_string($mensaje);
$insert_query = "INSERT INTO historial_chat (user_id, mensaje_usuario, respuesta_bot) VALUES ($db_user_id, '$mensaje_esc', '')";
$conexion->query($insert_query);
$last_insert_id = $conexion->insert_id;

if (!isset($_SESSION['chat_history'])) {
    $_SESSION['chat_history'] = [];
}
$historial_str = implode("\n", $_SESSION['chat_history']);

// Configuración y construcción del prompt
define("GEMINI_API_KEY", ""); // ¡USA VARIABLES DE ENTORNO EN PRODUCCIÓN!
define("GEMINI_MODEL", "gemini-2.0-flash"); // Modelo actualizado

$master_context = generarMasterContext($conexion);
$master_context = str_replace('{{FECHA_ACTUAL}}', date('Y-m-d'), $master_context);

$prompt_fase1 = <<<PROMPT
$master_context

INSTRUCCIONES CLAVE:
- Tu respuesta DEBE ser texto plano y natural.
- NO uses formato Markdown, NUNCA uses ```, NUNCA uses bloques de código.
- Actúa como un asistente de hotel amigable y profesional.

---
# CONVERSACIÓN ACTUAL
## Historial Reciente:
$historial_str

## Pregunta del Usuario:
"$mensaje"

---
Genera tu razonamiento y tu respuesta final en texto plano.
PROMPT;

// FASE 1: Obtener respuesta y pensamiento del bot
$respuesta_fase1 = llamarAGemini($prompt_fase1);
$respuesta_limpia = preg_replace('/<pensamiento>.*?<\/pensamiento>/s', '', $respuesta_fase1);
$respuesta_limpia = limpiarRespuesta($respuesta_limpia);

// Intentar extraer una llamada a herramienta
$datos_herramienta = null;
if (preg_match('/\{.*\}/s', $respuesta_limpia, $matches)) {
    $datos_herramienta = json_decode($matches[0], true);
}

$respuesta_final = "";

if ($datos_herramienta && isset($datos_herramienta['tool_name']) && $datos_herramienta['tool_name'] === 'verificar_disponibilidad') {
    
    // FASE 2: Ejecutar la herramienta y formular la respuesta final
    $params = $datos_herramienta['parameters'];
    $disponibles = verificarDisponibilidad($conexion, $params['fecha_inicio'], $params['fecha_fin'], $params['tipo_habitacion'] ?? null);
    
    $resultado_sistema = "";
    if (empty($disponibles)) {
        $tipo_str = isset($params['tipo_habitacion']) ? "la habitación {$params['tipo_habitacion']}" : "habitaciones";
        $resultado_sistema = "Resultado de la consulta: No se encontró disponibilidad para $tipo_str del {$params['fecha_inicio']} al {$params['fecha_fin']}.";
    } else {
        $resultado_sistema = "Resultado de la consulta: Sí hay disponibilidad. Habitaciones encontradas:\n";
        foreach ($disponibles as $hab) {
            // CORRECCIÓN: Se usa 'categoria' en lugar de 'estilo'
            $resultado_sistema .= "- {$hab['categoria']} (Precio: S/{$hab['precio']} por noche)\n";
        }
    }
    
    $prompt_fase2 = <<<PROMPT
INSTRUCCIONES CLAVE:
- Eres un asistente de hotel amigable.
- Tu respuesta DEBE ser texto plano. NO uses formato Markdown ni ```.

# TAREA: Informa al usuario sobre el resultado de su consulta de forma natural.

Pregunta Original del Usuario: "$mensaje"
Resultado de la consulta del sistema:
$resultado_sistema
PROMPT;

    $respuesta_final = llamarAGemini($prompt_fase2);

} else {

    $respuesta_final = $respuesta_limpia;
}


$respuesta_final = limpiarRespuesta($respuesta_final);


$_SESSION['chat_history'][] = "Usuario: " . $mensaje;
$_SESSION['chat_history'][] = "Bot: " . $respuesta_final;
if (count($_SESSION['chat_history']) > 8) { 
    $_SESSION['chat_history'] = array_slice($_SESSION['chat_history'], -8);
}

$respuesta_esc = $conexion->real_escape_string($respuesta_final);
$conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

echo nl2br(htmlspecialchars($respuesta_final));
?>
