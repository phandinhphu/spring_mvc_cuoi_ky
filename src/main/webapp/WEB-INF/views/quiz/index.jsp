<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz - Nihongo Study</title>
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
                            <h2 class="mb-3"><i class="fas fa-question-circle me-2"></i>Bài kiểm tra Quiz</h2>
                            <p class="text-muted mb-0">Kiểm tra kiến thức từ vựng tiếng Nhật của bạn</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats -->
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="stat-card text-center">
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary mx-auto">
                            <i class="fas fa-list"></i>
                        </div>
                        <div class="stat-value text-primary">${totalQuizzes}</div>
                        <div class="stat-label">Tổng số quiz</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="stat-card text-center">
                        <div class="stat-icon bg-success bg-opacity-10 text-success mx-auto">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-value text-success">${completedQuizzes}</div>
                        <div class="stat-label">Đã hoàn thành</div>
                    </div>
                </div>
            </div>

            <!-- Quiz List -->
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-star text-warning me-2"></i>Quiz cơ bản - N5</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="badge bg-success me-2">Cấp độ: N5</span>
                                <span class="badge bg-info">10 câu hỏi</span>
                            </div>
                            <p class="text-muted">Kiểm tra kiến thức từ vựng cơ bản tiếng Nhật cấp độ N5</p>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between small mb-1">
                                    <span>Tiến độ hoàn thành</span>
                                    <span>50%</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-success" style="width: 50%"></div>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/quiz/start" class="btn btn-primary btn-custom flex-grow-1">
                                    <i class="fas fa-play me-2"></i>Bắt đầu
                                </a>
                                <button class="btn btn-outline-secondary">
                                    <i class="fas fa-info-circle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-fire text-danger me-2"></i>Quiz nâng cao - N4</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="badge bg-warning me-2">Cấp độ: N4</span>
                                <span class="badge bg-info">15 câu hỏi</span>
                            </div>
                            <p class="text-muted">Thử thách với từ vựng nâng cao cấp độ N4</p>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between small mb-1">
                                    <span>Tiến độ hoàn thành</span>
                                    <span>20%</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-warning" style="width: 20%"></div>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/quiz/start" class="btn btn-warning btn-custom flex-grow-1">
                                    <i class="fas fa-play me-2"></i>Bắt đầu
                                </a>
                                <button class="btn btn-outline-secondary">
                                    <i class="fas fa-info-circle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-graduation-cap text-primary me-2"></i>Quiz Kanji</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="badge bg-primary me-2">Chuyên đề</span>
                                <span class="badge bg-info">12 câu hỏi</span>
                            </div>
                            <p class="text-muted">Luyện tập đọc và hiểu chữ Kanji</p>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between small mb-1">
                                    <span>Tiến độ hoàn thành</span>
                                    <span>0%</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-primary" style="width: 0%"></div>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/quiz/start" class="btn btn-primary btn-custom flex-grow-1">
                                    <i class="fas fa-play me-2"></i>Bắt đầu
                                </a>
                                <button class="btn btn-outline-secondary">
                                    <i class="fas fa-info-circle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-headphones text-success me-2"></i>Quiz nghe</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="badge bg-success me-2">Chuyên đề</span>
                                <span class="badge bg-info">10 câu hỏi</span>
                            </div>
                            <p class="text-muted">Kiểm tra khả năng nghe hiểu tiếng Nhật</p>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between small mb-1">
                                    <span>Tiến độ hoàn thành</span>
                                    <span>30%</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-success" style="width: 30%"></div>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/quiz/start" class="btn btn-success btn-custom flex-grow-1">
                                    <i class="fas fa-play me-2"></i>Bắt đầu
                                </a>
                                <button class="btn btn-outline-secondary">
                                    <i class="fas fa-info-circle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- History -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-history me-2"></i>Lịch sử làm bài</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Quiz</th>
                                            <th>Điểm</th>
                                            <th>Thời gian</th>
                                            <th>Ngày làm</th>
                                            <th>Kết quả</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Quiz cơ bản - N5</td>
                                            <td><strong>80/100</strong></td>
                                            <td>5 phút 30 giây</td>
                                            <td>01/12/2024</td>
                                            <td><span class="badge bg-success">Đạt</span></td>
                                        </tr>
                                        <tr>
                                            <td>Quiz Kanji</td>
                                            <td><strong>65/100</strong></td>
                                            <td>7 phút 15 giây</td>
                                            <td>30/11/2024</td>
                                            <td><span class="badge bg-warning">Trung bình</span></td>
                                        </tr>
                                        <tr>
                                            <td>Quiz nghe</td>
                                            <td><strong>90/100</strong></td>
                                            <td>6 phút 00 giây</td>
                                            <td>29/11/2024</td>
                                            <td><span class="badge bg-success">Xuất sắc</span></td>
                                        </tr>
                                    </tbody>
                                </table>
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
