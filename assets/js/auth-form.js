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
            alert('Has excedido el número de intentos para consultar el DNI.');
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
                alert(data.message || 'No se encontraron datos para el DNI.');
                nombreInput.value = '';
                apellidoInput.value = '';
            }
        } catch (error) {
            console.error('Error en fetch DNI:', error);
            alert('Hubo un problema al conectar con el servicio de DNI.');
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
            alert(result.msg); // Reemplazar con una notificación más elegante

            if (response.ok && result.tipo === 'success') {
                clearInterval(timerInterval); // Detener el temporizador
                // Recargar la página para que el header muestre el nuevo estado de sesión
                window.location.reload();
            }
        } catch (error) {
            console.error('Error en registro:', error);
            alert('Ocurrió un error inesperado al registrar la cuenta.');
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
function inicializarFormularioLogin() {
    const form = document.getElementById('login-form');
    if (!form) {
        console.error("No se encontró el formulario de login en el DOM.");
        return;
    }

    const loginBtn = form.querySelector('#chat-login-btn');
    const userInput = form.querySelector('#chat-login-user');
    const passInput = form.querySelector('#chat-login-clave');
    const captchaContainer = form.querySelector('#captcha-container');

    const esEntornoLocal = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';

    if (esEntornoLocal) {
        if (captchaContainer) {
            captchaContainer.innerHTML = '<p class="text-xs text-yellow-500 text-center italic">CAPTCHA desactivado en entorno local.</p>';
        }
        loginBtn.disabled = false;
    } else {
        loginBtn.disabled = true; 

        if (typeof window.turnstile !== 'undefined') {
            window.turnstile.render(captchaContainer, {
                sitekey: '0x4AAAAAAA30cAZZr49ACK72',
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
                captchaContainer.innerHTML = '<p class="text-xs text-red-500 text-center">Error al cargar el verificador de seguridad. Intenta recargar la página.</p>';
            }
        }
    }

    loginBtn.addEventListener('click', async () => {
        const user = userInput.value.trim();
        const clave = passInput.value.trim();
        const captchaInput = form.querySelector('[name="cf-turnstile-response"]');
        const captchaToken = captchaInput ? captchaInput.value : '';

        if (!user || !clave) {
            alert('Por favor, ingresa tu usuario y contraseña.');
            return;
        }

        if (!esEntornoLocal && !captchaToken) {
            alert('Por favor, completa la verificación de seguridad (CAPTCHA).');
            return;
        }

        loginBtn.textContent = 'Ingresando...';
        loginBtn.disabled = true;

        const formData = new FormData();
        formData.append('usuario', user);
        formData.append('clave', clave);
        formData.append('cf-turnstile-response', captchaToken);

        const chatSessionId = sessionStorage.getItem('chat_session_id');
        if (chatSessionId) {
            formData.append('anon_id', chatSessionId);
        }

        try {
            const response = await fetch('api/auth/login.php', {
                method: 'POST',
                body: formData
            });

            const result = await response.json();

            if (response.ok && result.tipo === 'success') {
                alert(result.msg);

                window.location.reload(); 

                if (typeof actualizarHeaderUsuario === 'function') {
                    actualizarHeaderUsuario(result.userName);
                }

                const formToRemove = document.getElementById('registro-form') || document.getElementById('login-form');
                // CORRECCIÓN APLICADA AQUÍ:
                if (formToRemove) formToRemove.closest('.message-animation').remove();

            } else {
                alert(result.msg);
                const attemptsMsg = form.querySelector('#login-attempts-msg');
                if (attemptsMsg && result.intentos_restantes !== undefined) {
                    attemptsMsg.textContent = `Intentos restantes: ${result.intentos_restantes}`;
                }

                if (!esEntornoLocal && typeof window.turnstile !== 'undefined') {
                    window.turnstile.reset(captchaContainer);
                } else {
                    loginBtn.disabled = false;
                }
            }

        } catch (error) {
            console.error('Error en el login:', error);
            alert('Ocurrió un error inesperado. Inténtalo de nuevo.');
            loginBtn.disabled = false;
        } finally {
            loginBtn.textContent = 'Ingresar';
        }
    });
}