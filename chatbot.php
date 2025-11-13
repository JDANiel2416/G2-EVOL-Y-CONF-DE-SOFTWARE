<?php
require_once "app/core/session_manager.php"; // Movido aquí para usar la sesión desde el principio
// === CONFIGURACIÓN DE ERRORES Y DEPENDENCIAS ===
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once "app/core/db.php";
require_once "app/contexts/master-context.php";

// =================================================================
// --- FUNCIONES AUXILIARES Y HERRAMIENTAS DEL BOT ---
// =================================================================

function limpiarSesionInvalida($conexion)
{
    if (isset($_SESSION['user_id']) && is_numeric($_SESSION['user_id'])) {
        $user_id = (int)$_SESSION['user_id'];
        $stmt = $conexion->prepare("SELECT id FROM usuarios WHERE id = ? AND estado = 1");

        if ($stmt) {
            $stmt->bind_param("i", $user_id);
            $stmt->execute();
            $resultado = $stmt->get_result();
            $stmt->close();

            if ($resultado->num_rows === 0) {
                // El usuario no existe o está inactivo en la BD, la sesión es inválida.
                session_destroy();
                session_start(); // Inicia una nueva sesión limpia
                return true; // Sesión limpiada
            }
        }
    }
    return false; // Sesión válida o no había sesión que limpiar
}


function procesarFechasRelativas($texto)
{
    date_default_timezone_set('America/Lima');
    $texto_procesado = $texto;

    $mapeo_fechas = [
        '/\b(pasado\s+mañana)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('+2 days')) . ")";
        },
        '/\b(mañana)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('+1 day')) . ")";
        },
        '/\b(hoy)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d') . ")";
        },
        '/\b(el\s+próximo\s+lunes|el\s+lunes\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Monday')) . ")";
        },
        '/\b(el\s+próximo\s+martes|el\s+martes\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Tuesday')) . ")";
        },
        '/\b(el\s+próximo\s+mi[eé]rcoles|el\s+mi[eé]rcoles\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Wednesday')) . ")";
        },
        '/\b(el\s+próximo\s+jueves|el\s+jueves\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Thursday')) . ")";
        },
        '/\b(el\s+próximo\s+viernes|el\s+viernes\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Friday')) . ")";
        },
        '/\b(el\s+próximo\s+s[aá]bado|el\s+s[aá]bado\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Saturday')) . ")";
        },
        '/\b(el\s+próximo\s+domingo|el\s+domingo\s+que\s+viene)\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime('next Sunday')) . ")";
        },
        '/\b(en|dentro\s+de)\s+(\d+)\s+días?\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime("+{$m[2]} days")) . ")";
        },
        '/\b(en|dentro\s+de)\s+(\d+)\s+semanas?\b/i' => function ($m) {
            return "(fecha: " . date('Y-m-d', strtotime("+{$m[2]} weeks")) . ")";
        },
    ];

    foreach ($mapeo_fechas as $patron => $callback) {
        $texto_procesado = preg_replace_callback($patron, $callback, $texto_procesado);
    }

    return $texto_procesado;
}

/**
 * Herramienta para verificar la disponibilidad de habitaciones.
 */
/**
 * Herramienta para verificar la disponibilidad de habitaciones.
 * Busca la primera habitación disponible que cumpla con los criterios.
 *
 * @param mysqli $conexion Conexión a la base de datos.
 * @param string $fecha_inicio Fecha de llegada en formato Y-m-d.
 * @param string $fecha_fin Fecha de salida en formato Y-m-d.
 * @param string|null $tipo_habitacion Nombre del tipo de habitación a buscar.
 * @return array Un array asociativo con los datos de la habitación si se encuentra, o un array vacío si no hay disponibilidad.
 */
