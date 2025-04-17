<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<c:if test="${not empty joinSuccess}">
    <script>alert("${joinSuccess}");</script>
    <c:remove var="joinSuccess" scope="session" />
</c:if>

<div class="container mt-5">
    <h2 class="mb-4">로그인</h2>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/member/login" method="post" class="card p-4 shadow-sm">
        <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <input type="text" name="id" id="id" class="form-control" value="${enteredId}" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>

    <div class="mt-3 text-end">
        <a href="${pageContext.request.contextPath}/member/join">회원가입 하러가기</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
