# 🤖 Asistente Virtual IA para "Hostal la Fé"


*<p align="center">Una breve demostración del asistente en acción.</p>*

Un chatbot inteligente y avanzado que actúa como recepcionista virtual para el "Hostal la Fé". Construido con PHP, MySQL y JavaScript, y potenciado por la API de Google Gemini, este asistente ofrece una experiencia de usuario fluida y natural.

<p align="center">
  <img src="https://img.shields.io/badge/PHP-8%2B-777BB4?style=for-the-badge&logo=php" alt="PHP 8+">
  <img src="https://img.shields.io/badge/JavaScript-ES6%2B-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black" alt="JavaScript">
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Tailwind_CSS-3-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="Tailwind CSS">
  <img src="https://img.shields.io/badge/Google_Gemini-API-4285F4?style=for-the-badge&logo=google&logoColor=white" alt="Google Gemini">
</p>

## ✨ Características Principales

Este no es un chatbot común. Ha sido diseñado con funcionalidades robustas para una experiencia completa:

- **🧠 Inteligencia Artificial Conversacional:** Utiliza el modelo `gemini-1.5-flash` de Google para entender y responder preguntas de forma natural y humana.
- **🔄 Contexto Dinámico (¡Característica Clave!):** El cerebro del bot se actualiza automáticamente desde la base de datos. La información sobre habitaciones, precios y servicios está **siempre al día**, sin necesidad de tocar el código.
- **📝 Formularios en el Chat:** Detecta intenciones como "registrarme" o "iniciar sesión" y muestra formularios interactivos **directamente en la ventana de chat**, sin redirigir al usuario.
- **🔐 Autenticación Segura:** Sistema completo de registro e inicio de sesión con validación en el servidor, contraseñas hasheadas y protección contra ataques de fuerza bruta.
- **📜 Unificación de Historial de Chat:** Cuando un visitante anónimo se registra, su historial de chat se fusiona con su cuenta de usuario. ¡Nunca pierde la conversación!
- **🇵🇪 Verificación de DNI (Perú):** Se conecta a una API externa (`apiperu.dev`) para autocompletar y validar los datos del usuario durante el registro usando su número de DNI.
- **🛡️ Seguridad Anti-Bots:** Protege los formularios de registro e inicio de sesión con **Cloudflare Turnstile** (un CAPTCHA moderno y no intrusivo).
- **🎨 Interfaz Moderna y Responsiva:** Diseñada con **Tailwind CSS**, incluye un modo oscuro y se adapta a cualquier dispositivo.

## 🛠️ Stack Tecnológico

| Componente | Tecnología |
| :--- | :--- |
| **Backend** | PHP 8+ (Puro, sin frameworks) |
| **Frontend** | JavaScript (Vanilla) y Tailwind CSS |
| **Base de Datos** | MySQL |
| **Inteligencia Artificial**| Google Gemini API |
| **Servicios Externos** | `apiperu.dev` (Verificación DNI) |
| **Seguridad** | Cloudflare Turnstile (CAPTCHA) |

## 📂 Estructura del Proyecto

Aquí tienes un mapa de cómo está organizado el código:
```
/
├── 📂 api/          # Endpoints para la lógica del negocio
│   ├── auth/       # Registro, login, logout
│   ├── chat/       # Historial de conversaciones
│   └── utils/      # Utilidades (ej. verificar DNI)
├── 📂 app/           # Núcleo de la aplicación
│   ├── contexts/   # Generación de prompts para la IA
│   └── core/       # Conexión a la base de datos
├── 📂 assets/        # Archivos públicos
│   ├── css/        # Hojas de estilo
│   ├── img/        # Imágenes
│   └── js/         # Lógica del frontend
├── 🤖 chatbot.php     # El "cerebro" que procesa los mensajes
├── 🌐 index.php       # Interfaz principal del chat
└── 📦 db.php          # (Archivo de conexión secundario)
```

## 🚀 Instalación y Puesta en Marcha

Sigue estos pasos para levantar el proyecto en tu entorno local (como XAMPP).

### 1. Requisitos Previos

- **Servidor Local:** [XAMPP](https://www.apachefriends.org/es/index.html) (o similar) con PHP 8+, MySQL y Apache.
- **Control de Versiones:** [Git](https://git-scm.com/).

### 2. Clonar el Repositorio

Abre tu terminal, navega a la carpeta `htdocs` de XAMPP y ejecuta:
```bash
git clone [URL-DE-TU-REPOSITORIO]
cd [NOMBRE-DEL-PROYECTO]
```

### 3. Configuración de la Base de Datos

1.  **Inicia XAMPP:** Asegúrate de que los módulos de Apache y MySQL estén corriendo.
2.  **Crea la Base de Datos:**
    -   Abre `phpMyAdmin` (normalmente en `http://localhost/phpmyadmin`).
    -   Crea una nueva base de datos llamada `ai_reservas`.
3.  **Importa los Datos:** Importa el archivo `.sql` del proyecto en la base de datos `ai_reservas`.
4.  **Verifica la Conexión:**
    -   Abre el archivo `app/core/db.php`.
    -   Asegúrate de que el usuario, contraseña y nombre de la base de datos coincidan con tu configuración de XAMPP. *Nota: El puerto por defecto suele ser `3306`, ajústalo si es necesario.*

### 4. Configuración de Claves API (¡Muy Importante!)

El chatbot no funcionará sin estas claves.

*   **Google Gemini API:**
    1.  Obtén tu clave desde [Google AI Studio](https://aistudio.google.com/).
    2.  Abre `chatbot.php` y pega tu clave aquí:
        ```php
        define("GEMINI_API_KEY", "TU_CLAVE_DE_GEMINI_AQUI");
        ```

*   **ApiPeru.dev (para DNI):**
    1.  Regístrate en [apiperu.dev](https://apiperu.dev/) para obtener un token.
    2.  Abre `api/utils/verificar_dni.php` y pégalo aquí:
        ```php
        $token = "TU_TOKEN_DE_APIPERU_AQUI";
        ```

*   **Cloudflare Turnstile (CAPTCHA):**
    1.  Obtén tu `Site Key` (clave de sitio) desde tu panel de [Cloudflare](https://www.cloudflare.com/).
    2.  Abre `chatbot.php` y reemplaza la clave de ejemplo en el código HTML que genera el formulario.
    3.  Abre `assets/js/auth-form.js` y actualiza la clave también aquí:
        ```javascript
        window.turnstile.render(captchaContainer, {
            sitekey: 'TU_SITE_KEY_DE_TURNSTILE_AQUI',
            // ...
        });
        ```

### 5. ¡A Chatear!

Una vez que hayas configurado todo, abre tu navegador y visita: `http://localhost/[NOMBRE-DE-LA-CARPETA-DEL-PROYECTO]/`.

¡Y listo! El asistente virtual debería saludarte.
