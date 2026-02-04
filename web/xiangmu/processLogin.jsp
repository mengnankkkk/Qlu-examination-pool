<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /* 设置请求编码 */
    request.setCharacterEncoding("UTF-8");

    /* 获取表单数据 */
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String remember = request.getParameter("remember");

    /* 简单的用户验证（实际项目中应该查询数据库） */
    boolean isValid = false;
    String userRole = "user";

    if ("admin".equals(username) && "123456".equals(password)) {
        isValid = true;
        userRole = "admin";
    } else if ("user".equals(username) && "password".equals(password)) {
        isValid = true;
        userRole = "user";
    }

    if (isValid) {
        /* 登录成功，创建 Session */
        session.setAttribute("username", username);
        session.setAttribute("userRole", userRole);
        session.setAttribute("loginTime", new java.util.Date());

        /* 设置 Session 超时时间（30分钟） */
        session.setMaxInactiveInterval(30 * 60);

        /* 处理"记住我"功能 */
        if ("true".equals(remember)) {
            /* 创建 Cookie 保存用户名和密码，有效期 7 天 */
            // 保存用户名
            Cookie usernameCookie = new Cookie("autoLoginUsername", java.net.URLEncoder.encode(username, "UTF-8"));
            usernameCookie.setMaxAge(7 * 24 * 60 * 60);
            usernameCookie.setPath(request.getContextPath() + "/");
            response.addCookie(usernameCookie);

            // 保存密码（使用 Base64 编码，仅用于教学演示）
            String encodedPassword = java.util.Base64.getEncoder().encodeToString(password.getBytes("UTF-8"));
            Cookie passwordCookie = new Cookie("autoLoginPassword", java.net.URLEncoder.encode(encodedPassword, "UTF-8"));
            passwordCookie.setMaxAge(7 * 24 * 60 * 60);
            passwordCookie.setPath(request.getContextPath() + "/");
            response.addCookie(passwordCookie);
        } else {
            /* 如果没有勾选"记住我"，删除之前的 Cookie */
            Cookie usernameCookie = new Cookie("autoLoginUsername", "");
            usernameCookie.setMaxAge(0);
            usernameCookie.setPath(request.getContextPath() + "/");
            response.addCookie(usernameCookie);

            Cookie passwordCookie = new Cookie("autoLoginPassword", "");
            passwordCookie.setMaxAge(0);
            passwordCookie.setPath(request.getContextPath() + "/");
            response.addCookie(passwordCookie);
        }

        /* 重定向到 Dashboard */
        response.sendRedirect("dashboard.jsp");
    } else {
        /* 登录失败，返回登录页面并显示错误 */
        response.sendRedirect("login.jsp?error=1");
    }
%>
