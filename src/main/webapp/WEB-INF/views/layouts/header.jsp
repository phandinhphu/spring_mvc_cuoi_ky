<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
            <i class="fas fa-language me-2"></i>Nihongo Study
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-home me-1"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vocabulary/search">
                        <i class="fas fa-search me-1"></i>Tra từ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vocabulary/my-list">
                        <i class="fas fa-book me-1"></i>Sổ tay của tôi
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="practiceDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-dumbbell me-1"></i>Luyện tập
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/practice/flashcard">
                            <i class="fas fa-layer-group me-2"></i>Flashcard
                        </a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/practice/listening">
                            <i class="fas fa-headphones me-2"></i>Nghe
                        </a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/practice/typing">
                            <i class="fas fa-keyboard me-2"></i>Điền từ
                        </a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/practice/quiz">
                            <i class="fas fa-question-circle me-2"></i>Trắc nghiệm
                        </a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/statistics/">
                        <i class="fas fa-chart-line me-1"></i>Thống kê
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle me-1"></i>${username != null ? username : 'Người dùng'}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile/"><i class="fas fa-cog me-2"></i>Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                        </a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