function verificarDisponibilidad($conexion, $fecha_inicio, $fecha_fin, $tipo_habitacion = null)
{
    // 1. Obtener IDs de habitaciones ocupadas en el rango de fechas
    $subquery = "SELECT DISTINCT id_habitacion FROM reservas WHERE fecha_salida > ? AND fecha_ingreso < ? AND estado = 'Confirmada'";
    $stmt_ocupadas = $conexion->prepare($subquery);
    if (!$stmt_ocupadas) {
        // Log de error o manejo de excepción sería ideal aquí
        return [];
    }
    $stmt_ocupadas->bind_param("ss", $fecha_inicio, $fecha_fin);
    $stmt_ocupadas->execute();
    $res_ocupadas = $stmt_ocupadas->get_result();
    $ids_ocupadas = [];
    while ($row = $res_ocupadas->fetch_assoc()) {
        $ids_ocupadas[] = $row['id_habitacion'];
    }
    $stmt_ocupadas->close();

    // 2. Construir la consulta principal para buscar habitaciones disponibles
    $query = "SELECT h.id, c.categoria, c.precio 
              FROM habitaciones h 
              JOIN categorias c ON h.id_categoria = c.id 
              WHERE h.estado = 1 AND c.estado = 1";

    $params = [];
    $types = "";

    // Excluir las habitaciones ocupadas si las hay
    if (!empty($ids_ocupadas)) {
        $placeholders = implode(',', array_fill(0, count($ids_ocupadas), '?'));
        $query .= " AND h.id NOT IN ($placeholders)";
        $params = array_merge($params, $ids_ocupadas);
        $types .= str_repeat('i', count($ids_ocupadas));
    }

    // Filtrar por tipo de habitación si se especifica
    if ($tipo_habitacion) {
        $query .= " AND c.categoria LIKE ?";
        // Limpiamos el input del usuario para una búsqueda más flexible
        $tipo_habitacion_limpio = preg_replace('/(habitación|habitacion|cuarto)/i', '', $tipo_habitacion);
        $params[] = "%" . trim($tipo_habitacion_limpio) . "%";
        $types .= "s";
    }

    // Ordenar por precio para ofrecer siempre la opción más económica primero y limitar a 1
    $query .= " ORDER BY c.precio ASC LIMIT 1";

    $stmt_disponibles = $conexion->prepare($query);

    if (!$stmt_disponibles) {
        return [];
    }

    // Vincular los parámetros si existen
    if (!empty($params)) {
        $stmt_disponibles->bind_param($types, ...$params);
    }

    $stmt_disponibles->execute();
    $res_disponibles = $stmt_disponibles->get_result();

    // 3. Devolver el resultado
    $habitacion_disponible = $res_disponibles->fetch_assoc();
    $stmt_disponibles->close();

    // Si fetch_assoc() no encontró nada, devolverá null. Lo convertimos a un array vacío para consistencia.
    return $habitacion_disponible ? $habitacion_disponible : [];
}

/**
 * Llama a la API de Gemini.
 */
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

/**
 * Limpia la respuesta del bot de formatos no deseados.
 */
function limpiarRespuesta($respuesta)
{
    $respuesta = preg_replace('/^```[a-z]*\s*|\s*```$/m', '', $respuesta);
    return trim($respuesta);
}


// =================================================================
// --- INICIO DE LA LÓGICA PRINCIPAL DEL SCRIPT ---
// =================================================================

// CORRECCIÓN 12: Llamar a la función de limpieza al inicio del script.
limpiarSesionInvalida($conexion);

