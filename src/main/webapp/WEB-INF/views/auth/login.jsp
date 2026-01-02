<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Nihongo Study</title>
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
                            <i class="fas fa-language text-primary" style="font-size: 48px;"></i>
                            <h2 class="mt-3 mb-2">Nihongo Study</h2>
                            <p class="text-muted">Đăng nhập để tiếp tục học tập</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty message}">
                            <div class="alert alert-info alert-dismissible fade show" role="alert">
                                <i class="fas fa-info-circle me-2"></i>${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/auth/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user me-2"></i>Tên đăng nhập
                                </label>
                                <input type="text" class="form-control form-control-lg" id="username" 
                                       name="username" placeholder="Nhập tên đăng nhập" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Mật khẩu
                                </label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form-control-lg" id="password" 
                                           name="password" placeholder="Nhập mật khẩu" required>
                                    <button type="button" class="btn btn-link position-absolute top-50 end-0 translate-middle-y" 
                                            id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">
                                    Ghi nhớ đăng nhập
                                </label>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg btn-custom">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </button>
                            </div>

                            <div class="text-center mb-3">
                                <a href="#" class="text-decoration-none">Quên mật khẩu?</a>
                            </div>

                            <hr class="my-4">

                            <div class="text-center">
                                <p class="text-muted mb-3">Hoặc đăng nhập với</p>
                                <div class="d-flex gap-2 justify-content-center">
                                    <button type="button" class="btn btn-outline-primary flex-fill"
                                           onclick="window.location.href='${pageContext.request.contextPath}/auth/oauth2/authorize/google'">
                                        <i class="fab fa-google me-2"></i>Google
                                    </button>
                                </div>
                            </div>

                            <hr class="my-4">

                            <div class="text-center">
                                <p class="mb-0">Chưa có tài khoản? 
                                    <a href="${pageContext.request.contextPath}/auth/register" class="text-decoration-none fw-bold">
                                        Đăng ký ngay
                                    </a>
                                </p>
                            </div>
                        </form>

                        <div class="mt-4 text-center">
                            <small class="text-muted">
                                Demo: admin / 123456
                            </small>
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/" class="text-white text-decoration-none">
                            <i class="fas fa-arrow-left me-2"></i>Về trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>
</body>
</html>
