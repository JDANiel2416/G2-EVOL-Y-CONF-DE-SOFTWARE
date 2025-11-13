<?php
// config.php

// --- CONFIGURACIÓN DE LA BASE DE DATOS ---
define('DB_HOST', '127.0.0.1');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'ai_reservas');
define('DB_PORT', 3307);

// --- CONFIGURACIÓN DEL SITIO ---
//define('RUTA_PRINCIPAL', 'https://423f6ae05311.ngrok-free.app/adminproject/'); // ¡Importante!
define('RUTA_PRINCIPAL', 'http://localhost/adminproject/'); // ¡Importante!

// --- CREDENCIALES DE API ---
define('GEMINI_API_KEY', ''); // Tu clave de Gemini
define('GEMINI_MODEL', 'gemini-2.0-flash');

// --- CONFIGURACIÓN DE CORREO (PHPMAILER) ---
define('HOST_SMTP', 'smtp.gmail.com');
define('USER_SMTP', 'escobedomichael921@gmail.com');
define('CLAVE_SMTP', 'avtb rkhn nkzl dgdj ');
define('PUERTO_SMTP', 465);

// --- CONFIGURACIÓN DE MERCADO PAGO ---
define('MP_ACCESS_TOKEN', 'TEST-5197646970259619-070419-b9aa7ff908589b38f386b308dd4f1c32-1656118711'); // Tu Access Token
define('MP_PUBLIC_KEY', 'TEST-6a2f5bc1-50fb-4dbe-b816-74370939f242'); // Tu Public Key
define('MP_MONEDA', 'PEN'); // Moneda local (Soles)

?>