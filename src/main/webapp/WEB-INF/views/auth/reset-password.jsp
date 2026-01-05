<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .password-strength {
            height: 5px;
            border-radius: 3px;
            transition: all 0.3s;
        }
        .password-strength-weak {
            background: linear-gradient(to right, #dc3545 0%, #dc3545 33%, #e9ecef 33%, #e9ecef 100%);
        }
        .password-strength-medium {
            background: linear-gradient(to right, #ffc107 0%, #ffc107 66%, #e9ecef 66%, #e9ecef 100%);
        }
        .password-strength-strong {
            background: linear-gradient(to right, #28a745 0%, #28a745 100%);
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="auth-card p-4">
                        <div class="text-center mb-4">
                            <i class="fas fa-lock-open text-primary" style="font-size: 48px;"></i>
                            <h2 class="mt-3 mb-2">Đặt lại mật khẩu</h2>
                            <p class="text-muted">Nhập mật khẩu mới cho tài khoản của bạn</p>
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

                        <form action="${pageContext.request.contextPath}/auth/reset-password" method="post" id="resetPasswordForm">
                            <input type="hidden" name="token" value="${token}">
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Mật khẩu mới
                                </label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form-control-lg" id="password" 
                                           name="password" placeholder="Nhập mật khẩu mới" required minlength="6">
                                    <button type="button" class="btn btn-link position-absolute top-50 end-0 translate-middle-y" 
                                            id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="password-strength mt-2" id="passwordStrength"></div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Mật khẩu phải có ít nhất 6 ký tự
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu
                                </label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form-control-lg" id="confirmPassword" 
                                           name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required minlength="6">
                                    <button type="button" class="btn btn-link position-absolute top-50 end-0 translate-middle-y" 
                                            id="toggleConfirmPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback" id="passwordMatchError">
                                    Mật khẩu xác nhận không khớp!
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg btn-custom">
                                    <i class="fas fa-check me-2"></i>Đặt lại mật khẩu
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

                        <div class="mt-4 pt-4 border-top">
                            <div class="alert alert-info mb-0" role="alert">
                                <i class="fas fa-shield-alt me-2"></i>
                                <strong>Mẹo bảo mật:</strong>
                                <ul class="mb-0 mt-2 ps-3">
                                    <li><small>Sử dụng ít nhất 8 ký tự</small></li>
                                    <li><small>Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt</small></li>
                                    <li><small>Không sử dụng thông tin cá nhân dễ đoán</small></li>
                                </ul>
                            </div>
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

        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const confirmPassword = document.getElementById('confirmPassword');
            const icon = this.querySelector('i');
            
            if (confirmPassword.type === 'password') {
                confirmPassword.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                confirmPassword.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrength');
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            strengthBar.className = 'password-strength mt-2';
            if (strength <= 2) {
                strengthBar.classList.add('password-strength-weak');
            } else if (strength <= 3) {
                strengthBar.classList.add('password-strength-medium');
            } else {
                strengthBar.classList.add('password-strength-strong');
            }
        });

        // Password match validation
        const form = document.getElementById('resetPasswordForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const matchError = document.getElementById('passwordMatchError');

        function checkPasswordMatch() {
            if (confirmPassword.value && password.value !== confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                matchError.style.display = 'block';
                return false;
            } else {
                confirmPassword.classList.remove('is-invalid');
                matchError.style.display = 'none';
                return true;
            }
        }

        confirmPassword.addEventListener('input', checkPasswordMatch);
        password.addEventListener('input', checkPasswordMatch);

        form.addEventListener('submit', function(e) {
            if (!checkPasswordMatch()) {
                e.preventDefault();
                return false;
            }
            
            if (password.value.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return false;
            }
        });
    </script>
</body>
</html>
