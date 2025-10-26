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

// Send button click
sendBtn.addEventListener('click', sendMessage);

// Quick questions
document.addEventListener('click', function (e) {
    const button = e.target.closest('.quick-question');
    if (button) {
        const question = button.getAttribute('data-question');
        userInput.value = question;
        userInput.focus();
        sendMessage();
    }
});

// Clear chat
clearChatBtn.addEventListener('click', clearChat);

function sendMessage() {
    const message = userInput.value.trim();
    if (!message || isTyping) return;

    // CORRECCIÓN: Añadir los parámetros que faltan.
    addMessage(message, 'user', false, null);

    userInput.value = '';
    userInput.style.height = 'auto';
    sendBtn.disabled = true;
    showTypingIndicator();

    fetch('chatbot.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'mensaje=' + encodeURIComponent(message)
    })
    .then(res => res.text())
    .then(data => {
        hideTypingIndicator();
        // CORRECCIÓN: También aquí.
        addMessage(data, 'bot', false, null);
    })
    .catch(error => {
        hideTypingIndicator();
        // CORRECCIÓN: Y aquí.
        addMessage('Lo siento, ha ocurrido un error. Por favor, inténtalo de nuevo.', 'bot', true, null);
        console.error('Error:', error);
    });
}

function addMessage(content, sender, isError = false, time = null) {
    const messageDiv = document.createElement('div');
    messageDiv.className = 'message-animation';

    const messageTime = time || new Date().toLocaleTimeString('es-ES', {
        hour: '2-digit',
        minute: '2-digit'
    });

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

        if (!isRegistroForm && !isLoginForm) {
            finalContent = finalContent.replace(/\n/g, '<br>');
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
                    <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 ml-2">${messageTime}</div>
                </div>
            </div>
        `;
    }

    chatMessages.appendChild(messageDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;

    const scripts = messageDiv.getElementsByTagName('script');
    for (let i = 0; i < scripts.length; i++) {
        new Function(scripts[i].innerText)();
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

async function loadChatHistory() {
    try {
        const response = await fetch('api/chat/get_history.php');
        const history = await response.json();

        if (history.length > 0) {
            chatMessages.innerHTML = ''; 
            history.forEach(msg => {
                addMessage(msg.content, msg.sender, false, msg.time);
            });
        }
    } catch (error) {
        console.error('Error al cargar el historial del chat:', error);
    }
}

document.addEventListener('DOMContentLoaded', function () {
    userInput.focus();
    loadChatHistory();
});

function actualizarHeaderUsuario(nombreUsuario) {
    const userStatusDiv = document.getElementById('user-status');
    if (!userStatusDiv) return;

    const loggedInHTML = `
        <div class="w-6 h-6 bg-primary-500 rounded-full flex items-center justify-center cursor-pointer" id="user-avatar-btn">
            <i class="fas fa-user-check text-white text-xs"></i>
        </div>
        <span class="text-sm font-medium text-gray-700 dark:text-gray-300 hidden sm:block">
            ${nombreUsuario}
        </span>
        <div id="user-menu" class="absolute top-12 right-0 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg py-1 z-20 hidden">
            <a href="#" class="block px-4 py-2 text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700">Ajustes</a>
            <a href="api/auth/logout.php" class="block px-4 py-2 text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700">Cerrar Sesión</a>
        </div>
    `;

    userStatusDiv.innerHTML = loggedInHTML;
    userStatusDiv.classList.add('relative');

    const avatarBtn = document.getElementById('user-avatar-btn');
    const userMenu = document.getElementById('user-menu');

    if (avatarBtn && userMenu) {
        avatarBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            userMenu.classList.toggle('hidden');
        });
    }
}

document.addEventListener('click', (e) => {
    const userMenu = document.getElementById('user-menu');
    if (userMenu && !userMenu.contains(e.target) && !userMenu.classList.contains('hidden')) {
        userMenu.classList.add('hidden');
    }
});