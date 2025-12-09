<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nihongo Study - Học tiếng Nhật hiệu quả</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="layouts/header.jsp" />

    <main>
        <!-- Hero Section -->
        <section class="bg-primary text-white py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 mb-4 mb-lg-0">
                        <h1 class="display-4 fw-bold mb-3">Học tiếng Nhật thông minh</h1>
                        <p class="lead mb-4">Ứng dụng học từ vựng tiếng Nhật với nhiều phương pháp luyện tập hiệu quả</p>
                        <div class="d-flex gap-3">
                            <a href="${pageContext.request.contextPath}/vocabulary/search" class="btn btn-light btn-lg btn-custom">
                                <i class="fas fa-search me-2"></i>Tra từ ngay
                            </a>
                            <a href="${pageContext.request.contextPath}/practice/" class="btn btn-outline-light btn-lg btn-custom">
                                <i class="fas fa-dumbbell me-2"></i>Luyện tập
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="text-center">
                            <i class="fas fa-graduation-cap" style="font-size: 200px; opacity: 0.2;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="stat-card text-center">
                            <div class="stat-icon bg-primary bg-opacity-10 text-primary mx-auto">
                                <i class="fas fa-fire"></i>
                            </div>
                            <div class="stat-value text-primary">${streak} ngày</div>
                            <div class="stat-label">Streak hiện tại</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card text-center">
                            <div class="stat-icon bg-success bg-opacity-10 text-success mx-auto">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="stat-value text-success">${totalWords}</div>
                            <div class="stat-label">Tổng từ vựng</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card text-center">
                            <div class="stat-icon bg-info bg-opacity-10 text-info mx-auto">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-value text-info">${todayWords}</div>
                            <div class="stat-label">Học hôm nay</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-5">Tính năng nổi bật</h2>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="stat-icon bg-primary bg-opacity-10 text-primary mx-auto mb-3">
                                    <i class="fas fa-search"></i>
                                </div>
                                <h5 class="card-title">Tra từ đa chiều</h5>
                                <p class="card-text text-muted">Tìm kiếm bằng Hiragana, Katakana, Kanji hoặc tiếng Việt</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="stat-icon bg-success bg-opacity-10 text-success mx-auto mb-3">
                                    <i class="fas fa-layer-group"></i>
                                </div>
                                <h5 class="card-title">Flashcard thông minh</h5>
                                <p class="card-text text-muted">Luyện tập với từ vựng, nghĩa, cách đọc</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="stat-icon bg-warning bg-opacity-10 text-warning mx-auto mb-3">
                                    <i class="fas fa-headphones"></i>
                                </div>
                                <h5 class="card-title">Luyện nghe</h5>
                                <p class="card-text text-muted">Nghe phát âm chuẩn và luyện tập</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="stat-icon bg-danger bg-opacity-10 text-danger mx-auto mb-3">
                                    <i class="fas fa-question-circle"></i>
                                </div>
                                <h5 class="card-title">Quiz đa dạng</h5>
                                <p class="card-text text-muted">Kiểm tra kiến thức với các bài quiz</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Practice Modes Section -->
        <section class="py-5">
            <div class="container">
                <h2 class="text-center mb-5">Phương pháp luyện tập</h2>
                <div class="row g-4">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-layer-group text-primary me-2"></i>Flashcard
                                </h5>
                                <p class="card-text">Lật thẻ để học từ vựng, nghĩa và cách đọc. Hỗ trợ nhiều chế độ luyện tập.</p>
                                <a href="${pageContext.request.contextPath}/practice/flashcard" class="btn btn-primary btn-custom">
                                    Bắt đầu <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-headphones text-success me-2"></i>Luyện nghe
                                </h5>
                                <p class="card-text">Nghe phát âm và chọn đáp án đúng. Cải thiện khả năng nghe hiểu tiếng Nhật.</p>
                                <a href="${pageContext.request.contextPath}/practice/listening" class="btn btn-success btn-custom">
                                    Bắt đầu <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-keyboard text-warning me-2"></i>Điền từ
                                </h5>
                                <p class="card-text">Gõ chữ cái để hoàn thành từ vựng bằng Romaji. Luyện tập phản xạ nhanh.</p>
                                <a href="${pageContext.request.contextPath}/practice/typing" class="btn btn-warning btn-custom">
                                    Bắt đầu <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="py-5 bg-primary text-white">
            <div class="container text-center">
                <h2 class="mb-4">Bắt đầu hành trình học tiếng Nhật ngay hôm nay!</h2>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light btn-lg btn-custom">
                    <i class="fas fa-rocket me-2"></i>Vào Dashboard
                </a>
            </div>
        </section>
    </main>

    <jsp:include page="layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
