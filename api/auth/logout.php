<?php
session_start(); // Inicia la sesión para poder acceder a ella
session_unset(); // Libera todas las variables de sesión
session_destroy(); // Destruye la sesión

// Redirige al usuario de vuelta al chat
header("Location: ../../index.php");
exit;
?>