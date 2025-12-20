<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luyện điền từ - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <!-- Progress -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-0">Câu hỏi <span id="currentQ">1</span>/<span id="totalQ">${vocabularies.size()}</span></h5>
                                </div>
                                <div>
                                    <span class="badge bg-primary fs-5">Điểm: <span id="score">0</span></span>
                                </div>
                            </div>
                            <div class="progress progress-custom mt-2">
                                <div class="progress-bar bg-warning" id="progressBar" style="width: 10%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Typing Question -->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body text-center py-5">
                            <h4 class="mb-4">Gõ cách đọc Romaji của từ sau</h4>
                            
                            <div class="mb-4">
                                <div class="display-1 text-primary mb-3" id="vocabWord">こんにちは</div>
                                <div class="h5 text-muted" id="vocabMeaning">Xin chào</div>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-md-8">
                                    <input type="text" class="form-control form-control-lg text-center" 
                                           id="answerInput" placeholder="Nhập romaji..." autocomplete="off">
                                    <div class="invalid-feedback" id="feedback"></div>
                                </div>
                            </div>

                            <div class="mt-4">
                                <button class="btn btn-primary btn-lg btn-custom me-2" id="checkBtn">
                                    <i class="fas fa-check me-2"></i>Kiểm tra
                                </button>
                                <button class="btn btn-outline-secondary btn-lg" id="skipBtn">
                                    <i class="fas fa-forward me-2"></i>Bỏ qua
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Hint Card -->
                    <div class="card">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info" id="hintBtn">
                                        <i class="fas fa-lightbulb me-2"></i>Xem gợi ý
                                    </button>
                                    <button class="btn btn-outline-warning ms-2" id="audioBtn">
                                        <i class="fas fa-volume-up"></i>
                                    </button>
                                </div>
                                <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                    <div class="text-muted small">
                                        <i class="fas fa-keyboard me-2"></i>
                                        Sử dụng bàn phím Romaji để nhập
                                    </div>
                                </div>
                            </div>
                            <div class="alert alert-info mt-3 d-none" id="hintBox">
                                <i class="fas fa-info-circle me-2"></i>
                                Bắt đầu với: <strong id="hintText">kon...</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layouts/footer.jsp" />
    
    <!-- Data từ server (hidden) -->
    <script type="application/json" id="vocabularyData">
        [
            <c:forEach var="vocab" items="${vocabularies}" varStatus="status">
            {
                "vocabId": ${vocab.vocabId},
                "userVocabId": ${vocab.userVocabId},
                "word": "${vocab.word}",
                "meaning": "${vocab.meaning}",
                "romaji": "${not empty vocab.romaji ? vocab.romaji : ''}"
            }<c:if test="${not status.last}">,</c:if>
            </c:forEach>
        ]
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Lấy dữ liệu từ controller
        const questions = JSON.parse(document.getElementById('vocabularyData').textContent);

        let currentQuestion = 0;
        let currentScore = 0;
        
        // Mảng lưu kết quả để gửi lên server
        // Mỗi phần tử sẽ lưu: userVocabId, correctCount, wrongCount, mode
        const results = [];

        const vocabWord = document.getElementById('vocabWord');
        const vocabMeaning = document.getElementById('vocabMeaning');
        const answerInput = document.getElementById('answerInput');
        const checkBtn = document.getElementById('checkBtn');
        const skipBtn = document.getElementById('skipBtn');
        const hintBtn = document.getElementById('hintBtn');
        const audioBtn = document.getElementById('audioBtn');
        const hintBox = document.getElementById('hintBox');
        const hintText = document.getElementById('hintText');
        const feedback = document.getElementById('feedback');
        const progressBar = document.getElementById('progressBar');
        const scoreSpan = document.getElementById('score');
        const currentQSpan = document.getElementById('currentQ');

        function loadQuestion() {
            const q = questions[currentQuestion];
            vocabWord.textContent = q.word;
            vocabMeaning.textContent = q.meaning;
            
            // Tạo hint từ 3 ký tự đầu của romaji
            const romajiText = q.romaji || '';
            const hintText = romajiText.length > 3 ? romajiText.substring(0, 3) + '...' : romajiText + '...';
            document.getElementById('hintText').textContent = hintText;
            
            answerInput.value = '';
            answerInput.classList.remove('is-valid', 'is-invalid');
            hintBox.classList.add('d-none');
            answerInput.focus();
            
            currentQSpan.textContent = currentQuestion + 1;
            progressBar.style.width = ((currentQuestion + 1) / questions.length * 100) + '%';
        }

        checkBtn.addEventListener('click', function() {
            const userAnswer = answerInput.value.trim().toLowerCase();
            const correctAnswer = questions[currentQuestion].romaji.toLowerCase();

            if (userAnswer === correctAnswer) {
                answerInput.classList.add('is-valid');
                answerInput.classList.remove('is-invalid');
                currentScore += 10;
                scoreSpan.textContent = currentScore;
                
                // Lưu kết quả đúng
                results.push({
                    userVocabId: questions[currentQuestion].userVocabId,
                    correctCount: 1,
                    wrongCount: 0,
                    mode: "fill"
                });
                
                setTimeout(() => {
                    currentQuestion++;
                    if (currentQuestion >= questions.length) {
                        finishPractice();
                    } else {
                        loadQuestion();
                    }
                }, 1000);
            } else {
                answerInput.classList.add('is-invalid');
                answerInput.classList.remove('is-valid');
                feedback.textContent = 'Sai rồi! Đáp án đúng là: ' + questions[currentQuestion].romaji;
                feedback.style.display = 'block';
                
                // Lưu kết quả sai
                results.push({
                    userVocabId: questions[currentQuestion].userVocabId,
                    correctCount: 0,
                    wrongCount: 1,
                    mode: "fill"
                });
                
                setTimeout(() => {
                    currentQuestion++;
                    if (currentQuestion >= questions.length) {
                        finishPractice();
                    } else {
                        loadQuestion();
                    }
                }, 1000);
            }
        });

        skipBtn.addEventListener('click', function() {
            // Lưu kết quả bỏ qua (tính là sai)
            results.push({
                userVocabId: questions[currentQuestion].userVocabId,
                correctCount: 0,
                wrongCount: 1,
                mode: "fill"
            });
            
            currentQuestion++;
            if (currentQuestion >= questions.length) {
                finishPractice();
            } else {
                loadQuestion();
            }
        });
        
        // Hàm hoàn thành bài luyện tập và chuyển đến trang kết quả
        function finishPractice() {
            // Tạo form để gửi kết quả lên server
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/practice/save-result';
            
            // Chuyển đổi results thành JSON
            const resultsInput = document.createElement('input');
            resultsInput.type = 'hidden';
            resultsInput.name = 'resultsJson';
            resultsInput.value = JSON.stringify(results);
            form.appendChild(resultsInput);
            
            // Thêm tổng điểm
            const scoreInput = document.createElement('input');
            scoreInput.type = 'hidden';
            scoreInput.name = 'totalScore';
            scoreInput.value = currentScore;
            form.appendChild(scoreInput);
            
            document.body.appendChild(form);
            form.submit();
        }

        hintBtn.addEventListener('click', function() {
            hintBox.classList.toggle('d-none');
        });

        audioBtn.addEventListener('click', function() {
            // Tạo đối tượng Speech Synthesis để phát âm tiếng Nhật
            const utterance = new SpeechSynthesisUtterance(questions[currentQuestion].word);
            utterance.lang = 'ja-JP'; // Ngôn ngữ tiếng Nhật
            utterance.rate = 0.8; // Tốc độ đọc chậm hơn một chút
            window.speechSynthesis.speak(utterance);
        });

        answerInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                checkBtn.click();
            }
        });

        loadQuestion();
    </script>
</body>
</html>
