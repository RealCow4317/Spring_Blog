<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>RealCowLabs - 메인</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
</head>
<body>

<c:if test="${not empty loginSuccess}">
    <script>alert("${loginSuccess}");</script>
    <c:remove var="loginSuccess" scope="session" />
</c:if>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="hero-section">
    <div class="container">
        <h1 class="display-4 fw-bold">RealCowLabs</h1>
        <p class="lead mb-4">"생각은 나누고, 할 일은 명확하게. 영감을 얻는 커뮤니티부터 꼼꼼한 일정 관리까지."</p>
        <div class="d-flex justify-content-center gap-3">
            <a href="${pageContext.request.contextPath}/board/list" class="btn btn-light btn-lg px-4">커뮤니티 둘러보기</a>
            <a href="#features" class="btn btn-outline-light btn-lg px-4">기능 알아보기</a>
        </div>
    </div>
</div>

<div id="features" class="container py-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100 text-center p-4 feature-card">
                <div class="card-icon text-primary">💬</div>
                <h4>커뮤니티</h4>
                <p class="text-muted">다양한 사람들과 영감을 주고받으며 함께 성장하세요.</p>
                <a href="${pageContext.request.contextPath}/board/list" class="btn btn-sm btn-outline-primary mt-auto">게시판 이동</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 text-center p-4 feature-card">
                <div class="card-icon text-success">✅</div>
                <h4>TODO 리스트</h4>
                <p class="text-muted">오늘의 할 일을 체계적으로 기록하고 관리하세요.</p>
                <a href="${pageContext.request.contextPath}/todo/list" class="btn btn-sm btn-outline-success mt-auto">할 일 작성</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 text-center p-4 feature-card">
                <div class="card-icon text-info">📅</div>
                <h4>캘린더</h4>
                <p class="text-muted">중요한 일정과 이벤트를 한눈에 파악하세요.</p>
                <a href="${pageContext.request.contextPath}/calendar/view" class="btn btn-sm btn-outline-info mt-auto">일정 확인</a>
            </div>
        </div>
    </div>
</div>

<hr class="container">

<div class="container mt-5 mb-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">최근 게시글</h2>
                <a href="${pageContext.request.contextPath}/board/list" class="text-muted text-decoration-none small">더보기 ></a>
            </div>
            <div class="row board-preview">
                <c:forEach var="board" items="${recentBoards}">
                    <div class="col-12">
                        <div class="card mb-3 overflow-hidden shadow-sm">
                            <div class="row g-0">
                                <c:if test="${not empty board.thumbnail}">
                                    <div class="col-md-3">
                                        <img src="${board.thumbnail}" class="img-fluid h-100 w-100" alt="썸네일" style="object-fit: cover; min-height: 120px;">
                                    </div>
                                    <div class="col-md-9">
                                </c:if>
                                <c:if test="${empty board.thumbnail}">
                                    <div class="col-md-12">
                                </c:if>
                                    <div class="card-body">
                                        <h5 class="card-title fw-bold text-truncate">${board.title}</h5>
                                        <p class="card-text text-muted small">
                                            <c:choose>
                                                <c:when test="${fn:length(board.contentWithoutImages) > 80}">
                                                    ${fn:substring(board.contentWithoutImages, 0, 80)}...
                                                </c:when>
                                                <c:otherwise>${board.contentWithoutImages}</c:otherwise>
                                            </c:choose>
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center mt-3">
                                            <small class="text-muted">
                                                <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd"/>
                                            </small>
                                            <a href="${pageContext.request.contextPath}/board/view/${board.id}" class="btn btn-sm btn-primary">읽기</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card bg-light border-0 p-3 mb-4">
                <h5 class="fw-bold mb-3">나의 현황</h5>
                <p class="small text-muted mb-2">오늘 완료할 일이 있나요?</p>
                <div class="list-group list-group-flush mb-3">
                    <div class="list-group-item bg-transparent px-0 small">✨ 새로운 영감을 기록해보세요</div>
                </div>
                <a href="${pageContext.request.contextPath}/todo/list" class="btn btn-dark w-100">할 일 추가하기</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>