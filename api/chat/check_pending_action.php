<?php
// api/chat/check_pending_action.php

require_once '../../app/core/session_manager.php';
require_once '../../app/core/db.php';

header("Content-Type: application/json; charset=UTF-8");

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['action' => 'none']);
    exit;
}

$user_id = (int)$_SESSION['user_id'];
$response = ['action' => 'none'];

// Verificar si hay una reserva pendiente no procesada
if (
    isset($_SESSION['pre_reserva']) && $_SESSION['pre_reserva'] !== null &&
    (!isset($_SESSION['__pre_reserva_processed']) || $_SESSION['__pre_reserva_processed'] === false)
) {

    $pre_reserva = $_SESSION['pre_reserva'];
    $monto_total_formatted = number_format($pre_reserva['monto_total'], 2);
    $nombre_usuario = htmlspecialchars($_SESSION['user_nombre'] ?? 'usuario');

    // Verificar si ya existe un mensaje similar
    $stmt_check = $conexion->prepare("SELECT id FROM historial_chat 
                                    WHERE user_id = ? AND respuesta_bot LIKE ? 
                                    ORDER BY id DESC LIMIT 1");
    $search_pattern = "%{$pre_reserva['descripcion']}%";
    $stmt_check->bind_param("is", $user_id, $search_pattern);
    $stmt_check->execute();
    $existing_message = $stmt_check->get_result()->fetch_assoc();
    $stmt_check->close();

    // --- INICIO DE LA CORRECCIÓN ---
    // 1. Construimos el inicio del mensaje que QUEREMOS buscar.
    $mensaje_bot_inicio = "¡Bienvenido {$nombre_usuario}! Tenemos tu reserva pendiente:";

    // 2. Hacemos la comprobación mucho más específica.
    // Buscamos un mensaje que contenga TANTO el saludo de bienvenida COMO la descripción de la reserva.
    // Esto evita confundirlo con el mensaje de oferta inicial que se le dio al usuario anónimo.
    $stmt_check = $conexion->prepare("SELECT id FROM historial_chat 
                                    WHERE user_id = ? AND respuesta_bot LIKE ? 
                                    ORDER BY id DESC LIMIT 1");

    // El patrón de búsqueda ahora es más robusto.
    $search_pattern = "%" . $conexion->real_escape_string($mensaje_bot_inicio) . "%" . $conexion->real_escape_string($pre_reserva['descripcion']) . "%";

    $stmt_check->bind_param("is", $user_id, $search_pattern);
    $stmt_check->execute();
    $existing_message = $stmt_check->get_result()->fetch_assoc();
    $stmt_check->close();
    // --- FIN DE LA CORRECCIÓN ---

    if (!$existing_message) {
        $mensaje_bot = "¡Bienvenido {$nombre_usuario}! Tenemos tu reserva pendiente: <b>{$pre_reserva['descripcion']}</b> por <b>S/ {$monto_total_formatted}</b>.";
        $datos_boton = [
            'text' => "Pagar S/ {$monto_total_formatted} ahora",
            'data_question' => '[Internal] initiate-payment'
        ];

        $mensaje_bot_esc = $conexion->real_escape_string($mensaje_bot);
        $query = "INSERT INTO historial_chat (user_id, mensaje_usuario, respuesta_bot, visible_al_usuario) 
                VALUES (?, '', ?, 1)";
        $stmt = $conexion->prepare($query);
        $stmt->bind_param("is", $user_id, $mensaje_bot_esc);
        $stmt->execute();
        $historial_id = $stmt->insert_id;
        $stmt->close();

        $response = [
            'action' => 'add_pending_message_with_button',
            'message' => [
                'content' => $mensaje_bot,
                'button' => $datos_boton,
                'historial_id' => $historial_id
            ]
        ];
    }

    $_SESSION['__pre_reserva_processed'] = true;
}
// Verificar si hay un mensaje de pago exitoso pendiente
elseif (isset($_SESSION['pending_chat_action']) && $_SESSION['pending_chat_action']['type'] === 'payment_success') {

    // Verificar si el mensaje ya existe
    $stmt_check = $conexion->prepare("SELECT id FROM historial_chat 
                                     WHERE user_id = ? AND respuesta_bot LIKE ? 
                                     ORDER BY id DESC LIMIT 1");
    $search_pattern = "%{$_SESSION['pending_chat_action']['message']}%";
    $stmt_check->bind_param("is", $user_id, $search_pattern);
    $stmt_check->execute();
    $existing_message = $stmt_check->get_result()->fetch_assoc();
    $stmt_check->close();

    if (!$existing_message) {
        $mensaje_bot = $_SESSION['pending_chat_action']['message'];
        $mensaje_bot_esc = $conexion->real_escape_string($mensaje_bot);

        $query_success = "INSERT INTO historial_chat (user_id, mensaje_usuario, respuesta_bot, visible_al_usuario) 
                          VALUES (?, '', ?, 1)";
        $stmt_success = $conexion->prepare($query_success);
        $stmt_success->bind_param("is", $user_id, $mensaje_bot_esc);
        $stmt_success->execute();
        $historial_id = $stmt_success->insert_id;
        $stmt_success->close();

        $response = [
            'action' => 'add_pending_message',
            'message' => [
                'content' => $mensaje_bot,
                'historial_id' => $historial_id
            ]
        ];
    }

    unset($_SESSION['pending_chat_action']);
}

$conexion->close();
echo json_encode($response);
