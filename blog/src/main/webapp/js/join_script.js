document.addEventListener('DOMContentLoaded', () => {
    let idChecked = false;
    let emailChecked = false;
    let passwordMatched = false;

    const idInput = document.getElementById("id");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const confirmInput = document.getElementById("confirmPassword");
    const checkIdBtn = document.getElementById("checkIdBtn");
    const checkEmailBtn = document.getElementById("checkEmailBtn");
    const passwordMessage = document.getElementById("passwordMatchMessage");
    const submitBtn = document.getElementById("submitBtn");

    // 이메일 형식 유효성 검사
    function isValidEmailFormat(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    // 회원가입 버튼 활성화 조건 검사
    function toggleSubmitButton() {
        submitBtn.disabled = !(idChecked && emailChecked && passwordMatched);
    }

    // 아이디 입력 시 버튼 활성화
    idInput.addEventListener("input", () => {
        idChecked = false;
        checkIdBtn.disabled = idInput.value.trim() === "";
        toggleSubmitButton();
    });

    // 이메일 입력 시 버튼 활성화
    emailInput.addEventListener("input", () => {
        emailChecked = false;
        const email = emailInput.value.trim();
        checkEmailBtn.disabled = !isValidEmailFormat(email);
        toggleSubmitButton();
    });

    // 비밀번호 확인
    function checkPasswordMatch() {
        const pw = passwordInput.value;
        const confirm = confirmInput.value;

        if (!confirm) {
            passwordMessage.textContent = "";
            passwordMessage.className = "form-text";
            passwordMatched = false;
        } else if (pw === confirm) {
            passwordMessage.textContent = "비밀번호가 일치합니다";
            passwordMessage.className = "form-text text-primary";
            passwordMatched = true;
        } else {
            passwordMessage.textContent = "비밀번호가 일치하지 않습니다";
            passwordMessage.className = "form-text text-danger";
            passwordMatched = false;
        }

        toggleSubmitButton();
    }

    passwordInput.addEventListener("input", checkPasswordMatch);
    confirmInput.addEventListener("input", checkPasswordMatch);

    // 중복확인 fetch 요청
    window.checkDuplicate = function(field) {
        const value = document.getElementById(field).value.trim();
        if (!value) {
            alert(field === "id" ? "아이디를 입력하세요." : "이메일을 입력하세요.");
            return;
        }

        if (field === "email" && !isValidEmailFormat(value)) {
            alert("올바른 이메일 형식이 아닙니다.");
            emailChecked = false;
            toggleSubmitButton();
            return;
        }

        const url = field === "id"
            ? contextPath + "/member/check-id?id=" + encodeURIComponent(value)
            : contextPath + "/member/check-email?email=" + encodeURIComponent(value);

        fetch(url)
            .then(res => res.text())
            .then(data => {
                const available = data === "true";
                const label = field === "id" ? "아이디" : "이메일";

                if (available) {
                    alert("사용 가능한 " + label + "입니다.");
                    if (field === "id") idChecked = true;
                    if (field === "email") emailChecked = true;
                } else {
                    alert("이미 존재하는 " + label + "입니다.");
                    if (field === "id") idChecked = false;
                    if (field === "email") emailChecked = false;
                }

                toggleSubmitButton();
            });
    };
});
