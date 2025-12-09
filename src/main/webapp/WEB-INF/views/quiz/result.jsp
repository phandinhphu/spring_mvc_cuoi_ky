<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả Quiz - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Result Card -->
                    <div class="card mb-4">
                        <div class="card-body text-center py-5">
                            <c:choose>
                                <c:when test="${passed}">
                                    <div class="mb-4">
                                        <i class="fas fa-check-circle text-success" style="font-size: 80px;"></i>
                                    </div>
                                    <h2 class="text-success mb-3">Chúc mừng! Bạn đã đạt</h2>
                                </c:when>
                                <c:otherwise>
                                    <div class="mb-4">
                                        <i class="fas fa-times-circle text-warning" style="font-size: 80px;"></i>
                                    </div>
                                    <h2 class="text-warning mb-3">Cố gắng lên!</h2>
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="display-4 mb-4 text-primary">
                                <strong>${score}/${total}</strong>
                            </div>
                            
                            <div class="h4 mb-4">
                                Tỷ lệ chính xác: <strong class="text-success">${percentage}%</strong>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <div class="p-3 bg-light rounded">
                                        <div class="h2 mb-1 text-success">${score}</div>
                                        <div class="text-muted">Câu đúng</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3 bg-light rounded">
                                        <div class="h2 mb-1 text-danger">${total - score}</div>
                                        <div class="text-muted">Câu sai</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3 bg-light rounded">
                                        <div class="h2 mb-1 text-primary">${total}</div>
                                        <div class="text-muted">Tổng câu</div>
                                    </div>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${percentage >= 80}">
                                    <div class="alert alert-success">
                                        <i class="fas fa-star me-2"></i>
                                        <strong>Xuất sắc!</strong> Bạn đã nắm vững kiến thức. Tiếp tục phát huy!
                                    </div>
                                </c:when>
                                <c:when test="${percentage >= 60}">
                                    <div class="alert alert-info">
                                        <i class="fas fa-thumbs-up me-2"></i>
                                        <strong>Khá tốt!</strong> Bạn đang trên đúng hướng. Hãy luyện tập thêm!
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning">
                                        <i class="fas fa-lightbulb me-2"></i>
                                        <strong>Cần cố gắng thêm!</strong> Hãy ôn tập lại và thử lại nhé!
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <a href="${pageContext.request.contextPath}/quiz/start" class="btn btn-primary w-100 btn-custom">
                                        <i class="fas fa-redo me-2"></i>Làm lại
                                    </a>
                                </div>
                                <div class="col-md-4">
                                    <a href="${pageContext.request.contextPath}/quiz/" class="btn btn-outline-primary w-100">
                                        <i class="fas fa-list me-2"></i>Danh sách Quiz
                                    </a>
                                </div>
                                <div class="col-md-4">
                                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary w-100">
                                        <i class="fas fa-home me-2"></i>Dashboard
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Share Results -->
                    <div class="card mt-3">
                        <div class="card-body text-center">
                            <h6 class="mb-3">Chia sẻ kết quả</h6>
                            <div class="d-flex justify-content-center gap-2">
                                <button class="btn btn-outline-primary">
                                    <i class="fab fa-facebook-f me-2"></i>Facebook
                                </button>
                                <button class="btn btn-outline-info">
                                    <i class="fab fa-twitter me-2"></i>Twitter
                                </button>
                                <button class="btn btn-outline-success">
                                    <i class="fab fa-whatsapp me-2"></i>WhatsApp
                                </button>
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
        // Confetti animation for good scores
        <c:if test="${percentage >= 80}">
        console.log('🎉 Congratulations!');
        </c:if>
    </script>
</body>
</html>
