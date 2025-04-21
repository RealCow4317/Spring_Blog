<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 상세 보기</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.8/dist/web/static/pretendard.css">
  <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
</head>
<body>

<%@ include file="/WEB-INF/views/common/adminNav.jsp" %>

<div class="container mt-5">
  <h2 class="mb-4">📄 게시글 상세 보기</h2>

  <!-- 게시글 정보 -->
  <div class="card p-4 mb-4">
    <h4 class="mb-3">${board.pinned ? "📌 " : ""}${board.title}</h4>
    <p><strong>카테고리:</strong> ${board.categoryName}</p>
    <p><strong>작성자:</strong> ${board.writer}</p>
    <p><strong>작성일:</strong> <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" /></p>
    <hr>
    <p>${board.content}</p>
  </div>

  <!-- 댓글 목록 -->
  <div class="card p-4">
    <h5>💬 댓글 목록 (${comments.size()})</h5>
    <c:choose>
      <c:when test="${not empty comments}">
        <c:forEach var="comment" items="${comments}">
          <div class="border-bottom py-2">
            <p class="mb-1">
              <strong>${comment.writer}</strong>
              <span class="text-muted"> • <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
            </p>
            <p class="mb-1">${comment.content}</p>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="text-muted">댓글이 없습니다.</div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- 버튼 영역 -->
  <div class="mt-4 d-flex gap-2">
    <a href="${pageContext.request.contextPath}/admin/posts/edit/${board.id}" class="btn btn-warning">✏️ 수정</a>
    <a href="${pageContext.request.contextPath}/admin/posts/delete/${board.id}"
       class="btn btn-danger"
       onclick="return confirm('정말 삭제하시겠습니까?');">🗑️ 삭제</a>
    <a href="${pageContext.request.contextPath}/admin/posts" class="btn btn-secondary">📄 목록</a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
