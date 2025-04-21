<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
    <style>
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📋 게시글 목록</h2>
        <a href="${pageContext.request.contextPath}/board/write" class="btn btn-primary">✏️ 글쓰기</a>
    </div>

    <form method="get" action="${pageContext.request.contextPath}/board/list" class="mb-4">
        <div class="row g-2">
            <div class="col-md-4">
                <select name="categoryId" class="form-select">
                    <option value="">전체 카테고리</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.id}" ${categoryId == cat.id ? "selected" : ""}>${cat.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6">
                <input type="text" name="keyword" class="form-control"
                       placeholder="검색어를 입력하세요"
                       value="${keyword != null ? keyword : ''}">
            </div>
            <div class="col-md-2">
                <button class="btn btn-outline-secondary w-100" type="submit">검색</button>
            </div>
        </div>
    </form>

    <table class="table table-hover table-bordered bg-white">
        <thead class="table-dark">
        <tr>
            <th scope="col">번호</th>
            <th scope="col">카테고리</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
        </tr>
        </thead>
        <tbody>

        <!-- ✅ 고정 게시글 먼저 출력 -->
        <c:forEach var="board" items="${boards}">
            <c:if test="${board.pinned}">
                <tr onclick="location.href='${pageContext.request.contextPath}/board/view/${board.id}'" class="table-warning">
                    <td>📌</td>
                    <td>${board.categoryName}</td>
                    <td class="text-primary fw-bold">${board.title}</td>
                    <td>${board.writer}</td>
                    <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:if>
        </c:forEach>

        <!-- ✅ 일반 게시글 출력 -->
        <c:forEach var="board" items="${boards}">
            <c:if test="${!board.pinned}">
                <tr onclick="location.href='${pageContext.request.contextPath}/board/view/${board.id}'">
                    <td>${board.id}</td>
                    <td>${board.categoryName}</td>
                    <td class="text-primary">${board.title}</td>
                    <td>${board.writer}</td>
                    <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:if>
        </c:forEach>

        </tbody>
    </table>

    <nav>
        <ul class="pagination justify-content-center mt-4">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/board/list?page=${currentPage - 1}&keyword=${keyword}&categoryId=${categoryId}">«</a>
                </li>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/board/list?page=${i}&keyword=${keyword}&categoryId=${categoryId}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/board/list?page=${currentPage + 1}&keyword=${keyword}&categoryId=${categoryId}">»</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
