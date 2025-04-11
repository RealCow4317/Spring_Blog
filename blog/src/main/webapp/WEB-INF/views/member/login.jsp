<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
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
    <h2 class="mb-4">로그인</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/member/login" method="post" class="card p-4 shadow-sm">
        <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <input type="text" name="id" id="id" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>
    <div class="mt-3 text-end">
        <a href="${pageContext.request.contextPath}/member/join">회원가입 하러가기</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
