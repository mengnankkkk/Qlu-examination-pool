<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servlet 技术演示 - JSP 实验</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <style>
        .demo-container {
            max-width: 900px;
            margin: 50px auto;
        }

        .demo-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .demo-header h2 {
            color: #667eea;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .demo-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 25px;
            margin: 30px 0;
        }

        .demo-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .demo-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.2);
        }

        .demo-card h3 {
            color: #667eea;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .demo-card p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .demo-link {
            display: inline-block;
            padding: 10px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .demo-link:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>

<body>
    <div class="container">
        <jsp:include page="includes/header.jsp" />

        <div class="content">
            <div class="demo-container">
                <div class="demo-header">
                    <h2>⚙️ Servlet 技术演示</h2>
                    <p style="color: #666; font-size: 18px;">实验 7：Servlet 开发与过滤器应用</p>
                </div>

                <div class="demo-grid">
                    <!-- Servlet 演示 -->
                    <div class="demo-card">
                        <h3>📝 简单 Servlet</h3>
                        <p>演示 Servlet 的基本用法，包括 doGet/doPost 方法、请求参数获取、响应输出等。</p>
                        <p><strong>知识点</strong>：</p>
                        <ul style="color: #666; line-height: 1.8;">
                            <li>Servlet 生命周期</li>
                            <li>@WebServlet 注解</li>
                            <li>HttpServletRequest/Response</li>
                        </ul>
                        <a href="HelloServlet" class="demo-link">查看演示 →</a>
                    </div>

                    <!-- 登录 Servlet -->
                    <div class="demo-card">
                        <h3>🔐 登录验证 Servlet</h3>
                        <p>使用 Servlet 处理用户登录请求，演示表单处理、Session 管理和重定向。</p>
                        <p><strong>知识点</strong>：</p>
                        <ul style="color: #666; line-height: 1.8;">
                            <li>表单数据处理</li>
                            <li>Session 管理</li>
                            <li>请求重定向</li>
                        </ul>
                        <a href="login.jsp" class="demo-link">查看演示 →</a>
                    </div>

                    <!-- 过滤器演示 -->
                    <div class="demo-card">
                        <h3>🔍 不缓存过滤器</h3>
                        <p>演示 Filter 的使用，设置 HTTP 响应头禁止浏览器缓存敏感页面。</p>
                        <p><strong>知识点</strong>：</p>
                        <ul style="color: #666; line-height: 1.8;">
                            <li>Filter 接口实现</li>
                            <li>@WebFilter 注解</li>
                            <li>HTTP 缓存控制</li>
                        </ul>
                        <a href="dashboard.jsp" class="demo-link">查看演示 →</a>
                    </div>

                    <!-- 登录验证过滤器 -->
                    <div class="demo-card">
                        <h3>🛡️ 登录验证过滤器</h3>
                        <p>演示使用 Filter 拦截未登录用户访问受保护页面，实现统一的权限控制。</p>
                        <p><strong>知识点</strong>：</p>
                        <ul style="color: #666; line-height: 1.8;">
                            <li>Filter 链处理</li>
                            <li>Session 验证</li>
                            <li>请求拦截与转发</li>
                        </ul>
                        <a href="dashboard.jsp" class="demo-link">查看演示 →</a>
                    </div>
                </div>

                <div class="info-card" style="margin-top: 40px;">
                    <h3>💡 Servlet 与 Filter 知识点总结</h3>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                        <div>
                            <h4 style="color: #667eea;">Servlet</h4>
                            <ul style="line-height: 1.8;">
                                <li><strong>定义</strong>：运行在服务器端的 Java 程序</li>
                                <li><strong>作用</strong>：处理客户端请求，生成动态响应</li>
                                <li><strong>生命周期</strong>：init() → service() → destroy()</li>
                                <li><strong>配置方式</strong>：@WebServlet 注解或 web.xml</li>
                                <li><strong>线程安全</strong>：Servlet 是单例，需注意并发</li>
                            </ul>
                        </div>
                        <div>
                            <h4 style="color: #667eea;">Filter</h4>
                            <ul style="line-height: 1.8;">
                                <li><strong>定义</strong>：请求/响应的预处理和后处理器</li>
                                <li><strong>作用</strong>：权限验证、日志记录、编码转换等</li>
                                <li><strong>生命周期</strong>：init() → doFilter() → destroy()</li>
                                <li><strong>配置方式</strong>：@WebFilter 注解或 web.xml</li>
                                <li><strong>过滤器链</strong>：多个 Filter 按顺序执行</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div style="text-align: center; margin-top: 30px;">
                    <a href="index.jsp" class="btn btn-secondary" style="padding: 12px 40px;">返回首页</a>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
