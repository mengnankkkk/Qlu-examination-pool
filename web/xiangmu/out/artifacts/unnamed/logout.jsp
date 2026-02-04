<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 获取用户名（用于显示消息） */ String username=(String) session.getAttribute("username"); /* 销毁 Session */
        session.invalidate(); /* 清除所有自动登录相关的 Cookie */ Cookie[] cookies=request.getCookies(); if (cookies !=null) { for
        (Cookie cookie : cookies) { // 清除自动登录用户名 if ("autoLoginUsername".equals(cookie.getName())) {
        cookie.setMaxAge(0); cookie.setPath(request.getContextPath() + "/" ); response.addCookie(cookie); } // 清除自动登录密码
        else if ("autoLoginPassword".equals(cookie.getName())) { cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath() + "/" ); response.addCookie(cookie); } // 清除旧的记住用户名 Cookie（兼容旧版本） else
        if ("rememberedUsername".equals(cookie.getName())) { cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath() + "/" ); response.addCookie(cookie); } } } /* 重定向到登录页面并显示消息 */ String
        message=username !=null ? "您已成功登出，期待您的再次访问！" : "登出成功" ;
        response.sendRedirect("login.jsp?message=" + java.net.URLEncoder.encode(message, " UTF-8")); %>