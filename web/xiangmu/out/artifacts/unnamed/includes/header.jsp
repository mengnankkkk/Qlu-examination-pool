<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.model.CartItem" %>
<%-- 页面头部组件 - 演示 jsp:include 的使用 --%>
<%
    /* 检查登录状态 */
    String loggedInUser = (String) session.getAttribute("username");

    /* 计算购物车商品数量 */
    @SuppressWarnings("unchecked")
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
    int cartCount = 0;
    if (cart != null) {
        for (CartItem item : cart.values()) {
            cartCount += item.getQuantity();
        }
    }
%>
<header>
    <h1>🎓 JSP 基本语法实验项目</h1>
    <p style="margin: 5px 0; opacity: 0.9;">掌握 JSP 基础语法、指令与动作标签</p>
    <% if (loggedInUser != null) { %>
    <p style="margin: 5px 0; font-size: 14px;">
        👤 欢迎，<strong><%= loggedInUser %></strong> |
        <a href="logout.jsp" style="color: white; text-decoration: underline;">登出</a>
    </p>
    <% } %>
    <nav>
        <a href="index.jsp">🏠 首页</a>
        <% if (loggedInUser != null) { %>
        <a href="dashboard.jsp">📊 控制台</a>
        <% } else { %>
        <a href="login.jsp">🔐 登录</a>
        <% } %>
        <a href="register.jsp">📝 注册</a>
        <a href="products.jsp">🛍️ 商品</a>
        <a href="cart.jsp" style="position: relative;">
            🛒 购物车
            <% if (cartCount > 0) { %>
            <span
                style="position: absolute; top: -5px; right: -5px; background: #f56565; color: white; border-radius: 50%; width: 18px; height: 18px; font-size: 11px; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                <%= cartCount %>
            </span>
            <% } %>
        </a>
        <a href="books.jsp">📚 图书</a>
        <a href="demo-include.jsp">📦 Include</a>
        <a href="demo-forward.jsp">➡️ Forward</a>
        <a href="demo-session.jsp">🔄 Session</a>
        <a href="demo-cookie.jsp">🍪 Cookie</a>
        <a href="demo-form.jsp">📋 表单</a>
    </nav>
</header>
