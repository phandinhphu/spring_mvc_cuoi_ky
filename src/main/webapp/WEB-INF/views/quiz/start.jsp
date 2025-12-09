<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Làm Quiz - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-4">
        <div class="container">
            <!-- Header -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0">Quiz cơ bản - N5</h4>
                                    <p class="text-muted mb-0 mt-1">Câu hỏi <span id="currentQ">1</span>/${totalQuestions}</p>
                                </div>
                                <div class="text-end">
                                    <div class="h3 mb-0 text-primary">
                                        <i class="fas fa-clock me-2"></i><span id="timer">10:00</span>
                                    </div>
                                </div>
                            </div>
                            <div class="progress progress-custom mt-3">
                                <div class="progress-bar bg-primary" id="progressBar" style="width: 10%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Question -->
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="quiz-question" id="questionCard">
                        <div class="d-flex align-items-start mb-4">
                            <span class="badge bg-primary fs-5 me-3">Câu <span id="qNum">1</span></span>
                            <h4 class="mb-0 flex-grow-1" id="questionText">
                                Từ 'こんにちは' nghĩa là gì?
                            </h4>
                        </div>

                        <div class="d-grid gap-3" id="optionsContainer">
                            <button class="quiz-option" data-answer="A">
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-primary me-3 fs-5">A</span>
                                    <span class="fs-5" id="optionA">Xin chào</span>
                                </div>
                            </button>
                            <button class="quiz-option" data-answer="B">
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-primary me-3 fs-5">B</span>
                                    <span class="fs-5" id="optionB">Tạm biệt</span>
                                </div>
                            </button>
                            <button class="quiz-option" data-answer="C">
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-primary me-3 fs-5">C</span>
                                    <span class="fs-5" id="optionC">Cảm ơn</span>
                                </div>
                            </button>
                            <button class="quiz-option" data-answer="D">
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-primary me-3 fs-5">D</span>
                                    <span class="fs-5" id="optionD">Xin lỗi</span>
                                </div>
                            </button>
                        </div>

                        <div class="mt-4 pt-3 border-top">
                            <div class="d-flex justify-content-between align-items-center">
                                <button class="btn btn-outline-secondary" id="prevBtn">
                                    <i class="fas fa-arrow-left me-2"></i>Câu trước
                                </button>
                                <div>
                                    <span class="text-muted me-3">Đã trả lời: <strong id="answeredCount">0</strong>/${totalQuestions}</span>
                                </div>
                                <button class="btn btn-primary btn-custom" id="nextBtn" disabled>
                                    Câu sau<i class="fas fa-arrow-right ms-2"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Card -->
                    <div class="card mt-3">
                        <div class="card-body text-center">
                            <p class="mb-3">
                                <i class="fas fa-info-circle me-2"></i>
                                Hoàn thành tất cả câu hỏi để nộp bài
                            </p>
                            <button class="btn btn-success btn-lg btn-custom" id="submitBtn" disabled>
                                <i class="fas fa-check me-2"></i>Nộp bài
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Data holder -->
    <div id="questionData" style="display:none;">
        <c:forEach var="question" items="${questions}" varStatus="status">
        <div class="question-item" 
             data-id="${question.id}" 
             data-text="${question.questionText}" 
             data-option-a="${question.optionA}" 
             data-option-b="${question.optionB}" 
             data-option-c="${question.optionC}" 
             data-option-d="${question.optionD}" 
             data-correct="${question.correctAnswer}"></div>
        </c:forEach>
    </div>

    <jsp:include page="../layouts/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Load questions from data holder
        var questions = [];
        var questionItems = document.querySelectorAll('.question-item');
        questionItems.forEach(function(item) {
            questions.push({
                id: parseInt(item.getAttribute('data-id')),
                text: item.getAttribute('data-text'),
                options: {
                    A: item.getAttribute('data-option-a'),
                    B: item.getAttribute('data-option-b'),
                    C: item.getAttribute('data-option-c'),
                    D: item.getAttribute('data-option-d')
                },
                correct: item.getAttribute('data-correct')
            });
        });

        let currentQuestion = 0;
        let answers = new Array(questions.length).fill(null);
        let timeLeft = 600; // 10 minutes

        const questionText = document.getElementById('questionText');
        const optionA = document.getElementById('optionA');
        const optionB = document.getElementById('optionB');
        const optionC = document.getElementById('optionC');
        const optionD = document.getElementById('optionD');
        const currentQSpan = document.getElementById('currentQ');
        const qNum = document.getElementById('qNum');
        const progressBar = document.getElementById('progressBar');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const submitBtn = document.getElementById('submitBtn');
        const answeredCount = document.getElementById('answeredCount');
        const timer = document.getElementById('timer');

        function loadQuestion() {
            const q = questions[currentQuestion];
            questionText.textContent = q.text;
            optionA.textContent = q.options.A;
            optionB.textContent = q.options.B;
            optionC.textContent = q.options.C;
            optionD.textContent = q.options.D;
            
            currentQSpan.textContent = currentQuestion + 1;
            qNum.textContent = currentQuestion + 1;
            progressBar.style.width = ((currentQuestion + 1) / questions.length * 100) + '%';
            
            prevBtn.disabled = currentQuestion === 0;
            
            // Restore selected answer
            document.querySelectorAll('.quiz-option').forEach(opt => {
                opt.classList.remove('selected');
                if (answers[currentQuestion] === opt.dataset.answer) {
                    opt.classList.add('selected');
                }
            });
            
            nextBtn.disabled = answers[currentQuestion] === null;
            
            const answeredNum = answers.filter(a => a !== null).length;
            answeredCount.textContent = answeredNum;
            submitBtn.disabled = answeredNum < questions.length;
        }

        document.getElementById('optionsContainer').addEventListener('click', function(e) {
            const option = e.target.closest('.quiz-option');
            if (!option) return;
            
            document.querySelectorAll('.quiz-option').forEach(opt => opt.classList.remove('selected'));
            option.classList.add('selected');
            
            answers[currentQuestion] = option.dataset.answer;
            nextBtn.disabled = false;
            
            const answeredNum = answers.filter(a => a !== null).length;
            answeredCount.textContent = answeredNum;
            submitBtn.disabled = answeredNum < questions.length;
        });

        prevBtn.addEventListener('click', function() {
            if (currentQuestion > 0) {
                currentQuestion--;
                loadQuestion();
            }
        });

        nextBtn.addEventListener('click', function() {
            if (currentQuestion < questions.length - 1) {
                currentQuestion++;
                loadQuestion();
            }
        });

        submitBtn.addEventListener('click', function() {
            if (confirm('Bạn có chắc chắn muốn nộp bài?')) {
                let score = 0;
                questions.forEach((q, index) => {
                    if (answers[index] === q.correct) {
                        score += 10;
                    }
                });
                window.location.href = '${pageContext.request.contextPath}/quiz/result?score=' + score;
            }
        });

        // Timer
        setInterval(function() {
            timeLeft--;
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            timer.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            
            if (timeLeft <= 0) {
                alert('Hết giờ làm bài!');
                submitBtn.click();
            }
        }, 1000);

        loadQuestion();
    </script>
</body>
</html>
