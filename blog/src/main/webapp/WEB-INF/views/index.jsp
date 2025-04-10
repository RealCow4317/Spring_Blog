<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Index Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 60px;
            background-color: #f8f9fa;
        }

        .offcanvas {
            background-color: #343a40;
            color: white;
        }

        .board-preview .card {
            margin-bottom: 20px;
        }

        .view-more-btn {
            text-align: right;
        }
    </style>
</head>
<body>

<!-- 상단 네비게이션 -->
<nav class="navbar fixed-top navbar-dark bg-dark">
    <div class="container-fluid">
        <button class="btn btn-outline-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#sideMenu" aria-controls="sideMenu">
            ☰ 메뉴
        </button>
        <span class="navbar-text text-white">빼지누의 블로그</span>
    </div>
</nav>

<!-- 오프캔버스 사이드 메뉴 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="sideMenu" aria-labelledby="sideMenuLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="sideMenuLabel">메뉴</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link text-white" href="/">홈</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="/board/list">게시판</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="/member/profile">내 정보</a></li>
        </ul>
    </div>
</div>

<!-- 본문 영역 -->
<div class="container mt-4">
    <h2 class="mb-4">최근 게시글</h2>
    <div class="row board-preview">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">게시글 제목 1</h5>
                    <p class="card-text">게시글 내용 요약 또는 미리보기 텍스트...</p>
                    <a href="/board/detail?id=1" class="btn btn-sm btn-primary">읽기</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">게시글 제목 2</h5>
                    <p class="card-text">게시글 내용 요약 또는 미리보기 텍스트...</p>
                    <a href="/board/detail?id=2" class="btn btn-sm btn-primary">읽기</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">게시글 제목 3</h5>
                    <p class="card-text">게시글 내용 요약 또는 미리보기 텍스트...</p>
                    <a href="/board/detail?id=3" class="btn btn-sm btn-primary">읽기</a>
                </div>
            </div>
        </div>
    </div>
    <div class="view-more-btn mt-3">
        <a href="/board/list" class="btn btn-outline-secondary">자세히 보기</a>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
