<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${vocabulary.word} - Chi tiết từ vựng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/vocabulary/search">Tra từ</a></li>
                    <li class="breadcrumb-item active">${vocabulary.word}</li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-lg-8">
                    <!-- Vocabulary Detail Card -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Chi tiết từ vựng</h4>
                            <button class="btn btn-primary btn-sm btn-custom" id="addToListBtn">
                                <i class="fas ${isInMyList ? 'fa-check' : 'fa-plus'} me-2"></i>
                                ${isInMyList ? 'Đã thêm' : 'Thêm vào sổ tay'}
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-4 py-4 bg-light rounded">
                                <div class="vocab-word" style="font-size: 3rem;">${vocabulary.word}</div>
                                <button class="audio-btn mx-auto mt-3" id="playAudioBtn">
                                    <i class="fas fa-volume-up"></i>
                                </button>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <div class="p-3 bg-light rounded">
                                        <div class="small text-muted mb-1">Hiragana</div>
                                        <div class="h4 mb-0 text-primary">${vocabulary.hiragana}</div>
                                    </div>
                                </div>
                                <c:if test="${not empty vocabulary.katakana}">
                                    <div class="col-md-6">
                                        <div class="p-3 bg-light rounded">
                                            <div class="small text-muted mb-1">Katakana</div>
                                            <div class="h4 mb-0 text-success">${vocabulary.katakana}</div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty vocabulary.kanji}">
                                    <div class="col-md-6">
                                        <div class="p-3 bg-light rounded">
                                            <div class="small text-muted mb-1">Kanji</div>
                                            <div class="h4 mb-0 text-warning">${vocabulary.kanji}</div>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="col-md-6">
                                    <div class="p-3 bg-light rounded">
                                        <div class="small text-muted mb-1">Romaji</div>
                                        <div class="h4 mb-0 text-info">${vocabulary.romaji}</div>
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-primary">
                                <i class="fas fa-language me-2"></i>
                                <strong>Nghĩa:</strong> ${vocabulary.meaning}
                            </div>
                        </div>
                    </div>

                    <!-- Examples Card -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Ví dụ câu minh họa</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty examples}">
                                <div class="list-group list-group-flush">
                                    <c:forEach var="example" items="${examples}" varStatus="status">
                                        <div class="list-group-item px-0">
                                            <div class="d-flex">
                                                <span class="badge bg-primary me-3">${status.index + 1}</span>
                                                <div class="flex-grow-1">
                                                    <div class="mb-2">
                                                        <i class="fas fa-quote-left text-muted me-2"></i>
                                                        <span class="h6">${example.exampleSentence}</span>
                                                        <button class="btn btn-sm btn-link text-primary">
                                                            <i class="fas fa-volume-up"></i>
                                                        </button>
                                                    </div>
                                                    <div class="text-muted">
                                                        <i class="fas fa-language me-2"></i>${example.translation}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <c:if test="${empty examples}">
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-info-circle fa-2x mb-3"></i>
                                    <p>Chưa có ví dụ cho từ vựng này</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Quick Actions -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Hành động</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-custom">
                                    <i class="fas fa-layer-group me-2"></i>Luyện với Flashcard
                                </button>
                                <button class="btn btn-success btn-custom">
                                    <i class="fas fa-question-circle me-2"></i>Làm Quiz
                                </button>
                                <button class="btn btn-info btn-custom">
                                    <i class="fas fa-keyboard me-2"></i>Luyện điền từ
                                </button>
                                <button class="btn btn-warning btn-custom">
                                    <i class="fas fa-headphones me-2"></i>Luyện nghe
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Info Box -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin</h6>
                        </div>
                        <div class="card-body">
                            <div class="small">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Từ loại:</span>
                                    <span class="badge bg-secondary">Danh từ</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Cấp độ:</span>
                                    <span class="badge bg-success">N5</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Đã học:</span>
                                    <span class="fw-bold">125 lần</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Độ khó:</span>
                                    <div>
                                        <i class="fas fa-star text-warning"></i>
                                        <i class="fas fa-star text-warning"></i>
                                        <i class="fas fa-star text-warning"></i>
                                        <i class="far fa-star text-warning"></i>
                                        <i class="far fa-star text-warning"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Related Words -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0"><i class="fas fa-link me-2"></i>Từ liên quan</h6>
                        </div>
                        <div class="card-body">
                            <div class="list-group list-group-flush">
                                <a href="#" class="list-group-item list-group-item-action px-0">
                                    <div class="fw-semibold">おはよう</div>
                                    <small class="text-muted">Chào buổi sáng</small>
                                </a>
                                <a href="#" class="list-group-item list-group-item-action px-0">
                                    <div class="fw-semibold">こんばんは</div>
                                    <small class="text-muted">Chào buổi tối</small>
                                </a>
                                <a href="#" class="list-group-item list-group-item-action px-0">
                                    <div class="fw-semibold">ありがとう</div>
                                    <small class="text-muted">Cảm ơn</small>
                                </a>
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
        // Add to list functionality
        document.getElementById('addToListBtn').addEventListener('click', function() {
            const isAdded = this.innerHTML.includes('Đã thêm');
            if (isAdded) {
                this.innerHTML = '<i class="fas fa-plus me-2"></i>Thêm vào sổ tay';
                this.classList.replace('btn-success', 'btn-primary');
            } else {
                this.innerHTML = '<i class="fas fa-check me-2"></i>Đã thêm';
                this.classList.replace('btn-primary', 'btn-success');
            }
        });

        // Audio playback
        document.getElementById('playAudioBtn').addEventListener('click', function() {
            this.classList.add('active');
            setTimeout(() => this.classList.remove('active'), 1000);
            alert('Chức năng phát âm sẽ được triển khai với audio file thực tế');
        });

        document.querySelectorAll('.btn-link').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                alert('Phát âm ví dụ câu');
            });
        });
    </script>
</body>
</html>
