<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<!-- 본문 -->
<div class="container mt-5">
    <h2 class="mb-4">게시글 작성</h2>
    <div class="card p-4">
        <form action="${pageContext.request.contextPath}/board/write" method="post">

            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>

            <div class="mb-3">
                <label for="writer" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer" name="writer" value="${loginUser.id}" readonly>
            </div>

            <div class="mb-3">
                <label for="categoryId" class="form-label">카테고리</label>
                <select class="form-select" id="categoryId" name="categoryId" required>
                    <option value="">카테고리 선택</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.id}" ${cat.id == board.categoryId ? "selected" : ""}>
                                ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="8" required></textarea>
            </div>

            <div class="d-flex justify-content-between">
                <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary">목록</a>
                <button type="submit" class="btn btn-success">등록</button>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
