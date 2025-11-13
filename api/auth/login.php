<?php
// En api/auth/login.php
require_once '../../app/core/session_manager.php';

header("Content-Type: application/json; charset=UTF-8");

require_once '../../app/core/db.php';

// --- CONFIGURACIÓN DE SEGURIDAD ---
define('MAX_LOGIN_ATTEMPTS', 5);
define('LOGIN_WAIT_TIME', 300);

// Inicializar contadores si no existen
if (!isset($_SESSION['login_attempts'])) {
    $_SESSION['login_attempts'] = 0;
}
if (!isset($_SESSION['login_wait_until'])) {
    $_SESSION['login_wait_until'] = 0;
}

// --- VERIFICACIÓN DE TIEMPO DE ESPERA ---
if ($_SESSION['login_wait_until'] > 0 && time() > $_SESSION['login_wait_until']) {
    $_SESSION['login_attempts'] = 0;
    $_SESSION['login_wait_until'] = 0;
}

// --- PROCESO DE LOGIN ---

// 1. Verificar si el usuario está bloqueado
if ($_SESSION['login_attempts'] >= MAX_LOGIN_ATTEMPTS && time() < $_SESSION['login_wait_until']) {
    $remaining = $_SESSION['login_wait_until'] - time();
    http_response_code(429);
    echo json_encode(['tipo' => 'error', 'msg' => "Demasiados intentos. Por favor, espera {$remaining} segundos.", 'bloqueado' => true]);
    exit;
}

// 2. Validar datos recibidos
$es_entorno_local = ($_SERVER['REMOTE_ADDR'] === '127.0.0.1' || $_SERVER['REMOTE_ADDR'] === '::1');
if (!$es_entorno_local && !isset($_POST['cf-turnstile-response'])) {
    
}

if (!isset($_POST['usuario'], $_POST['clave'])) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'Faltan datos para el inicio de sesión.']);
    exit;
}

// 4. Verificar credenciales
$usuario_o_correo = $conexion->real_escape_string($_POST['usuario']);
$clave = $_POST['clave'];

$stmt = $conexion->prepare("SELECT id, nombre, clave FROM usuarios WHERE usuario = ? OR correo = ?");
$stmt->bind_param("ss", $usuario_o_correo, $usuario_o_correo);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    if (password_verify($clave, $user['clave'])) {
        
        if (isset($_SESSION['chat_session_id'])) {
            $anon_session_id = $conexion->real_escape_string($_SESSION['chat_session_id']);

            $update_stmt = $conexion->prepare("UPDATE historial_chat SET user_id = ?, session_id = NULL WHERE session_id = ?");
            $update_stmt->bind_param("is", $user['id'], $anon_session_id);
            $update_stmt->execute();
            $update_stmt->close();

            unset($_SESSION['chat_session_id']);
        }

        $_SESSION['user_id'] = $user['id'];
        $_SESSION['user_nombre'] = $user['nombre'];

        if (isset($_SESSION['pre_reserva'])) {
            $_SESSION['__pre_reserva_processed'] = false;
        }

        $_SESSION['login_wait_until'] = 0;
        $_SESSION['login_attempts'] = 0;


        echo json_encode([
            'tipo' => 'success',
            'msg' => '¡Bienvenido de nuevo, ' . htmlspecialchars($user['nombre']) . '!',
            'userId' => $user['id'],
            'userName' => htmlspecialchars($user['nombre'])
        ]);
    } else {
        $_SESSION['login_attempts']++;
        $intentos_restantes = MAX_LOGIN_ATTEMPTS - $_SESSION['login_attempts'];
        if ($intentos_restantes <= 0) {
            $_SESSION['login_wait_until'] = time() + LOGIN_WAIT_TIME;
        }
        http_response_code(401);
        echo json_encode(['tipo' => 'error', 'msg' => 'Usuario o contraseña incorrectos.', 'intentos_restantes' => $intentos_restantes]);
    }
} else {
    
    $_SESSION['login_attempts']++;
    $intentos_restantes = MAX_LOGIN_ATTEMPTS - $_SESSION['login_attempts'];

    if ($intentos_restantes <= 0) {
        $_SESSION['login_wait_until'] = time() + LOGIN_WAIT_TIME;
    }

    http_response_code(404);
    echo json_encode(['tipo' => 'error', 'msg' => 'Usuario o contraseña incorrectos.', 'intentos_restantes' => $intentos_restantes]);
}

$stmt->close();
$conexion->close();
?>