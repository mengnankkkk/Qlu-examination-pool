package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 登录验证过滤器
 * 实验 7-4: 登录验证过滤器
 *
 * 作用：拦截需要登录才能访问的页面，未登录用户重定向到登录页面
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/dashboard.jsp"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter 初始化");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 获取 Session
        HttpSession session = httpRequest.getSession(false);

        // 检查用户是否已登录
        boolean isLoggedIn = (session != null && session.getAttribute("username") != null);

        if (isLoggedIn) {
            // 已登录，继续访问
            chain.doFilter(request, response);
        } else {
            // 未登录，重定向到登录页面
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/login.jsp?message=" +
                    java.net.URLEncoder.encode("请先登录", "UTF-8"));
        }
    }

    @Override
    public void destroy() {
        System.out.println("AuthFilter 销毁");
    }
}
