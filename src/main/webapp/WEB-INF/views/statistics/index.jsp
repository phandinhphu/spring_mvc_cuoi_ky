<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="mb-3"><i class="fas fa-chart-line me-2"></i>Thống kê học tập</h2>
                            <p class="text-muted mb-0">Theo dõi tiến độ và thành tích của bạn</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Stats -->
            <div class="row g-4 mb-4">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                            <i class="fas fa-fire"></i>
                        </div>
                        <div class="stat-value text-primary">${currentStreak}</div>
                        <div class="stat-label">Streak hiện tại</div>
                        <div class="mt-2 small text-muted">
                            <i class="fas fa-trophy me-1"></i>Cao nhất: ${longestStreak} ngày
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-success bg-opacity-10 text-success">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-value text-success">${learnedWords}</div>
                        <div class="stat-label">Từ đã học</div>
                        <div class="mt-2 small text-muted">
                            <i class="fas fa-list me-1"></i>Tổng: ${totalWords} từ
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <div class="stat-value text-warning">${accuracy}%</div>
                        <div class="stat-label">Độ chính xác</div>
                        <div class="mt-2 small text-muted">
                            <i class="fas fa-chart-line me-1"></i>Trung bình
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-info bg-opacity-10 text-info">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-value text-info">${totalPracticeTime}</div>
                        <div class="stat-label">Phút luyện tập</div>
                        <div class="mt-2 small text-muted">
                            <i class="fas fa-calendar me-1"></i>Tổng thời gian
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="row g-4 mb-4">
                <!-- Weekly Progress Chart -->
                <div class="col-lg-8">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Tiến độ tuần này</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="weeklyChart" height="80"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Practice Distribution -->
                <div class="col-lg-4">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-pie-chart me-2"></i>Phân bố luyện tập</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="practiceChart"></canvas>
                            <div class="mt-3">
                                <c:forEach var="entry" items="${practiceDistribution}">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>${entry.key}</span>
                                        <strong>${entry.value}%</strong>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Vocabulary Progress -->
            <div class="row g-4 mb-4">
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-book-open me-2"></i>Tiến độ từ vựng</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Đã học</span>
                                    <span><strong>${learnedWords}</strong> / ${totalWords}</span>
                                </div>
                                <div class="progress progress-custom">
                                    <div class="progress-bar bg-success" style="width: 56%"></div>
                                </div>
                            </div>

                            <div class="row g-3">
                                <div class="col-6">
                                    <div class="p-3 bg-light rounded text-center">
                                        <div class="h4 mb-1 text-success">${learnedWords}</div>
                                        <div class="small text-muted">Đã thành thạo</div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="p-3 bg-light rounded text-center">
                                        <div class="h4 mb-1 text-warning">${totalWords - learnedWords}</div>
                                        <div class="small text-muted">Đang học</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Achievements -->
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-trophy me-2"></i>Thành tích gần đây</h5>
                        </div>
                        <div class="card-body">
                            <div class="list-group list-group-flush">
                                <div class="list-group-item px-0 border-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-warning bg-opacity-10 text-warning me-3" style="width: 50px; height: 50px; font-size: 20px;">
                                            <i class="fas fa-fire"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Streak 5 ngày</div>
                                            <small class="text-muted">Học liên tục 5 ngày</small>
                                        </div>
                                        <span class="badge bg-warning">Hôm nay</span>
                                    </div>
                                </div>
                                <div class="list-group-item px-0 border-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-success bg-opacity-10 text-success me-3" style="width: 50px; height: 50px; font-size: 20px;">
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">100 từ vựng</div>
                                            <small class="text-muted">Đạt mốc 100 từ</small>
                                        </div>
                                        <span class="badge bg-success">2 ngày trước</span>
                                    </div>
                                </div>
                                <div class="list-group-item px-0 border-0">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-primary bg-opacity-10 text-primary me-3" style="width: 50px; height: 50px; font-size: 20px;">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Quiz Master</div>
                                            <small class="text-muted">Hoàn thành 10 quiz</small>
                                        </div>
                                        <span class="badge bg-primary">1 tuần trước</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Study Time -->
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Lịch sử học tập</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Ngày</th>
                                            <th>Từ mới</th>
                                            <th>Luyện tập</th>
                                            <th>Quiz</th>
                                            <th>Thời gian</th>
                                            <th>Streak</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>01/12/2024</td>
                                            <td><span class="badge bg-success">15 từ</span></td>
                                            <td><span class="badge bg-primary">3 bài</span></td>
                                            <td><span class="badge bg-warning">2 quiz</span></td>
                                            <td>45 phút</td>
                                            <td><i class="fas fa-fire text-warning"></i> 5</td>
                                        </tr>
                                        <tr>
                                            <td>30/11/2024</td>
                                            <td><span class="badge bg-success">12 từ</span></td>
                                            <td><span class="badge bg-primary">2 bài</span></td>
                                            <td><span class="badge bg-warning">1 quiz</span></td>
                                            <td>35 phút</td>
                                            <td><i class="fas fa-fire text-warning"></i> 4</td>
                                        </tr>
                                        <tr>
                                            <td>29/11/2024</td>
                                            <td><span class="badge bg-success">20 từ</span></td>
                                            <td><span class="badge bg-primary">4 bài</span></td>
                                            <td><span class="badge bg-warning">3 quiz</span></td>
                                            <td>60 phút</td>
                                            <td><i class="fas fa-fire text-warning"></i> 3</td>
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
    <script>
        // Weekly Progress Chart
        const weeklyCtx = document.getElementById('weeklyChart').getContext('2d');
        new Chart(weeklyCtx, {
            type: 'bar',
            data: {
                labels: [<c:forEach var="day" items="${weeklyProgress}" varStatus="status">'${day.day}'${!status.last ? ',' : ''}</c:forEach>],
                datasets: [{
                    label: 'Số từ đã học',
                    data: [<c:forEach var="day" items="${weeklyProgress}" varStatus="status">${day.words}${!status.last ? ',' : ''}</c:forEach>],
                    backgroundColor: 'rgba(13, 110, 253, 0.8)',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        // Practice Distribution Chart
        const practiceCtx = document.getElementById('practiceChart').getContext('2d');
        new Chart(practiceCtx, {
            type: 'doughnut',
            data: {
                labels: [<c:forEach var="entry" items="${practiceDistribution}" varStatus="status">'${entry.key}'${!status.last ? ',' : ''}</c:forEach>],
                datasets: [{
                    data: [<c:forEach var="entry" items="${practiceDistribution}" varStatus="status">${entry.value}${!status.last ? ',' : ''}</c:forEach>],
                    backgroundColor: [
                        'rgba(13, 110, 253, 0.8)',
                        'rgba(25, 135, 84, 0.8)',
                        'rgba(255, 193, 7, 0.8)',
                        'rgba(220, 53, 69, 0.8)'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: { display: false }
                }
            }
        });
    </script>
</body>
</html>
