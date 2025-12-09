<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luyện tập - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="mb-3"><i class="fas fa-dumbbell me-2"></i>Luyện tập từ vựng</h2>
                            <p class="text-muted mb-0">Chọn phương pháp luyện tập phù hợp với bạn</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card text-center">
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary mx-auto">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-value text-primary">${totalWords}</div>
                        <div class="stat-label">Tổng từ vựng</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card text-center">
                        <div class="stat-icon bg-success bg-opacity-10 text-success mx-auto">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-value text-success">${todayPracticed}</div>
                        <div class="stat-label">Đã luyện hôm nay</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card text-center">
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning mx-auto">
                            <i class="fas fa-fire"></i>
                        </div>
                        <div class="stat-value text-warning">5</div>
                        <div class="stat-label">Streak</div>
                    </div>
                </div>
            </div>

            <!-- Practice Modes -->
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <div class="stat-icon bg-primary bg-opacity-10 text-primary mx-auto mb-3" style="width: 80px; height: 80px; font-size: 32px;">
                                <i class="fas fa-layer-group"></i>
                            </div>
                            <h4 class="mb-3">Flashcard</h4>
                            <p class="text-muted mb-4">Lật thẻ để học từ vựng với các chế độ: nghĩa, cách đọc, kanji</p>
                            
                            <div class="d-grid gap-2 mb-3">
                                <a href="${pageContext.request.contextPath}/practice/flashcard?mode=meaning" class="btn btn-outline-primary">
                                    <i class="fas fa-language me-2"></i>Luyện nghĩa
                                </a>
                                <a href="${pageContext.request.contextPath}/practice/flashcard?mode=reading" class="btn btn-outline-primary">
                                    <i class="fas fa-book-reader me-2"></i>Luyện cách đọc
                                </a>
                                <a href="${pageContext.request.contextPath}/practice/flashcard?mode=kanji" class="btn btn-outline-primary">
                                    <i class="fas fa-kanji me-2"></i>Luyện kanji
                                </a>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/practice/flashcard" class="btn btn-primary btn-lg w-100 btn-custom">
                                <i class="fas fa-play me-2"></i>Bắt đầu
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <div class="stat-icon bg-success bg-opacity-10 text-success mx-auto mb-3" style="width: 80px; height: 80px; font-size: 32px;">
                                <i class="fas fa-headphones"></i>
                            </div>
                            <h4 class="mb-3">Luyện nghe</h4>
                            <p class="text-muted mb-4">Nghe phát âm và chọn đáp án đúng. Cải thiện khả năng nghe hiểu</p>
                            
                            <div class="alert alert-success mb-4">
                                <i class="fas fa-info-circle me-2"></i>
                                <small>Hỗ trợ phát âm chuẩn native speaker</small>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/practice/listening" class="btn btn-success btn-lg w-100 btn-custom">
                                <i class="fas fa-play me-2"></i>Bắt đầu
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <div class="stat-icon bg-warning bg-opacity-10 text-warning mx-auto mb-3" style="width: 80px; height: 80px; font-size: 32px;">
                                <i class="fas fa-keyboard"></i>
                            </div>
                            <h4 class="mb-3">Điền từ (Romaji)</h4>
                            <p class="text-muted mb-4">Gõ chữ cái để hoàn thành từ vựng. Luyện tập phản xạ và ghi nhớ</p>
                            
                            <div class="alert alert-warning mb-4">
                                <i class="fas fa-lightbulb me-2"></i>
                                <small>Luyện tập với bàn phím Romaji</small>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/practice/typing" class="btn btn-warning btn-lg w-100 btn-custom">
                                <i class="fas fa-play me-2"></i>Bắt đầu
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tips -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Mẹo luyện tập hiệu quả</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="d-flex mb-3">
                                        <i class="fas fa-check-circle text-success me-3 mt-1"></i>
                                        <div>
                                            <strong>Luyện tập đều đặn</strong>
                                            <p class="text-muted small mb-0">Học 15-20 phút mỗi ngày hiệu quả hơn học dồn</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex mb-3">
                                        <i class="fas fa-sync-alt text-primary me-3 mt-1"></i>
                                        <div>
                                            <strong>Kết hợp nhiều phương pháp</strong>
                                            <p class="text-muted small mb-0">Xen kẽ flashcard, nghe và điền từ</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex mb-3">
                                        <i class="fas fa-redo text-warning me-3 mt-1"></i>
                                        <div>
                                            <strong>Ôn tập thường xuyên</strong>
                                            <p class="text-muted small mb-0">Lặp lại từ đã học sau 1, 3, 7 ngày</p>
                                        </div>
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
