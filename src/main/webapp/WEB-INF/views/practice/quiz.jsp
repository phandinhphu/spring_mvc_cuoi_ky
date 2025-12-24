<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trắc nghiệm - Nihongo Study</title>
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
                                    <h5>Câu hỏi <span id="currentQ"></span>/<span id="totalQ"></span></h5>
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

            <!-- Quiz Question -->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body text-center py-5">
                            <h4 class="mb-4">Chọn đáp án đúng</h4>
                            
                            <div class="quiz-question-display mb-4">
                                <div class="display-4 fw-bold text-primary mb-3" id="questionWord"></div>
                                <div class="text-muted fs-5" id="questionReading"></div>
                            </div>
                            
                            <p class="text-muted">
                                <i class="fas fa-info-circle me-2"></i>Chọn nghĩa đúng của từ vựng trên
                            </p>
                        </div>
                    </div>

                    <!-- Options -->
                    <div class="card">
                        <div class="card-body">
                            <div class="d-grid gap-3" id="optionsContainer">
                            <!-- các đáp án được js sinh tại đây -->
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
    	// 1. Dữ liệu từ Server
	    const initialVocabs = [
	        <c:forEach items="${vocabularies}" var="v" varStatus="status">
	        { 
	            userVocabId: ${v.userVocabId}, 
	            word: "${v.vocabulary.word}", 
	            meaning: "${v.vocabulary.meaning}", 
	            reading: "${v.vocabulary.hiragana}", 
	            romaji: "${v.vocabulary.romaji}" 
	        }${!status.last ? ',' : ''}
	        </c:forEach>
	    ];
	
	    const distractorPool = [
	        <c:forEach items="${distractors}" var="d" varStatus="status">
	            { meaning: "${d.meaning}" }${!status.last ? ',' : ''}
	        </c:forEach>
	    ];
	
	    // 2. Khởi tạo trạng thái buổi tập
	    let stats = {};
	    initialVocabs.forEach(item => {
	        stats[item.userVocabId] = {
	            userVocabId: item.userVocabId,
	            word: item.word,
	            meaning: item.meaning,
	            correctCount: 0,
	            wrongCount: 0,
	            mode: 'quiz'
	        };
	    });
	
	    let queue = [...initialVocabs]; 
	    let score = 0;
	    let currentItem = null;
	    const totalOriginal = initialVocabs.length;
	
	    document.getElementById('totalQ').textContent = totalOriginal;
	
	    function initQuiz() {
	        if (queue.length === 0) {
	            submitResults(Object.values(stats));
	            return;
	        }
	        renderQuestion();
	    }
	
	    function renderQuestion() {
	        currentItem = queue[0];
	        
	        // Cập nhật số thứ tự câu hỏi dựa trên số từ đã hoàn thành (xóa khỏi queue)
	        const completedCount = totalOriginal - queue.length;
	        document.getElementById('currentQ').textContent = completedCount + 1;
	        document.getElementById('progressBar').style.width = ((completedCount + 1) / totalOriginal * 100) + '%';
	        
	        // Hiển thị câu hỏi (từ vựng)
	        document.getElementById('questionWord').textContent = currentItem.word;
	        document.getElementById('questionReading').textContent = currentItem.reading || currentItem.romaji || '';
	        
	        // Tạo 4 phương án
	        let options = [currentItem.meaning];
	        while(options.length < 4) {
	            let randomDistractor = distractorPool[Math.floor(Math.random() * distractorPool.length)].meaning;
	            if(!options.includes(randomDistractor)) options.push(randomDistractor);
	        }
	        options.sort(() => Math.random() - 0.5);
	
	        const container = document.getElementById('optionsContainer');
	        container.innerHTML = options.map((opt, i) => `
	            <button class="quiz-option" onclick="checkAnswer('\${opt}', this)">
	                <div class="d-flex align-items-center">
	                    <span class="badge bg-primary me-3 fs-5">\${String.fromCharCode(65 + i)}</span>
	                    <span class="fs-5">\${opt}</span>
	                </div>
	            </button>
	        `).join('');
	        
	        document.getElementById('nextBtn').disabled = true;
	    }
	
	    function checkAnswer(selected, btnElement) {
	        const isCorrect = (selected === currentItem.meaning);
	        const vocabId = currentItem.userVocabId;
	        const allButtons = document.querySelectorAll('.quiz-option');
	        
	        allButtons.forEach(btn => {
	            btn.disabled = true;
	            if (btn.querySelector('span:last-child').textContent === currentItem.meaning) {
	                btn.classList.add('correct');
	            }
	        });
	
	        if (isCorrect) {
	            // Chỉ cộng điểm nếu từ này chưa bao giờ bị làm sai trong phiên này
	            if (stats[vocabId].wrongCount === 0) {
	                score += 1;
	                document.getElementById('score').textContent = score;
	            }
	            stats[vocabId].correctCount++;
	            queue.shift(); // Xong câu này, xóa khỏi hàng đợi
	        } else {
	            stats[vocabId].wrongCount++;
	            btnElement.classList.add('incorrect');
	            // Đưa câu sai xuống cuối để làm lại
	            queue.push(queue.shift());
	        }
	        document.getElementById('nextBtn').disabled = false;
	    }
	
	    document.getElementById('nextBtn').addEventListener('click', initQuiz);
	
	    function submitResults(finalData) {
	        document.getElementById('resultsJson').value = JSON.stringify(finalData);
	        document.getElementById('totalScore').value = score;
	        document.getElementById('resultForm').submit();
	    }
	
	    initQuiz();
	</script>
	
	<form id="resultForm" action="${pageContext.request.contextPath}/practice/save-result" method="POST" style="display: none;">
	    <input type="hidden" name="resultsJson" id="resultsJson">
	    <input type="hidden" name="totalScore" id="totalScore">
	</form>
</body>
</html>

