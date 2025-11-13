<?php
// api/feedback/guardar_feedback.php

require_once '../../app/core/session_manager.php';
require_once '../../app/core/db.php';

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405); // Method Not Allowed
    echo json_encode(['tipo' => 'error', 'msg' => 'Método no permitido.']);
    exit;
}

if (!isset($_POST['historial_id']) || !isset($_POST['feedback_type'])) {
    http_response_code(400); // Bad Request
    echo json_encode(['tipo' => 'error', 'msg' => 'Faltan datos.']);
    exit;
}

$historial_id = filter_var($_POST['historial_id'], FILTER_VALIDATE_INT);
$feedback_type_str = $_POST['feedback_type'];

if ($historial_id === false) {
    http_response_code(400);
    echo json_encode(['tipo' => 'error', 'msg' => 'ID de historial inválido.']);
    exit;
}

// Convertir 'like'/'dislike' a un valor numérico
$feedback_value = ($feedback_type_str === 'like') ? 1 : -1;

try {
    $stmt = $conexion->prepare("INSERT INTO feedback_mensajes (historial_chat_id, feedback_type) VALUES (?, ?)");
    $stmt->bind_param("ii", $historial_id, $feedback_value);
    
    if ($stmt->execute()) {
        echo json_encode(['tipo' => 'success', 'msg' => 'Feedback guardado con éxito.']);
    } else {
        http_response_code(500);
        echo json_encode(['tipo' => 'error', 'msg' => 'Error al guardar el feedback.']);
    }
    $stmt->close();
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['tipo' => 'error', 'msg' => 'Error del servidor.']);
}

$conexion->close();
?>