// INTERCEPCIÓN ESPECIAL PARA EL TOKEN DE RECUPERACIÓN (Lógica interna, no del chat)
if (isset($_POST['mensaje']) && strpos($_POST['mensaje'], '[Internal] reset_password_with_token:') === 0) {
    $token = str_replace('[Internal] reset_password_with_token:', '', $_POST['mensaje']);

    function verificarTokenValido($conexion, $token)
    {
        $stmt = $conexion->prepare("SELECT id, correo FROM usuarios WHERE token = ? AND token_expiracion > NOW() AND token_estado = 1");
        if (!$stmt) return null;
        $stmt->bind_param("s", $token);
        $stmt->execute();
        $resultado = $stmt->get_result();
        $usuario = $resultado->fetch_assoc();
        $stmt->close();
        return $usuario;
    }

    $usuario = verificarTokenValido($conexion, $token);

    if ($usuario) {
        $formulario_html = <<<HTML
        <p class="text-gray-800 dark:text-gray-200 mb-4">¡Verificación exitosa! Por favor, establece tu nueva contraseña.</p>
        <div class="chat-form-container" id="cambiar-clave-form">
            <input type="hidden" id="chat-token-hidden" value="{$token}">
            <div class="form-group">
                <label for="chat-nueva-clave">Nueva Contraseña:</label>
                <input type="password" id="chat-nueva-clave" class="w-full" placeholder="••••••••">
            </div>
            <div class="form-group mt-2">
                <label for="chat-confirmar-clave">Confirmar Nueva Contraseña:</label>
                <input type="password" id="chat-confirmar-clave" class="w-full" placeholder="••••••••">
            </div>
            <button id="chat-cambiar-btn" class="default-btn mt-3">Restablecer Contraseña</button>
        </div>
HTML;
        echo $formulario_html;
    } else {
        echo "<p class='text-red-500'>Este enlace de recuperación no es válido o ya ha expirado. Por favor, solicita uno nuevo.</p>";
    }

    $conexion->close();
    exit;
}

// CORRECCIÓN 1: Guardar el mensaje ORIGINAL del usuario ANTES de cualquier procesamiento.
$mensaje_original_usuario = trim($_POST['mensaje'] ?? '');
if (empty($mensaje_original_usuario)) {
    header('Content-Type: application/json');
    echo json_encode(['respuesta' => "Por favor, escribe un mensaje.", 'historial_id' => null]);
    exit;
}

// --- **NUEVA LÓGICA DE VISIBILIDAD** ---
$mensaje_para_ia = mb_strtolower($mensaje_original_usuario, 'UTF-8');
$es_visible = true; // Por defecto, todos los mensajes son visibles
$es_accion_de_formulario = false; // Flag para saber si se mostró un formulario

$frases_ocultas = [
    'registrarme',
    'registro',
    'crear una cuenta',
    'inscribirme',
    'iniciar sesión',
    'iniciar sesion',
    'login',
    'entrar',
    'acceder',
    'loguear',
    'loguearme',
    'olvidé mi contraseña',
    'olvide mi contraseña',
    'olvide mi clave',
    'olvidé mi clave',
    'recuperar contraseña',
    'restablecer clave',
    'contraseña',
    'clave' // Estas son más genéricas, tener cuidado
];

// Si es un comando interno o contiene una frase clave, se marca como no visible
if (strpos($mensaje_original_usuario, '[Internal]') === 0) {
    $es_visible = false;
} else {
    foreach ($frases_ocultas as $frase) {
        if (strpos($mensaje_para_ia, $frase) !== false) {
            $es_visible = false;
            break;
        }
    }
}
// --- **FIN DE LA LÓGICA DE VISIBILIDAD** ---

// Determinar el ID de usuario/sesión para la BD
$db_user_id = "NULL";
$session_id_str = "NULL";
if (isset($_SESSION['user_id']) && is_numeric($_SESSION['user_id'])) {
    $db_user_id = (int)$_SESSION['user_id'];
} else {
    if (!isset($_SESSION['chat_session_id'])) {
        $_SESSION['chat_session_id'] = 'anon_' . uniqid();
    }
    $session_id_str = "'" . $conexion->real_escape_string($_SESSION['chat_session_id']) . "'";
}

// Guardar el mensaje del usuario en la BD inmediatamente
$mensaje_esc = $conexion->real_escape_string($mensaje_original_usuario);
$visible_int = (int)$es_visible; // Convertir booleano a 0 o 1
$insert_query = "INSERT INTO historial_chat (user_id, session_id, mensaje_usuario, respuesta_bot, visible_al_usuario) VALUES ($db_user_id, $session_id_str, '$mensaje_esc', '', $visible_int)";
$conexion->query($insert_query);
$last_insert_id = $conexion->insert_id;

