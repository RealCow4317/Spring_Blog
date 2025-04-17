<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<!-- 본문 -->
<div class="container mt-4">
    <h2 class="mb-4">게시글 상세 보기</h2>
    <div class="card p-4">
        <h4 class="mb-3">${board.title}</h4>
        <p><strong>카테고리:</strong> ${board.categoryName}</p>
        <p><strong>작성자:</strong> ${board.writer}</p>
        <p><strong>작성일:</strong> ${board.createdAt}</p>
        <hr>
        <p>${board.content}</p>

        <div class="mt-4">
            <!-- 로그인한 사용자와 작성자가 같을 때만 수정/삭제 버튼 표시 -->
            <c:if test="${not empty loginUser and loginUser.id eq board.writer}">
                <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning btn-sm">수정</a>
                <a href="${pageContext.request.contextPath}/board/delete/${board.id}" class="btn btn-danger btn-sm">삭제</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary btn-sm">목록</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
