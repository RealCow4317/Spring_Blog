<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">댓글 수정</h2>
    <form action="${pageContext.request.contextPath}/comment/edit" method="post" class="card p-4 shadow-sm">
        <input type="hidden" name="id" value="${comment.id}" />
        <input type="hidden" name="boardId" value="${comment.boardId}" />
        <input type="hidden" name="writer" value="${comment.writer}" />

        <div class="mb-3">
            <label class="form-label">내용</label>
            <textarea name="content" class="form-control" rows="4" required>${comment.content}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="${pageContext.request.contextPath}/board/view/${comment.boardId}" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>
