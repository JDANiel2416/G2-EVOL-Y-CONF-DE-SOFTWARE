<?php
// api/pagos/webhook_mp.php

// 1. Incluir dependencias
require_once '../../config.php';
require_once '../../app/core/db.php';
require_once '../../vendor/autoload.php';

use MercadoPago\MercadoPagoConfig;
use MercadoPago\Client\Payment\PaymentClient;

// 2. Configurar un archivo de log para depuración (¡muy importante!)
$log_file = __DIR__ . '/../../logs/webhook_mp.log';
function write_log($message) {
    global $log_file;
    // Añade la fecha y hora a cada entrada del log
    file_put_contents($log_file, date('Y-m-d H:i:s') . " - " . $message . "\n", FILE_APPEND);
}

write_log("--- Webhook Invocado ---");

// 3. Obtener la notificación
// Mercado Pago puede enviar la información de dos maneras: como un POST JSON o con parámetros GET.
$input = file_get_contents('php://input');
$data = json_decode($input, true);

write_log("Datos recibidos: " . json_encode($data));

// Verificamos si la información viene en el cuerpo de la petición o como parámetro
if (isset($data['action']) && $data['action'] == 'payment.updated' && isset($data['data']['id'])) {
    $payment_id = $data['data']['id'];
} elseif (isset($_GET['id']) && isset($_GET['topic']) && $_GET['topic'] == 'payment') {
    $payment_id = $_GET['id'];
} else {
    write_log("Notificación no válida o sin ID de pago.");
    http_response_code(400); // Bad Request
    exit;
}

write_log("ID de pago extraído: " . $payment_id);

// 4. Consultar la API de Mercado Pago para obtener el estado real del pago
// ¡NUNCA confíes ciegamente en la notificación! Siempre verifica el estado real.
try {
    MercadoPagoConfig::setAccessToken(MP_ACCESS_TOKEN);
    $client = new PaymentClient();
    $payment = $client->get($payment_id);
    
    if (!$payment) {
        write_log("No se encontró el pago con ID: " . $payment_id);
        http_response_code(404);
        exit;
    }

    write_log("Pago obtenido de MP: " . json_encode($payment));

    // 5. Lógica de negocio: Actualizar nuestra base de datos
    // Obtenemos el ID de nuestra reserva que guardamos en external_reference
    $id_reserva_interna = $payment->external_reference;

    // Verificamos el estado del pago
    if ($payment->status == 'approved') {
        write_log("Pago APROBADO para la reserva interna ID: " . $id_reserva_interna);
        
        // Actualizamos la reserva a 'Confirmada' y guardamos el ID de pago de MP
        $stmt = $conexion->prepare("UPDATE reservas SET estado = 'Confirmada', id_pago_externo = ? WHERE id = ? AND estado = 'Pendiente de Pago'");
        if ($stmt) {
            $stmt->bind_param("si", $payment_id, $id_reserva_interna);
            $stmt->execute();
            
            if ($stmt->affected_rows > 0) {
                write_log("ÉXITO: Reserva ID " . $id_reserva_interna . " actualizada a 'Confirmada'.");
                // Aquí podrías añadir lógica para enviar un email de confirmación al usuario.
            } else {
                write_log("ADVERTENCIA: La reserva ID " . $id_reserva_interna . " no se actualizó (quizás ya estaba confirmada o no existía).");
            }
            $stmt->close();
        } else {
            write_log("ERROR: No se pudo preparar la consulta de actualización.");
        }
    } else {
        // El pago fue rechazado, cancelado, etc.
        $nuevo_estado = 'Rechazada'; // O podrías usar $payment->status
        write_log("Pago NO APROBADO (Estado: {$payment->status}) para la reserva interna ID: " . $id_reserva_interna);
        
        $stmt = $conexion->prepare("UPDATE reservas SET estado = ? WHERE id = ?");
        $stmt->bind_param("si", $nuevo_estado, $id_reserva_interna);
        $stmt->execute();
        $stmt->close();
    }
    
    $conexion->close();
    
    // 6. Responder a Mercado Pago con un 200 OK para que sepa que recibimos la notificación.
    http_response_code(200);
    echo "Notificación recibida.";

} catch (Exception $e) {
    write_log("ERROR CRÍTICO: " . $e->getMessage());
    http_response_code(500); // Internal Server Error
}
?>