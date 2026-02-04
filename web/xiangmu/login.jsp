<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /* 检查是否已经登录 */
    String loggedInUser = (String) session.getAttribute("username");
    if (loggedInUser != null) {
        /* 已登录，重定向到 Dashboard */
        response.sendRedirect("dashboard.jsp");
        return;
    }

    /* 获取错误信息（如果有） */
    String error = request.getParameter("error");
    String message = request.getParameter("message");

    /* 检查 Cookie 中的自动登录信息 */
    String savedUsername = "";
    String savedPassword = "";
    boolean hasAutoLogin = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("autoLoginUsername".equals(cookie.getName())) {
                savedUsername = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
            } else if ("autoLoginPassword".equals(cookie.getName())) {
                savedPassword = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
            }
        }
    }

    // 如果同时存在用户名和密码，则启用自动登录
    if (!savedUsername.isEmpty() && !savedPassword.isEmpty()) {
        hasAutoLogin = true;
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - JSP 实验</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
</head>

<body style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="login-container">
        <div class="login-box">
            <div class="logo">🔐</div>
            <h2>用户登录</h2>

            <% if (hasAutoLogin) { %>
            <div class="success-alert">
                🔄 检测到自动登录信息，正在登录...
            </div>
            <% } %>

            <% if ("1".equals(error)) { %>
            <div class="error-alert">
                ❌ 用户名或密码错误，请重试！
            </div>
            <% } %>

            <% if (message != null && !message.isEmpty()) { %>
            <div class="success-alert">
                ✅ <%= message %>
            </div>
            <% } %>

            <form id="loginForm" action="processLogin.jsp" method="post">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" value="<%= savedUsername %>" placeholder="请输入用户名"
                        autocomplete="username">
                </div>

                <div class="form-group password-toggle">
                    <label for="password">密码</label>
                    <input type="password" id="password" name="password" placeholder="请输入密码"
                        autocomplete="current-password">
                    <button type="button" class="toggle-btn" onclick="togglePassword()">👁️</button>
                </div>

                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember" value="true"
                        <%= hasAutoLogin ? "checked" : "" %>>
                    <label for="remember">记住我（7天内自动登录）</label>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" style="width: 100%;">登录</button>
                </div>
            </form>

            <div class="login-footer">
                <p>还没有账号？ <a href="register.jsp">立即注册</a></p>
                <p style="margin-top: 10px;"><a href="index.jsp">返回首页</a></p>
            </div>

            <div class="info-card" style="margin-top: 20px; font-size: 12px;">
                <p><strong>测试账号：</strong></p>
                <p>用户名: admin / 密码: 123456</p>
                <p>用户名: user / 密码: password</p>
                <% if (hasAutoLogin) { %>
                <p style="margin-top: 10px; color: #667eea;">
                    💡 提示：已检测到自动登录 Cookie，表单将自动提交
                </p>
                <% } %>
            </div>
        </div>
    </div>

    <script src="js/login.js"></script>
    <script>
        // 自动登录功能
        <% if (hasAutoLogin) { %>
        // 解码密码并填充
        document.getElementById('password').value = atob('<%= java.util.Base64.getEncoder().encodeToString(savedPassword.getBytes("UTF-8")) %>');

        // 延迟 1.5 秒后自动提交表单
        setTimeout(function () {
            document.getElementById('loginForm').submit();
        }, 1500);
        <% } %>
    </script>
</body>

</html>
