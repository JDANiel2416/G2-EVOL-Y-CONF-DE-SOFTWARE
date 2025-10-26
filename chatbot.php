<?php
ini_set('display_errors', 1); // Temporalmente en 1 para ver todos los avisos
ini_set('display_startup_errors', 1); // Temporalmente en 1
error_reporting(E_ALL);

// Dependencias
require_once "app/core/db.php";
require_once "app/contexts/master-context.php";

// =================================================================
// --- HERRAMIENTAS DEL BOT ---
// =================================================================

/**
 * CORREGIDO: Función para verificar disponibilidad usando la nueva estructura de BD.
 * Ahora utiliza un JOIN para obtener datos de 'categorias'.
 */
function verificarDisponibilidad($conexion, $fecha_inicio, $fecha_fin, $tipo_habitacion = null)
{
    // ... (Tu función de verificarDisponibilidad se mantiene exactamente igual) ...
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

    $query = "SELECT h.id, c.categoria, h.capacidad, c.precio FROM habitaciones h JOIN categorias c ON h.id_categoria = c.id WHERE h.estado = 1 AND c.estado = 1";
    $params = [];
    $types = "";

    if (!empty($ids_ocupadas)) {
        $placeholders = implode(',', array_fill(0, count($ids_ocupadas), '?'));
        $query .= " AND h.id NOT IN ($placeholders)";
        $params = array_merge($params, $ids_ocupadas);
        $types .= str_repeat('i', count($ids_ocupadas));
    }

    if ($tipo_habitacion) {
        // La condición ahora es sobre 'c.categoria'
        $query .= " AND c.categoria LIKE ?";
        $tipo_habitacion_limpio = str_replace(['habitación', 'habitacion'], '', $tipo_habitacion);
        $params[] = "%" . trim($tipo_habitacion_limpio) . "%";
        $types .= "s";
    }

    $query .= " ORDER BY c.precio ASC"; // Ordenamos por el precio de la categoría
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
    // ... (Tu función de llamarAGemini se mantiene exactamente igual) ...
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

function limpiarRespuesta($respuesta)
{
    // ... (Tu función de limpiarRespuesta se mantiene exactamente igual) ...
    $respuesta = preg_replace('/^```[a-z]*\s*|\s*```$/m', '', $respuesta);
    return trim($respuesta);
}


// =================================================================
// --- LÓGICA PRINCIPAL (MODIFICADA) ---
// =================================================================
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$mensaje = mb_strtolower(trim($_POST['mensaje'] ?? ''), 'UTF-8');
if (empty($mensaje)) {
    echo "Por favor, escribe un mensaje.";
    exit;
}

// 1. Detección de intención de REGISTRO
$palabras_clave_registro = ['registrarme', 'registro', 'crear una cuenta', 'inscribirme'];
$intencion_registro = false;
foreach ($palabras_clave_registro as $palabra) {
    if (strpos($mensaje, $palabra) !== false) {
        $intencion_registro = true;
        break;
    }
}

// 2. Detección de intención de LOGIN
$palabras_clave_login = ['iniciar sesión', 'iniciar sesion', 'login', 'entrar', 'acceder', 'loguear', 'loguearme'];
$intencion_login = false;
if (!$intencion_registro) {
    foreach ($palabras_clave_login as $palabra) {
        if (strpos($mensaje, $palabra) !== false) {
            $intencion_login = true;
            break;
        }
    }
}

// =================================================================
// --- NUEVO: VERIFICACIÓN DE SESIÓN ACTIVA ---
// Si el usuario intenta registrarse o loguearse pero ya tiene una sesión,
// le informamos y detenemos el script.
// =================================================================
if ( ($intencion_registro || $intencion_login) && isset($_SESSION['user_id']) ) {
    $nombre_usuario = htmlspecialchars($_SESSION['user_nombre']);
    $respuesta = "¡Hola, $nombre_usuario! Ya has iniciado sesión en tu cuenta. No necesitas registrarte ni acceder de nuevo. ¿Hay algo más en lo que pueda ayudarte?";
    echo $respuesta;
    exit; // Detenemos la ejecución aquí
}

// En chatbot.php
if ($intencion_registro) {
    $formulario_html = <<<HTML
    <p class="text-gray-800 dark:text-gray-200 mb-4">¡Perfecto! Vamos a crear tu cuenta. Por favor, completa los siguientes datos:</p>
    
    <div class="chat-form-container" id="registro-form">
        <div class="form-group">
            <label for="chat-dni">Tu DNI (8 dígitos)</label>
            <input type="text" id="chat-dni" placeholder="Escribe tu DNI y sal del campo..." maxlength="8">
            <small id="dni-attempts-msg">Intentos restantes: 2</small>
        </div>
        <div class="form-group">
            <label for="chat-nombre">Nombres</label>
            <input type="text" id="chat-nombre" placeholder="Se completará automáticamente" readonly>
        </div>
        <div class="form-group">
            <label for="chat-apellido">Apellidos</label>
            <input type="text" id="chat-apellido" placeholder="Se completará automáticamente" readonly>
        </div>
        <div class="form-group">
            <label for="chat-usuario">Nombre de Usuario</label>
            <input type="text" id="chat-usuario" placeholder="Ej: juanperez">
        </div>
        <div class="form-group">
            <label for="chat-correo">Correo Electrónico</label>
            <input type="email" id="chat-correo" placeholder="tu@correo.com">
        </div>
        <div class="form-group">
            <label for="chat-clave">Crea una Contraseña</label>
            <input type="password" id="chat-clave" placeholder="••••••••">
        </div>
        <div class="form-group">
            <label for="chat-confirmar">Confirmar Contraseña</label>
            <input type="password" id="chat-confirmar" placeholder="••••••••">
            <div id="password-match-msg"></div>
        </div>
        <div id="password-rules" class="password-requirements" style="display:none;">
            <p id="length-check" class="invalid"><i class="fas fa-times-circle"></i>Debe tener al menos 8 caracteres.</p>
            <p id="uppercase-check" class="invalid"><i class="fas fa-times-circle"></i>Debe contener una mayúscula.</p>
            <p id="number-check" class="invalid"><i class="fas fa-times-circle"></i>Debe contener un número.</p>
            <p id="special-check" class="invalid"><i class="fas fa-times-circle"></i>Debe contener un símbolo especial.</p>
        </div>
        <div class="form-condition">
            <input type="checkbox" id="chat-terminos">
            <label for="chat-terminos">Acepto los <a href="#" target="_blank">Términos y Condiciones</a>.</label>
        </div>
        <button id="chat-register-btn" class="default-btn" disabled>Crear Mi Cuenta</button>
        <div id="form-timer">Tiempo restante: 05:00</div>
    </div>
    <script>
        if (typeof inicializarFormularioRegistro === "function") { inicializarFormularioRegistro(); }
    </script>
HTML;
    echo $formulario_html;
    exit;
} elseif ($intencion_login) {
    // --- El usuario quiere iniciar sesión. ---

    // Revisar si está bloqueado por intentos fallidos
    if (isset($_SESSION['login_attempts']) && $_SESSION['login_attempts'] >= 5 && isset($_SESSION['login_wait_until']) && time() < $_SESSION['login_wait_until']) {
        $remaining = $_SESSION['login_wait_until'] - time();
        $mensaje_bloqueo = "<p class='text-red-500'>Has excedido el límite de intentos de inicio de sesión. Por favor, espera {$remaining} segundos antes de volver a intentarlo.</p>";
        echo $mensaje_bloqueo;
        exit;
    }

    // Si no está bloqueado, devolvemos el HTML del formulario de login.
    $formulario_html_login = <<<HTML
    <p class="text-gray-800 dark:text-gray-200 mb-4">¡Hola de nuevo! Para acceder a tu cuenta, por favor, completa tus datos:</p>
    
    <div class="chat-form-container" id="login-form">
        <div class="form-group">
            <label for="chat-login-user">Usuario o Correo Electrónico</label>
            <input type="text" id="chat-login-user" placeholder="Escribe tu usuario o correo">
        </div>
        <div class="form-group">
            <label for="chat-login-clave">Contraseña</label>
            <input type="password" id="chat-login-clave" placeholder="••••••••">
        </div>
        
        <div id="captcha-container" class="my-4 flex justify-center">
            <!-- RECUERDA CAMBIAR 'TU_SITEKEY_DE_TURNSTILE' por tu clave real -->
            <div class="cf-turnstile" data-sitekey="0x4AAAAAAA30cAZZr49ACK72" data-callback="onCaptchaVerified" data-theme="dark"></div>
        </div>
        
        <button id="chat-login-btn" class="default-btn" disabled>Ingresar</button>
        <small id="login-attempts-msg" class="form-text text-center mt-2"></small>
        
        <div class="login-links text-center mt-3">
            <a href="#" class="quick-question text-sm text-primary-500 hover:underline" data-question="Olvidé mi contraseña">¿Olvidaste tu contraseña?</a>
        </div>
    </div>

    <!-- Script para cargar el widget de Turnstile -->
    <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
    <script>
        // Llama a la función de inicialización del formulario de login
        if (typeof inicializarFormularioLogin === "function") {
            inicializarFormularioLogin();
        }
    </script>
HTML;

    echo $formulario_html_login;
    exit; // Detenemos la ejecución para no continuar con la lógica de la IA
}

// --- SI NO ES UNA ACCIÓN ESPECIAL, CONTINUAMOS CON LA LÓGICA NORMAL DE LA IA ---

// Determinar el ID de usuario para la base de datos (NULL si es anónimo)
$db_user_id = "NULL";
$session_id_str = "NULL";
$historial_condition = "";

if (isset($_SESSION['user_id']) && is_numeric($_SESSION['user_id'])) {
    // Usuario logueado
    $db_user_id = (int)$_SESSION['user_id'];
    $historial_condition = "user_id = $db_user_id";
} else {
    // Usuario anónimo
    if (!isset($_SESSION['chat_session_id'])) {
        $_SESSION['chat_session_id'] = 'anon_' . uniqid();
    }
    $session_id_str = "'" . $conexion->real_escape_string($_SESSION['chat_session_id']) . "'";
    $historial_condition = "session_id = $session_id_str";
}

// Guardar mensaje del usuario en la BD
$mensaje_esc = $conexion->real_escape_string($mensaje);
$insert_query = "INSERT INTO historial_chat (user_id, session_id, mensaje_usuario, respuesta_bot) VALUES ($db_user_id, $session_id_str, '$mensaje_esc', '')";
$conexion->query($insert_query);
$last_insert_id = $conexion->insert_id;

// Recuperar historial (ahora funciona para ambos tipos de usuario)
$historial_str = "";
$res_historial = $conexion->query("SELECT mensaje_usuario, respuesta_bot FROM historial_chat WHERE ($historial_condition) AND respuesta_bot != '' ORDER BY fecha DESC LIMIT 8");
if ($res_historial && $res_historial->num_rows > 0) {
    $temp = [];
    while ($row = $res_historial->fetch_assoc()) {
        $temp[] = "Usuario: " . $row['mensaje_usuario'];
        $temp[] = "Bot: " . $row['respuesta_bot'];
    }
    $historial_str = implode("\n", array_reverse($temp));
}

// Configuración y construcción del prompt
define("GEMINI_API_KEY", "AIzaSyAdo1i2V1qKC5sxzPARMQqVzFk-hiSs5Ek");
define("GEMINI_MODEL", "gemini-1.5-flash");
$master_context = generarMasterContext($conexion);
$master_context = str_replace('{{FECHA_ACTUAL}}', date('Y-m-d'), $master_context);

$prompt_fase1 = <<<PROMPT
$master_context
// ... (Tu prompt_fase1 se mantiene exactamente igual) ...
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

// ¿La acción es una llamada a herramienta válida?
if ($datos_herramienta && isset($datos_herramienta['tool_name']) && $datos_herramienta['tool_name'] === 'verificar_disponibilidad') {
    // ... (Tu lógica de FASE 2 se mantiene exactamente igual) ...
    $params = $datos_herramienta['parameters'];
    $disponibles = verificarDisponibilidad($conexion, $params['fecha_inicio'], $params['fecha_fin'], $params['tipo_habitacion'] ?? null);

    $resultado_sistema = "";
    if (empty($disponibles)) {
        $tipo_str = isset($params['tipo_habitacion']) ? "la habitación {$params['tipo_habitacion']}" : "habitaciones";
        $resultado_sistema = "Resultado de la consulta: No se encontró disponibilidad para $tipo_str del {$params['fecha_inicio']} al {$params['fecha_fin']}.";
    } else {
        $resultado_sistema = "Resultado de la consulta: Sí hay disponibilidad. Habitaciones encontradas:\n";
        foreach ($disponibles as $hab) {
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
    // Si no es una llamada a herramienta, la respuesta limpia es la respuesta final.
    $respuesta_final = $respuesta_limpia;
}

// Limpieza final de la respuesta
$respuesta_final = limpiarRespuesta($respuesta_final);

// Guardar en memoria de sesión para la próxima interacción
$_SESSION['chat_history'][] = "Usuario: " . $mensaje;
$_SESSION['chat_history'][] = "Bot: " . $respuesta_final;
if (count($_SESSION['chat_history']) > 8) {
    $_SESSION['chat_history'] = array_slice($_SESSION['chat_history'], -8);
}

// Guardar respuesta final en la BD y mostrarla
$respuesta_esc = $conexion->real_escape_string($respuesta_final);
$conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

echo nl2br(htmlspecialchars($respuesta_final));
