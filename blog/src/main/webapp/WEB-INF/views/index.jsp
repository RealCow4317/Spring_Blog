<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Index Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">


</head>
<script>

</script>

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
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/">홈</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/board/list">게시판</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/profile">내 정보</a></li>
        </ul>
    </div>
</div>

<!-- 본문 영역 -->
<div class="container mt-4">
    <h2 class="mb-4">최근 게시글</h2>
    <div class="row board-preview">
        <c:forEach var="board" items="${recentBoards}">
            <div class="col-md-6">
                <div class="card">
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

    <div class="view-more-btn mt-3">
        <a href="${pageContext.request.contextPath}/board/list" class="btn btn-outline-secondary">자세히 보기</a>
    </div>
</div>


<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
