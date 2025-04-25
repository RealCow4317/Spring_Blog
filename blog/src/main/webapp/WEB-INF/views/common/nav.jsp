<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar fixed-top navbar-dark bg-dark" style="background-color: #343a40 !important;">
    <div class="container-fluid">

        <div class="d-flex align-items-center">
            <!-- 메뉴 버튼 -->
            <button class="btn btn-outline-light me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#sideMenu" aria-controls="sideMenu">
                ☰ 메뉴
            </button>

            <!-- 로고 이미지 -->
            <a href="${pageContext.request.contextPath}/" >
                <img src="${pageContext.request.contextPath}/img/logo.png" alt="REALCOW Logo" style="height: 36px;">
            </a>
        </div>
        <div class="dropdown position-fixed top-0 end-0 m-3 z-3">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="themeDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-circle-half"></i> Theme
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="themeDropdown">
                <li><button class="dropdown-item" data-theme-value="light"><i class="bi bi-sun-fill me-2"></i>Light</button></li>
                <li><button class="dropdown-item" data-theme-value="dark"><i class="bi bi-moon-fill me-2"></i>Dark</button></li>
                <li><button class="dropdown-item" data-theme-value="auto"><i class="bi bi-circle-half me-2"></i>Auto</button></li>
            </ul>
        </div>

    </div>
</nav>