// --- NUEVO: Lógica para manejar los comandos internos de los botones de acción ---
// Verificamos si el mensaje es un comando interno (empieza con '[Internal]')
// --- FASE 1 y 3: MANEJO DE COMANDOS INTERNOS DE LOS BOTONES ---
if (strpos($mensaje_original_usuario, '[Internal]') === 0) {

    // CASO 1: El usuario anónimo hace clic en "Asegurar Habitación y Pagar"
    if ($mensaje_original_usuario === '[Internal] request-login') {

        // Verificamos que realmente exista una pre-reserva en la sesión para evitar errores
        if (isset($_SESSION['pre_reserva'])) {
            $respuesta = "¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.";
        } else {
            // Caso de borde: el usuario hace clic en un botón de un chat antiguo donde la sesión ya expiró.
            $respuesta = "Lo siento, parece que los detalles de tu reserva han expirado. ¿Podrías indicarme de nuevo las fechas y el tipo de habitación que deseas?";
        }

        // Actualizamos el historial y enviamos la respuesta de texto.
        $respuesta_esc = $conexion->real_escape_string($respuesta);
        $conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");
        echo json_encode(['respuesta' => $respuesta, 'historial_id' => $last_insert_id]);
        exit;
    }

    // CASO 2: El usuario logueado hace clic en "Pagar S/ XX ahora"

    if ($mensaje_original_usuario === '[Internal] initiate-payment') {

        // 1. Verificación de seguridad: Asegurarse de que el usuario está en el estado correcto.
        if (isset($_SESSION['user_id']) && isset($_SESSION['pre_reserva'])) {

            // 2. Preparar el mensaje que el bot mostrará en el chat.
            $mensaje_para_chat = "¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...";

            // 3. Preparar la instrucción JSON para el frontend.
            //    Esto le dice a main.js que debe llamar a la función que renderiza el modal de pago.
            $instruccion_para_frontend = [
                'action' => 'initiate_payment_ui',
                'message' => $mensaje_para_chat
            ];

            // 4. Guardar el mensaje del bot en el historial de la base de datos.
            $respuesta_esc = $conexion->real_escape_string($mensaje_para_chat);
            $conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

            // 5. Enviar la instrucción al frontend y detener el script.
            header('Content-Type: application/json');
            echo json_encode($instruccion_para_frontend);
            exit;
        } else {
            // Manejo de error si el usuario llega aquí sin una sesión válida o sin una pre-reserva.
            $respuesta_error = "Lo siento, ha ocurrido un error al procesar tu solicitud de pago. Por favor, intenta realizar la consulta de reserva de nuevo.";

            $respuesta_esc = $conexion->real_escape_string($respuesta_error);
            $conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

            echo json_encode(['respuesta' => $respuesta_error, 'historial_id' => $last_insert_id]);
            exit;
        }
    }
}

// CORRECCIÓN 4: AHORA SÍ, creamos una copia del mensaje para procesarla y enviarla a la IA.
$mensaje_para_ia = mb_strtolower($mensaje_original_usuario, 'UTF-8');
$mensaje_para_ia = procesarFechasRelativas($mensaje_para_ia);

// CORRECCIÓN 5: Detección de intenciones usando el MENSAJE PROCESADO.
$palabras_clave_registro = ['registrarme', 'registro', 'crear una cuenta', 'inscribirme'];
$intencion_registro = false;
foreach ($palabras_clave_registro as $palabra) {
    if (strpos($mensaje_para_ia, $palabra) !== false) {
        $intencion_registro = true;
        break;
    }
}

$palabras_clave_login = ['iniciar sesión', 'iniciar sesion', 'login', 'entrar', 'acceder', 'loguear', 'loguearme'];
$intencion_login = false;
foreach ($palabras_clave_login as $palabra) {
    if (strpos($mensaje_para_ia, $palabra) !== false) {
        $intencion_login = true;
        break;
    }
}

$palabras_clave_recuperar = ['olvidé mi contraseña', 'olvide mi contraseña', 'olvide mi clave', 'olvidé mi clave', 'recuperar contraseña', 'no puedo entrar', 'restablecer clave', 'olvidé la clave', 'contraseña', 'clave'];
$intencion_recuperar = false;
foreach ($palabras_clave_recuperar as $palabra) {
    if (strpos($mensaje_para_ia, $palabra) !== false) {
        $intencion_recuperar = true;
        break;
    }
}

