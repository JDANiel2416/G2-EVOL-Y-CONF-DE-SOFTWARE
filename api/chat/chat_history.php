<?php
header("Content-Type: application/json; charset=UTF-8");

require_once '../../app/core/db.php';
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$historial = [];
$historial_condition = "";

if (isset($_SESSION['user_id']) && is_numeric($_SESSION['user_id'])) {
    $db_user_id = (int)$_SESSION['user_id'];
    $historial_condition = "user_id = $db_user_id";
} else if (isset($_SESSION['chat_session_id'])) {
    $session_id_str = "'" . $conexion->real_escape_string($_SESSION['chat_session_id']) . "'";
    $historial_condition = "session_id = $session_id_str";
}

if (!empty($historial_condition)) {

    $query = "
        SELECT * FROM (
            SELECT mensaje_usuario, respuesta_bot, fecha 
            FROM historial_chat 
            WHERE ($historial_condition) 
            ORDER BY fecha DESC 
            LIMIT 20
        ) AS ultimos_mensajes
        ORDER BY fecha ASC;
    ";
    
    $result = $conexion->query($query);
    
    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            if (!empty($row['mensaje_usuario'])) {
                $historial[] = [
                    'sender' => 'user',
                    'content' => $row['mensaje_usuario'],
                    'time' => (new DateTime($row['fecha']))->format('H:i')
                ];
            }
            if (!empty($row['respuesta_bot'])) {
                $historial[] = [
                    'sender' => 'bot',
                    'content' => $row['respuesta_bot'],
                    'time' => (new DateTime($row['fecha']))->format('H:i')
                ];
            }
        }
    }
}

echo json_encode($historial);

$conexion->close();
?>