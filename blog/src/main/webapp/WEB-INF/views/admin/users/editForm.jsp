<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 수정</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
  <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
  <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
</head>
<body>

<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="container mt-5">
  <h2 class="mb-4">👤 회원 수정</h2>
  <form action="${pageContext.request.contextPath}/admin/users/edit" method="post" class="card p-4 shadow-sm">

    <input type="hidden" name="memberNo" value="${user.memberNo}" />

    <div class="mb-3">
      <label for="id" class="form-label">아이디</label>
      <input type="text" id="id" name="id" class="form-control" value="${user.id}" readonly />
    </div>

    <div class="mb-3">
      <label for="password" class="form-label">새 비밀번호 (선택)</label>
      <input type="password" id="password" name="password" class="form-control" placeholder="변경 시에만 입력" />
    </div>

    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" id="name" name="name" class="form-control" value="${user.name}" required />
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">이메일</label>
      <input type="email" id="email" name="email" class="form-control" value="${user.email}" />
    </div>

    <div class="mb-3 form-check">
      <input type="checkbox" class="form-check-input" id="admin" name="admin" ${user.admin ? 'checked' : ''} />
      <label class="form-check-label" for="admin">관리자 권한</label>
    </div>

    <div class="d-flex justify-content-between">
      <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">취소</a>
      <button type="submit" class="btn btn-primary">수정 완료</button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
