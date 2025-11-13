<?php
// api/pagos/verificar_pago.php
require_once '../../app/core/session_manager.php';
require_once '../../app/core/db.php';

header('Content-Type: application/json');

$status = $_GET['collection_status'] ?? null;
$payment_id = $_GET['payment_id'] ?? null;
$reserva_id = $_GET['external_reference'] ?? null;

if (!$status || !$reserva_id) {
    echo json_encode(['status' => 'ignored', 'msg' => 'Faltan parámetros.']);
    exit;
}

$reserva_id = (int)$reserva_id;

$stmt = $conexion->prepare("SELECT id, id_usuario, estado FROM reservas WHERE id = ?");
$stmt->bind_param("i", $reserva_id);
$stmt->execute();
$reserva = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$reserva) {
    echo json_encode(['status' => 'not_found', 'msg' => 'Reserva no encontrada.']);
    exit;
}

if ($reserva['estado'] === 'Confirmada') {
    echo json_encode(['status' => 'already_processed', 'msg' => 'Esta reserva ya fue confirmada.']);
    exit;
}

$user_id = $reserva['id_usuario'];
$mensaje_bot = '';

if ($status === 'approved') {
    // --- LÓGICA DE PAGO APROBADO (Esta parte ya estaba bien) ---

    // 1. Actualizar el estado de la reserva a 'Confirmada'
    $stmt_update = $conexion->prepare("UPDATE reservas SET estado = 'Confirmada', id_pago_externo = ? WHERE id = ?");
    $stmt_update->bind_param("si", $payment_id, $reserva_id);
    $stmt_update->execute();
    $stmt_update->close();

    // 2. **ACCIÓN CLAVE**: Ocultar todos los mensajes anteriores del chat para este usuario.
    $stmt_hide = $conexion->prepare("UPDATE historial_chat SET visible_al_usuario = 0 WHERE user_id = ?");
    $stmt_hide->bind_param("i", $user_id);
    $stmt_hide->execute();
    $stmt_hide->close();

    // 3. Obtener el nombre del usuario para un mensaje personalizado
    $stmt_user = $conexion->prepare("SELECT nombre FROM usuarios WHERE id = ?");
    $stmt_user->bind_param("i", $user_id);
    $stmt_user->execute();
    $user_data = $stmt_user->get_result()->fetch_assoc();
    $stmt_user->close();
    $user_nombre = $user_data ? htmlspecialchars($user_data['nombre']) : 'cliente';

    // 4. Crear el mensaje de confirmación
    $mensaje_bot = "¡Excelente, {$user_nombre}! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!";

    // 5. Insertar el nuevo mensaje de confirmación como el ÚNICO visible
    $mensaje_esc = $conexion->real_escape_string($mensaje_bot);
    $query_insert = "INSERT INTO historial_chat (user_id, mensaje_usuario, respuesta_bot, visible_al_usuario) VALUES (?, '', ?, 1)";
    $stmt_insert = $conexion->prepare($query_insert);
    $stmt_insert->bind_param("is", $user_id, $mensaje_esc);
    $stmt_insert->execute();
    $stmt_insert->close();

    // 6. Limpiar la pre-reserva y la bandera de la sesión.
    if (isset($_SESSION['pre_reserva'])) {
        unset($_SESSION['pre_reserva']);
        unset($_SESSION['__pre_reserva_processed']);
    }
} elseif ($status === 'rejected') {
    // --- LÓGICA DE PAGO RECHAZADO ---

    $stmt_update = $conexion->prepare("UPDATE reservas SET estado = 'Rechazada', id_pago_mp = ? WHERE id = ?");
    $stmt_update->bind_param("si", $payment_id, $reserva_id);
    $stmt_update->execute();
    $stmt_update->close();

    $mensaje_bot = "Lo sentimos, tu pago fue rechazado. Tu reserva no ha sido confirmada.<br><br>Puedes intentar con otro método de pago o contactar a tu banco para más información.";

    $mensaje_esc = $conexion->real_escape_string($mensaje_bot);
    $query_insert = "INSERT INTO historial_chat (user_id, mensaje_usuario, respuesta_bot, visible_al_usuario) VALUES (?, '', ?, 1)";
    $stmt_insert = $conexion->prepare($query_insert);
    $stmt_insert->bind_param("is", $user_id, $mensaje_esc);
    $stmt_insert->execute();
    $stmt_insert->close();

    // === INICIO DE LA CORRECCIÓN AÑADIDA ===
    // También limpiamos la sesión aquí para que el usuario no quede atascado.
    if (isset($_SESSION['pre_reserva'])) {
        unset($_SESSION['pre_reserva']);
        unset($_SESSION['__pre_reserva_processed']);
    }
    // === FIN DE LA CORRECCIÓN AÑADIDA ===
}

$conexion->close();
if ($status === 'approved') {
    $_SESSION['pending_chat_action'] = [
        'type' => 'payment_success',
        'message' => $mensaje_bot
    ];
}
echo json_encode(['status' => 'processed']);
