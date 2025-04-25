<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
  <title>회원등록</title>
  <%@ include file="/WEB-INF/views/admin/common/adminHead.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/common/adminNav.jsp" %>

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
</body>
</html>