// CORRECCIÓN 6: Verificación de sesión activa MEJORADA y CENTRALIZADA.
if (($intencion_registro || $intencion_login || $intencion_recuperar) && isset($_SESSION['user_id'])) {
    $user_id_check = (int)$_SESSION['user_id'];
    $stmt = $conexion->prepare("SELECT nombre FROM usuarios WHERE id = ? AND estado = 1");
    $stmt->bind_param("i", $user_id_check);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows > 0) {
        $usuario_data = $resultado->fetch_assoc();
        $nombre_usuario = htmlspecialchars($usuario_data['nombre']);
        $respuesta = "¡Hola, $nombre_usuario! Ya has iniciado sesión. No es necesario que te registres o inicies sesión de nuevo. ¿En qué más puedo ayudarte?";
        $stmt->close();
        header('Content-Type: application/json');
        echo json_encode(['respuesta' => $respuesta, 'historial_id' => $last_insert_id]);
        exit;
    } else {
        $stmt->close();
        limpiarSesionInvalida($conexion);
    }
}

// === GESTIÓN DE FORMULARIOS POR INTENCIÓN (PARA USUARIOS ANÓNIMOS O CON SESIÓN EXPIRADA) ===

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
HTML;
    header('Content-Type: application/json');
    // CAMBIO: Se elimina 'action' => 'remove_last_user_message' porque el JS ya se encarga de no mostrar el mensaje.
    echo json_encode([
        'respuesta' => $formulario_html,
        'historial_id' => null,
        'action' => 'remove_last_user_message' // Esta acción se mantiene para que el JS no muestre el mensaje del usuario.
    ]);
    exit;
} elseif ($intencion_recuperar) {
    $formulario_html = <<<HTML
    <p class="text-gray-800 dark:text-gray-200 mb-4">Entendido. Para iniciar la recuperación de tu cuenta, por favor, introduce el correo electrónico asociado a ella.</p>
    
    <div class="chat-form-container" id="recuperar-form">
        <div class="form-group">
            <label for="chat-recuperar-correo">Correo Electrónico</label>
            <input type="email" id="chat-recuperar-correo" placeholder="tu@correo.com" class="w-full">
        </div>
        <button id="chat-recuperar-btn" class="default-btn mt-2">Enviar Enlace de Recuperación</button>
    </div>
HTML;
    header('Content-Type: application/json');
    // CAMBIO: Se elimina 'action' => 'remove_last_user_message'.
    echo json_encode([
        'respuesta' => $formulario_html,
        'historial_id' => null,
        'action' => 'remove_last_user_message' // Esta acción se mantiene para que el JS no muestre el mensaje del usuario.
    ]);
    exit;
} elseif ($intencion_login) {
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
            <div class="cf-turnstile" data-sitekey="0x4AAAAAAA30cAZZr49ACK72" data-callback="onCaptchaVerified" data-theme="dark"></div>
        </div>
        
        <button id="chat-login-btn" class="default-btn" disabled>Ingresar</button>
        <small id="login-attempts-msg" class="form-text text-center mt-2"></small>
        
        <div class="login-links text-center mt-3">
            <a href="#" class="quick-question text-sm text-primary-500 hover:underline" data-question="Olvidé mi contraseña">¿Olvidaste tu contraseña?</a>
        </div>
    </div>

    <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
    <script>
        if (typeof inicializarFormularioLogin === "function") {
            inicializarFormularioLogin();
        }
    </script>
HTML;
    header('Content-Type: application/json');
    // CAMBIO: Se elimina 'action' => 'remove_last_user_message'.
    echo json_encode([
        'respuesta' => $formulario_html_login,
        'historial_id' => null,
        'action' => 'remove_last_user_message' // Esta acción se mantiene para que el JS no muestre el mensaje del usuario.
    ]);
    exit;
}

