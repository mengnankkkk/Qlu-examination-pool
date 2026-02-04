<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 检查用户是否已登录 */ String username=(String) session.getAttribute("username"); if (username==null) { /* 未登录，重定向到登录页面
        */ response.sendRedirect("login.jsp"); return; } /* 获取用户信息 */ String userRole=(String)
        session.getAttribute("userRole"); java.util.Date loginTime=(java.util.Date) session.getAttribute("loginTime");
        /* 获取 Session 信息 */ String sessionId=session.getId(); int maxInactiveInterval=session.getMaxInactiveInterval();
        long creationTime=session.getCreationTime(); long lastAccessedTime=session.getLastAccessedTime(); /* 计算在线时长 */
        long onlineMinutes=(System.currentTimeMillis() - creationTime) / (1000 * 60); %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>用户中心 - JSP 实验</title>
            <link rel="stylesheet" href="css/style.css">
            <link rel="stylesheet" href="css/login.css">
        </head>

        <body>
            <div class="container">
                <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <div class="dashboard-header">
                        <h1>👋 欢迎回来，<%= username %>！</h1>
                        <p>您已成功登录系统</p>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="icon">👤</div>
                            <div class="label">用户名</div>
                            <div class="value">
                                <%= username %>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="icon">🎭</div>
                            <div class="label">角色</div>
                            <div class="value">
                                <%= userRole %>
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="icon">⏱️</div>
                            <div class="label">在线时长</div>
                            <div class="value">
                                <%= onlineMinutes %> 分钟
                            </div>
                        </div>

                        <div class="stat-card">
                            <div class="icon">🔒</div>
                            <div class="label">Session 状态</div>
                            <div class="value">活跃</div>
                        </div>
                    </div>

                    <div class="info-card">
                        <h3>📊 Session 信息</h3>
                        <dl class="session-info">
                            <dt>Session ID:</dt>
                            <dd>
                                <%= sessionId %>
                            </dd>

                            <dt>登录时间:</dt>
                            <dd>
                                <%= loginTime %>
                            </dd>

                            <dt>Session 创建时间:</dt>
                            <dd>
                                <%= new java.util.Date(creationTime) %>
                            </dd>

                            <dt>最后访问时间:</dt>
                            <dd>
                                <%= new java.util.Date(lastAccessedTime) %>
                            </dd>

                            <dt>Session 超时时间:</dt>
                            <dd>
                                <%= maxInactiveInterval / 60 %> 分钟
                            </dd>
                        </dl>
                    </div>

                    <div class="card-grid" style="margin-top: 30px;">
                        <a href="demo-session.jsp" style="text-decoration: none; color: inherit;">
                            <div class="card">
                                <div class="icon">🔄</div>
                                <h3>Session 演示</h3>
                                <p>查看 Session 的增删改查操作</p>
                            </div>
                        </a>

                        <a href="demo-form.jsp" style="text-decoration: none; color: inherit;">
                            <div class="card">
                                <div class="icon">📝</div>
                                <h3>表单演示</h3>
                                <p>查看各种表单交互示例</p>
                            </div>
                        </a>

                        <a href="register.jsp" style="text-decoration: none; color: inherit;">
                            <div class="card">
                                <div class="icon">✍️</div>
                                <h3>用户注册</h3>
                                <p>体验完整的注册流程</p>
                            </div>
                        </a>

                        <a href="logout.jsp" style="text-decoration: none; color: inherit;">
                            <div class="card">
                                <div class="icon">🚪</div>
                                <h3>安全登出</h3>
                                <p>退出当前登录状态</p>
                            </div>
                        </a>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
            </div>
        </body>

        </html>