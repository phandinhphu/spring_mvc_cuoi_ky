<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flashcard - Luyện tập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <!-- Progress Bar -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="mb-0">Tiến độ</h5>
                        <span class="badge bg-primary"><span id="current">1</span>/${totalCards}</span>
                    </div>
                    <div class="progress progress-custom">
                        <div class="progress-bar progress-bar-animated" id="progressBar" style="width: 0%"></div>
                    </div>
                </div>
            </div>

            <!-- Flashcard -->
            <div class="flashcard-container mb-4">
                <div class="flashcard" id="flashcard" data-index="0">
                    <div class="flashcard-front">
                        <div class="mb-3">
                            <span class="badge bg-white text-primary px-3 py-2">Nhấn để lật</span>
                        </div>
                        <h1 class="display-1 mb-4" id="frontText">こんにちは</h1>
                        <p class="h4" id="frontSubtext">[konnichiwa]</p>
                    </div>
                    <div class="flashcard-back">
                        <div class="mb-3">
                            <span class="badge bg-white text-danger px-3 py-2">Nghĩa</span>
                        </div>
                        <h2 class="display-3" id="backText">Xin chào</h2>
                        <button class="btn btn-light btn-lg mt-4" id="playAudio">
                            <i class="fas fa-volume-up"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Controls -->
            <div class="card">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <button class="btn btn-outline-secondary w-100" id="prevBtn">
                                <i class="fas fa-arrow-left me-2"></i>Trước
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-outline-danger w-100" id="hardBtn">
                                <i class="fas fa-times me-2"></i>Khó
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-outline-success w-100" id="easyBtn">
                                <i class="fas fa-check me-2"></i>Dễ
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-outline-secondary w-100" id="nextBtn">
                                Sau<i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-danger me-2">Khó: <span id="hardCount">0</span></span>
                                    <span class="badge bg-success">Dễ: <span id="easyCount">0</span></span>
                                </div>
                                <a href="${pageContext.request.contextPath}/practice/" class="btn btn-primary btn-custom">
                                    <i class="fas fa-check me-2"></i>Hoàn thành
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Keyboard Shortcuts -->
            <div class="card mt-3">
                <div class="card-body">
                    <div class="small text-muted">
                        <i class="fas fa-keyboard me-2"></i>
                        <strong>Phím tắt:</strong> 
                        Space: Lật thẻ | 
                        ←: Thẻ trước | 
                        →: Thẻ sau | 
                        1: Khó | 
                        2: Dễ
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Data holder -->
    <div id="vocabData" style="display:none;">
        <c:forEach var="vocab" items="${vocabularies}" varStatus="status">
        <div class="vocab-item" 
             data-word="${vocab.word}" 
             data-meaning="${vocab.meaning}" 
             data-romaji="${vocab.romaji}" 
             data-hiragana="${vocab.hiragana}" 
             data-kanji="${vocab.kanji}"></div>
        </c:forEach>
    </div>

    <jsp:include page="../layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Load vocabularies from data holder
        var vocabularies = [];
        var vocabItems = document.querySelectorAll('.vocab-item');
        vocabItems.forEach(function(item) {
            vocabularies.push({
                word: item.getAttribute('data-word'),
                meaning: item.getAttribute('data-meaning'),
                romaji: item.getAttribute('data-romaji'),
                hiragana: item.getAttribute('data-hiragana'),
                kanji: item.getAttribute('data-kanji')
            });
        });

        let currentIndex = 0;
        let hardCount = 0;
        let easyCount = 0;
        let isFlipped = false;

        const flashcard = document.getElementById('flashcard');
        const frontText = document.getElementById('frontText');
        const frontSubtext = document.getElementById('frontSubtext');
        const backText = document.getElementById('backText');
        const progressBar = document.getElementById('progressBar');
        const currentSpan = document.getElementById('current');
        const hardCountSpan = document.getElementById('hardCount');
        const easyCountSpan = document.getElementById('easyCount');

        function updateCard() {
            const vocab = vocabularies[currentIndex];
            const mode = '${mode}';
            
            if (mode === 'meaning') {
                frontText.textContent = vocab.word;
                frontSubtext.textContent = '[' + vocab.romaji + ']';
                backText.textContent = vocab.meaning;
            } else if (mode === 'reading') {
                frontText.textContent = vocab.meaning;
                frontSubtext.textContent = '';
                backText.textContent = vocab.word + ' [' + vocab.romaji + ']';
            } else {
                frontText.textContent = vocab.word;
                frontSubtext.textContent = '[' + vocab.romaji + ']';
                backText.textContent = vocab.meaning;
            }
            
            currentSpan.textContent = currentIndex + 1;
            progressBar.style.width = ((currentIndex + 1) / vocabularies.length * 100) + '%';
            isFlipped = false;
            flashcard.classList.remove('flipped');
        }

        flashcard.addEventListener('click', function() {
            isFlipped = !isFlipped;
            flashcard.classList.toggle('flipped');
        });

        document.getElementById('prevBtn').addEventListener('click', function() {
            if (currentIndex > 0) {
                currentIndex--;
                updateCard();
            }
        });

        document.getElementById('nextBtn').addEventListener('click', function() {
            if (currentIndex < vocabularies.length - 1) {
                currentIndex++;
                updateCard();
            }
        });

        document.getElementById('hardBtn').addEventListener('click', function() {
            hardCount++;
            hardCountSpan.textContent = hardCount;
            if (currentIndex < vocabularies.length - 1) {
                currentIndex++;
                updateCard();
            }
        });

        document.getElementById('easyBtn').addEventListener('click', function() {
            easyCount++;
            easyCountSpan.textContent = easyCount;
            if (currentIndex < vocabularies.length - 1) {
                currentIndex++;
                updateCard();
            }
        });

        document.getElementById('playAudio').addEventListener('click', function(e) {
            e.stopPropagation();
            alert('Phát âm: ' + vocabularies[currentIndex].word);
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            switch(e.key) {
                case ' ':
                    e.preventDefault();
                    flashcard.click();
                    break;
                case 'ArrowLeft':
                    document.getElementById('prevBtn').click();
                    break;
                case 'ArrowRight':
                    document.getElementById('nextBtn').click();
                    break;
                case '1':
                    document.getElementById('hardBtn').click();
                    break;
                case '2':
                    document.getElementById('easyBtn').click();
                    break;
            }
        });

        updateCard();
    </script>
</body>
</html>
