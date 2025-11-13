<?php
// app/core/session_manager.php

$session_path = __DIR__ . '/../../sessions'; 

if (!is_dir($session_path)) {
    mkdir($session_path, 0777, true);
}

session_save_path($session_path);

// Iniciar la sesión SÓLO si no hay una sesión activa.
if (session_status() === PHP_SESSION_NONE) {
    // --- NUEVO: Forzar parámetros de la cookie ---
    session_set_cookie_params([
        'lifetime' => 0,
        'path' => '/',
        // 'domain' => '.localhost', // Descomentar solo si usas subdominios
        'secure' => false, // Poner a 'true' si usas HTTPS (SSL)
        'httponly' => true,
        'samesite' => 'Lax' // Opciones: 'Lax' o 'Strict'.
    ]);
    
    session_start();
}
?>