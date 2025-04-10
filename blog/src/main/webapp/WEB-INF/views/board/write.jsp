<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>게시글 작성</title>
</head>
<body>
<h1>게시글 작성</h1>

<form action="${pageContext.request.contextPath}/board/write" method="post">
    <p>제목: <input type="text" name="title" /></p>
    <p>작성자: <input type="text" name="writer" /></p>
    <p>내용: <br/><textarea name="content" rows="10" cols="50"></textarea></p>
    <input type="submit" value="등록" />
</form>

<a href="${pageContext.request.contextPath}/board/list">목록</a>
</body>
</html>
