<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar fixed-top navbar-dark bg-dark" style="background-color: #343a40 !important;">
    <div class="container-fluid">
        <!-- Left-aligned items (Hamburger Menu Button and Logo) -->
        <div class="d-flex align-items-center">
            <!-- Offcanvas Menu Button -->
            <button class="btn btn-outline-light me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#sideMenu" aria-controls="sideMenu">
                ☰
            </button>
            <!-- Logo -->
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/img/logo.png" alt="REALCOW Logo" style="height: 36px;">
            </a>
        </div>

        <!-- Centered Menu Items -->
        <ul class="navbar-nav mx-auto d-flex flex-row gap-4">
            <li class="nav-item">
                <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/board/list">Board</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/todo/list">ToDo</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/calendar/view">Calendar</a>
            </li>
        </ul>

        <!-- Right-aligned items (Theme Dropdown) -->
        <div class="d-flex align-items-center">
            <div class="dropdown">
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
    </div>
</nav>
