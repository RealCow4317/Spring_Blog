<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>수정</title>
    <%@ include file="/WEB-INF/views/admin/common/adminHead.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/common/adminNav.jsp" %>
<div class="container mt-5">
    <h2 class="mb-4">✍️ 게시글 수정</h2>
    <div class="card p-4 shadow-sm">
        <form action="${pageContext.request.contextPath}/admin/posts/edit" method="post">
            <input type="hidden" name="id" value="${board.id}" />

            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-control" value="${board.title}" required>
            </div>

            <div class="mb-3">
                <label for="writer" class="form-label">작성자</label>
                <input type="text" id="writer" name="writer" class="form-control" value="${board.writer}" readonly>
            </div>

            <div class="mb-3">
                <label for="categoryId" class="form-label">카테고리</label>
                <select id="categoryId" name="categoryId" class="form-select" required>
                    <option value="">카테고리 선택</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.id}" ${cat.id == board.categoryId ? 'selected' : ''}>
                                ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea id="content" name="content" class="form-control" rows="8" required>${board.content}</textarea>
            </div>

            <div class="form-check mb-4">
                <input type="checkbox" class="form-check-input" id="pinned" name="pinned" ${board.pinned ? 'checked' : ''}>
                <label class="form-check-label" for="pinned">📌 이 게시글을 고정합니다</label>
            </div>

            <div class="d-flex justify-content-between">
                <a href="${pageContext.request.contextPath}/admin/posts" class="btn btn-secondary">
                    목록으로 돌아가기
                </a>
                <button type="submit" class="btn btn-primary">
                    수정 완료
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
