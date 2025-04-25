<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>회원목록</title>
    <%@ include file="/WEB-INF/views/admin/common/adminHead.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/views/admin/common/adminNav.jsp" %>

<div class="admin-layout">
    <!-- 사이드바 -->


    <!-- 본문 -->
    <div class="container mt-5">
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


</body>
</html>
