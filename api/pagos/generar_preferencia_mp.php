<?php
// api/pagos/generar_preferencia_mp.php

require_once '../../app/core/session_manager.php';
require_once '../../config.php';
require_once '../../app/core/db.php';
require_once '../../vendor/autoload.php';

use MercadoPago\Client\Preference\PreferenceClient;
use MercadoPago\MercadoPagoConfig;

header("Content-Type: application/json; charset=UTF-8");

if (!isset($_SESSION['user_id']) || !isset($_SESSION['pre_reserva'])) {
    http_response_code(403);
    echo json_encode(['tipo' => 'error', 'msg' => 'Acceso denegado. Se requiere iniciar sesión y tener una reserva pendiente.']);
    exit;
}

$pre_reserva = $_SESSION['pre_reserva'];
$user_id = $_SESSION['user_id'];

if (!isset($pre_reserva['monto_total']) || $pre_reserva['monto_total'] <= 0) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'El monto de la reserva no es válido.']);
    exit;
}

$payer_stmt = $conexion->prepare("SELECT nombre, apellido, correo FROM usuarios WHERE id = ?");
$payer_stmt->bind_param("i", $user_id);
$payer_stmt->execute();
$payer_data = $payer_stmt->get_result()->fetch_assoc();
$payer_stmt->close();

if (!$payer_data) {
    http_response_code(404);
    echo json_encode(['tipo' => 'error', 'msg' => 'No se encontraron los datos del usuario para el pago.']);
    exit;
}

$stmt = $conexion->prepare("INSERT INTO reservas (id_usuario, id_habitacion, fecha_ingreso, fecha_salida, monto, estado, metodo) VALUES (?, ?, ?, ?, ?, 'Pendiente de Pago', 'Mercado Pago')");
if (!$stmt) { http_response_code(500); echo json_encode(['tipo' => 'error', 'msg' => 'Error DB P1']); exit; }
$stmt->bind_param("iissd", $user_id, $pre_reserva['id_habitacion'], $pre_reserva['fecha_inicio'], $pre_reserva['fecha_fin'], $pre_reserva['monto_total']);
if (!$stmt->execute()) { http_response_code(500); echo json_encode(['tipo' => 'error', 'msg' => 'Error DB P2']); exit; }
$id_reserva_interna = $stmt->insert_id;
$stmt->close();

try {
    MercadoPagoConfig::setAccessToken(MP_ACCESS_TOKEN);
    $client = new PreferenceClient();
    $monto_formateado = round(floatval($pre_reserva['monto_total']), 2);
    
    $preference_data = [
        "items" => [[ "title" => $pre_reserva['descripcion'], "quantity" => 1, "currency_id" => "PEN", "unit_price" => $monto_formateado ]],
        "payer" => [ "name" => $payer_data['nombre'], "surname" => $payer_data['apellido'], "email" => $payer_data['correo'], ],
        "back_urls" => [
            "success" => RUTA_PRINCIPAL . "index.php",
            "failure" => RUTA_PRINCIPAL . "index.php",
            "pending" => RUTA_PRINCIPAL . "index.php"
        ],
        "auto_return" => "approved",
        "external_reference" => strval($id_reserva_interna),
        "notification_url" => RUTA_PRINCIPAL . "api/pagos/webhook_mp.php",
        "statement_descriptor" => "Reserva Hotel",
        "expires" => true,
        "expiration_date_to" => date('c', strtotime('+1 hour'))
    ];
    $preference = $client->create($preference_data);

    $update_stmt = $conexion->prepare("UPDATE reservas SET preferencia_pago_id = ? WHERE id = ?");
    $update_stmt->bind_param("si", $preference->id, $id_reserva_interna);
    $update_stmt->execute();
    $update_stmt->close();

    echo json_encode(['tipo' => 'success', 'checkout_url' => $preference->init_point]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['tipo' => 'error', 'msg' => 'Hubo un problema al generar tu solicitud de pago.']);
}
$conexion->close();
?>