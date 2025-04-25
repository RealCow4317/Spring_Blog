<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-light">
    <div class="container-fluid">
        <button class="btn btn-outline-primary me-2"
                type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#adminSidebar"
                aria-controls="adminSidebar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <a class="navbar-brand" href="/admin">관리자 대시보드</a>
    </div>
</nav>

<div class="offcanvas offcanvas-start" tabindex="-1" id="adminSidebar" aria-labelledby="adminSidebarLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="adminSidebarLabel"><a href="/admin"> 관리자 메뉴</a></h5>
        <button type="button" class="btn-close text-reset"
                data-bs-dismiss="offcanvas"
                aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <h6>회원 관리</h6>
        <ul class="nav flex-column mb-4">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">유저 리스트</a>
            </li>
        </ul>

        <h6>콘텐츠 관리</h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/posts">게시글 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">카테고리 관리</a>
            </li>
        </ul>
    </div>
</div>
