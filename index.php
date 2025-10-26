<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostal la Fé AI</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/styles.css">
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        'sans': ['Inter', 'system-ui', 'sans-serif']
                    },
                    colors: {
                        primary: {
                            50: '#f0fdf4',
                            500: '#10b981',
                            600: '#059669',
                            700: '#047857'
                        }
                    }
                }
            }
        }
    </script>
</head>

<body class="font-sans bg-gray-50 dark:bg-gray-900 transition-colors duration-200">

    <div class="flex flex-col h-screen">
        <!-- Header -->
        <header class="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 px-4 py-3 sm:px-6">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="flex items-center justify-center w-10 h-10 bg-primary-500 rounded-xl">
                        <i class="fas fa-hotel text-white text-lg"></i>
                    </div>
                    <div>
                        <h1 class="text-lg font-semibold text-gray-900 dark:text-white">Asistente del Hotel</h1>
                        <div class="flex items-center space-x-2">
                            <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                            <span class="text-xs text-gray-500 dark:text-gray-400">En línea</span>
                        </div>
                    </div>
                </div>

                <div class="flex items-center space-x-2">
                    <!-- Theme Toggle -->
                    <button id="theme-toggle"
                        class="p-2 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition-colors">
                        <i class="fas fa-sun text-lg dark:hidden"></i>
                        <i class="fas fa-moon text-lg hidden dark:block"></i>
                    </button>

                    <!-- Clear Chat -->
                    <button id="clear-chat"
                        class="p-2 text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition-colors"
                        title="Limpiar chat">
                        <i class="fas fa-broom text-lg"></i>
                    </button>

                    <!-- CAMBIO/AÑADIDO: Avatar de Usuario Dinámico -->
                    <div id="user-status"
                        class="flex items-center space-x-2 bg-gray-100 dark:bg-gray-700 rounded-lg px-3 py-2">
                        <?php if (isset($_SESSION['user_id']) && isset($_SESSION['user_nombre'])): ?>
                        <!-- Vista para usuario logueado -->
                        <div class="w-6 h-6 bg-primary-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-user-check text-white text-xs"></i>
                        </div>
                        <span class="text-sm font-medium text-gray-700 dark:text-gray-300 hidden sm:block">
                            <?php echo htmlspecialchars($_SESSION['user_nombre']); ?>
                        </span>
                        <a href="api/auth/logout.php" title="Cerrar Sesión"
                            class="ml-2 text-gray-500 hover:text-red-500 dark:text-gray-400 dark:hover:text-red-400">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                        <?php else: ?>
                        <!-- Vista para visitante -->
                        <div class="w-6 h-6 bg-gray-400 dark:bg-gray-600 rounded-full flex items-center justify-center">
                            <i class="fas fa-user-alt-slash text-white text-xs"></i>
                        </div>
                        <span
                            class="text-sm font-medium text-gray-700 dark:text-gray-300 hidden sm:block">Visitante</span>
                        <?php endif; ?>
                    </div>

                </div>
            </div>
        </header>

        <!-- Chat Messages -->
        <main class="flex-1 overflow-hidden">
            <div id="chat-messages" class="h-full overflow-y-auto scrollbar-thin px-4 py-6 sm:px-6">
                <!-- Welcome Message -->
                <div class="message-animation">
                    <div class="flex items-start space-x-3 mb-6">
                        <div
                            class="w-8 h-8 bg-gray-200 dark:bg-gray-700 rounded-full flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-robot text-gray-600 dark:text-gray-300 text-sm"></i>
                        </div>
                        <div class="flex-1 min-w-0">
                            <div
                                class="bg-white dark:bg-gray-800 rounded-2xl rounded-tl-sm px-4 py-3 shadow-sm border border-gray-200 dark:border-gray-700">
                                <p class="text-gray-800 dark:text-gray-200 mb-3">¡Hola! Soy el asistente virtual del
                                    hotel. ¿En qué puedo ayudarte hoy?</p>

                                <!-- CAMBIO/AÑADIDO: Quick Questions Dinámicas -->
                                <!-- En tu archivo index.php, busca esta sección -->
                                <div class="space-y-2">
                                    <p class="text-sm text-gray-600 dark:text-gray-400 font-medium">Puedes probar con
                                        esto:</p>
                                    <div class="flex flex-wrap gap-2">
                                        <?php if (!isset($_SESSION['user_id'])): ?>
                                        <!-- ESTOS BOTONES SOLO SE MUESTRAN SI EL USUARIO NO ESTÁ LOGUEADO -->
                                        <button
                                            class="quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors"
                                            data-question="Quiero crear una cuenta">
                                            <i class="fas fa-user-plus mr-1"></i>
                                            Registrarme
                                        </button>
                                        <button
                                            class="quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors"
                                            data-question="Quiero iniciar sesión">
                                            <i class="fas fa-sign-in-alt mr-1"></i>
                                            Iniciar Sesión
                                        </button>
                                        <?php endif; ?>

                                        <!-- ESTOS BOTONES SIEMPRE SE MUESTRAN -->
                                        <button
                                            class="quick-question bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 px-3 py-2 rounded-full text-sm hover:bg-primary-100 dark:hover:bg-primary-900/30 transition-colors"
                                            data-question="¿Qué tipos de habitaciones tienes?">
                                            <i class="fas fa-bed mr-1"></i>
                                            Habitaciones
                                        </button>
                                        <button
                                            class="quick-question bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 px-3 py-2 rounded-full text-sm hover:bg-primary-100 dark:hover:bg-primary-900/30 transition-colors"
                                            data-question="Muéstrame fotos del hotel">
                                            <i class="fas fa-camera mr-1"></i>
                                            Fotos
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 ml-2">Ahora</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Input Area -->
        <footer class="bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700 p-4 sm:p-6">
            <div class="max-w-4xl mx-auto">
                <div class="flex items-end space-x-3">
                    <div class="flex-1 relative">
                        <textarea id="user-input" placeholder="Escribe tu mensaje..." rows="1"
                            class="w-full resize-none border border-gray-300 dark:border-gray-600 rounded-2xl px-4 py-3 pr-12 bg-white dark:bg-gray-700 text-gray-900 dark:text-white placeholder-gray-500 dark:placeholder-gray-400 focus:ring-2 focus:ring-primary-500 focus:border-transparent outline-none transition-all max-h-32"></textarea>
                        <button id="send-btn" disabled
                            class="absolute right-2 bottom-2 w-8 h-8 bg-primary-500 hover:bg-primary-600 disabled:bg-gray-300 dark:disabled:bg-gray-600 disabled:cursor-not-allowed rounded-full flex items-center justify-center text-white transition-all transform hover:scale-105 disabled:hover:scale-100">
                            <i class="fas fa-paper-plane text-sm"></i>
                        </button>
                    </div>
                </div>
                <p class="text-xs text-gray-500 dark:text-gray-400 text-center mt-3">
                    El asistente puede cometer errores. Verifica la información importante.
                </p>
            </div>
        </footer>
    </div>

    <!-- Custom JS -->
    <script src="assets/js/main.js"></script>
    <script src="assets/js/auth-form.js"></script>
    <!-- SCRIPT DE CLOUDFLARE TURNSTILE (CAPTCHA) -->
    <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
</body>

</html>