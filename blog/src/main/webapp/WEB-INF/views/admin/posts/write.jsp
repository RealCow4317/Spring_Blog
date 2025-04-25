<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>게시글 작성</title>
  <%@ include file="/WEB-INF/views/admin/common/adminHead.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/common/adminNav.jsp" %>

<div class="container mt-5">
  <h2 class="mb-4">📝 게시글 작성</h2>

  <form action="${pageContext.request.contextPath}/admin/posts/write" method="post" class="card p-4 shadow-sm">
    <div class="mb-3">
      <label for="title" class="form-label">제목</label>
      <input type="text" class="form-control" id="title" name="title" required>
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
      <textarea class="form-control" id="content" name="content" rows="8" required></textarea>
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" id="pinned" name="pinned">
      <label class="form-check-label" for="pinned">📌 상단 고정</label>
    </div>

    <button type="submit" class="btn btn-primary w-100">등록</button>
  </form>
</div>
</body>
</html>
