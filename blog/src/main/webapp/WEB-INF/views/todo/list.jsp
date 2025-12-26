<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light">
<head>
    <title>TODO 리스트</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
    <style>
        .todo-item { display: flex; align-items: center; gap: 1rem; padding: 0.75rem; border-bottom: 1px solid #eee; }
        .todo-item.completed .todo-content { text-decoration: line-through; color: #aaa; }
        .todo-content { flex-grow: 1; }
        .todo-due-date { font-size: 0.9em; color: #666; }
        .todo-actions { visibility: hidden; }
        .todo-item:hover .todo-actions { visibility: visible; }
        .sub-task-list { padding-left: 2.5rem; border-left: 2px solid #f0f0f0; margin-left: 0.7rem; }
        .sub-task-form { padding: 1rem 0 0 2.5rem; margin-left: 0.7rem; border-left: 2px solid #f0f0f0; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">✅ 나의 할 일 목록</h2>

    <!-- Add Root Todo Form -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/todo/add" class="d-flex gap-2">
                <input type="text" name="content" class="form-control" placeholder="새로운 할 일을 입력하세요..." required>
                <input type="date" name="dueDate" class="form-control" style="width: 150px;" required id="todoDueDate">
                <button class="btn btn-primary" type="submit">추가</button>
            </form>
        </div>
    </div>

    <!-- Todo List -->
    <div class="card">
        <div class="list-group list-group-flush">
            <c:choose>
                <c:when test="${empty todos}">
                    <div class="list-group-item text-center text-muted p-4">
                        할 일이 없습니다. 새 할 일을 추가해보세요!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="todo" items="${todos}">
                        <%-- Render Parent Task --%>
                        <div class="list-group-item todo-item ${todo.completed ? 'completed' : ''}" data-id="${todo.id}">
                            <input class="form-check-input" type="checkbox" ${todo.completed ? 'checked' : ''} onchange="updateTodoStatus(this)">
                            <div class="todo-content fw-bold">${todo.content}</div>
                            <c:if test="${not empty todo.dueDate}">
                                <div class="todo-due-date">
                                    <fmt:formatDate value="${todo.dueDate}" pattern="yyyy-MM-dd"/>
                                </div>
                            </c:if>
                            <div class="todo-actions">
                                <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#subTaskForm-${todo.id}">+</button>
                                <a href="${pageContext.request.contextPath}/todo/delete/${todo.id}" class="btn btn-sm btn-outline-danger">삭제</a>
                            </div>
                        </div>
                        
                        <%-- Sub-task Add Form --%>
                        <div class="collapse" id="subTaskForm-${todo.id}">
                             <div class="sub-task-form pb-3">
                                <form method="post" action="${pageContext.request.contextPath}/todo/add" class="d-flex gap-2">
                                    <input type="hidden" name="parentId" value="${todo.id}">
                                    <input type="text" name="content" class="form-control form-control-sm" placeholder="세부 할 일 추가..." required>
                                    <input type="date" name="dueDate" class="form-control form-control-sm" style="width: 130px;" required>
                                    <button class="btn btn-sm btn-success" type="submit">추가</button>
                                </form>
                            </div>
                        </div>

                        <%-- Render Sub-tasks --%>
                        <c:if test="${not empty todo.subTasks}">
                            <div class="sub-task-list">
                                <c:forEach var="subTask" items="${todo.subTasks}">
                                    <div class="list-group-item todo-item ${subTask.completed ? 'completed' : ''}" data-id="${subTask.id}">
                                        <input class="form-check-input" type="checkbox" ${subTask.completed ? 'checked' : ''} onchange="updateTodoStatus(this)">
                                        <div class="todo-content">${subTask.content}</div>
                                        <c:if test="${not empty subTask.dueDate}">
                                            <div class="todo-due-date">
                                                <fmt:formatDate value="${subTask.dueDate}" pattern="yyyy-MM-dd"/>
                                            </div>
                                        </c:if>
                                        <div class="todo-actions">
                                             <a href="${pageContext.request.contextPath}/todo/delete/${subTask.id}" class="btn btn-sm btn-outline-danger">삭제</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const todayString = `${yyyy}-${mm}-${dd}`;

        document.getElementById('todoDueDate').setAttribute('min', todayString);
        
        // Also set min date for all sub-task date inputs
        document.querySelectorAll('input[type="date"][name="dueDate"]').forEach(function(el) {
            el.setAttribute('min', todayString);
        });
    });

    function updateTodoStatus(checkbox) {
        const todoItem = checkbox.closest('.todo-item');
        const todoId = todoItem.dataset.id;
        const isCompleted = checkbox.checked;

        fetch('${pageContext.request.contextPath}/todo/update', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: todoId, completed: isCompleted })
        })
        .then(response => response.text())
        .then(data => {
            if (data === 'success') {
                todoItem.classList.toggle('completed', isCompleted);
            } else {
                alert('상태 업데이트에 실패했습니다.');
                checkbox.checked = !isCompleted;
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('오류가 발생했습니다.');
            checkbox.checked = !isCompleted;
        });
    }
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
