<div class="offcanvas offcanvas-start" tabindex="-1" id="sideMenu" aria-labelledby="sideMenuLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="sideMenuLabel">메뉴</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/">홈</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/board/list">게시판</a></li>

            <c:choose>
                <c:when test="${not empty loginUser}">
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/profile">내 정보</a></li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/member/logout">
                            로그아웃 (${loginUser.name}님)
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
