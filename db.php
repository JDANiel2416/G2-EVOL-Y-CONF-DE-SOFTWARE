<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$conexion = new mysqli("127.0.0.1", "root", "", "reservas", 3306);
if ($conexion->connect_error) {
    echo "ERROR DE CONEXIÓN EN DB.PHP: " . $conexion->connect_error . "<br>";

    $conexion = null; // o false;

} else {

}

?>