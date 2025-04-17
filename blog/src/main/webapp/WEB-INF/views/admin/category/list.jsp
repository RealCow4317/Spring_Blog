<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body">

<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">📂 카테고리 관리</h2>

    <!-- 카테고리 추가 폼 -->
    <form method="post" action="${pageContext.request.contextPath}/admin/categories/add" class="row g-2 mb-4">
        <div class="col-auto">
            <input type="text" name="name" class="form-control" placeholder="새 카테고리명 입력" required />
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">➕ 추가</button>
        </div>
    </form>

    <!-- 카테고리 목록 -->
    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>카테고리명</th>
            <th style="width: 100px;">관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cat" items="${categories}">
            <tr>
                <td>${cat.name}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/categories/delete/${cat.id}"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('삭제하시겠습니까?')">삭제</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
