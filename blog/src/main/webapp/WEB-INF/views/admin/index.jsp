<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 대시보드</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
  <style>
    .admin-layout {
      display: flex;
      min-height: 100vh;
    }
    .admin-sidebar {
      width: 220px;
      background-color: #343a40;
      padding: 20px;
      color: white;
    }
    .admin-sidebar h5 {
      color: #fff;
      margin-bottom: 15px;
    }
    .admin-sidebar a {
      display: block;
      margin-bottom: 10px;
      color: #ccc;
      text-decoration: none;
    }
    .admin-sidebar a:hover {
      color: #fff;
    }
    .admin-content {
      flex-grow: 1;
      padding: 30px;
      background-color: #f8f9fa;
    }
    .table-hover tbody tr:hover {
      background-color: #f1f1f1;
      cursor: pointer;
    }
    .view-more {
      text-align: right;
      margin-top: -15px;
      margin-bottom: 30px;
    }
  </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="admin-layout">
  <div class="admin-sidebar">
    <h5>회원 관리</h5>
    <a href="${pageContext.request.contextPath}/admin/users">유저 리스트</a>

    <h5 class="mt-4">콘텐츠 관리</h5>
    <a href="${pageContext.request.contextPath}/admin/posts">게시글 관리</a>
    <a href="${pageContext.request.contextPath}/admin/categories">카테고리 관리</a>
  </div>

  <div class="admin-content">
    <h2 class="mb-4">👑 관리자 대시보드</h2>

    <!-- 회원 리스트 -->
    <div class="card p-3 shadow-sm mb-4">
      <h4 class="mb-3">회원 리스트</h4>
      <table class="table table-hover table-bordered bg-white">
        <thead class="table-dark">
        <tr>
          <th>번호</th>
          <th>아이디</th>
          <th>이름</th>
          <th>이메일</th>
          <th>관리자 여부</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}" varStatus="status" begin="0" end="4">
          <tr>
            <td>${status.index + 1}</td>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>
              <c:choose>
                <c:when test="${user.admin}">✔</c:when>
                <c:otherwise>✖</c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <div class="view-more">
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-secondary">자세히 보기</a>
      </div>
    </div>

    <!-- 게시글 리스트 -->
    <div class="card p-3 shadow-sm mb-4">
      <h4 class="mb-3">게시글 리스트</h4>
      <table class="table table-hover table-bordered bg-white">
        <thead class="table-dark">
        <tr>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="post" items="${recentPosts}" varStatus="status" begin="0" end="4">
          <tr>
            <td>${post.title}</td>
            <td>${post.writer}</td>
            <td>${post.createdAt}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <div class="view-more">
        <a href="${pageContext.request.contextPath}/admin/posts" class="btn btn-sm btn-outline-secondary">자세히 보기</a>
      </div>
    </div>

    <!-- 카테고리 리스트 -->
    <div class="card p-3 shadow-sm">
      <h4 class="mb-3">카테고리 리스트</h4>
      <table class="table table-hover table-bordered bg-white">
        <thead class="table-dark">
        <tr>
          <th>카테고리명</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cat" items="${categories}" varStatus="status" begin="0" end="4">
          <tr>
            <td>${cat.name}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <div class="view-more">
        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-sm btn-outline-secondary">자세히 보기</a>
      </div>
    </div>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
