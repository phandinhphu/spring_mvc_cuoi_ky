<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sổ tay của tôi - Nihongo Study</title>
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
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="mb-0"><i class="fas fa-book me-2"></i>Sổ tay của tôi</h2>
                                <div class="streak-badge">
                                    <i class="fas fa-book-open"></i>
                                    <span>${totalWords} từ</span>
                                </div>
                            </div>
                            <p class="text-muted mb-0">Quản lý và luyện tập từ vựng đã lưu</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filter and Sort -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-lg-4">
                                    <div class="search-box">
                                        <i class="fas fa-search"></i>
                                        <input type="text" class="form-control" placeholder="Tìm trong sổ tay...">
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <select class="form-select">
                                        <option value="all">Tất cả trạng thái</option>
                                        <option value="active">Đang học</option>
                                        <option value="sleep">Đã ngủ</option>
                                    </select>
                                </div>
                                <div class="col-lg-3">
                                    <select class="form-select">
                                        <option value="date_desc">Mới nhất</option>
                                        <option value="date_asc">Cũ nhất</option>
                                        <option value="name_asc">Tên A-Z</option>
                                        <option value="name_desc">Tên Z-A</option>
                                    </select>
                                </div>
                                <div class="col-lg-2">
                                    <button class="btn btn-primary w-100 btn-custom">
                                        <i class="fas fa-filter me-2"></i>Lọc
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Vocabulary List -->
            <div class="row">
                <c:forEach var="vocab" items="${vocabularies}">
                    <div class="col-12 mb-3 fade-in-up">
                        <div class="vocab-card">
                            <div class="row align-items-center">
                                <div class="col-lg-7">
                                    <div class="vocab-word">${vocab.word}</div>
                                    <div class="vocab-reading">
                                        <span class="badge bg-info me-2">${vocab.hiragana}</span>
                                        <c:if test="${not empty vocab.kanji}">
                                            <span class="badge bg-secondary me-2">${vocab.kanji}</span>
                                        </c:if>
                                        <span class="text-muted">[${vocab.romaji}]</span>
                                    </div>
                                    <div class="vocab-meaning">
                                        <i class="fas fa-language me-2 text-primary"></i>${vocab.meaning}
                                    </div>
                                    <div class="mt-2">
                                        <span class="badge badge-active">Đang học</span>
                                        <span class="badge bg-light text-dark ms-2">Đã học: 5 lần</span>
                                    </div>
                                </div>
                                <div class="col-lg-5 text-lg-end mt-3 mt-lg-0">
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-outline-primary btn-sm" title="Phát âm">
                                            <i class="fas fa-volume-up"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/vocabulary/detail/${vocab.id}" 
                                           class="btn btn-outline-info btn-sm" title="Chi tiết">
                                            <i class="fas fa-info-circle"></i>
                                        </a>
                                        <button class="btn btn-outline-success btn-sm" title="Luyện tập">
                                            <i class="fas fa-dumbbell"></i>
                                        </button>
                                        <button class="btn btn-outline-warning btn-sm" title="Chuyển sang ngủ">
                                            <i class="fas fa-bed"></i>
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty vocabularies}">
                <div class="card">
                    <div class="card-body text-center py-5">
                        <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">Sổ tay của bạn đang trống</h5>
                        <p class="text-muted">Hãy bắt đầu thêm từ vựng để học tập</p>
                        <a href="${pageContext.request.contextPath}/vocabulary/search" class="btn btn-primary btn-custom">
                            <i class="fas fa-search me-2"></i>Tra từ ngay
                        </a>
                    </div>
                </div>
            </c:if>

            <!-- Pagination -->
            <c:if test="${not empty vocabularies}">
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Trước</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </main>

    <jsp:include page="../layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
