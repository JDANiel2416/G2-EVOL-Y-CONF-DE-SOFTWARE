<?php
// En api/auth/registrar.php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

header("Content-Type: application/json; charset=UTF-8");

// Incluir la conexión a la base de datos
require_once '../../app/core/db.php';

// Obtener los datos JSON enviados desde JavaScript
$data = json_decode(file_get_contents("php://input"));

// --- Validaciones del Lado del Servidor (se mantienen igual) ---
if (
    !isset($data->dni, $data->nombre, $data->apellido, $data->usuario, $data->correo, $data->clave) ||
    empty(trim($data->dni)) || empty(trim($data->nombre)) || empty(trim($data->apellido)) ||
    empty(trim($data->usuario)) || empty(trim($data->correo)) || empty(trim($data->clave))
) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'Todos los campos son obligatorios.']);
    exit;
}

if (!filter_var($data->correo, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'El formato del correo electrónico no es válido.']);
    exit;
}

$clave = $data->clave;
if (strlen($clave) < 8 || !preg_match('/[A-Z]/', $clave) || !preg_match('/[a-z]/', $clave) || !preg_match('/[0-9]/', $clave) || !preg_match('/[\W_]/', $clave)) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'La contraseña no cumple con los requisitos de seguridad.']);
    exit;
}

// --- Verificación de Usuario y Correo Existentes (se mantiene igual) ---
$usuario = $conexion->real_escape_string($data->usuario);
$correo = $conexion->real_escape_string($data->correo);

$stmt = $conexion->prepare("SELECT id FROM usuarios WHERE usuario = ? OR correo = ?");
$stmt->bind_param("ss", $usuario, $correo);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    http_response_code(409); // Conflict
    echo json_encode(['tipo' => 'warning', 'msg' => 'El nombre de usuario o el correo ya están registrados.']);
    $stmt->close();
    exit;
}
$stmt->close();

// --- Inserción en la Base de Datos ---
$clave_hash = password_hash($clave, PASSWORD_DEFAULT);

$stmt = $conexion->prepare("INSERT INTO usuarios (dni, nombre, apellido, usuario, correo, clave, rol) VALUES (?, ?, ?, ?, ?, ?, 2)");
$dni_clean = $conexion->real_escape_string($data->dni);
$nombre_clean = $conexion->real_escape_string($data->nombre);
$apellido_clean = $conexion->real_escape_string($data->apellido);
$stmt->bind_param("ssssss", $dni_clean, $nombre_clean, $apellido_clean, $usuario, $correo, $clave_hash);

if ($stmt->execute()) {
    $id_nuevo_usuario = $stmt->insert_id;
    $nombre_nuevo_usuario = $data->nombre;

    // --- NUEVO: LÓGICA DE UNIFICACIÓN DE HISTORIAL ---
    // Verificamos si existía un ID de sesión anónimo.
    if (isset($_SESSION['chat_session_id'])) {
        $anon_session_id = $conexion->real_escape_string($_SESSION['chat_session_id']);
        
        $update_stmt = $conexion->prepare("UPDATE historial_chat SET user_id = ?, session_id = NULL WHERE session_id = ?");
        $update_stmt->bind_param("is", $id_nuevo_usuario, $anon_session_id);
        $update_stmt->execute();
        $update_stmt->close();
        
        unset($_SESSION['chat_session_id']);
    }
    // --- FIN DE LA LÓGICA DE UNIFICACIÓN ---

    // Establecer la sesión para el nuevo usuario.
    $_SESSION['user_id'] = $id_nuevo_usuario;
    $_SESSION['user_nombre'] = $nombre_nuevo_usuario;

    echo json_encode([
        'tipo' => 'success', 
        'msg' => '¡Cuenta creada con éxito! Tu historial de chat se ha guardado y ya has iniciado sesión.',
        'userId' => $id_nuevo_usuario,
        'userName' => htmlspecialchars($nombre_nuevo_usuario)
    ]);

} else {
    // Error al insertar
    http_response_code(500); // Internal Server Error
    echo json_encode(['tipo' => 'error', 'msg' => 'Ocurrió un error al crear tu cuenta. Por favor, inténtalo más tarde.']);
}

$stmt->close();
$conexion->close();
?>