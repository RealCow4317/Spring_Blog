<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">회원가입</h2>
    <form id="joinForm" action="${pageContext.request.contextPath}/member/join" method="post" class="card p-4 shadow-sm">
        <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <div class="input-group">
                <input type="text" name="id" id="id" class="form-control" required>
                <button type="button" class="btn btn-outline-secondary" onclick="checkDuplicate('id')">중복확인</button>
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" name="name" id="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <div class="input-group">
                <input type="email" name="email" id="email" class="form-control" placeholder="email@example.com" required>
                <button type="button" class="btn btn-outline-secondary" id="checkEmailBtn" onclick="checkDuplicate('email')">중복확인</button>
            </div>
        </div>

        <button type="submit" id="submitBtn" class="btn btn-primary w-100" disabled>회원가입</button>
    </form>
    <div class="mt-3 text-end">
        <a href="${pageContext.request.contextPath}/member/login">이미 계정이 있으신가요?</a>
    </div>
</div>

<!-- JSP 상단 somewhere in <head> or <body> -->
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<script>
    let idChecked = false;
    let emailChecked = false;

    function checkDuplicate(field) {
        const value = document.getElementById(field).value.trim();
        if (!value) {
            alert(field === "id" ? "아이디를 입력하세요." : "이메일을 입력하세요.");
            return;
        }

        const url = field === "id"
            ? contextPath + "/member/check-id?id=" + encodeURIComponent(value)
            : contextPath + "/member/check-email?email=" + encodeURIComponent(value);

        fetch(url)
            .then(res => res.text())
            .then(data => {
                const available = data === "true";
                const label = field === "id" ? "아이디" : "이메일";

                if (available) {
                    alert("사용 가능한" + label + "입니다.");
                    if (field === "id") idChecked = true;
                    if (field === "email") emailChecked = true;
                } else {
                    alert("이미 존재하는" + label + "입니다.");
                    if (field === "id") idChecked = false;
                    if (field === "email") emailChecked = false;
                }

                document.getElementById("submitBtn").disabled = !(idChecked && emailChecked);
            });
    }

    document.getElementById("id").addEventListener("input", () => {
        idChecked = false;
        document.getElementById("submitBtn").disabled = true;
    });
    document.getElementById("email").addEventListener("input", () => {
        emailChecked = false;
        document.getElementById("submitBtn").disabled = true;
    });


    //이메일형식
    function isValidEmailFormat(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    document.getElementById("email").addEventListener("input", () => {
        emailChecked = false;

        const emailValue = document.getElementById("email").value.trim();
        const isValid = isValidEmailFormat(emailValue);

        document.getElementById("checkEmailBtn").disabled = !isValid;
        document.getElementById("submitBtn").disabled = true;
    });
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
