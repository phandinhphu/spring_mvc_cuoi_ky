<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="auth-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="auth-card p-4">
                        <div class="text-center mb-4">
                            <i class="fas fa-key text-primary" style="font-size: 48px;"></i>
                            <h2 class="mt-3 mb-2">Quên mật khẩu</h2>
                            <p class="text-muted">Nhập email của bạn để nhận liên kết đặt lại mật khẩu</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/auth/forgot-password" method="post" id="forgotPasswordForm">
                            <div class="mb-4">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope me-2"></i>Email
                                </label>
                                <input type="email" class="form-control form-control-lg" id="email" 
                                       name="email" placeholder="Nhập địa chỉ email của bạn" required>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Chúng tôi sẽ gửi liên kết đặt lại mật khẩu đến email này
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg btn-custom" id="submitBtn">
                                    <i class="fas fa-paper-plane me-2"></i>Gửi liên kết đặt lại mật khẩu
                                </button>
                            </div>

                            <hr class="my-4">

                            <div class="text-center">
                                <p class="mb-0">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none">
                                        Quay lại đăng nhập
                                    </a>
                                </p>
                            </div>
                        </form>

                        <div class="mt-4 pt-4 border-top text-center">
                            <p class="text-muted mb-2"><small><i class="fas fa-shield-alt me-2"></i>Bảo mật & An toàn</small></p>
                            <p class="text-muted"><small>Liên kết đặt lại mật khẩu sẽ hết hạn sau 15 phút</small></p>
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/" class="text-white text-decoration-none">
                            <i class="fas fa-home me-2"></i>Về trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation and loading state
        document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            const email = document.getElementById('email').value;
            
            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Vui lòng nhập địa chỉ email hợp lệ!');
                return;
            }
            
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
        });
    </script>
</body>
</html>
