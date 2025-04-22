<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시글 보기</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-4">
    <h2 class="mb-4">게시글 상세 보기</h2>

    <!-- 게시글 카드 -->
    <div class="card p-4 mb-4">
        <h4 class="mb-3">${board.title}</h4>
        <p><strong>카테고리:</strong> ${board.categoryName}</p>
        <p><strong>작성자:</strong> ${board.writer}</p>
        <p><strong>작성일:</strong> <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" /></p>
        <hr>

        <!-- Summernote 내용 HTML 렌더링 -->
        <c:out value="${board.content}" escapeXml="false" />

        <div class="mt-4">
            <c:if test="${not empty loginUser and loginUser.id eq board.writer}">
                <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning btn-sm">수정</a>
                <a href="${pageContext.request.contextPath}/board/delete/${board.id}" class="btn btn-danger btn-sm">삭제</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary btn-sm">목록</a>
        </div>
    </div>

    <!-- 댓글 리스트 -->
    <div class="card p-4 mb-4">
        <h5>💬 댓글</h5>
        <c:choose>
            <c:when test="${not empty comments}">
                <c:forEach var="comment" items="${comments}">
                    <div class="border-bottom py-2">
                        <p class="mb-1">
                            <strong>${comment.writer}</strong>
                            <span class="text-muted"> • <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                        </p>
                        <p class="mb-1">${comment.content}</p>
                        <c:if test="${not empty loginUser and loginUser.id eq comment.writer}">
                            <form action="${pageContext.request.contextPath}/comment/delete/${comment.id}/${board.id}" method="get" style="display:inline;">
                                <button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>
                            </form>
                            <a href="${pageContext.request.contextPath}/comment/edit/${comment.id}" class="btn btn-sm btn-outline-primary">수정</a>
                        </c:if>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="text-muted">아직 댓글이 없습니다.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 댓글 작성 -->
    <c:if test="${not empty loginUser}">
        <form action="${pageContext.request.contextPath}/comment/add" method="post" class="card p-4 shadow-sm">
            <input type="hidden" name="boardId" value="${board.id}" />
            <div class="mb-3">
                <label for="content" class="form-label">댓글 작성</label>
                <textarea name="content" class="form-control" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">댓글 등록</button>
        </form>
    </c:if>

    <c:if test="${empty loginUser}">
        <div class="alert alert-light text-muted mt-3">
            댓글을 작성하려면 <a href="${pageContext.request.contextPath}/member/login">로그인</a>이 필요합니다.
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
