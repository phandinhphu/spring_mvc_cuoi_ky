<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sổ tay của tôi - Nihongo Study</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="../layouts/header.jsp" />

	<main class="py-4">
		<div class="container">
			<div class="row mb-4">
				<div
					class="col-12 d-flex justify-content-between align-items-center">
					<div id="title-section">
						<h2 class="mb-0">
							<i class="fas fa-book me-2"></i>Sổ tay của tôi
						</h2>
						<p class="text-muted mt-1">Quản lý và luyện tập từ vựng đã lưu</p>
					</div>
					<c:if test="${viewMode == 'LIST'}">
						<a href="${pageContext.request.contextPath}/vocabulary/my-list"
							class="btn btn-outline-secondary"> <i
							class="fas fa-arrow-left me-1"></i> Quay lại chung
						</a>
					</c:if>
				</div>
			</div>

			<div class="row mb-4">
				<div class="col-12">
					<div class="card search-container shadow-sm border-0">
						<div class="card-body">
							<form
								action="${pageContext.request.contextPath}/vocabulary/my-list"
								method="GET" id="searchForm">
								<div class="row g-2">
									<div class="col-lg-8">
										<div class="search-box position-relative">
											<i
												class="fas fa-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
											<input type="text" name="keyword" class="form-control ps-5"
												placeholder="Tìm kiếm bằng Romaji trong toàn bộ sổ tay..."
												value="${param.keyword}" style="border-radius: 10px;">
										</div>
									</div>
									<div class="col-lg-4">
										<button type="submit" class="btn btn-primary w-100"
											style="border-radius: 10px;">
											<i class="fas fa-search me-1"></i> Tìm kiếm
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<form
				action="${pageContext.request.contextPath}/vocabulary/update-notebook-status"
				method="POST" id="statusForm">
				<input type="hidden" name="currentStatus" value="${currentStatus}">

				<c:if test="${viewMode == 'LIST' && empty param.keyword}">
					<div class="row mb-3">
						<div class="col-12 text-end">
							<button type="submit" class="btn btn-success px-4"
								style="border-radius: 10px;">
								<i class="fas fa-save me-1"></i> Lưu
							</button>
						</div>
					</div>
				</c:if>

				<c:choose>
					<%-- TRƯỜNG HỢP 1: DASHBOARD (2 CARD TỔNG QUÁT) --%>
					<c:when test="${viewMode == 'DASHBOARD'}">
						<div class="row g-4">
							<div class="col-md-6">
								<a href="?status=active" class="notebook-card card-active">
									<span class="card-icon py-3 d-block"> <img
										src="${pageContext.request.contextPath}/resources/images/mascot_study.png"
										alt="Ôn tập" class="notebook-img"
										onerror="this.src='https://cdn-icons-png.flaticon.com/512/3429/3429156.png'">
								</span> <span class="card-number h1 d-block">${reviewCount}</span> <span
									class="card-label h5 text-muted d-block">từ ôn tập</span>
								</a>
							</div>
							<div class="col-md-6">
								<a href="?status=sleep" class="notebook-card card-sleep"> <span
									class="card-icon py-3 d-block"> <img
										src="${pageContext.request.contextPath}/resources/images/mascot_sleep.png"
										alt="Ngủ đông" class="notebook-img"
										onerror="this.src='https://cdn-icons-png.flaticon.com/512/3094/3094831.png'">
								</span> <span class="card-number h1 d-block">${sleepCount}</span> <span
									class="card-label h5 text-muted d-block">từ ngủ đông</span>
								</a>
							</div>
						</div>
					</c:when>

					<%-- TRƯỜNG HỢP 2: LIST (DANH SÁCH CHI TIẾT) --%>
					<c:otherwise>
						<div class="row" id="vocab-list">
							<c:forEach var="vocab" items="${vocabularies}">
								<div class="col-12 mb-3">
									<input type="hidden" name="allIds" value="${vocab.userVocabId}">

									<div class="vocab-card p-3 shadow-sm bg-white border rounded">
										<div class="row align-items-center">
											<div class="col-lg-1 text-center">
												<input type="checkbox" name="tickedIds"
													value="${vocab.userVocabId}" class="form-check-input"
													style="width: 25px; height: 25px;"
													${currentStatus == 'sleep' || vocab.status == 'sleep' ? 'checked' : ''}>
											</div>

											<div class="col-lg-7">
												<c:if test="${not empty param.keyword}">
													<span
														class="badge ${vocab.status == 'active' ? 'bg-warning' : 'bg-secondary'} mb-2">
														${vocab.status == 'active' ? 'Đang ôn tập' : 'Ngủ đông'} </span>
												</c:if>
												<div class="h4 text-primary mb-1">${vocab.word}</div>
												<div class="mb-2">
													<span class="badge bg-info me-2">${vocab.hiragana}</span> <span
														class="text-muted small">[${vocab.romaji}]</span>
												</div>
												<div class="vocab-meaning">
													<i class="fas fa-language me-2 text-secondary"></i>${vocab.meaning}
												</div>
											</div>
											<div class="col-lg-4 text-lg-end">
												<div class="btn-group">
													<a
														href="${pageContext.request.contextPath}/vocabulary/detail/${vocab.vocabId}"
														class="btn btn-outline-info btn-sm">Chi tiết</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

						<c:if test="${empty vocabularies}">
							<div class="card border-0 shadow-sm">
								<div class="card-body text-center py-5">
									<i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
									<h5 class="text-muted">Không tìm thấy từ vựng nào phù hợp</h5>
									<c:if test="${not empty param.keyword}">
										<a
											href="${pageContext.request.contextPath}/vocabulary/my-list"
											class="btn btn-link">Xem lại toàn bộ sổ tay</a>
									</c:if>
								</div>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>
			</form>
		</div>
	</main>

	<jsp:include page="../layouts/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>