/**
 * Chatbot Logic
 * Xử lý kết nối WebSocket và giao diện chat
 */

document.addEventListener('DOMContentLoaded', function () {
    // Các phần tử DOM
    const chatBtn = document.getElementById('chatWidgetBtn');
    const chatWindow = document.getElementById('chatWindow');
    const closeChatBtn = document.getElementById('closeChatBtn');
    const msgInput = document.getElementById('chatInput');
    const sendBtn = document.getElementById('sendBtn');
    const messagesContainer = document.getElementById('chatMessages');
    const typingIndicator = document.getElementById('typingIndicator');

    let socket = null;
    let isConnected = false;

    // Toggle Chat Window
    chatBtn.addEventListener('click', () => {
        if (chatWindow.style.display === 'none' || !chatWindow.style.display) {
            chatWindow.style.display = 'flex';
            connectWebSocket(); // Kết nối khi mở chat
            scrollToBottom();
        } else {
            chatWindow.style.display = 'none';
        }
    });

    closeChatBtn.addEventListener('click', () => {
        chatWindow.style.display = 'none';
    });

    // Gửi tin nhắn
    function sendMessage() {
        const message = msgInput.value.trim();
        if (message && isConnected) {
            // Hiển thị tin nhắn người dùng
            appendMessage(message, 'user');
            msgInput.value = '';

            // Gửi qua WebSocket
            socket.send(message);

            // Hiện loading
            showTyping(true);
            scrollToBottom();
        } else if (!isConnected) {
            appendMessage("Mất kết nối server. Đang thử kết nối lại...", 'bot');
            connectWebSocket();
        }
    }

    sendBtn.addEventListener('click', sendMessage);
    msgInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });

    // Hàm kết nối WebSocket
    function connectWebSocket() {
        if (socket && socket.readyState === WebSocket.OPEN) return;

        // Xác định URL WebSocket (tự động lấy host và context path)
        const protocol = window.location.protocol === 'https:' ? 'wss://' : 'ws://';
        // Biến contextPath được định nghĩa ở footer.jsp
        const wsUrl = protocol + window.location.host + contextPath + "/chat";

        console.log("Connecting to WebSocket: " + wsUrl);

        socket = new WebSocket(wsUrl);

        socket.onopen = function () {
            console.log("WebSocket Connected");
            isConnected = true;
            // Nếu đây là lần kết nối đầu tiên (hoặc không có tin nhắn), có thể gửi tin chào
            if (messagesContainer.children.length === 0) {
                appendMessage("Konnichiwa! Mình là trợ lý học tiếng Nhật. Bạn cần giúp gì không?", 'bot');
            }
        };

        socket.onmessage = function (event) {
            showTyping(false);
            const response = event.data;
            appendMessage(response, 'bot');
            scrollToBottom();
        };

        socket.onclose = function (event) {
            console.log("WebSocket Closed");
            isConnected = false;
        };

        socket.onerror = function (error) {
            console.error("WebSocket Error: " + error);
            showTyping(false);
        };
    }

    // Hàm hiển thị tin nhắn lên giao diện
    function appendMessage(text, sender) {
        const div = document.createElement('div');
        div.classList.add('message', sender);
        div.innerText = text; // Sử dụng innerText để tránh XSS đơn giản
        messagesContainer.appendChild(div);
    }

    function scrollToBottom() {
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }

    function showTyping(show) {
        typingIndicator.style.display = show ? 'block' : 'none';
    }
});
