<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả luyện tập - Nihongo Study</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layouts/header.jsp" />

    <main class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <div class="card p-5 shadow-sm border-0" style="border-radius: 20px;">
					    <h1 class="display-4 text-success mb-4 fw-bold">Hoàn thành! 🎉</h1>
					    
					    <div class="row justify-content-center align-items-center mb-4">
					        <div class="col-md-5 border-end">
					            <div class="p-2">
					                <span class="fs-5 text-muted d-block mb-2">Bạn đã trả lời đúng</span>
					                <div class="display-4 fw-bold text-primary">
					                    ${score} <span class="fs-2 text-secondary fw-normal">/ ${total}</span>
					                </div>
					            </div>
					        </div>
					
					        <div class="col-md-5">
					            <div class="p-2">
					                <span class="fs-5 text-muted d-block mb-2">Tỷ lệ chính xác</span>
					                <div class="display-4 fw-bold ${percent >= 80 ? 'text-success' : 'text-warning'}">
					                    ${percent}%
					                </div>
					            </div>
					        </div>
					    </div>
					
					    <div class="row justify-content-center mb-5">
					        <div class="col-md-9">
					            <div class="progress" style="height: 12px; border-radius: 10px; background-color: #f0f2f5;">
					                <div class="progress-bar progress-bar-striped progress-bar-animated 
					                            ${percent >= 80 ? 'bg-success' : (percent >= 50 ? 'bg-warning' : 'bg-danger')}" 
					                     role="progressbar" 
					                     style="width: ${percent}%" 
					                     aria-valuenow="${percent}" aria-valuemin="0" aria-valuemax="100">
					                </div>
					            </div>
					        </div>
					    </div>
					
					    <div class="text-start mt-4">
					        <div class="d-flex align-items-center mb-3">
					            <h4 class="mb-0">Chi tiết từ vựng</h4>
					            <hr class="flex-grow-1 ms-3 text-muted opacity-25">
					        </div>
					        
					        <div class="table-responsive">
					            <table class="table table-hover align-middle border-top-0">
					                <thead class="table-light">
					                    <tr>
					                        <th scope="col" class="py-3 ps-4" style="width: 30%">Từ vựng</th>
					                        <th scope="col" class="py-3" style="width: 45%">Ý nghĩa</th>
					                        <th scope="col" class="py-3 text-center" style="width: 25%">Số lần sai</th>
					                    </tr>
					                </thead>
					                <tbody>
					                    <c:forEach items="${results}" var="res">
					                        <tr>
					                            <td class="ps-4">
					                                <strong class="text-primary fs-5">${res.word}</strong>
					                            </td>
					                            <td class="text-dark">${res.meaning}</td>
					                            <td class="text-center">
					                                <span class="badge ${res.wrongCount > 0 ? 'bg-danger' : 'bg-success'} rounded-pill fs-6">
														${res.wrongCount}					
													</span>
					                            </td>
					                        </tr>
					                    </c:forEach>
					                </tbody>
					            </table>
					        </div>
					    </div>

    <div class="mt-5 d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/practice/" class="btn btn-primary btn-lg px-5 py-3 fw-bold rounded-pill shadow-sm">
            Luyện tập tiếp
        </a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-lg px-5 py-3 rounded-pill">
            Về trang chủ
        </a>
    </div>
</div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layouts/footer.jsp" />
</body>
</html>