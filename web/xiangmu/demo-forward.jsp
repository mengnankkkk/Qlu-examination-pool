<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 检查是否有转发请求 */ String action=request.getParameter("action"); if ("forwardToSuccess".equals(action)) { /* 使用
        pageContext.forward 代替 <jsp:forward> 标签以避免在 scriptlet 中嵌套标签导致的编译错误 */
        /* 手动设置参数需要通过 request.setAttribute */
        request.setAttribute("msg", "这是通过 pageContext.forward 转发过来的消息！");
        request.setAttribute("from", "demo-forward.jsp");
        pageContext.forward("success.jsp");
        return; /* 转发后结束执行 */
        } else if ("forwardToRegister".equals(action)) {
        pageContext.forward("register.jsp");
        return; /* 转发后结束执行 */
        }
        %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>JSP Forward 动作演示</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <div class="container">
                <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <h2>➡️ jsp:forward 动作演示</h2>
                    <p style="margin-bottom: 20px;">
                        <code>&lt;jsp:forward&gt;</code> 动作元素用于将请求转发到另一个资源（JSP、Servlet 或静态页面）。
                        转发是在服务器端进行的，浏览器的 URL 不会改变。
                    </p>

                    <div class="card-grid">
                        <div class="card">
                            <div class="icon">✨</div>
                            <h3>转发到成功页面</h3>
                            <p>点击下方按钮，服务器将请求转发到 success.jsp，并传递参数。</p>
                            <a href="demo-forward.jsp?action=forwardToSuccess" class="btn btn-primary">测试转发</a>
                        </div>

                        <div class="card">
                            <div class="icon">📝</div>
                            <h3>转发到注册页面</h3>
                            <p>点击下方按钮，服务器将请求转发到 register.jsp。</p>
                            <a href="demo-forward.jsp?action=forwardToRegister" class="btn btn-secondary">去注册</a>
                        </div>
                    </div>

                    <div class="info-card" style="margin-top: 30px;">
                        <h3>📝 知识点：Forward vs Redirect</h3>
                        <ul>
                            <li><strong>Forward (转发)</strong>: 服务器内部跳转，客户端不知道，URL 不变，共享 Request 对象，速度快。</li>
                            <li><strong>Redirect (重定向)</strong>: 客户端重新发送请求，URL 改变，不共享 Request 对象，速度较慢。</li>
                        </ul>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
            </div>
        </body>

        </html>