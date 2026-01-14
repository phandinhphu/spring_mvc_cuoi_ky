<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h5><i class="fas fa-language me-2"></i>Nihongo Study</h5>
                <p class="text-muted">Ứng dụng học từ vựng tiếng Nhật hiệu quả và thông minh.</p>
            </div>
            <div class="col-md-4 mb-3">
                <h6>Liên kết nhanh</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/vocabulary/search" class="text-muted text-decoration-none">Tra từ</a></li>
                    <li><a href="${pageContext.request.contextPath}/practice/" class="text-muted text-decoration-none">Luyện tập</a></li>
                    <li><a href="${pageContext.request.contextPath}/quiz/" class="text-muted text-decoration-none">Quiz</a></li>
                    <li><a href="${pageContext.request.contextPath}/statistics/" class="text-muted text-decoration-none">Thống kê</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-3">
                <h6>Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-muted text-decoration-none">Hướng dẫn sử dụng</a></li>
                    <li><a href="#" class="text-muted text-decoration-none">Câu hỏi thường gặp</a></li>
                    <li><a href="#" class="text-muted text-decoration-none">Liên hệ</a></li>
                </ul>
            </div>
        </div>
        <hr class="bg-secondary">
        <div class="text-center text-muted">
            <p class="mb-0">&copy; 2024 Nihongo Study. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Chatbot Widget -->
<!-- 1. CSS Styles -->
<link href="${pageContext.request.contextPath}/resources/css/chat.css" rel="stylesheet">

<!-- 2. Chat Button -->
<div class="chat-widget-btn" id="chatWidgetBtn">
    <i class="fas fa-comments"></i>
</div>

<!-- 3. Chat Window -->
<div class="chat-window" id="chatWindow">
    <div class="chat-header">
        <h5>
		   	<span>Thời gian phản hồi đôi lúc hơi lâu, mong bạn thông cảm!</span>
		   	<br/>
        	<i class="fas fa-robot me-2"></i>Trợ lý tiếng Nhật
       	</h5>
        <button class="close-chat-btn" id="closeChatBtn">&times;</button>
    </div>
    
    <div class="chat-messages" id="chatMessages">
        <!-- Tin nhắn sẽ được thêm vào đây bằng JS -->
    </div>
    <div class="typing-indicator" id="typingIndicator">Bot đang nhập...</div>
    
    <div class="chat-input-area">
        <input type="text" id="chatInput" placeholder="Hỏi gì đó (Ví dụ: 'Mèo nghĩa là gì?')...">
        <button id="sendBtn"><i class="fas fa-paper-plane"></i></button>
    </div>
</div>

<!-- 4. Scripts -->
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
