<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>
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
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="admin-layout">
    <!-- 사이드바 -->
    <div class="admin-sidebar">
        <h5>회원 관리</h5>
        <a href="${pageContext.request.contextPath}/admin/users">유저 리스트</a>
        <h5 class="mt-4">콘텐츠 관리</h5>
        <a href="${pageContext.request.contextPath}/admin/posts">게시글 관리</a>
        <a href="${pageContext.request.contextPath}/admin/categories">카테고리 관리</a>
    </div>

    <!-- 본문 -->
    <div class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>👥 전체 회원 목록</h2>
            <a href="${pageContext.request.contextPath}/admin/users/add" class="btn btn-success btn-sm">+ 회원 추가</a>
        </div>

        <div class="card p-3 shadow-sm">
            <table class="table table-hover table-bordered bg-white">
                <thead class="table-dark">
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>관리자 여부</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}" varStatus="status">
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
                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/admin/users/edit/${user.memberNo}" class="btn btn-sm btn-outline-primary">수정</a>
                            <a href="${pageContext.request.contextPath}/admin/users/delete/${user.memberNo}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
