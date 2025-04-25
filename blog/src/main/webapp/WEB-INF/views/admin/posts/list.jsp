<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>게시글관리</title>
    <%@ include file="/WEB-INF/views/admin/common/adminHead.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/common/adminNav.jsp" %>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📋 게시글 관리</h2>
        <a href="${pageContext.request.contextPath}/admin/posts/write" class="btn btn-primary">➕ 새 글 작성</a>
    </div>

    <!-- 검색 & 카테고리 필터 -->
    <form method="get" action="${pageContext.request.contextPath}/admin/posts" class="row g-2 mb-4">
        <div class="col-md-4">
            <select name="categoryId" class="form-select">
                <option value="">전체 카테고리</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}" ${cat.id == categoryId ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-6">
            <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요" value="${keyword != null ? keyword : ''}" />
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-outline-secondary w-100">검색</button>
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
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="post" items="${posts}">
            <tr onclick="location.href='${pageContext.request.contextPath}/admin/posts/view/${post.id}'">
                <td>${post.id}</td>
                <td>${post.categoryName}</td>
                <td>${post.pinned ? "📌 " : ""}${post.title}
                    <c:if test="${post.commentCount > 0}">
                        <span class="text-muted small">(${post.commentCount})</span>
                    </c:if>
                </td>
                <td>${post.writer}</td>
                <td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td class="text-center">${post.views}</td> <!-- ✅ 수정된 부분 -->
            </tr>
        </c:forEach>
        </tbody>

    </table>

    <!-- 페이징 -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/posts?page=${currentPage - 1}&keyword=${keyword}&categoryId=${categoryId}">«</a>
                </li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/posts?page=${i}&keyword=${keyword}&categoryId=${categoryId}">${i}</a>
                </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/posts?page=${currentPage + 1}&keyword=${keyword}&categoryId=${categoryId}">»</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</body>
</html>
