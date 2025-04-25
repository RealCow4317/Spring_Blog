<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시판 목록</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
    <link href="${pageContext.request.contextPath}/css/listStyle.css" rel="stylesheet">
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
            <th scope="col" style="width: 30px">✖️</th>
            <th scope="col">카테고리</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
            <th class="center" scope="col" style="width: 60px">조회수</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="board" items="${boards}">
            <c:if test="${board.pinned}">
                <tr onclick="location.href='${pageContext.request.contextPath}/board/view/${board.id}'" class="table-warning">
                    <td class="text-center">📌</td>
                    <td>${board.categoryName}</td>
                    <td class="text-primary fw-bold">
                            ${board.title}
                        <c:if test="${board.commentCount > 0}">
                            <span class="text-muted">(${board.commentCount})</span>
                        </c:if>
                    </td>
                    <td>${board.writer}</td>
                    <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="text-center">${board.views}</td>
                </tr>
            </c:if>
        </c:forEach>

        <c:forEach var="board" items="${boards}">
            <c:if test="${!board.pinned}">
                <tr onclick="location.href='${pageContext.request.contextPath}/board/view/${board.id}'">
                    <td class="text-center"></td> <!-- 번호 비워두기 -->
                    <td>${board.categoryName}</td>
                    <td class="text-primary">
                            ${board.title}
                        <c:if test="${board.commentCount > 0}">
                            <span class="text-muted">(${board.commentCount})</span>
                        </c:if>
                    </td>
                    <td>${board.writer}</td>
                    <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="text-center">${board.views}</td>
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

</body>
</html>
