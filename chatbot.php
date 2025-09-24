<?php
ini_set('display_errors', 0); // Se recomienda 0 para producción
ini_set('display_startup_errors', 0); // Se recomienda 0 para producción
error_reporting(E_ALL);

// Dependencias
require_once "db.php";
require_once "contextos/master-context.php";

// --- HERRAMIENTAS DEL BOT ---
function verificarDisponibilidad($conexion, $fecha_inicio, $fecha_fin, $tipo_habitacion = null) {
    $subquery = "SELECT DISTINCT id_habitacion FROM reservas WHERE fecha_salida > ? AND fecha_ingreso < ?";
    $stmt_ocupadas = $conexion->prepare($subquery);
    if (!$stmt_ocupadas) return [];
    $stmt_ocupadas->bind_param("ss", $fecha_inicio, $fecha_fin);
    $stmt_ocupadas->execute();
    $res_ocupadas = $stmt_ocupadas->get_result();
    $ids_ocupadas = [];
    while ($row = $res_ocupadas->fetch_assoc()) { $ids_ocupadas[] = $row['id_habitacion']; }
    $stmt_ocupadas->close();

    $query = "SELECT id, estilo, capacidad, precio FROM habitaciones WHERE estado = 1";
    $params = [];
    $types = "";

    if (!empty($ids_ocupadas)) {
        $placeholders = implode(',', array_fill(0, count($ids_ocupadas), '?'));
        $query .= " AND id NOT IN ($placeholders)";
        $params = array_merge($params, $ids_ocupadas);
        $types .= str_repeat('i', count($ids_ocupadas));
    }

    if ($tipo_habitacion) {
        $query .= " AND estilo LIKE ?";
        $tipo_habitacion_limpio = str_replace(['habitación', 'habitacion'], '', $tipo_habitacion);
        $params[] = "%" . trim($tipo_habitacion_limpio) . "%";
        $types .= "s";
    }

    $query .= " ORDER BY precio ASC";
    $stmt_disponibles = $conexion->prepare($query);
    if (!$stmt_disponibles) return [];
    if (!empty($params)) { $stmt_disponibles->bind_param($types, ...$params); }
    $stmt_disponibles->execute();
    $res_disponibles = $stmt_disponibles->get_result();

    $habitaciones_disponibles = [];
    while ($row = $res_disponibles->fetch_assoc()) { $habitaciones_disponibles[] = $row; }
    $stmt_disponibles->close();
    return $habitaciones_disponibles;
}

