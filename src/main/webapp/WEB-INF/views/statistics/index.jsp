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
	
	        <div class="row g-4 mb-4">
	            <div class="col-lg-4 col-md-4">
	                <div class="stat-card h-100">
	                    <div class="stat-icon bg-primary bg-opacity-10 text-primary">
	                        <i class="fas fa-fire"></i>
	                    </div>
	                    <div class="stat-value text-primary">${streak}</div>
	                    <div class="mt-2 small text-muted">
	                        <i class="fas fa-trophy me-1"></i>Streak hiện tại
	                    </div>
	                </div>
	            </div>
	            <div class="col-lg-4 col-md-4">
	                <div class="stat-card h-100">
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
	            <div class="col-lg-4 col-md-4">
	                <div class="stat-card h-100">
	                    <div class="stat-icon bg-warning bg-opacity-10 text-warning">
	                        <i class="fas fa-bullseye"></i>
	                    </div>
	                    <div class="stat-value text-warning">${accuracy}%</div>
	                    <div class="stat-label"></div>
	                    <div class="mt-2 small text-muted">
	                        <i class="fas fa-chart-line me-1"></i>Độ chính xác trung bình
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <div class="row g-4 mb-4">
	            <div class="col-lg-6">
	                <div class="card h-100">
	                    <div class="card-header">
	                        <h5 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Phân bố luyện tập</h5>
	                    </div>
	                    <div class="card-body">
	                        <div style="max-height: 250px;">
	                            <canvas id="practiceChart"></canvas>
	                        </div>
	                        <div class="mt-3">
	                            <c:forEach var="entry" items="${practiceDistribution}">
	                                <div class="d-flex justify-content-between mb-2">
	                                    <span>${entry.key}</span>
	                                    <strong>${entry.value / totalPractice * 100}%</strong>
	                                </div>
	                            </c:forEach>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col-lg-6">
	                <div class="card h-100">
	                    <div class="card-header">
	                        <h5 class="mb-0"><i class="fas fa-book-open me-2"></i>Tiến độ từ vựng</h5>
	                    </div>
	                    <div class="card-body">
	                        <div class="mb-4">
	                            <div class="d-flex justify-content-between mb-2">
	                                <span>Mức độ hoàn thành</span>
	                                <span><strong>${learnedWords}</strong> / ${totalWords}</span>
	                            </div>
	                            <div class="progress progress-custom">
	                                <c:set var="percent" value="${totalWords > 0 ? (learnedWords * 100 / totalWords) : 0}" />
	                                <div class="progress-bar bg-success" style="width: ${percent}%"></div>
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
	        </div>
	    </div>
	</main>

    <jsp:include page="../layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
