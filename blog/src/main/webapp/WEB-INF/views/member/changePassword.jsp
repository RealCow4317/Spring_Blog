<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 변경</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">🔒 비밀번호 변경</h2>
    <form action="${pageContext.request.contextPath}/member/changePassword" method="post" class="card p-4 shadow-sm">
        <div class="mb-3">
            <label for="currentPassword" class="form-label">현재 비밀번호</label>
            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
        </div>
        <div class="mb-3">
            <label for="newPassword" class="form-label">새 비밀번호</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <button type="submit" class="btn btn-primary">비밀번호 변경</button>
        <a href="${pageContext.request.contextPath}/member/profile" class="btn btn-secondary">취소</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
