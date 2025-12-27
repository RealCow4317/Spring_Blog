<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>회원가입</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
    <script src="${pageContext.request.contextPath}/js/join_script.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">회원가입</h2>
    <form id="joinForm" action="${pageContext.request.contextPath}/member/join" method="post" class="card p-4 shadow-sm">

        <!-- 아이디 -->
        <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <div class="input-group">
                <input type="text" name="id" id="id" class="form-control" required>
                <button type="button" class="btn btn-outline-secondary" id="checkIdBtn" onclick="checkDuplicate('id')" disabled>중복확인</button>
            </div>
        </div>

        <!-- 비밀번호 -->
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="mb-3">
            <label for="confirmPassword" class="form-label">비밀번호 확인</label>
            <input type="password" id="confirmPassword" class="form-control" required>
            <small id="passwordMatchMessage" class="form-text"></small>
        </div>

        <!-- 이름 -->
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" name="name" id="name" class="form-control" required>
        </div>

        <!-- 이메일 -->
        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <div class="input-group">
                <input type="email" name="email" id="email" class="form-control" placeholder="email@example.com" required>
                <button type="button" class="btn btn-outline-secondary" id="checkEmailBtn" onclick="checkDuplicate('email')" disabled>중복확인</button>
            </div>
        </div>

        <!-- 이용약관 -->
        <div class="mb-3">
            <label class="form-label">이용약관</label>
            <%@ include file="/WEB-INF/views/member/terms.jsp" %>
            <div class="form-check mt-2">
                <input class="form-check-input" type="checkbox" id="agreeTerms">
                <label class="form-check-label" for="agreeTerms">
                    이용약관에 동의합니다.
                </label>
            </div>
        </div>

        <button type="submit" id="submitBtn" class="btn btn-primary w-100" disabled>회원가입</button>
    </form>

    <div class="mt-3 text-end">
        <a href="${pageContext.request.contextPath}/member/login">이미 계정이 있으신가요?</a>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

</body>
</html>
