package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 登录验证 Servlet
 * 实验 7-2: 模拟登录身份验证
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 获取表单参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        // 简单的用户验证（实际项目中应该查询数据库）
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
            // 登录成功，创建 Session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userRole", userRole);
            session.setAttribute("loginTime", new java.util.Date());
            session.setMaxInactiveInterval(30 * 60); // 30 分钟

            // 处理"记住我"功能
            if ("true".equals(remember)) {
                // 创建 Cookie 保存用户名，有效期 7 天
                jakarta.servlet.http.Cookie usernameCookie = new jakarta.servlet.http.Cookie(
                        "autoLoginUsername",
                        java.net.URLEncoder.encode(username, "UTF-8")
                );
                usernameCookie.setMaxAge(7 * 24 * 60 * 60);
                usernameCookie.setPath(request.getContextPath() + "/");
                response.addCookie(usernameCookie);
            }

            // 重定向到 Dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // 登录失败，返回登录页面并显示错误
            response.sendRedirect("login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET 请求重定向到登录页面
        response.sendRedirect("login.jsp");
    }

    @Override
    public String getServletInfo() {
        return "登录验证 Servlet - 实验 7-2";
    }
}
