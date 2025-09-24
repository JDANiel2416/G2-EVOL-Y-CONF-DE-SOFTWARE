<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$conexion = new mysqli("127.0.0.1", "root", "", "reservas", 3306);
if ($conexion->connect_error) {
    // En lugar de die(), que detiene todo, podemos hacer esto para ver el error:
    echo "ERROR DE CONEXIÓN EN DB.PHP: " . $conexion->connect_error . "<br>";
    // Para que chatbot_memoria.php sepa que no hay conexión, $conexion debe ser false o null
    $conexion = null; // o false;
    // No uses die() aquí durante la depuración si quieres que chatbot_memoria.php intente seguir
} else {
    // echo "Conexión a BD exitosa desde db.php<br>"; // Descomenta para prueba
}
// No cierres la conexión aquí si la vas a usar en el otro script
?>