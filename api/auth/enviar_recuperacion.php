<?php
// api/auth/enviar_recuperacion.php

header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *"); // Opcional: útil para desarrollo

// Incluir archivos de configuración y conexión
require_once '../../config.php';
require_once '../../app/core/db.php';
require_once '../../vendor/autoload.php'; // Autoloader de Composer para PHPMailer

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// --- FUNCIONES DEL MODELO ADAPTADAS ---
// (Estas funciones reemplazan a las de tu RecuperarModel.txt)

function buscarUsuarioPorCorreo($conexion, $correo) {
    $stmt = $conexion->prepare("SELECT id, nombre, correo FROM usuarios WHERE correo = ? AND estado = 1");
    if (!$stmt) return null;
    $stmt->bind_param("s", $correo);
    $stmt->execute();
    $resultado = $stmt->get_result();
    $usuario = $resultado->fetch_assoc();
    $stmt->close();
    return $usuario;
}

function guardarTokenRecuperacion($conexion, $idUsuario, $token, $fechaExpiracion) {
    $stmt = $conexion->prepare("UPDATE usuarios SET token = ?, token_expiracion = ?, token_estado = 1 WHERE id = ?");
    if (!$stmt) return false;
    $stmt->bind_param("ssi", $token, $fechaExpiracion, $idUsuario);
    $exito = $stmt->execute();
    $stmt->close();
    return $exito;
}


// --- LÓGICA PRINCIPAL DEL SCRIPT ---

// Verificar que la solicitud sea POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405); // Method Not Allowed
    echo json_encode(['tipo' => 'error', 'msg' => 'Método no permitido.']);
    exit;
}

// Verificar que se recibió un correo
if (!isset($_POST['correo']) || empty(trim($_POST['correo']))) {
    http_response_code(400); // Bad Request
    echo json_encode(['tipo' => 'error', 'msg' => 'El campo de correo es obligatorio.']);
    exit;
}

$correo = trim($_POST['correo']);

// Validar formato del correo
if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'El formato del correo no es válido.']);
    exit;
}

// 1. Buscar al usuario en la base de datos
$usuario = buscarUsuarioPorCorreo($conexion, $correo);

if (!$usuario) {
    // Para no dar pistas a atacantes, enviamos un mensaje de éxito genérico.
    // El correo simplemente no se enviará, pero el usuario no sabrá si el correo existe o no.
    echo json_encode(['tipo' => 'success', 'msg' => 'Si tu correo está en nuestro sistema, recibirás un enlace para recuperar tu contraseña en breve.']);
    exit;
}

// 2. Generar token y fecha de expiración
$token = bin2hex(random_bytes(32)); // Token seguro de 64 caracteres
$fechaExpiracion = date('Y-m-d H:i:s', strtotime('+15 minutes')); // Válido por 15 minutos

// 3. Guardar el token en la base de datos
if (!guardarTokenRecuperacion($conexion, $usuario['id'], $token, $fechaExpiracion)) {
    http_response_code(500); // Internal Server Error
    echo json_encode(['tipo' => 'error', 'msg' => 'Error al guardar la información. Inténtalo más tarde.']);
    exit;
}

// 4. Construir el enlace de recuperación (apuntando de vuelta al chat)
$enlace = RUTA_PRINCIPAL . "?reset_token=" . $token;

// 5. Enviar el correo electrónico
$mail = new PHPMailer(true);

try {
    // Configuración del servidor SMTP (usando las constantes de config.php)
    $mail->isSMTP();
    $mail->Host       = HOST_SMTP;
    $mail->SMTPAuth   = true;
    $mail->Username   = USER_SMTP;
    $mail->Password   = CLAVE_SMTP;
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; // O 'tls'
    $mail->Port       = PUERTO_SMTP;
    $mail->CharSet    = 'UTF-8';

    // Remitente y Destinatario
    $mail->setFrom(USER_SMTP, 'Asistente del Hotel');
    $mail->addAddress($usuario['correo'], $usuario['nombre']);

    // Contenido del correo
    $mail->isHTML(true);
    $mail->Subject = 'Recuperación de Contraseña - Asistente del Hotel';
    $mail->Body    = "
        <div style='font-family: Arial, sans-serif; line-height: 1.6;'>
            <h2>Hola, {$usuario['nombre']}</h2>
            <p>Hemos recibido una solicitud para restablecer la contraseña de tu cuenta en nuestro hotel.</p>
            <p>Por favor, haz clic en el siguiente botón para continuar. Si no lo solicitaste, puedes ignorar este correo.</p>
            <p style='text-align: center;'>
                <a href='{$enlace}' style='display: inline-block; padding: 12px 24px; font-size: 16px; color: white; background-color: #10B981; text-decoration: none; border-radius: 5px;'>
                    Restablecer Contraseña
                </a>
            </p>
            <p>Este enlace es válido por 15 minutos.</p>
            <p>Gracias,<br>El equipo del hotel.</p>
        </div>";
    $mail->AltBody = "Hola {$usuario['nombre']},\n\nPara restablecer tu contraseña, copia y pega el siguiente enlace en tu navegador:\n{$enlace}\n\nEste enlace es válido por 15 minutos.";

    $mail->send();

    echo json_encode(['tipo' => 'success', 'msg' => '¡Enlace enviado! Revisa tu bandeja de entrada (y la carpeta de spam).']);

} catch (Exception $e) {
    // Log del error para nosotros (opcional pero recomendado)
    error_log("PHPMailer Error: " . $mail->ErrorInfo);
    
    http_response_code(500);
    echo json_encode(['tipo' => 'error', 'msg' => 'No se pudo enviar el correo. Por favor, contacta a soporte.']);
}

$conexion->close();
?>