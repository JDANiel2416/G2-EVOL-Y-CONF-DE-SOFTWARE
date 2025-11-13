document.addEventListener('DOMContentLoaded', function () {
    let isTyping = false;

    // Theme management
    const themeToggle = document.getElementById('theme-toggle');
    const htmlElement = document.documentElement;
    const currentTheme = localStorage.getItem('theme') || 'light';
    if (currentTheme === 'dark') {
        htmlElement.classList.add('dark');
    }
    themeToggle.addEventListener('click', function () {
        htmlElement.classList.toggle('dark');
        const theme = htmlElement.classList.contains('dark') ? 'dark' : 'light';
        localStorage.setItem('theme', theme);
    });

    // Chat functionality
    const userInput = document.getElementById('user-input');
    const sendBtn = document.getElementById('send-btn');
    const chatMessages = document.getElementById('chat-messages');
    const clearChatBtn = document.getElementById('clear-chat');

    // Auto-resize textarea
    if (userInput) {
        userInput.addEventListener('input', function () {
            this.style.height = 'auto';
            this.style.height = Math.min(this.scrollHeight, 128) + 'px';
            sendBtn.disabled = !this.value.trim();
        });

        // Send message on Enter
        userInput.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    }

    if (sendBtn) {
        sendBtn.addEventListener('click', sendMessage);
    }

    // Quick questions
    document.addEventListener('click', function (e) {
        const button = e.target.closest('.quick-question');
        if (button) {
            const question = button.getAttribute('data-question');
            if (userInput) {
                userInput.value = question;
                userInput.focus();
                sendMessage();
            }
        }
    });

    // Feedback en Mensajes del Bot
    if (chatMessages) {
        chatMessages.addEventListener('click', function (e) {
            const feedbackBtn = e.target.closest('.feedback-btn');

            if (!feedbackBtn || feedbackBtn.closest('.feedback-container').classList.contains('feedback-sent')) {
                return;
            }

            e.preventDefault();

            const feedbackContainer = feedbackBtn.closest('.feedback-container');
            const historial_id = feedbackContainer.getAttribute('data-message-id');
            const feedback_type = feedbackBtn.getAttribute('data-feedback');

            feedbackContainer.classList.add('feedback-sent');

            if (feedback_type === 'like') {
                feedbackBtn.classList.add('text-primary-500');
            } else {
                feedbackBtn.classList.add('text-red-500');
            }

            enviarFeedback(historial_id, feedback_type);
        });
    }

    // Clear chat
    if (clearChatBtn) {
        clearChatBtn.addEventListener('click', clearChat);
    }

    // --- GESTIÓN DEL MENÚ DE USUARIO (AHORA DENTRO DE DOMCONTENTLOADED) ---
    const avatarBtn = document.getElementById('user-avatar-btn');
    const userMenu = document.getElementById('user-menu');

    if (avatarBtn && userMenu) {
        avatarBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            userMenu.classList.toggle('hidden');
        });
    }

    document.addEventListener('click', (e) => {
        if (userMenu && !userMenu.classList.contains('hidden')) {
            if (avatarBtn && !avatarBtn.contains(e.target) && !userMenu.contains(e.target)) {
                userMenu.classList.add('hidden');
            }
        }
    });
    // --- FIN DE LA GESTIÓN DEL MENÚ ---


    // --- FUNCIONES ---

    async function enviarFeedback(historial_id, feedback_type) {
        const formData = new FormData();
        formData.append('historial_id', historial_id);
        formData.append('feedback_type', feedback_type);

        try {
            const response = await fetch('/adminproject/api/feedback/guardar_feedback.php', {
                method: 'POST',
                body: formData,
                credentials: 'same-origin'
            });

            const result = await response.json();
            if (response.ok && result.tipo === 'success') {
                showToast('¡Gracias por tu feedback!');
            } else {
                showToast(result.msg || 'Error al guardar la valoración', 'error');
            }
        } catch (error) {
            console.error('Error al enviar feedback:', error);
            showToast('Error de conexión al enviar feedback', 'error');
        }
    }

    async function iniciarPagoMercadoPago() {
        try {
            // 1. Mostrar un mensaje de espera en el chat
            addMessage("Generando tu enlace de pago seguro, un momento por favor...", "bot");

            // 2. Llamar a nuestro backend para obtener la URL del checkout
            const response = await fetch('api/pagos/generar_preferencia_mp.php', { method: 'POST' });

            // Ocultamos el mensaje de "Generando..." para dar una respuesta más limpia
            const mensajes = chatMessages.querySelectorAll('.message-animation');
            if (mensajes.length > 0) {
                mensajes[mensajes.length - 1].remove();
            }

            const data = await response.json();

            // 3. Validar la respuesta del backend
            if (data.tipo !== 'success' || !data.checkout_url) {
                showToast(data.msg || 'Error al generar el proceso de pago.', 'error');
                addMessage("Hubo un problema al generar tu solicitud de pago. Por favor, intenta de nuevo más tarde.", "bot", true);
                return;
            }

            // 4. Informar al usuario y redirigir
            addMessage("¡Listo! Serás redirigido a la página de pago para completar tu reserva. Allí encontrarás Yape, tarjetas y otros métodos.", "bot");

            // Pequeña pausa para que el usuario pueda leer el mensaje
            setTimeout(() => {
                window.location.href = data.checkout_url;
            }, 2500); // 2.5 segundos de espera

        } catch (error) {
            console.error("Error en el flujo de pago:", error);
            showToast('Error de conexión al iniciar el pago.', 'error');
            addMessage("No pudimos conectar con el servicio de pagos. Por favor, inténtalo de nuevo.", "bot", true);
        }
    }
    function sendMessage() {
        const message = userInput.value.trim();
        if (!message || isTyping) return;

        // AÑADIMOS EL MENSAJE DEL USUARIO INMEDIATAMENTE A LA UI
        addMessage(message, 'user');

        userInput.value = '';
        userInput.style.height = 'auto';
        if (sendBtn) sendBtn.disabled = true;
        showTypingIndicator();

        fetch('chatbot.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'mensaje=' + encodeURIComponent(message)
        })
            .then(res => res.json())
            .then(data => {
                hideTypingIndicator();

                // **NUEVA LÓGICA DE ELIMINACIÓN**
                // Si el backend nos dice que el mensaje que acabamos de poner no
                // debería estar ahí, lo eliminamos.
                if (data.action === 'remove_last_user_message') {
                    const userMessages = chatMessages.querySelectorAll('.message-animation .justify-end');
                    if (userMessages.length > 0) {
                        userMessages[userMessages.length - 1].closest('.message-animation').remove();
                    }
                }

                if (data.action === 'initiate_payment_ui') {
                    addMessage(data.message, 'bot');
                    iniciarPagoMercadoPago();
                } else {
                    // La respuesta puede estar vacía si solo se quería eliminar el mensaje del usuario
                    if (data.respuesta) {
                        addMessage(data.respuesta, 'bot', false, null, data.historial_id);
                    }
                }
            })
            .catch(error => {
                hideTypingIndicator();
                addMessage('Hubo un problema al generar tu solicitud de pago. Por favor, intenta de nuevo más tarde.', 'bot', true);
                console.error('Error en fetch de sendMessage:', error);
            });
    }


    function addMessage(content, sender, isError = false, time = null, historial_id = null) {
        // --- INICIO DEL CAMBIO: Ocultar mensaje automático ---
        if (sender === 'user' && content === '[Acción automática post-login]') {
            return; // No hacer nada, simplemente salir de la función
        }
        // --- FIN DEL CAMBIO ---

        const messageDiv = document.createElement('div');
        messageDiv.className = 'message-animation';

        const messageTime = time || new Date().toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' });

        if (sender === 'user') {
            messageDiv.innerHTML = `
                <div class="flex items-start space-x-3 mb-6 justify-end">
                    <div class="flex-1 min-w-0 flex flex-col items-end">
                        <div class="bg-primary-500 text-white rounded-2xl rounded-tr-sm px-4 py-3 max-w-xs sm:max-w-md lg:max-w-lg">
                            <p>${content}</p> 
                        </div>
                        <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 mr-2">${messageTime}</div>
                    </div>
                    <div class="w-8 h-8 bg-primary-500 rounded-full flex items-center justify-center flex-shrink-0">
                        <i class="fas fa-user text-white text-sm"></i>
                    </div>
                </div>
            `;
        } else {
            let finalContent = content;
            const regexImagen = /\[IMAGEN:(.*?)\]/g;
            finalContent = finalContent.replace(regexImagen, (match, url) => {
                return `<img src="${url.trim()}" class="chat-image" alt="Vista del hotel" loading="lazy">`;
            });

            const isRegistroForm = finalContent.includes('id="registro-form"');
            const isLoginForm = finalContent.includes('id="login-form"');
            const isRecuperarForm = finalContent.includes('id="recuperar-form"');
            const isCambiarClaveForm = finalContent.includes('id="cambiar-clave-form"');

            if (!isRegistroForm && !isLoginForm && !isRecuperarForm && !isCambiarClaveForm) {
                // No se reemplaza \n para permitir HTML
            }

            messageDiv.innerHTML = `
            <div class="flex items-start space-x-3 mb-6">
                <div class="w-8 h-8 bg-gray-200 dark:bg-gray-700 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-robot text-gray-600 dark:text-gray-300 text-sm"></i>
                </div>
                <div class="flex-1 min-w-0">
                    <div class="bg-white dark:bg-gray-800 ${isError ? 'border-red-200 dark:border-red-800' : 'border-gray-200 dark:border-gray-700'} rounded-2xl rounded-tl-sm px-4 py-3 shadow-sm border max-w-xs sm:max-w-md lg:max-w-lg">
                        <div class="${isError ? 'text-red-600 dark:text-red-400' : 'text-gray-800 dark:text-gray-200'}">
                            ${finalContent}
                        </div>
                    </div>
                    <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 ml-2">
                        ${messageTime}
                        ${historial_id ? `
                        <div class="feedback-container mt-2 flex items-center space-x-3" data-message-id="${historial_id}">
                            <button class="feedback-btn text-gray-400 hover:text-primary-500 transition-colors" data-feedback="like">
                                <i class="fas fa-thumbs-up"></i>
                            </button>
                            <button class="feedback-btn text-gray-400 hover:text-red-500 transition-colors" data-feedback="dislike">
                                <i class="fas fa-thumbs-down"></i>
                            </button>
                        </div>
                        ` : ''}
                    </div>
                </div>
            </div>
        `;
        }

        chatMessages.appendChild(messageDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;

        if (sender === 'bot') {
            const addedMessageContent = messageDiv.innerHTML;
            if (addedMessageContent.includes('id="registro-form"')) inicializarFormularioRegistro();
            if (addedMessageContent.includes('id="login-form"')) inicializarFormularioLogin();
            if (addedMessageContent.includes('id="recuperar-form"')) inicializarFormularioRecuperar();
            if (addedMessageContent.includes('id="cambiar-clave-form"')) inicializarFormularioCambioClave();
        }
    }

    function showTypingIndicator() {
        isTyping = true;
        const typingDiv = document.createElement('div');
        typingDiv.id = 'typing-indicator';
        typingDiv.className = 'message-animation';
        typingDiv.innerHTML = `
            <div class="flex items-start space-x-3 mb-6">
                <div class="w-8 h-8 bg-gray-200 dark:bg-gray-700 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-robot text-gray-600 dark:text-gray-300 text-sm"></i>
                </div>
                <div class="flex-1 min-w-0">
                    <div class="bg-white dark:bg-gray-800 rounded-2xl rounded-tl-sm px-4 py-3 shadow-sm border border-gray-200 dark:border-gray-700">
                        <div class="typing-dots flex space-x-1">
                            <span class="w-2 h-2 bg-gray-400 dark:bg-gray-500 rounded-full"></span>
                            <span class="w-2 h-2 bg-gray-400 dark:bg-gray-500 rounded-full"></span>
                            <span class="w-2 h-2 bg-gray-400 dark:bg-gray-500 rounded-full"></span>
                        </div>
                    </div>
                </div>
            </div>
        `;
        chatMessages.appendChild(typingDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function hideTypingIndicator() {
        isTyping = false;
        const typingIndicator = document.getElementById('typing-indicator');
        if (typingIndicator) {
            typingIndicator.remove();
        }
    }

    function clearChat() {
        fetch('api/auth/clear_chat_session.php');
        setTimeout(() => { window.location.reload(); }, 200);
    }

    function handleResetToken() {
        const urlParams = new URLSearchParams(window.location.search);
        const resetToken = urlParams.get('reset_token');

        if (resetToken) {
            window.history.replaceState({}, document.title, window.location.pathname);
            addMessage('He llegado desde el enlace de recuperación de contraseña.', 'user');
            showTypingIndicator();

            fetch('chatbot.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'mensaje=' + encodeURIComponent(`[Internal] reset_password_with_token:${resetToken}`)
            })
                .then(res => res.text()) // Cambiado a text() porque la respuesta es HTML
                .then(data => {
                    hideTypingIndicator();
                    addMessage(data, 'bot', false, null);
                })
                .catch(error => {
                    hideTypingIndicator();
                    addMessage('Hubo un error al verificar tu solicitud. Por favor, intenta de nuevo desde el correo.', 'bot', true);
                    console.error('Error:', error);
                });
        }
    }

    // AÑADE ESTA NUEVA FUNCIÓN COMPLETA
    async function checkPendingActions() {
        try {
            const response = await fetch('api/chat/check_pending_action.php');
            const data = await response.json();

            if (!data || data.action === 'none') {
                return; // No hay acciones pendientes
            }

            // Función auxiliar para verificar si el mensaje ya existe
            const messageAlreadyExists = (content) => {
                const existingMessages = document.querySelectorAll('.message-animation .text-gray-800, .message-animation .text-gray-200');
                return Array.from(existingMessages).some(
                    msg => msg.textContent.includes(content.substring(0, 30)) // Compara los primeros 30 caracteres
                );
            };

            // Caso 1: Mensaje simple (pago exitoso)
            if (data.action === 'add_pending_message') {
                if (!messageAlreadyExists(data.message.content)) {
                    addMessage(data.message.content, 'bot', false, null, data.message.historial_id);
                }
            }
            // Caso 2: Mensaje con botón (reserva pendiente)
            else if (data.action === 'add_pending_message_with_button') {
                const buttonHtml = `
                <div class='mt-2'>
                    <button class='quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3' 
                            data-question='${data.message.button.data_question}'>
                        ${data.message.button.text}
                    </button>
                </div>`;

                const fullContent = data.message.content + buttonHtml;

                if (!messageAlreadyExists(data.message.content)) {
                    addMessage(fullContent, 'bot', false, null, data.message.historial_id);
                }
            }

            // Limpiar la acción pendiente después de procesarla
            if (data.action !== 'none') {
                await fetch('api/chat/clear_pending_action.php'); // Nuevo endpoint para limpiar
            }

        } catch (error) {
            console.error('Error checking pending actions:', error);
            // Opcional: Mostrar mensaje de error al usuario
            addMessage("Ocurrió un error al cargar acciones pendientes.", "bot", true);
        }
    }

    async function loadChatHistory() {
        try {
            const response = await fetch('api/chat/get_history.php');
            const history = await response.json();

            // Limpia los mensajes existentes SÓLO si hay historial que cargar
            if (history.length > 0) {
                const welcomeMessage = chatMessages.querySelector('.message-animation');
                if (welcomeMessage) {
                    chatMessages.innerHTML = '';
                    chatMessages.appendChild(welcomeMessage);
                }
            }

            history.forEach(msg => {
                addMessage(msg.content, msg.sender, false, msg.time, msg.historial_id);
            });
        } catch (error) {
            console.error('Error al cargar el historial del chat:', error);
        }
    }

    function showToast(message, type = 'info') {
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer);
                toast.addEventListener('mouseleave', Swal.resumeTimer);
            }
        });

        Toast.fire({
            icon: type,
            title: message
        });
    }

    // --- INICIALIZACIÓN AL CARGAR LA PÁGINA ---

    // Función para manejar el resultado del pago que viene en la URL
    // En main.js
    async function handlePaymentResult() {
        const urlParams = new URLSearchParams(window.location.search);
        if (!urlParams.has('collection_status')) return false;

        try {
            addMessage("Procesando tu pago...", "bot");
            const response = await fetch(`api/pagos/verificar_pago.php?${urlParams.toString()}`);
            const data = await response.json();

            window.history.replaceState({}, document.title, window.location.pathname);

            if (data.status === 'processed') {
                // Eliminar el mensaje "Procesando..." antes de recargar
                const messages = document.querySelectorAll('.message-animation');
                if (messages.length > 1) messages[messages.length - 1].remove();

                window.location.reload();
            }
            return true;
        } catch (error) {
            console.error("Error:", error);
            return true;
        }
    }

    // Función de inicialización principal que controla el orden
    async function initializeChat() {
        if (userInput) {
            userInput.focus();
        }

        // 1. Manejar resultado de pago primero
        const paymentWasProcessed = await handlePaymentResult();
        if (paymentWasProcessed) return;

        // 2. Cargar historial
        await loadChatHistory();

        // 3. Verificar acciones pendientes (incluyendo pre-reserva)
        await checkPendingActions();

        // 4. Manejar otros casos
        handleResetToken();
    }

    // Llamamos a nuestra función de inicialización para empezar todo
    initializeChat();

    // --- FIN DE INICIALIZACIÓN ---


    // Este script se encargará de la lógica de los formularios de autenticación dentro del chat.

    // Función que se llama cuando el bot renderiza el formulario de registro
    function inicializarFormularioRegistro() {
        const form = document.getElementById('registro-form');
        if (!form) return; // Salir si el formulario no está en el DOM

        const dniInput = form.querySelector('#chat-dni');
        const nombreInput = form.querySelector('#chat-nombre');
        const apellidoInput = form.querySelector('#chat-apellido');
        const claveInput = form.querySelector('#chat-clave');
        const confirmarInput = form.querySelector('#chat-confirmar');
        const registerBtn = form.querySelector('#chat-register-btn');
        const passwordRulesContainer = form.querySelector('#password-rules');
        const timerEl = form.querySelector('#form-timer');

        let dniIntentos = 2;

        // --- LÓGICA DEL TEMPORIZADOR ---
        let tiempoRestante = 300; // 5 minutos en segundos
        const timerInterval = setInterval(() => {
            tiempoRestante--;
            const minutos = Math.floor(tiempoRestante / 60).toString().padStart(2, '0');
            const segundos = (tiempoRestante % 60).toString().padStart(2, '0');
            timerEl.textContent = `Tiempo restante: ${minutos}:${segundos}`;

            if (tiempoRestante <= 0) {
                clearInterval(timerInterval);
                timerEl.textContent = 'Tiempo expirado.';
                // Deshabilitar todo el formulario
                form.querySelectorAll('input, button').forEach(el => el.disabled = true);
                // El bot podría enviar un mensaje aquí si quisiéramos
            }
        }, 1000);

        // --- LÓGICA DE DNI ---
        dniInput.addEventListener('blur', async () => {
            const dni = dniInput.value.trim();
            if (dni.length !== 8 || !/^\d+$/.test(dni)) return;
            if (dniIntentos <= 0) {
                showToast('Has excedido el número de intentos para consultar el DNI.', 'error');
                return;
            }

            dniInput.disabled = true;

            try {
                const formData = new FormData();
                formData.append('dni', dni);

                const response = await fetch('api/utils/verificar_dni.php', {
                    method: 'POST',
                    body: formData
                });

                const data = await response.json();

                if (response.ok && data.success) {
                    nombreInput.value = data.nombres;
                    apellidoInput.value = data.apellidos;
                } else {
                    showToast(data.message || 'No se encontraron datos para el DNI.', 'error');
                    nombreInput.value = '';
                    apellidoInput.value = '';
                }
            } catch (error) {
                console.error('Error en fetch DNI:', error);
                showToast('Hubo un problema al conectar con el servicio de DNI.', 'error');
            } finally {
                dniInput.disabled = false;
                dniIntentos--;
                const attemptsMsg = form.querySelector('#dni-attempts-msg');
                if (attemptsMsg) attemptsMsg.textContent = `Intentos restantes: ${dniIntentos}`;
            }
        });

        // --- LÓGICA DE CONTRASEÑA ---
        claveInput.addEventListener('input', () => {
            const clave = claveInput.value;
            passwordRulesContainer.style.display = 'block';

            const check = (id, condition) => {
                const el = document.getElementById(id);
                if (el) {
                    el.className = condition ? 'valid flex items-center text-green-500' : 'invalid flex items-center text-red-500';
                    el.querySelector('i').className = condition ? 'fas fa-check-circle mr-2' : 'fas fa-times-circle mr-2';
                }
            };

            check('length-check', clave.length >= 8);
            check('uppercase-check', /[A-Z]/.test(clave));
            check('number-check', /[0-9]/.test(clave));
            check('special-check', /[\W_]/.test(clave));

            validarFormularioCompleto();
        });

        claveInput.addEventListener('blur', () => {
            if (!claveInput.value) passwordRulesContainer.style.display = 'none';
        });

        confirmarInput.addEventListener('input', () => {
            const msgEl = document.getElementById('password-match-msg');
            if (confirmarInput.value && claveInput.value === confirmarInput.value) {
                msgEl.textContent = 'Las contraseñas coinciden.';
                msgEl.className = 'text-xs text-green-500';
            } else if (confirmarInput.value) {
                msgEl.textContent = 'Las contraseñas no coinciden.';
                msgEl.className = 'text-xs text-red-500';
            } else {
                msgEl.textContent = '';
            }
            validarFormularioCompleto();
        });

        // --- LÓGICA DE SUBMIT ---
        registerBtn.addEventListener('click', async () => {
            const datosRegistro = {
                dni: form.querySelector('#chat-dni').value,
                nombre: form.querySelector('#chat-nombre').value,
                apellido: form.querySelector('#chat-apellido').value,
                usuario: form.querySelector('#chat-usuario').value,
                correo: form.querySelector('#chat-correo').value,
                clave: form.querySelector('#chat-clave').value,
            };

            const chatSessionId = sessionStorage.getItem('chat_session_id'); // Usamos sessionStorage
            if (chatSessionId) {
                datosRegistro.anon_id = chatSessionId;
            }

            try {
                const response = await fetch('api/auth/registrar.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(datosRegistro) // Ahora lleva el anon_id
                });

                const result = await response.json();
                showToast(result.msg, result.tipo === 'success' ? 'success' : 'error');

                if (response.ok && result.tipo === 'success') {
                    clearInterval(timerInterval); // Detiene el temporizador del formulario

                    // Muestra la notificación de éxito
                    showToast(result.msg, 'success');

                    // Espera 1.5 segundos para que el usuario pueda leer el mensaje y LUEGO recarga la página.
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);

                } else {
                    // Muestra el mensaje de error si algo falla
                    showToast(result.msg, result.tipo || 'error');
                }

            } catch (error) {
                console.error('Error en registro:', error);
                showToast('Ocurrió un error inesperado al registrar la cuenta.', 'error');
            } finally {
                registerBtn.disabled = false;
                registerBtn.textContent = 'Crear Mi Cuenta';
            }
        });

        function validarFormularioCompleto() {
            const esValido =
                form.querySelector('#chat-nombre').value.trim() !== '' &&
                form.querySelector('#chat-usuario').value.trim() !== '' &&
                form.querySelector('#chat-correo').value.trim() !== '' &&
                form.querySelector('#chat-clave').value === form.querySelector('#chat-confirmar').value &&
                form.querySelectorAll('#password-rules .valid').length === 4 &&
                form.querySelector('#chat-terminos').checked;

            registerBtn.disabled = !esValido;
        }

        ['chat-usuario', 'chat-correo', 'chat-terminos', 'chat-clave', 'chat-confirmar'].forEach(id => {
            const el = form.querySelector(`#${id}`);
            if (el) {
                el.addEventListener('input', validarFormularioCompleto);
                el.addEventListener('change', validarFormularioCompleto);
            }
        });
    }

    // Esta función se llamará cuando el bot envíe el formulario de login.
    // REEMPLAZA OTRA VEZ TODA LA FUNCIÓN EN auth-form.js CON ESTA VERSIÓN COMPLETA

    function inicializarFormularioLogin() {
        const todosLosBotonesLogin = document.querySelectorAll('#chat-login-btn');

        todosLosBotonesLogin.forEach(loginBtn => {
            if (loginBtn.dataset.listenerAttached) {
                return;
            }

            loginBtn.dataset.listenerAttached = 'true';

            // --- LÓGICA DEL CAPTCHA REINTRODUCIDA ---
            // Buscamos el formulario contenedor y su captcha
            const form = loginBtn.closest('#login-form');
            if (!form) return;
            const captchaContainer = form.querySelector('#captcha-container');
            //const esEntornoLocal = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'; 
            const esEntornoLocal = true; // <-- ¡FORZANDO MODO LOCAL PARA DESACTIVAR CAPTCHA!



            if (esEntornoLocal) {
                if (captchaContainer) {
                    captchaContainer.innerHTML = '<p class="text-xs text-yellow-500 text-center italic">CAPTCHA desactivado en entorno local.</p>';
                }
                loginBtn.disabled = false; // Habilitamos el botón directamente en local
            } else {
                loginBtn.disabled = true; // Deshabilitado por defecto en producción
                if (typeof window.turnstile !== 'undefined' && captchaContainer) {
                    window.turnstile.render(captchaContainer, {
                        sitekey: '0x4AAAAAAA30cAZZr49ACK72', // Reemplaza con tu sitekey real
                        callback: function (token) {
                            loginBtn.disabled = false;
                        },
                        'expired-callback': function () {
                            loginBtn.disabled = true;
                        },
                        theme: document.documentElement.classList.contains('dark') ? 'dark' : 'light'
                    });
                } else {
                    if (captchaContainer) {
                        captchaContainer.innerHTML = '<p class="text-xs text-red-500 text-center">Error al cargar el verificador de seguridad.</p>';
                    }
                }
            }
            // --- FIN DE LA LÓGICA DEL CAPTCHA ---

            loginBtn.addEventListener('click', async (event) => {
                // El resto de la función (el evento click) se mantiene exactamente igual que en la versión anterior.
                // ... (toda la lógica de fetch, manejo de respuesta, etc.) ...
                const form = event.target.closest('#login-form');
                if (!form) return;

                const userInput = form.querySelector('#chat-login-user');
                const passInput = form.querySelector('#chat-login-clave');

                const user = userInput.value.trim();
                const clave = passInput.value.trim();

                if (!user || !clave) {
                    showToast('Por favor, ingresa tu usuario y contraseña.', 'warning');
                    return;
                }

                const captchaInput = form.querySelector('[name="cf-turnstile-response"]');
                const captchaToken = captchaInput ? captchaInput.value : '';

                if (!esEntornoLocal && !captchaToken) {
                    showToast('Completa la verificación de seguridad.', 'warning');
                    return;
                }

                loginBtn.textContent = 'Ingresando...';
                loginBtn.disabled = true;

                const formData = new FormData();
                formData.append('usuario', user);
                formData.append('clave', clave);
                formData.append('cf-turnstile-response', captchaToken);

                try {
                    const response = await fetch('api/auth/login.php', {
                        method: 'POST',
                        body: formData,
                        credentials: 'same-origin'
                    });
                    const result = await response.json();

                    if (response.ok && result.tipo === 'success') {

                        if (typeof actualizarHeaderUsuario === 'function') {
                            actualizarHeaderUsuario(result.userName);
                        }

                        showToast(result.msg, 'success');
                        setTimeout(() => {
                            window.location.reload();
                        }, 1000); // Pequeña espera para que el usuario vea el mensaje de éxito.

                    } else {
                        showToast(result.msg, 'error');
                        const attemptsMsgEl = form.querySelector('#login-attempts-msg');
                        if (attemptsMsgEl && result.intentos_restantes !== undefined) {
                            if (result.intentos_restantes > 0) {
                                attemptsMsgEl.textContent = `Intentos restantes: ${result.intentos_restantes}`;
                                attemptsMsgEl.style.color = '#EF4444';
                            } else {
                                attemptsMsgEl.textContent = 'Has sido bloqueado temporalmente.';
                            }
                        }
                        if (!esEntornoLocal && typeof window.turnstile !== 'undefined') {
                            window.turnstile.reset(captchaContainer);
                        }
                    }
                } catch (error) {
                    console.error('Error en el login:', error);
                    showToast('Ocurrió un error inesperado. Inténtalo de nuevo.', 'error');
                } finally {
                    loginBtn.textContent = 'Ingresar';
                    loginBtn.disabled = false;
                }
            });
        });
    }

    // --- AÑADE ESTA NUEVA FUNCIÓN A auth-form.js ---

    function inicializarFormularioCambioClave() {
        const form = document.getElementById('cambiar-clave-form');
        if (!form) return;

        const cambiarBtn = form.querySelector('#chat-cambiar-btn');

        cambiarBtn.addEventListener('click', async () => {
            const token = form.querySelector('#chat-token-hidden').value;
            const nuevaClave = form.querySelector('#chat-nueva-clave').value;
            const confirmarClave = form.querySelector('#chat-confirmar-clave').value;

            if (nuevaClave.length < 8) {
                addMessage('La contraseña debe tener al menos 8 caracteres.', 'bot', true);
                return;
            }
            if (nuevaClave !== confirmarClave) {
                addMessage('Las contraseñas no coinciden.', 'bot', true);
                return;
            }

            cambiarBtn.disabled = true;
            cambiarBtn.textContent = 'Actualizando...';

            const formData = new FormData();
            formData.append('token', token);
            formData.append('nueva_clave', nuevaClave);

            try {
                // El endpoint final que crearemos en el próximo paso
                const response = await fetch('api/auth/restablecer_clave.php', {
                    method: 'POST',
                    body: formData
                });
                const result = await response.json();

                addMessage(result.msg, 'bot', result.tipo !== 'success');
                if (result.tipo === 'success') {
                    form.remove(); // Limpiamos el formulario del chat
                }
            } catch (error) {
                console.error('Error al restablecer la clave:', error);
                addMessage('Ocurrió un error inesperado al cambiar la contraseña.', 'bot', true);
            } finally {
                cambiarBtn.disabled = false;
                cambiarBtn.textContent = 'Restablecer Contraseña';
            }
        });
    }

    function inicializarFormularioRecuperar() {
        const form = document.getElementById('recuperar-form');
        if (!form) return; // Salir si el formulario no está

        const recuperarBtn = form.querySelector('#chat-recuperar-btn');
        const correoInput = form.querySelector('#chat-recuperar-correo');

        recuperarBtn.addEventListener('click', async () => {
            const correo = correoInput.value.trim();

            if (!correo || !/^\S+@\S+\.\S+$/.test(correo)) {
                // Usamos la función addMessage para notificar al usuario en el chat
                showToast('Por favor, introduce una dirección de correo válida.', 'warning');
                return;
            }

            // Deshabilitar el botón para evitar clics múltiples
            recuperarBtn.disabled = true;
            recuperarBtn.textContent = 'Enviando...';

            try {
                const formData = new FormData();
                formData.append('correo', correo);

                // Haremos la petición a un nuevo endpoint que crearemos en el siguiente paso
                const response = await fetch('api/auth/enviar_recuperacion.php', {
                    method: 'POST',
                    body: formData
                });

                const result = await response.json();

                // Mostramos el resultado (éxito o error) como un nuevo mensaje del bot
                addMessage(result.msg, 'bot', (result.tipo !== 'success'));

                // Si el envío fue exitoso, podemos opcionalmente ocultar o eliminar el formulario
                if (result.tipo === 'success') {
                    form.remove();
                }

            } catch (error) {
                console.error('Error al enviar el correo de recuperación:', error);
                addMessage('Hubo un problema de conexión. Por favor, inténtalo más tarde.', 'bot', true);
            } finally {
                // Volvemos a habilitar el botón en caso de error
                recuperarBtn.disabled = false;
                recuperarBtn.textContent = 'Enviar Enlace de Recuperación';
            }
        });
    }

});