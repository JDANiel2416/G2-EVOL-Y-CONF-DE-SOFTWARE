<?php
// Permitir solicitudes de cualquier origen (CORS) - Ajustar en producción
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Validar que se recibió un DNI
if (!isset($_POST['dni']) || empty(trim($_POST['dni']))) {
    http_response_code(400); // Bad Request
    echo json_encode(['success' => false, 'message' => 'DNI no proporcionado.']);
    exit;
}

$dni = trim($_POST['dni']);

// Validar que el DNI tenga 8 dígitos
if (!preg_match('/^[0-9]{8}$/', $dni)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'El DNI debe tener 8 dígitos.']);
    exit;
}

// --- Llamada a la API Externa ---
// ¡IMPORTANTE! NUNCA expongas tu API token en el lado del cliente (JavaScript).
// Siempre debe estar en el backend.
$token = "8cc0364a71e30ab1107ab842bcd2ac89c84e3db477ec8b54c72c2778895870bf"; // Tu token real
$url = "https://apiperu.dev/api/dni/{$dni}?api_token={$token}";

// Usar cURL para una llamada más robusta
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 10); // Timeout de 10 segundos
$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($http_code !== 200) {
    http_response_code(503); // Service Unavailable
    echo json_encode(['success' => false, 'message' => 'El servicio de consulta de DNI no está disponible en este momento.']);
    exit;
}

$data = json_decode($response, true);

if ($data && isset($data['success']) && $data['success'] === true && isset($data['data'])) {
    // Éxito: Devolvemos solo los datos necesarios
    $result = [
        'success' => true,
        'nombres' => $data['data']['nombres'],
        'apellidos' => trim("{$data['data']['apellido_paterno']} {$data['data']['apellido_materno']}")
    ];
    echo json_encode($result);
} else {
    // Error o DNI no encontrado
    http_response_code(404); // Not Found
    $errorMessage = $data['message'] ?? 'No se encontraron datos para el DNI ingresado.';
    echo json_encode(['success' => false, 'message' => $errorMessage]);
}
?>