<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <title>404 - 페이지를 찾을 수 없습니다</title>
    <style>
        .container {
            text-align: center;
        }

        h1 {
            font-size: 6rem;
            margin: 0;
            color: #0d6efd;
        }

        h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        p {
            font-size: 1rem;
            color: #6c757d;
            margin-bottom: 30px;
        }

        a {
            display: inline-block;
            padding: 12px 24px;
            font-size: 1rem;
            background-color: #0d6efd;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>404</h1>
    <h2>페이지를 찾을 수 없습니다</h2>
    <p>요청하신 페이지는 존재하지 않거나<br>삭제되었을 수 있습니다.</p>
    <a href="<%= request.getContextPath() %>/">🏠 메인으로 돌아가기</a>
</div>
</body>
</html>
