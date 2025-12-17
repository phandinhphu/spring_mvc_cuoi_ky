<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra từ - Nihongo Study</title>
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
                            <h2 class="mb-4"><i class="fas fa-search me-2"></i>Tra từ vựng</h2>
                            
                            <form action="${pageContext.request.contextPath}/vocabulary/search" method="get">
                                <div class="row g-3 mb-3">
                                    <div class="col-lg-8">
                                        <div class="search-box">
                                            <i class="fas fa-search"></i>
                                            <input type="text" class="form-control form-control-lg" name="q" 
                                                   placeholder="Nhập từ cần tìm (Hiragana, Katakana, Kanji, Romaji, hoặc tiếng Việt)..."
                                                   value="${query}">
                                        </div>
                                    </div>
                                    <div class="col-lg-2">
                                        <select class="form-select form-select-lg" name="type">
                                            <option value="all" ${searchType == 'all' ? 'selected' : ''}>Tất cả</option>
                                            <option value="hiragana" ${searchType == 'hiragana' ? 'selected' : ''}>Hiragana</option>
                                            <option value="katakana" ${searchType == 'katakana' ? 'selected' : ''}>Katakana</option>
                                            <option value="kanji" ${searchType == 'kanji' ? 'selected' : ''}>Kanji</option>
                                            <option value="romaji" ${searchType == 'romaji' ? 'selected' : ''}>Romaji</option>
                                            <option value="meaning" ${searchType == 'meaning' ? 'selected' : ''}>Tiếng Việt</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-2">
                                        <button type="submit" class="btn btn-primary btn-lg w-100 btn-custom">
                                            <i class="fas fa-search me-2"></i>Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <div class="d-flex gap-2 flex-wrap">
                                <span class="badge bg-light text-dark border">Gợi ý tìm kiếm:</span>
                                <a href="${pageContext.request.contextPath}/vocabulary/search?q=こんにちは" class="badge bg-primary text-decoration-none">こんにちは</a>
                                <a href="${pageContext.request.contextPath}/vocabulary/search?q=ありがとう" class="badge bg-primary text-decoration-none">ありがとう</a>
                                <a href="${pageContext.request.contextPath}/vocabulary/search?q=さようなら" class="badge bg-primary text-decoration-none">さようなら</a>
                                <a href="${pageContext.request.contextPath}/vocabulary/search?q=xin chào" class="badge bg-primary text-decoration-none">xin chào</a>
                                <a href="${pageContext.request.contextPath}/vocabulary/search?q=cảm ơn" class="badge bg-primary text-decoration-none">cảm ơn</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty query}">
                <div class="row mb-3">
                    <div class="col-12">
                        <h5>Kết quả tìm kiếm cho: <span class="text-primary">"${query}"</span></h5>
                        <p class="text-muted">Tìm thấy ${results != null ? results.size() : 0} kết quả</p>
                    </div>
                </div>

                <c:if test="${not empty results}">
                    <div class="row">
                        <c:forEach var="vocab" items="${results}">
                            <div class="col-12 mb-3 fade-in-up">
                                <div class="vocab-card">
                                    <div class="row align-items-center">
                                        <div class="col-lg-8">
                                            <div class="vocab-word">${vocab.word}</div>
                                            <div class="vocab-reading">
                                                <c:if test="${not empty vocab.hiragana}">
                                                    <span class="badge bg-info me-2">${vocab.hiragana}</span>
                                                </c:if>
                                                <c:if test="${not empty vocab.katakana}">
                                                    <span class="badge bg-success me-2">${vocab.katakana}</span>
                                                </c:if>
                                                <c:if test="${not empty vocab.kanji}">
                                                    <span class="badge bg-secondary me-2">${vocab.kanji}</span>
                                                </c:if>
                                                <c:if test="${not empty vocab.romaji}">
                                                    <span class="text-muted">[${vocab.romaji}]</span>
                                                </c:if>
                                            </div>
                                            <div class="vocab-meaning">
                                                <i class="fas fa-language me-2 text-primary"></i>${vocab.meaning}
                                            </div>
                                        </div>
                                        <div class="col-lg-4 text-lg-end">
                                            <button class="audio-btn me-2" 
                                                    title="Phát âm"
                                                    data-audio-url="${vocab.audioUrl}"
                                                    data-word="${vocab.word}"
                                                    data-romaji="${vocab.romaji}">
                                                <i class="fas fa-volume-up"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/vocabulary/detail/${vocab.id}" 
                                               class="btn btn-primary btn-custom">
                                                <i class="fas fa-info-circle me-2"></i>Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <c:if test="${empty results}">
                    <div class="card">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-search fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">Không tìm thấy kết quả phù hợp</h5>
                            <p class="text-muted">Hãy thử tìm kiếm với từ khóa khác</p>
                        </div>
                    </div>
                </c:if>
            </c:if>

            <c:if test="${empty query}">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-book fa-3x text-primary mb-3"></i>
                                <h5>Bắt đầu tra từ</h5>
                                <p class="text-muted">Nhập từ vựng bạn muốn tìm kiếm vào ô tìm kiếm bên trên</p>
                                
                                <div class="mt-4">
                                    <h6 class="mb-3">Cách tìm kiếm hiệu quả:</h6>
                                    <div class="row g-3 mb-3">
                                        <div class="col-lg-2 col-md-4 col-sm-6">
                                            <div class="p-3 bg-light rounded">
                                                <i class="fas fa-font text-primary fa-2x mb-2"></i>
                                                <div class="small fw-semibold">Hiragana</div>
                                                <div class="small text-muted">こんにちは</div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-6">
                                            <div class="p-3 bg-light rounded">
                                                <i class="fas fa-language text-success fa-2x mb-2"></i>
                                                <div class="small fw-semibold">Katakana</div>
                                                <div class="small text-muted">コンピュータ</div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-6">
                                            <div class="p-3 bg-light rounded">
                                                <i class="fas fa-book text-warning fa-2x mb-2"></i>
                                                <div class="small fw-semibold">Kanji</div>
                                                <div class="small text-muted">今日は</div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-6">
                                            <div class="p-3 bg-light rounded">
                                                <i class="fas fa-keyboard text-danger fa-2x mb-2"></i>
                                                <div class="small fw-semibold">Romaji</div>
                                                <div class="small text-muted">konnichiwa</div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-6">
                                            <div class="p-3 bg-light rounded">
                                                <i class="fas fa-comment text-info fa-2x mb-2"></i>
                                                <div class="small fw-semibold">Tiếng Việt</div>
                                                <div class="small text-muted">xin chào</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="../layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script>
        // Wait for voices to be loaded
        if ('speechSynthesis' in window) {
            let voicesLoaded = false;
            window.speechSynthesis.onvoiceschanged = function() {
                voicesLoaded = true;
            };
            
            // Load voices immediately if already available
            if (window.speechSynthesis.getVoices().length > 0) {
                voicesLoaded = true;
            }
        }

        // Audio playback functionality
        document.querySelectorAll('.audio-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                
                // Check if already playing
                if (this.classList.contains('playing')) {
                    NihongoStudy.stopSpeech(this);
                    return;
                }
                
                const audioUrl = this.getAttribute('data-audio-url');
                const word = this.getAttribute('data-word');
                const romaji = this.getAttribute('data-romaji');
                
                // Use word if available, otherwise use romaji
                const textToSpeak = word || romaji || '';
                
                if (textToSpeak) {
                    NihongoStudy.playAudio(audioUrl, textToSpeak, this);
                } else {
                    NihongoStudy.showToast('Không có văn bản để phát âm', 'warning');
                }
            });
        });
    </script>
</body>
</html>
