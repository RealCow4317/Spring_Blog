<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Index Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- 로그인 성공 alert -->
<c:if test="${not empty loginSuccess}">
    <script>alert("${loginSuccess}");</script>
    <c:remove var="loginSuccess" scope="session" />
</c:if>

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

<!-- 본문 영역 -->
<div class="container mt-4">
    <h2 class="mb-4">최근 게시글</h2>
    <div class="row board-preview">
        <c:forEach var="board" items="${recentBoards}">
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">${board.title}</h5>
                        <p class="card-text">
                            <c:choose>
                                <c:when test="${fn:length(board.content) > 50}">
                                    ${fn:substring(board.content, 0, 50)}...
                                </c:when>
                                <c:otherwise>
                                    ${board.content}
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-muted mb-2">
                            <small>작성일: <span class="created-at" data-time="${board.createdAt}"></span></small>
                        </p>
                        <a href="${pageContext.request.contextPath}/board/view/${board.id}" class="btn btn-sm btn-primary">읽기</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="view-more-btn mt-3 text-end">
        <a href="${pageContext.request.contextPath}/board/list" class="btn btn-outline-secondary">자세히 보기</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>

<!-- 작성일 상대 시간 표시 -->
<script>
    function timeAgo(dateStr) {
        const now = new Date();
        const target = new Date(dateStr);
        const diff = (now - target) / 1000;

        if (diff < 60) return "방금 전";
        if (diff < 3600) return Math.floor(diff / 60) + "분 전";
        if (diff < 86400) return Math.floor(diff / 3600) + "시간 전";
        if (diff < 2592000) return Math.floor(diff / 86400) + "일 전";
        return Math.floor(diff / 2592000) + "개월 전";
    }

    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll(".created-at").forEach(el => {
            const timeStr = el.dataset.time;
            if (timeStr) {
                el.textContent = timeAgo(timeStr);
            }
        });
    });
</script>
</body>
</html>
