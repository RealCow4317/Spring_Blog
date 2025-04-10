<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>게시글 수정</title>
</head>
<body>
<h1>게시글 수정</h1>

<form action="${pageContext.request.contextPath}/board/edit" method="post">
    <input type="hidden" name="id" value="${board.id}" />
    <p>제목: <input type="text" name="title" value="${board.title}" /></p>
    <p>작성자: <input type="text" name="writer" value="${board.writer}" readonly /></p>
    <p>내용: <br/><textarea name="content" rows="10" cols="50">${board.content}</textarea></p>
    <input type="submit" value="수정" />
</form>

<a href="${pageContext.request.contextPath}/board/view/${board.id}">뒤로</a>
</body>
</html>
