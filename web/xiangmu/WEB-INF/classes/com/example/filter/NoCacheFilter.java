package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * 不缓存页面的过滤器
 * 实验 7-3: 不缓存页面的过滤器
 *
 * 作用：防止浏览器缓存敏感页面（如登录后的页面）
 */
@WebFilter(filterName = "NoCacheFilter", urlPatterns = {"/dashboard.jsp", "/books.jsp", "/cart.jsp"})
public class NoCacheFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("NoCacheFilter 初始化");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 设置 HTTP 响应头，禁止浏览器缓存
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0
        httpResponse.setDateHeader("Expires", 0); // Proxies

        // 继续过滤器链
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("NoCacheFilter 销毁");
    }
}