// =================================================================
// --- NUEVA INTENCIÓN: INICIAR PAGO ---
// =================================================================
$palabras_clave_pago = ['pagar', 'realizar el pago', 'completar mi reserva', 'quiero pagar'];
$intencion_pago = false;
foreach ($palabras_clave_pago as $palabra) {
    if (strpos($mensaje_para_ia, $palabra) !== false) {
        $intencion_pago = true;
        break;
    }
}

// SOLO si el usuario ha iniciado sesión puede pagar
if ($intencion_pago && isset($_SESSION['user_id'])) {
    // Aquí puedes añadir lógica para verificar si realmente tiene algo que pagar
    // Por ahora, simplemente iniciamos el flujo.

    $respuesta_pago = [
        'action' => 'initiate_payment_ui', // La acción que el JS espera
        'message' => '¡Claro! Te estoy preparando el formulario de pago seguro. Un momento por favor...', // Mensaje para el chat
    ];

    // Actualizamos el historial para saber que se intentó un pago
    $respuesta_esc = $conexion->real_escape_string($respuesta_pago['message']);
    $conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

    header('Content-Type: application/json');
    echo json_encode($respuesta_pago);
    $conexion->close();
    exit; // IMPORTANTE: detenemos el script aquí
} elseif ($intencion_pago && !isset($_SESSION['user_id'])) {
    // Si un anónimo intenta pagar, le pedimos que inicie sesión.
    $respuesta_anonimo = "Para poder realizar un pago, primero necesitas iniciar sesión o registrarte. ¿Qué te gustaría hacer?";

    $respuesta_esc = $conexion->real_escape_string($respuesta_anonimo);
    $conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

    header('Content-Type: application/json');
    echo json_encode(['respuesta' => $respuesta_anonimo, 'historial_id' => $last_insert_id]);
    $conexion->close();
    exit;
}
// --- FIN DE LA INTENCIÓN DE PAGO ---

// --- SI NO ES UNA ACCIÓN ESPECIAL, CONTINUAMOS CON LA LÓGICA NORMAL DE LA IA ---
// --- MODIFICADO: CONSTRUCCIÓN DEL CONTEXTO DE USUARIO ---
$contexto_usuario_str = "El usuario es ANÓNIMO.";
if (isset($_SESSION['user_id']) && is_numeric($_SESSION['user_id'])) {
    $user_id = (int)$_SESSION['user_id'];
    $stmt_user = $conexion->prepare("SELECT nombre FROM usuarios WHERE id = ? AND estado = 1");
    if ($stmt_user) {
        $stmt_user->bind_param("i", $user_id);
        $stmt_user->execute();
        $resultado_user = $stmt_user->get_result();
        if ($resultado_user->num_rows > 0) {
            $usuario_data = $resultado_user->fetch_assoc();
            $nombre_usuario_logueado = htmlspecialchars($usuario_data['nombre']);
            $contexto_usuario_str = "El usuario HA INICIADO SESIÓN. Su nombre es '$nombre_usuario_logueado' y su ID es $user_id.";
        }
        $stmt_user->close();
    }
}

// --- CONSTRUCCIÓN DEL PROMPT Y LLAMADA A LA IA ---
$historial_condition = (isset($_SESSION['user_id'])) ? "user_id = " . (int)$_SESSION['user_id'] : "session_id = " . $session_id_str;
$historial_str = "";
$res_historial = $conexion->query("SELECT mensaje_usuario, respuesta_bot FROM historial_chat WHERE ($historial_condition) AND respuesta_bot != '' ORDER BY fecha DESC LIMIT 4");
if ($res_historial && $res_historial->num_rows > 0) {
    $temp = [];
    while ($row = $res_historial->fetch_assoc()) {
        $temp[] = "Usuario: " . htmlspecialchars($row['mensaje_usuario']);
        $temp[] = "Bot: " . htmlspecialchars($row['respuesta_bot']);
    }
    $historial_str = implode("\n", array_reverse($temp));
}

