<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리자 카테고리관리</title>
<%@ include file="/WEB-INF/views/admin/common/adminHead.jsp" %>
</head>
<body">
<%@ include file="/WEB-INF/views/admin/common/adminNav.jsp" %>


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
</body>
</html>
