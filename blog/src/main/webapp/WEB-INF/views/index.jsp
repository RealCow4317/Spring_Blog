<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메인페이지</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
</head>
<body>

<!-- 로그인 성공 alert -->
<c:if test="${not empty loginSuccess}">
    <script>alert("${loginSuccess}");</script>
    <c:remove var="loginSuccess" scope="session" />
</c:if>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

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
