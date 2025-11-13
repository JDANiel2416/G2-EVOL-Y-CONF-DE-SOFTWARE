<?php
// api/auth/restablecer_clave.php

header("Content-Type: application/json; charset=UTF-8");

// Incluir archivos de configuración y conexión
require_once '../../config.php';
require_once '../../app/core/db.php';

// --- FUNCIONES DEL MODELO ADAPTADAS ---
// (Estas funciones reemplazan a las de tu CambiarModel.txt)

function verificarTokenParaCambio($conexion, $token) {
    // Es la misma función que en chatbot.php, pero la necesitamos aquí de nuevo para seguridad.
    $stmt = $conexion->prepare("SELECT id FROM usuarios WHERE token = ? AND token_expiracion > NOW() AND token_estado = 1");
    if (!$stmt) return null;
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $resultado = $stmt->get_result();
    $usuario = $resultado->fetch_assoc();
    $stmt->close();
    return $usuario;
}

function actualizarClaveYToken($conexion, $idUsuario, $claveHash) {
    // Actualiza la contraseña y, muy importante, invalida el token para que no se pueda reusar.
    $stmt = $conexion->prepare("UPDATE usuarios SET clave = ?, token = NULL, token_expiracion = NULL, token_estado = 0 WHERE id = ?");
    if (!$stmt) return false;
    $stmt->bind_param("si", $claveHash, $idUsuario);
    $exito = $stmt->execute();
    $stmt->close();
    return $exito;
}

// --- LÓGICA PRINCIPAL DEL SCRIPT ---

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['tipo' => 'error', 'msg' => 'Método no permitido.']);
    exit;
}

// Validar que los datos necesarios fueron enviados
if (!isset($_POST['token'], $_POST['nueva_clave']) || empty(trim($_POST['token'])) || empty(trim($_POST['nueva_clave']))) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'Faltan datos para restablecer la contraseña.']);
    exit;
}

$token = trim($_POST['token']);
$nuevaClave = trim($_POST['nueva_clave']);

// 1. Validar la fortaleza de la contraseña (igual que en el JS)
if (strlen($nuevaClave) < 8) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'La contraseña debe tener al menos 8 caracteres.']);
    exit;
}

// 2. Volver a verificar el token por seguridad
$usuario = verificarTokenParaCambio($conexion, $token);

if (!$usuario) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'El enlace de recuperación no es válido, ha expirado o ya fue utilizado.']);
    exit;
}

// 3. Hashear la nueva contraseña
$claveHash = password_hash($nuevaClave, PASSWORD_DEFAULT);

// 4. Actualizar la contraseña en la base de datos e invalidar el token
if (actualizarClaveYToken($conexion, $usuario['id'], $claveHash)) {
    // ¡Éxito!
    echo json_encode(['tipo' => 'success', 'msg' => '¡Tu contraseña ha sido actualizada con éxito! Ya puedes iniciar sesión con tu nueva clave.']);
} else {
    // Error en la base de datos
    http_response_code(500);
    echo json_encode(['tipo' => 'error', 'msg' => 'Ocurrió un error al actualizar tu contraseña. Por favor, inténtalo de nuevo.']);
}

$conexion->close();
?>