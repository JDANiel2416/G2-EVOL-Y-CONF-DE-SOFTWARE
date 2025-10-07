let isTyping = false;

// Theme management
const themeToggle = document.getElementById('theme-toggle');
const htmlElement = document.documentElement;

// Check for saved theme preference or default to 'light'
const currentTheme = localStorage.getItem('theme') || 'light';

if (currentTheme === 'dark') {
    htmlElement.classList.add('dark');
}

themeToggle.addEventListener('click', function() {
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
userInput.addEventListener('input', function() {
    this.style.height = 'auto';
    this.style.height = Math.min(this.scrollHeight, 128) + 'px';
    sendBtn.disabled = !this.value.trim();
});

// Send message on Enter
userInput.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        sendMessage();
    }
});

// Send button click
sendBtn.addEventListener('click', sendMessage);

// Quick questions
document.addEventListener('click', function(e) {
    // Traverse up the DOM to find the button, useful for clicks on the icon inside
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
    
    // Add user message
    addMessage(message, 'user');
    
    // Clear input
    userInput.value = '';
    userInput.style.height = 'auto';
    sendBtn.disabled = true;
    
    // Show typing indicator
    showTypingIndicator();
    
    // Send to server (replace with your backend endpoint)
    fetch('chatbot.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'mensaje=' + encodeURIComponent(message)
    })
    .then(res => res.text())
    .then(data => {
        hideTypingIndicator();
        addMessage(data, 'bot');
    })
    .catch(error => {
        hideTypingIndicator();
        addMessage('Lo siento, ha ocurrido un error. Por favor, inténtalo de nuevo.', 'bot', true);
        console.error('Error:', error);
    });
}

function addMessage(content, sender, isError = false) {
    const messageDiv = document.createElement('div');
    messageDiv.className = 'message-animation';
    
    const time = new Date().toLocaleTimeString('es-ES', { 
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
                    <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 mr-2">${time}</div>
                </div>
                <div class="w-8 h-8 bg-primary-500 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-user text-white text-sm"></i>
                </div>
            </div>
        `;
    } else {
        messageDiv.innerHTML = `
            <div class="flex items-start space-x-3 mb-6">
                <div class="w-8 h-8 bg-gray-200 dark:bg-gray-700 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-robot text-gray-600 dark:text-gray-300 text-sm"></i>
                </div>
                <div class="flex-1 min-w-0">
                    <div class="bg-white dark:bg-gray-800 ${isError ? 'border-red-200 dark:border-red-800' : 'border-gray-200 dark:border-gray-700'} rounded-2xl rounded-tl-sm px-4 py-3 shadow-sm border max-w-xs sm:max-w-md lg:max-w-lg">
                        <p class="${isError ? 'text-red-600 dark:text-red-400' : 'text-gray-800 dark:text-gray-200'}">${content}</p>
                    </div>
                    <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 ml-2">${time}</div>
                </div>
            </div>
        `;
    }
    
    chatMessages.appendChild(messageDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
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
    chatMessages.innerHTML = `
        <div class="message-animation">
            <div class="flex items-start space-x-3 mb-6">
                <div class="w-8 h-8 bg-gray-200 dark:bg-gray-700 rounded-full flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-robot text-gray-600 dark:text-gray-300 text-sm"></i>
                </div>
                <div class="flex-1 min-w-0">
                    <div class="bg-white dark:bg-gray-800 rounded-2xl rounded-tl-sm px-4 py-3 shadow-sm border border-gray-200 dark:border-gray-700">
                        <p class="text-gray-800 dark:text-gray-200 mb-3">¡Hola! Soy el asistente virtual del hotel. ¿En qué puedo ayudarte hoy?</p>
                        
                        <div class="space-y-2">
                            <p class="text-sm text-gray-600 dark:text-gray-400 font-medium">Preguntas frecuentes:</p>
                            <div class="flex flex-wrap gap-2">
                                <button class="quick-question bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 px-3 py-2 rounded-full text-sm hover:bg-primary-100 dark:hover:bg-primary-900/30 transition-colors" data-question="¿Qué tipos de habitaciones tienes?">
                                    <i class="fas fa-bed mr-1"></i>
                                    Habitaciones
                                </button>
                                <button class="quick-question bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 px-3 py-2 rounded-full text-sm hover:bg-primary-100 dark:hover:bg-primary-900/30 transition-colors" data-question="¿Qué precios tienen las habitaciones?">
                                    <i class="fas fa-tags mr-1"></i>
                                    Precios
                                </button>
                                <button class="quick-question bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 px-3 py-2 rounded-full text-sm hover:bg-primary-100 dark:hover:bg-primary-900/30 transition-colors" data-question="¿Cómo puedo contactar al hotel?">
                                    <i class="fas fa-phone mr-1"></i>
                                    Contacto
                                </button>
                                <button class="quick-question bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 px-3 py-2 rounded-full text-sm hover:bg-primary-100 dark:hover:bg-primary-900/30 transition-colors" data-question="¿Qué calificaciones tiene el hotel?">
                                    <i class="fas fa-star mr-1"></i>
                                    Calificaciones
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="text-xs text-gray-500 dark:text-gray-400 mt-2 ml-2">Ahora</div>
                </div>
            </div>
        </div>
    `;
}

// Focus input on load
document.addEventListener('DOMContentLoaded', function() {
    userInput.focus();
});