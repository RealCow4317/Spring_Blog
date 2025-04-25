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
        <div class="col-md-6 d-flex">
            <div class="card mb-3 w-100">
                <div class="row g-0 align-items-stretch h-100">
                    <c:if test="${not empty board.thumbnail}">
                    <div class="col-md-4 d-flex">
                        <img src="${board.thumbnail}" class="img-fluid w-100"
                             alt="썸네일" style="object-fit: cover; height: 100%;">
                    </div>
                    <div class="col-md-8">
                        </c:if>
                        <c:if test="${empty board.thumbnail}">
                        <div class="col-md-12">
                            </c:if>
                            <div class="card-body d-flex flex-column justify-content-between h-100">
                                <div>
                                    <h5 class="card-title">${board.title}</h5>
                                    <p class="card-text">
                                        <c:choose>
                                            <c:when test="${fn:length(board.contentWithoutImages) > 50}">
                                                ${fn:substring(board.contentWithoutImages, 0, 50)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${board.contentWithoutImages}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-muted mb-2">
                                        <small>작성일: <span class="created-at" data-time="${board.createdAt}"></span></small>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/board/view/${board.id}"
                                       class="btn btn-sm btn-primary">읽기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>

        <div class="view-more-btn mt-3 text-end">
            <a href="${pageContext.request.contextPath}/board/list" class="btn btn-outline-secondary">자세히 보기</a>
        </div>
    </div>


</body>
</html>
