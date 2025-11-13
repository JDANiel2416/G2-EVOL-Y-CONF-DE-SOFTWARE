<?php
// En api/chat/get_history.php
header("Content-Type: application/json; charset=UTF-8");

require_once '../../app/core/db.php';
require_once '../../app/core/session_manager.php';

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
    // --- CONSULTA SQL MEJORADA Y CORREGIDA ---
    // 1. Añadimos "visible_al_usuario = 1" para filtrar solo los mensajes que deben mostrarse.
    // 2. Seleccionamos el `id` para poder usarlo en la función de feedback.
    // 3. Obtenemos los últimos 20 mensajes y los ordenamos de más antiguo a más reciente.
    $query = "
        SELECT * FROM (
            SELECT id, mensaje_usuario, respuesta_bot, fecha 
            FROM historial_chat 
            WHERE ($historial_condition) AND visible_al_usuario = 1
            ORDER BY fecha DESC 
            LIMIT 20
        ) AS ultimos_mensajes
        ORDER BY fecha ASC;
    ";
    
    $result = $conexion->query($query);
    
    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            // Cada fila de la base de datos ahora representa un par de pregunta y respuesta.
            // Primero, añadimos el mensaje del usuario.
            if (!empty($row['mensaje_usuario'])) {
                $historial[] = [
                    'sender' => 'user',
                    'content' => htmlspecialchars($row['mensaje_usuario']), // Escapamos para seguridad
                    'time' => (new DateTime($row['fecha']))->format('H:i'),
                    'historial_id' => null // Los mensajes de usuario no tienen feedback
                ];
            }
            
            // Luego, añadimos la respuesta del bot (si existe).
            // Le pasamos el 'id' de la fila para la función de feedback.
            if (!empty(trim($row['respuesta_bot']))) {
                $historial[] = [
                    'sender' => 'bot',
                    'content' => $row['respuesta_bot'], // El contenido del bot ya es HTML, no se escapa
                    'time' => (new DateTime($row['fecha']))->format('H:i'),
                    'historial_id' => $row['id'] // Asociamos el ID a la respuesta del bot
                ];
            }
        }
    }
}

echo json_encode($historial);

$conexion->close();
?>