<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng ký - Nihongo Study</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
</head>
<body>
	<div class="auth-container">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="auth-card p-4">
						<div class="text-center mb-4">
							<i class="fas fa-language text-primary" style="font-size: 48px;"></i>
							<h2 class="mt-3 mb-2">Tạo tài khoản mới</h2>
							<p class="text-muted">Bắt đầu hành trình học tiếng Nhật của
								bạn</p>
						</div>

						<c:if test="${not empty error}">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								<i class="fas fa-exclamation-circle me-2"></i>${error}
								<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
							</div>
						</c:if>

						<form action="${pageContext.request.contextPath}/auth/register"
							method="post" id="registerForm">
							<div class="row">
								<div class="col-md-6 mb-3">
									<label for="username" class="form-label"> <i
										class="fas fa-user me-2"></i>Tên đăng nhập
									</label> <input type="text" class="form-control" id="username"
										name="username" placeholder="Nhập tên đăng nhập" required>
									<div class="invalid-feedback">Vui lòng nhập tên đăng nhập
									</div>
								</div>

								<div class="col-md-6 mb-3">
									<label for="email" class="form-label"> <i
										class="fas fa-envelope me-2"></i>Email
									</label> <input type="email" class="form-control" id="email"
										name="email" placeholder="email@example.com" required>
									<div class="invalid-feedback">Vui lòng nhập email hợp lệ
									</div>
								</div>
							</div>

							<div class="mb-3">
								<label for="password" class="form-label"> <i
									class="fas fa-lock me-2"></i>Mật khẩu
								</label>
								<div class="position-relative">
									<input type="password" class="form-control" id="password"
										name="password" placeholder="Nhập mật khẩu" required
										minlength="6">
									<button type="button"
										class="btn btn-link position-absolute top-50 end-0 translate-middle-y"
										id="togglePassword">
										<i class="fas fa-eye"></i>
									</button>
								</div>
								<div class="form-text">Mật khẩu phải có ít nhất 6 ký tự</div>
							</div>

							<div class="mb-3">
								<label for="confirmPassword" class="form-label"> <i
									class="fas fa-lock me-2"></i>Xác nhận mật khẩu
								</label>
								<div class="position-relative">
									<input type="password" class="form-control"
										id="confirmPassword" name="confirmPassword"
										placeholder="Nhập lại mật khẩu" required>
									<button type="button"
										class="btn btn-link position-absolute top-50 end-0 translate-middle-y"
										id="toggleConfirmPassword">
										<i class="fas fa-eye"></i>
									</button>
								</div>
								<div class="invalid-feedback" id="passwordMismatch">Mật
									khẩu không khớp</div>
							</div>

							<div class="d-grid mb-3">
								<button type="submit" class="btn btn-primary btn-lg btn-custom">
									<i class="fas fa-user-plus me-2"></i>Đăng ký
								</button>
							</div>

							<hr class="my-4">

							<div class="text-center">
								<p class="text-muted mb-3">Hoặc đăng ký với</p>
								<div class="d-flex gap-2 justify-content-center">
									<button type="button" class="btn btn-outline-primary flex-fill"
										onclick="window.location.href='${pageContext.request.contextPath}/auth/oauth2/authorize/google'">
										<i class="fab fa-google me-2"></i>Google
									</button>
								</div>
							</div>

							<hr class="my-4">

							<div class="text-center">
								<p class="mb-0">
									Đã có tài khoản? <a
										href="${pageContext.request.contextPath}/auth/login"
										class="text-decoration-none fw-bold"> Đăng nhập </a>
								</p>
							</div>
						</form>
					</div>

					<div class="text-center mt-3">
						<a href="${pageContext.request.contextPath}/"
							class="text-white text-decoration-none"> <i
							class="fas fa-arrow-left me-2"></i>Về trang chủ
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// Toggle password visibility
		document.getElementById('togglePassword').addEventListener('click',
				function() {
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

		document.getElementById('toggleConfirmPassword').addEventListener(
				'click',
				function() {
					const confirmPassword = document
							.getElementById('confirmPassword');
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

		// Validate password match
		document
				.getElementById('registerForm')
				.addEventListener(
						'submit',
						function(e) {
							const password = document
									.getElementById('password').value;
							const confirmPassword = document
									.getElementById('confirmPassword').value;

							if (password !== confirmPassword) {
								e.preventDefault();
								document.getElementById('confirmPassword').classList
										.add('is-invalid');
								document.getElementById('passwordMismatch').style.display = 'block';
							} else {
								document.getElementById('confirmPassword').classList
										.remove('is-invalid');
								document.getElementById('passwordMismatch').style.display = 'none';
							}
						});

		// Remove invalid class on input
		document.getElementById('confirmPassword').addEventListener('input',
				function() {
					this.classList.remove('is-invalid');
				});
	</script>
</body>
</html>
