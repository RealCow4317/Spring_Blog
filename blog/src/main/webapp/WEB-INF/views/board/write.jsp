<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>게시글 작성</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">게시글 작성</h2>
    <div class="card p-4">
        <form action="${pageContext.request.contextPath}/board/write" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>

            <div class="mb-3">
                <label for="writer" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer" name="writer" value="${loginUser.id}" readonly>
            </div>

            <div class="mb-3">
                <label for="categoryId" class="form-label">카테고리</label>
                <select class="form-select" id="categoryId" name="categoryId" required>
                    <option value="">카테고리 선택</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="8"></textarea>
            </div>

            <c:if test="${isAdmin}">
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="pinned" name="pinned" value="true">
                    <label class="form-check-label" for="pinned">상단 고정</label>
                </div>
            </c:if>

            <div class="d-flex justify-content-between">
                <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary">목록</a>
                <button type="submit" class="btn btn-success">등록</button>
            </div>
        </form>
    </div>
</div>

<!-- Summernote -->
<script>
    $(document).ready(function () {
        $('#content').summernote({
            height: 300,
            lang: 'ko-KR',
            placeholder: '내용을 입력하세요...',
            callbacks: {
                onImageUpload: function (files) {
                    for (let i = 0; i < files.length; i++) {
                        sendFile(files[i]);
                    }
                }
            }
        });

        function sendFile(file) {
            const data = new FormData();
            data.append("file", file);

            $.ajax({
                url: '${pageContext.request.contextPath}/upload/image',
                method: 'POST',
                data: data,
                contentType: false,
                processData: false,
                success: function (url) {
                    $('#content').summernote('insertImage', url);
                },
                error: function (xhr, status, error) {
                    console.error("업로드 실패:", xhr.responseText);
                    alert("이미지 업로드 실패: " + error);
                }
            });
        }
    });
</script>


</body>
</html>