// Preparamos el master context, reemplazando los placeholders
$master_context = generarMasterContext($conexion);
$master_context = str_replace('{{FECHA_ACTUAL}}', date('Y-m-d'), $master_context);
$master_context = str_replace('{{CONTEXTO_USUARIO}}', $contexto_usuario_str, $master_context);

$prompt_fase1 = <<<PROMPT
$master_context

# CONVERSACIÓN ACTUAL
## Historial Reciente de la Base de Datos:
$historial_str

## Pregunta del Usuario (procesada para mejor comprensión de fechas y entidades):
"$mensaje_para_ia" 

---
Genera tu razonamiento (dentro de <pensamiento>) y tu respuesta final en texto plano, siguiendo las instrucciones de tu contexto.
PROMPT;

$respuesta_fase1 = llamarAGemini($prompt_fase1);
$respuesta_limpia = preg_replace('/<pensamiento>.*?<\/pensamiento>/s', '', $respuesta_fase1);
$respuesta_limpia = limpiarRespuesta($respuesta_limpia);

$datos_herramienta = null;
if (preg_match('/\{.*\}/s', $respuesta_limpia, $matches)) {
    $datos_herramienta = json_decode($matches[0], true);
}

$respuesta_final = "";

// --- LÓGICA DE MANEJO DE HERRAMIENTAS ---
if ($datos_herramienta && isset($datos_herramienta['tool_name']) && $datos_herramienta['tool_name'] === 'verificar_disponibilidad') {
    $params = $datos_herramienta['parameters'];
    $disponible = verificarDisponibilidad($conexion, $params['fecha_inicio'], $params['fecha_fin'], $params['tipo_habitacion'] ?? null);

    // Si se encontró disponibilidad Y el usuario NO está logueado
    // Si se encontró disponibilidad Y el usuario NO está logueado
    if (!empty($disponible) && !isset($_SESSION['user_id'])) {

        // 1. CALCULAR PRIMERO
        $fecha1 = new DateTime($params['fecha_inicio']);
        $fecha2 = new DateTime($params['fecha_fin']);
        $dias = max(1, $fecha2->diff($fecha1)->days); // Usamos max(1,...) para evitar 0 días
        $monto_total = $dias * floatval($disponible['precio']);

        // 2. GUARDAR EN LA SESIÓN AHORA
        $_SESSION['pre_reserva'] = [
            'id_habitacion' => $disponible['id'],
            'fecha_inicio' => $params['fecha_inicio'],
            'fecha_fin' => $params['fecha_fin'],
            'monto_total' => $monto_total,
            'descripcion' => "Reserva de Habitación {$disponible['categoria']}"
        ];

        $_SESSION['__pre_reserva_processed'] = false; 

        // 3. USAR LOS VALORES CALCULADOS PARA LA RESPUESTA
        $monto_total_formatted = number_format($monto_total, 2);
        $categoria_habitacion = htmlspecialchars($disponible['categoria']);

        $respuesta_final = "¡Excelente elección! Hemos encontrado una <b>Habitación {$categoria_habitacion}</b> disponible para ti por <b>S/ {$monto_total_formatted}</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:";

        // Añadimos los dos botones de acción
        $respuesta_final .= "<div class='flex flex-wrap gap-2 mt-3'>";
        $respuesta_final .= "<button class='quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors' data-question='Quiero iniciar sesión'><i class='fas fa-sign-in-alt mr-1'></i> Iniciar Sesión</button>";
        $respuesta_final .= "<button class='quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors' data-question='Quiero crear una cuenta'><i class='fas fa-user-plus mr-1'></i> Registrarme</button>";
        $respuesta_final .= "</div>";

        // Actualizamos la base de datos y enviamos la respuesta directamente.
        $respuesta_esc = $conexion->real_escape_string($respuesta_final);
        $conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

        header('Content-Type: application/json');
        echo json_encode([
            'respuesta' => $respuesta_final,
            'historial_id' => $last_insert_id
        ]);
        exit; // Detenemos el script aquí para este caso específico.
    }

    $resultado_sistema = "";
    if (empty($disponible)) {
        $resultado_sistema = "Resultado de la consulta: sin_disponibilidad.";
    } else {
        $fecha1 = new DateTime($params['fecha_inicio']);
        $fecha2 = new DateTime($params['fecha_fin']);
        $dias = $fecha2->diff($fecha1)->days;
        // Asegurarse de que al menos sea 1 día si las fechas son las mismas (check-in y check-out el mismo día no es típico, pero evita división por cero)
        if ($dias == 0) $dias = 1;

        $monto_total = $dias * floatval($disponible['precio']);

        // --- Guardar la pre-reserva en la sesión ---
        $_SESSION['pre_reserva'] = [
            'id_habitacion' => $disponible['id'],
            'fecha_inicio' => $params['fecha_inicio'],
            'fecha_fin' => $params['fecha_fin'],
            'monto_total' => $monto_total,
            'descripcion' => "Reserva de Habitación {$disponible['categoria']}"
        ];

        $_SESSION['__pre_reserva_processed'] = false;

        // Preparamos la información para que la IA la procese
        $resultado_sistema = "Resultado de la consulta: disponibilidad_encontrada.\n";
        $resultado_sistema .= "Descripción: Habitación {$disponible['categoria']}.\n";
        $resultado_sistema .= "Precio Total: $monto_total";
    }

    // Le pedimos a la IA que formule la respuesta final basada en el resultado del sistema
    $prompt_fase2 = <<<PROMPT
INSTRUCCIONES CLAVE: Eres un asistente de hotel. Tu respuesta DEBE ser texto plano y natural. Sigue las instrucciones del "PROCESO DE RESERVA" que tienes en tu contexto maestro.
TAREA: Informa al usuario sobre el resultado de su consulta de forma natural y presenta la acción correspondiente.

Contexto del Usuario: $contexto_usuario_str
Pregunta Original del Usuario: "$mensaje_original_usuario"
Resultado de la consulta del sistema:
$resultado_sistema
PROMPT;
    $respuesta_final = llamarAGemini($prompt_fase2);
} else {
    // Si no se usó ninguna herramienta, la respuesta de la IA es la respuesta final.
    $respuesta_final = $respuesta_limpia;
}

