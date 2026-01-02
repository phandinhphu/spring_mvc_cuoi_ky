<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ người dùng - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card shadow-sm text-center p-4">
                        <div class="mb-3">
							<c:choose>
								<c:when test="${not empty user.avatar}">
									<img src="${user.avatar}" class="rounded-circle img-thumbnail"
										style="width: 150px; height: 150px; object-fit: cover;"
										alt="Avatar" />
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/resources/images/default-avatar.png"
										class="rounded-circle img-thumbnail"
										style="width: 150px; height: 150px; object-fit: cover;"
										alt="Avatar" />
								</c:otherwise>
							</c:choose>
						</div>
                        <h4 class="mb-1">${not empty user.fullname ? user.fullname : user.username}</h4>
                        <p class="text-muted">@${user.username}</p>
                        <p class="text-muted">
						    Ngày tạo: <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy" />
						</p>
                        
						<form action="${pageContext.request.contextPath}/profile/update-avatar" method="post" enctype="multipart/form-data">
					        <input type="file" name="file" id="avatarInput" class="d-none" accept="image/*" onchange="this.form.submit()">
					        
					        <button type="button" class="btn btn-outline-primary btn-sm w-100 mt-2" onclick="document.getElementById('avatarInput').click()">
					            <i class="fas fa-camera me-2"></i> Cập nhật ảnh hồ sơ
					        </button>
					    </form>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow-sm p-4">
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show">
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <ul class="nav nav-tabs mb-4" id="profileTab" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#info">Thông tin</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#pass">Đổi mật khẩu</button>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="info">
                                <form action="${pageContext.request.contextPath}/profile/update-profile" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">Tên hiển thị</label>
                                        <input type="text" name="fullname" class="form-control" value="${not empty user.fullname ? user.fullname : user.username}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="${user.email}" disabled>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                </form>
                            </div>

                            <div class="tab-pane fade" id="pass">
                                <form action="${pageContext.request.contextPath}/profile/change-password" method="post" id="changePasswordForm">
                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu hiện tại</label>
                                        <input type="password" name="oldPassword" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu mới</label>
                                        <input type="password" name="newPassword" id="newPassword" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
							            <label class="form-label">Nhập lại mật khẩu mới</label>
							            <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
							            <div id="passwordError" class="text-danger small" style="display:none;">Mật khẩu nhập lại không khớp.</div>
							        </div>
                                    <button type="submit" class="btn btn-danger" id="btnSubmitPassword">Cập nhật mật khẩu</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layouts/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
		document.addEventListener("DOMContentLoaded", function() {
		    const form = document.getElementById("changePasswordForm");
		    const newPassword = document.getElementById("newPassword");
		    const confirmPassword = document.getElementById("confirmPassword");
		    const passwordError = document.getElementById("passwordError");
		    const btnSubmit = document.getElementById("btnSubmitPassword");
		
		    // Hàm kiểm tra sự trùng khớp
		    function checkPasswordMatch() {
		        const pass = newPassword.value;
		        const confirmPass = confirmPassword.value;
		
		        // Chỉ kiểm tra khi ô "Nhập lại" đã có dữ liệu
		        if (confirmPass.length > 0) {
		            if (pass !== confirmPass) {
		                // Không khớp: Hiện lỗi, đỏ viền, khóa nút
		                passwordError.style.display = "block";
		                confirmPassword.classList.add("is-invalid");
		                btnSubmit.disabled = true;
		            } else {
		                // Khớp: Ẩn lỗi, xanh viền, mở nút
		                passwordError.style.display = "none";
		                confirmPassword.classList.remove("is-invalid");
		                confirmPassword.classList.add("is-valid");
		                btnSubmit.disabled = false;
		            }
		        } else {
		            // Nếu xóa trắng ô nhập lại thì reset trạng thái
		            passwordError.style.display = "none";
		            confirmPassword.classList.remove("is-invalid", "is-valid");
		            btnSubmit.disabled = false;
		        }
		    }
		
		    // Lắng nghe sự kiện gõ phím trên cả 2 ô mật khẩu
		    newPassword.addEventListener("input", checkPasswordMatch);
		    confirmPassword.addEventListener("input", checkPasswordMatch);
		});
	</script>
</body>
</html>