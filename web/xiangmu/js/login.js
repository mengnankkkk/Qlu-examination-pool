/* 登录表单验证脚本 */

/* 密码显示/隐藏切换 */
function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleBtn = document.querySelector('.toggle-btn');

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleBtn.textContent = '🙈';
    } else {
        passwordInput.type = 'password';
        toggleBtn.textContent = '👁️';
    }
}

/* 登录表单验证 */
function validateLoginForm(form) {
    const username = form.username.value.trim();
    const password = form.password.value;

    /* 清除之前的错误提示 */
    const existingError = form.querySelector('.error-alert');
    if (existingError) {
        existingError.remove();
    }

    /* 验证用户名 */
    if (!username) {
        showError(form, '请输入用户名');
        return false;
    }

    if (username.length < 3) {
        showError(form, '用户名至少需要 3 个字符');
        return false;
    }

    /* 验证密码 */
    if (!password) {
        showError(form, '请输入密码');
        return false;
    }

    if (password.length < 6) {
        showError(form, '密码至少需要 6 个字符');
        return false;
    }

    return true;
}

/* 显示错误信息 */
function showError(form, message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-alert';
    errorDiv.textContent = '❌ ' + message;

    const firstElement = form.firstElementChild;
    form.insertBefore(errorDiv, firstElement);

    /* 3秒后自动消失 */
    setTimeout(() => {
        errorDiv.remove();
    }, 3000);
}

/* 从 Cookie 读取记住的用户名 */
function loadRememberedUsername() {
    const cookies = document.cookie.split(';');
    for (let cookie of cookies) {
        const [name, value] = cookie.trim().split('=');
        if (name === 'rememberedUsername') {
            const usernameInput = document.getElementById('username');
            const rememberCheckbox = document.getElementById('remember');
            if (usernameInput && value) {
                usernameInput.value = decodeURIComponent(value);
                if (rememberCheckbox) {
                    rememberCheckbox.checked = true;
                }
            }
            break;
        }
    }
}

/* 页面加载时初始化 */
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () {
        loadRememberedUsername();

        /* 为登录表单添加提交事件 */
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', function (e) {
                if (!validateLoginForm(this)) {
                    e.preventDefault();
                    return false;
                }
            });
        }
    });
} else {
    loadRememberedUsername();
}
