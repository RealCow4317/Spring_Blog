<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>내정보</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
</head>
<body class="bg-light">


<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>


<div class="container mt-5">
    <h2 class="mb-4">내 정보</h2>

    <div class="card p-4 shadow-sm">
        <p><strong>아이디:</strong> ${loginUser.id}</p>
        <p><strong>이름:</strong> ${loginUser.name}</p>
        <p><strong>이메일:</strong> ${loginUser.email}</p>
    </div>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/member/change-password" class="btn btn-outline-primary">비밀번호 변경</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">홈으로</a>
    </div>

</div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