$respuesta_final = limpiarRespuesta($respuesta_final);

// --- PROCESADO FINAL DE LA RESPUESTA (RENDERIZADO DEL BOTÓN) ---
$patron_boton = '/\[ACTION_BUTTON:(.*?)\|(.*?)\]/';
if (preg_match($patron_boton, $respuesta_final, $matches_boton)) {
    $action_name = trim($matches_boton[1]); // ej: 'request-login' o 'initiate-payment'
    $button_text = trim($matches_boton[2]); // ej: 'Asegurar Habitación y Pagar'

    // Reemplazamos el placeholder del precio en el texto del botón, si existe
    if (isset($_SESSION['pre_reserva']['monto_total'])) {
        $button_text = str_replace('{precio_total}', number_format($_SESSION['pre_reserva']['monto_total'], 2), $button_text);
    }

    $boton_html = "<button class='quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3' data-question='[Internal] {$action_name}'>{$button_text}</button>";

    $respuesta_final = preg_replace($patron_boton, $boton_html, $respuesta_final);
}

// --- FINALIZACIÓN Y RESPUESTA AL FRONTEND ---
//$respuesta_final = "<!-- La respuesta final generada por la IA o herramientas -->";
$respuesta_esc = $conexion->real_escape_string($respuesta_final);
$conexion->query("UPDATE historial_chat SET respuesta_bot = '$respuesta_esc' WHERE id = $last_insert_id");

$response_data = [
    'respuesta' => $respuesta_final,
    'historial_id' => $last_insert_id
];

// **NUEVO**: Si el mensaje del usuario fue una acción que no debe ser visible,
// le decimos al frontend que lo elimine de la vista.
if (!$es_visible) {
    $response_data['action'] = 'remove_last_user_message';
}


header('Content-Type: application/json');
echo json_encode($response_data);

$conexion->close();

// --- NO OLVIDES RELLENAR LAS PARTES CON "código sin cambios" CON TU CÓDIGO ORIGINAL ---
?>
