<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- 상단 네비게이션 -->
<nav class="navbar fixed-top navbar-dark bg-dark">
    <div class="container-fluid">
        <button class="btn btn-outline-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#sideMenu" aria-controls="sideMenu">
            ☰ 메뉴
        </button>
        <span class="navbar-text text-white">빼지누의 블로그</span>
    </div>
</nav>

<!-- 오프캔버스 사이드 메뉴 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="sideMenu" aria-labelledby="sideMenuLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="sideMenuLabel">메뉴</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link text-white" href="/">홈</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="/board/list">게시판</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="/member/profile">내 정보</a></li>
        </ul>
    </div>
</div>

<!-- 본문 영역 -->
<div class="container mt-4">
    <h2 class="mb-4">게시글 상세 보기</h2>
    <div class="card">
        <h4 class="mb-3">${board.title}</h4>
        <p><strong>작성자:</strong> ${board.writer}</p>
        <p><strong>작성일:</strong> ${board.createdAt}</p>
        <hr>
        <p>${board.content}</p>
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning btn-sm">수정</a>
            <a href="${pageContext.request.contextPath}/board/delete/${board.id}" class="btn btn-danger btn-sm">삭제</a>
            <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary btn-sm">목록</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