function llamarAGemini($prompt_texto) {
    $gemini_url = "https://generativelanguage.googleapis.com/v1beta/models/" . GEMINI_MODEL . ":generateContent?key=" . GEMINI_API_KEY;
    $payload = json_encode([ "contents" => [["parts" => [["text" => $prompt_texto]]]], "generationConfig" => [ "temperature" => 0.3, "topP" => 0.9, "topK" => 20, "maxOutputTokens" => 1024 ] ]);
    $ch = curl_init($gemini_url);
    curl_setopt_array($ch, [ CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_HTTPHEADER => ["Content-Type: application/json"], CURLOPT_POSTFIELDS => $payload, CURLOPT_TIMEOUT => 30 ]);
    
    $response_raw = curl_exec($ch);
    $curl_error = curl_error($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($curl_error || $http_code !== 200) {
        // Log del error para revisión interna
        $log_message = date('Y-m-d H:i:s') . " - cURL Error: " . $curl_error . " | HTTP Code: " . $http_code . "\n";
        file_put_contents(__DIR__ . '/logs/gemini_errors.log', $log_message, FILE_APPEND);
        return json_encode(["error" => "Problema de conexión con el asistente."]);
    }
    
    $decoded = json_decode($response_raw, true);
    return $decoded['candidates'][0]['content']['parts'][0]['text'] ?? json_encode(["error" => "Respuesta inesperada del asistente."]);
}

// --- LÓGICA PRINCIPAL ---
session_start();

if (!isset($_SESSION['user_id'])) {
    $_SESSION['user_id'] = "user_" . uniqid();
}
$user_id = $_SESSION['user_id'];

$mensaje = mb_strtolower(trim($_POST['mensaje'] ?? ''), 'UTF-8');
if (empty($mensaje)) {
    echo "Por favor, escribe un mensaje.";
    exit;
}

// Guardar mensaje del usuario
$mensaje_esc = $conexion->real_escape_string($mensaje);
$insert_query = "INSERT INTO historial_chat (user_id, mensaje_usuario, respuesta_bot) VALUES ('$user_id', '$mensaje_esc', '')";
$conexion->query($insert_query);
$last_insert_id = $conexion->insert_id;

// Obtener historial de conversación
$historial_str = "";
$res_historial = $conexion->query("SELECT mensaje_usuario, respuesta_bot FROM historial_chat WHERE user_id = '$user_id' AND respuesta_bot != '' ORDER BY fecha DESC LIMIT 8");
if ($res_historial) {
    $temp = [];
    while ($row = $res_historial->fetch_assoc()) {
        $temp[] = "Usuario: " . $row['mensaje_usuario'];
        $temp[] = "Bot: " . $row['respuesta_bot'];
    }
    $historial_str = implode("\n", array_reverse($temp));
}

// Configuración y construcción del prompt
define("GEMINI_API_KEY", ""); // ¡USA VARIABLES DE ENTORNO EN PRODUCCIÓN!
define("GEMINI_MODEL", "gemini-2.0-flash");
$master_context = generarMasterContext($conexion);
$master_context = str_replace('{{FECHA_ACTUAL}}', date('Y-m-d'), $master_context);

$prompt_fase1 = <<<PROMPT
$master_context
---
# CONVERSACIÓN ACTUAL
## Historial Reciente:
$historial_str
## Pregunta del Usuario:
"$mensaje"
---
Ahora, sigue tu proceso de razonamiento y genera tu PASO 1 y PASO 2.
PROMPT;

// FASE 1: Obtener respuesta y pensamiento del bot
$respuesta_fase1 = llamarAGemini($prompt_fase1);

// Limpiar el bloque de pensamiento para que nunca se muestre al usuario
$respuesta_limpia = preg_replace('/<pensamiento>.*?<\/pensamiento>/s', '', $respuesta_fase1);
$respuesta_limpia = trim($respuesta_limpia);

// Intentar extraer un JSON de la respuesta limpia
$datos_herramienta = null;
if (preg_match('/\{.*\}/s', $respuesta_limpia, $matches)) {
    $datos_herramienta = json_decode($matches[0], true);
}

$respuesta_final = "";

// ¿La acción es una llamada a herramienta válida?
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
            $resultado_sistema .= "- {$hab['estilo']} (Precio: S/{$hab['precio']} por noche)\n";
        }
    }
    
    $prompt_fase2 = <<<PROMPT
    # ROL: Eres un asistente de hotel.
    # TAREA: Informa al usuario sobre el resultado de su consulta de disponibilidad de forma amable y natural.
    - Pregunta Original del Usuario: "$mensaje"
    - Resultado de la consulta del sistema:
    $resultado_sistema
    PROMPT;

    $respuesta_final = llamarAGemini($prompt_fase2);

} else {
    // Si no es una llamada a herramienta, la respuesta limpia ya es la respuesta final para el usuario.
    $respuesta_final = $respuesta_limpia;
}

// Manejo de errores finales y salida
$check_error = json_decode($respuesta_final, true);
if (is_array($check_error) && isset($check_error['error'])) {
    $respuesta_final = "Lo siento, tuve un problema técnico. Por favor, intenta de nuevo más tarde.";
}

// Guardar respuesta final en la BD y mostrarla
$respuesta_esc = $conexion->real_escape_string($respuesta_final);
$conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

echo nl2br(htmlspecialchars($respuesta_final));
?>