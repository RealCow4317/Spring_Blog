<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>내 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

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
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/">홈</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/board/list">게시판</a></li>

            <c:choose>
                <c:when test="${not empty loginUser}">
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/profile">내 정보</a></li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/member/logout">
                            로그아웃 (${loginUser.name}님)
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>

<div class="container mt-5">
    <h2 class="mb-4">내 정보</h2>

    <div class="card p-4 shadow-sm">
        <p><strong>아이디:</strong> ${loginUser.id}</p>
        <p><strong>이름:</strong> ${loginUser.name}</p>
        <p><strong>이메일:</strong> ${loginUser.email}</p>
    </div>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">홈으로</a>
    </div>
</div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
