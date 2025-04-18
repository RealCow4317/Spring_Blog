<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 등록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
  <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
  <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body>
<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="container mt-5">
  <h2 class="mb-4">👤 회원 등록</h2>
  <form action="${pageContext.request.contextPath}/admin/users/add" method="post" class="card p-4 shadow-sm">
    <div class="mb-3">
      <label for="id" class="form-label">아이디</label>
      <input type="text" name="id" id="id" class="form-control" required>
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
      <input type="email" name="email" id="email" class="form-control">
    </div>

    <button type="submit" class="btn btn-primary w-100">등록</button>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
