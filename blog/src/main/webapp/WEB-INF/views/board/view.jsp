<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<!-- 본문 영역 -->
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
            <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning btn-sm">수정</a>
            <a href="${pageContext.request.contextPath}/board/delete/${board.id}" class="btn btn-danger btn-sm">삭제</a>
            <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary btn-sm">목록</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
