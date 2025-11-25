<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="comment" items="${commentList}">
    <div class="comment-item" style="margin-left: ${depth * 40}px;">
        <div class="d-flex justify-content-between">
            <div>
                <strong>${comment.writer}</strong>
                <small class="text-muted"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /></small>
            </div>
            <div>
                <c:if test="${not empty loginUser and loginUser.id eq comment.writer}">
                    <a href="${pageContext.request.contextPath}/comment/edit/${comment.id}" class="btn btn-sm btn-outline-secondary">수정</a>
                    <a href="${pageContext.request.contextPath}/comment/delete/${comment.id}/${board.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </c:if>
                <c:if test="${not empty loginUser}">
                    <button class="btn btn-sm btn-outline-primary reply-btn" data-comment-id="${comment.id}">답글</button>
                </c:if>
            </div>
        </div>
        <p>${comment.content}</p>

        <!-- 답글 작성 폼 (숨겨져 있음) -->
        <c:if test="${not empty loginUser}">
            <div id="reply-form-${comment.id}" style="display: none;" class="mt-2 mb-3">
                <form action="${pageContext.request.contextPath}/comment/add" method="post">
                    <input type="hidden" name="boardId" value="${board.id}" />
                    <input type="hidden" name="parentId" value="${comment.id}" />
                    <div class="input-group">
                        <textarea name="content" class="form-control" rows="2" required></textarea>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </form>
            </div>
        </c:if>

        <!-- 대댓글 재귀 호출 -->
        <c:if test="${not empty comment.replies}">
            <c:set var="commentList" value="${comment.replies}" scope="request" />
            <c:set var="depth" value="${depth + 1}" scope="request" />
            <jsp:include page="comment_tree.jsp" />
        </c:if>
    </div>
    <hr>
</c:forEach>
