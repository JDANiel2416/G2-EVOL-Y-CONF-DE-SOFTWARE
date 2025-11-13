<?php
// db.php
require_once __DIR__ . '/../../config.php'; // Incluir la configuración

ini_set('display_errors', 1);
error_reporting(E_ALL);

$conexion = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);
if ($conexion->connect_error) {
    echo "ERROR DE CONEXIÓN EN DB.PHP: " . $conexion->connect_error . "<br>";
    $conexion = null;
}
?>