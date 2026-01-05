<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không tìm thấy trang - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            text-align: center;
            color: white;
        }
        .error-code {
            font-size: 120px;
            font-weight: bold;
            line-height: 1;
            text-shadow: 4px 4px 8px rgba(0,0,0,0.3);
            animation: bounce 2s infinite;
        }
        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }
        .error-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 600px;
            margin: 0 auto;
        }
        .error-title {
            color: #333;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .error-message {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .btn-home {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 50px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
            color: white;
        }
        .btn-back {
            background: white;
            border: 2px solid #667eea;
            color: #667eea;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 50px;
            transition: all 0.3s;
            margin-left: 10px;
        }
        .btn-back:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        .suggestions {
            text-align: left;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e0e0e0;
        }
        .suggestions h5 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
        .suggestions ul {
            list-style: none;
            padding: 0;
        }
        .suggestions li {
            padding: 10px 0;
            color: #666;
        }
        .suggestions li i {
            color: #667eea;
            margin-right: 10px;
            width: 20px;
        }
        .suggestions a {
            color: #667eea;
            text-decoration: none;
            transition: all 0.3s;
        }
        .suggestions a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle text-warning"></i>
            </div>
            <div class="error-code">404</div>
            <h1 class="error-title">Oops! Không tìm thấy trang</h1>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger mx-auto" style="max-width: 500px;" role="alert">
                    <i class="fas fa-info-circle me-2"></i>${error}
                </div>
            </c:if>
            
            <p class="error-message">
                Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển. 
                Có thể liên kết đã hết hạn hoặc URL không chính xác.
            </p>
            
            <div class="d-flex justify-content-center flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/" class="btn btn-home">
                    <i class="fas fa-home me-2"></i>Về trang chủ
                </a>
                <button onclick="history.back()" class="btn btn-back">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                </button>
            </div>
            
            <div class="suggestions">
                <h5><i class="fas fa-lightbulb me-2"></i>Gợi ý cho bạn:</h5>
                <ul>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        Kiểm tra lại URL có chính xác không
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <a href="${pageContext.request.contextPath}/dashboard">Truy cập trang chủ</a>
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a> để truy cập đầy đủ tính năng
                    </li>
                    <li>
                        <i class="fas fa-check-circle"></i>
                        Liên hệ với chúng tôi nếu bạn cần hỗ trợ
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="mt-4">
            <p class="text-white">
                <small>
                    <i class="fas fa-question-circle me-2"></i>
                    Cần hỗ trợ? Liên hệ: support@nihongostudy.com
                </small>
            </p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto redirect after 10 seconds (optional)
        // setTimeout(function() {
        //     window.location.href = '${pageContext.request.contextPath}/';
        // }, 10000);
    </script>
</body>
</html>
