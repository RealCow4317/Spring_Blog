<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
    <link rel="icon"
          href="${pageContext.request.contextPath}/resources/favicon.ico"
          type="image/x-icon">
</head>
<body>
<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">📋 게시글 관리</h2>

    <!-- 검색 & 카테고리 필터 -->
    <form method="get"
          action="${pageContext.request.contextPath}/admin/posts"
          class="row g-2 mb-4">
        <div class="col-md-4">
            <select name="categoryId" class="form-select">
                <option value="">전체 카테고리</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}"
                        ${cat.id == categoryId ? 'selected' : ''}>
                            ${cat.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-6">
            <input type="text"
                   name="keyword"
                   class="form-control"
                   placeholder="검색어를 입력하세요"
                   value="${keyword != null ? keyword : ''}" />
        </div>
        <div class="col-md-2">
            <button type="submit"
                    class="btn btn-outline-secondary w-100">
                검색
            </button>
        </div>
    </form>

    <!-- 게시글 테이블 -->
    <table class="table table-hover table-bordered bg-white">
        <thead class="table-dark">
        <tr>
            <th>번호</th>
            <th>카테고리</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="post" items="${posts}">
            <tr>
                <td>${post.id}</td>
                <td>${post.categoryName}</td>
                <td>${post.title}</td>
                <td>${post.writer}</td>
                <td>
                    <fmt:formatDate
                            value="${post.createdAt}"
                            pattern="yyyy-MM-dd HH:mm"/>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/posts/edit/${post.id}"
                       class="btn btn-sm btn-warning">수정</a>
                    <a href="${pageContext.request.contextPath}/admin/posts/delete/${post.id}"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('정말 삭제하시겠습니까?');">
                        삭제
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 페이징 -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/admin/posts?page=${currentPage - 1}
                                  &keyword=${keyword}&categoryId=${categoryId}">
                        «
                    </a>
                </li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/admin/posts?page=${i}
                                  &keyword=${keyword}&categoryId=${categoryId}">
                            ${i}
                    </a>
                </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link"
                       href="${pageContext.request.contextPath}/admin/posts?page=${currentPage + 1}
                                  &keyword=${keyword}&categoryId=${categoryId}">
                        »
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
