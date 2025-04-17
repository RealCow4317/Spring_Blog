<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
    <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
    <link rel="icon"
          href="${pageContext.request.contextPath}/resources/favicon.ico"
          type="image/x-icon">
</head>
<body>
<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">✍️ 게시글 수정</h2>
    <div class="card p-4 shadow-sm">
        <form action="${pageContext.request.contextPath}/admin/posts/edit" method="post">
            <!-- 반드시 hidden 으로 id 전달 -->
            <input type="hidden" name="id" value="${board.id}" />

            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text"
                       id="title"
                       name="title"
                       class="form-control"
                       value="${board.title}"
                       required>
            </div>

            <div class="mb-3">
                <label for="writer" class="form-label">작성자</label>
                <!-- 관리자는 변경 불필요하므로 readonly -->
                <input type="text"
                       id="writer"
                       name="writer"
                       class="form-control"
                       value="${board.writer}"
                       readonly>
            </div>

            <div class="mb-3">
                <label for="categoryId" class="form-label">카테고리</label>
                <select id="categoryId"
                        name="categoryId"
                        class="form-select"
                        required>
                    <option value="">카테고리 선택</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.id}"
                            ${cat.id == board.categoryId ? 'selected' : ''}>
                                ${cat.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea id="content"
                          name="content"
                          class="form-control"
                          rows="8"
                          required>${board.content}</textarea>
            </div>

            <div class="d-flex justify-content-between">
                <a href="${pageContext.request.contextPath}/admin/posts"
                   class="btn btn-secondary">
                    목록으로 돌아가기
                </a>
                <button type="submit" class="btn btn-primary">
                    수정 완료
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
