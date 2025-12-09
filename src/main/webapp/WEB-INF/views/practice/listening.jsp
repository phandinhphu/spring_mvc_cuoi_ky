<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luyện nghe - Nihongo Study</title>
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
                                    <h5 class="mb-0">Câu hỏi <span id="currentQ">1</span>/10</h5>
                                </div>
                                <div>
                                    <span class="badge bg-primary fs-5">Điểm: <span id="score">0</span></span>
                                </div>
                            </div>
                            <div class="progress progress-custom mt-2">
                                <div class="progress-bar bg-success" id="progressBar" style="width: 10%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Listening Question -->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body text-center py-5">
                            <h4 class="mb-4">Nghe và chọn đáp án đúng</h4>
                            
                            <button class="audio-btn mx-auto" id="playBtn" style="width: 100px; height: 100px; font-size: 40px;">
                                <i class="fas fa-volume-up"></i>
                            </button>
                            
                            <p class="text-muted mt-3">
                                <i class="fas fa-info-circle me-2"></i>Nhấn để nghe lại
                            </p>
                        </div>
                    </div>

                    <!-- Options -->
                    <div class="card">
                        <div class="card-body">
                            <div class="d-grid gap-3" id="optionsContainer">
                                <button class="quiz-option" data-answer="A">
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-primary me-3 fs-5">A</span>
                                        <span class="fs-5">Xin chào</span>
                                    </div>
                                </button>
                                <button class="quiz-option" data-answer="B">
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-primary me-3 fs-5">B</span>
                                        <span class="fs-5">Cảm ơn</span>
                                    </div>
                                </button>
                                <button class="quiz-option" data-answer="C">
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-primary me-3 fs-5">C</span>
                                        <span class="fs-5">Tạm biệt</span>
                                    </div>
                                </button>
                                <button class="quiz-option" data-answer="D">
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-primary me-3 fs-5">D</span>
                                        <span class="fs-5">Xin lỗi</span>
                                    </div>
                                </button>
                            </div>

                            <div class="mt-4 text-center">
                                <button class="btn btn-success btn-lg btn-custom" id="nextBtn" disabled>
                                    Câu tiếp theo <i class="fas fa-arrow-right ms-2"></i>
                                </button>
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
        const questions = [
            { audio: 'konnichiwa', correct: 'A', options: ['Xin chào', 'Cảm ơn', 'Tạm biệt', 'Xin lỗi'] },
            { audio: 'arigatou', correct: 'B', options: ['Xin chào', 'Cảm ơn', 'Tạm biệt', 'Xin lỗi'] },
            { audio: 'sayounara', correct: 'C', options: ['Xin chào', 'Cảm ơn', 'Tạm biệt', 'Xin lỗi'] }
        ];

        let currentQuestion = 0;
        let score = 0;
        let selectedAnswer = null;

        const playBtn = document.getElementById('playBtn');
        const nextBtn = document.getElementById('nextBtn');
        const optionsContainer = document.getElementById('optionsContainer');
        const progressBar = document.getElementById('progressBar');
        const scoreSpan = document.getElementById('score');
        const currentQSpan = document.getElementById('currentQ');

        playBtn.addEventListener('click', function() {
            this.classList.add('active');
            setTimeout(() => this.classList.remove('active'), 1000);
            alert('Phát âm: ' + questions[currentQuestion].audio);
        });

        optionsContainer.addEventListener('click', function(e) {
            const option = e.target.closest('.quiz-option');
            if (!option || selectedAnswer) return;

            selectedAnswer = option.dataset.answer;
            const correct = questions[currentQuestion].correct;

            document.querySelectorAll('.quiz-option').forEach(opt => {
                opt.disabled = true;
                if (opt.dataset.answer === correct) {
                    opt.classList.add('correct');
                }
                if (opt.dataset.answer === selectedAnswer && selectedAnswer !== correct) {
                    opt.classList.add('incorrect');
                }
            });

            if (selectedAnswer === correct) {
                score += 10;
                scoreSpan.textContent = score;
            }

            nextBtn.disabled = false;
        });

        nextBtn.addEventListener('click', function() {
            currentQuestion++;
            if (currentQuestion >= questions.length) {
                alert('Hoàn thành! Điểm của bạn: ' + score);
                window.location.href = '${pageContext.request.contextPath}/practice/';
                return;
            }

            selectedAnswer = null;
            nextBtn.disabled = true;
            
            document.querySelectorAll('.quiz-option').forEach((opt, index) => {
                opt.disabled = false;
                opt.classList.remove('correct', 'incorrect', 'selected');
                opt.querySelector('span:last-child').textContent = questions[currentQuestion].options[index];
            });

            currentQSpan.textContent = currentQuestion + 1;
            progressBar.style.width = ((currentQuestion + 1) / questions.length * 100) + '%';
        });
    </script>
</body>
</html>
