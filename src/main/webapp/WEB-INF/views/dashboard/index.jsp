<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <!-- Welcome Section -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h2 class="mb-1">Xin chào, ${username}! 👋</h2>
                                    <p class="text-muted mb-0">Chào mừng bạn trở lại. Hãy tiếp tục hành trình học tập của mình!</p>
                                </div>
                                <div class="streak-badge">
                                    <i class="fas fa-fire"></i>
                                    <span>${streak} ngày</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-value text-primary">${totalWords}</div>
                        <div class="stat-label">Tổng từ vựng</div>
                        <div class="progress progress-custom mt-2">
                            <div class="progress-bar bg-primary" style="width: 75%"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon bg-success bg-opacity-10 text-success">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-value text-success">${learnedWords}</div>
                        <div class="stat-label">Đã học</div>
                        <div class="progress progress-custom mt-2">
                            <div class="progress-bar bg-success" style="width: 56%"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="stat-value text-warning">${accuracy}%</div>
                        <div class="stat-label">Độ chính xác</div>
                        <div class="progress progress-custom mt-2">
                            <div class="progress-bar bg-warning" style="width: 87.5%"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon bg-info bg-opacity-10 text-info">
                            <i class="fas fa-fire"></i>
                        </div>
                        <div class="stat-value text-info">${streak}</div>
                        <div class="stat-label">Streak hiện tại</div>
                        <div class="progress progress-custom mt-2">
                            <div class="progress-bar bg-info" style="width: 60%"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Hành động nhanh</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <a href="${pageContext.request.contextPath}/practice/flashcard" class="btn btn-primary w-100 btn-custom">
                                        <i class="fas fa-layer-group me-2"></i>Flashcard
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="${pageContext.request.contextPath}/quiz/start" class="btn btn-success w-100 btn-custom">
                                        <i class="fas fa-question-circle me-2"></i>Làm Quiz
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="${pageContext.request.contextPath}/vocabulary/search" class="btn btn-info w-100 btn-custom">
                                        <i class="fas fa-search me-2"></i>Tra từ
                                    </a>
                                </div>
                                <div class="col-md-3">
                                    <a href="${pageContext.request.contextPath}/statistics/" class="btn btn-warning w-100 btn-custom">
                                        <i class="fas fa-chart-bar me-2"></i>Thống kê
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Today's Goal & Recent Activity -->
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-target me-2"></i>Mục tiêu hôm nay</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Học 20 từ mới</span>
                                    <span class="fw-bold">12/20</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-primary progress-bar-animated" style="width: 60%"></div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Hoàn thành 2 quiz</span>
                                    <span class="fw-bold">1/2</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-success progress-bar-animated" style="width: 50%"></div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Luyện tập 30 phút</span>
                                    <span class="fw-bold">18/30</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-warning progress-bar-animated" style="width: 60%"></div>
                                </div>
                            </div>
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-lightbulb me-2"></i>
                                Bạn đang làm rất tốt! Tiếp tục phát huy nhé!
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-history me-2"></i>Hoạt động gần đây</h5>
                        </div>
                        <div class="card-body">
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 px-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-primary bg-opacity-10 text-primary me-3" style="width: 40px; height: 40px; font-size: 16px;">
                                            <i class="fas fa-layer-group"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Luyện tập Flashcard</div>
                                            <small class="text-muted">15 từ vựng - 5 phút trước</small>
                                        </div>
                                        <span class="badge bg-primary">+15 XP</span>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 px-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-success bg-opacity-10 text-success me-3" style="width: 40px; height: 40px; font-size: 16px;">
                                            <i class="fas fa-question-circle"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Hoàn thành Quiz cơ bản</div>
                                            <small class="text-muted">Điểm: 80/100 - 1 giờ trước</small>
                                        </div>
                                        <span class="badge bg-success">+25 XP</span>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 px-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-info bg-opacity-10 text-info me-3" style="width: 40px; height: 40px; font-size: 16px;">
                                            <i class="fas fa-book"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Thêm từ vào sổ tay</div>
                                            <small class="text-muted">5 từ mới - 2 giờ trước</small>
                                        </div>
                                        <span class="badge bg-info">+5 XP</span>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 px-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-warning bg-opacity-10 text-warning me-3" style="width: 40px; height: 40px; font-size: 16px;">
                                            <i class="fas fa-headphones"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Luyện nghe</div>
                                            <small class="text-muted">10 từ vựng - Hôm qua</small>
                                        </div>
                                        <span class="badge bg-warning">+10 XP</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
