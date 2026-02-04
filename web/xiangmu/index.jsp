<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>JSP 基本语法实验项目</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="container">
            <jsp:include page="includes/header.jsp" />

            <div class="content">
                <div style="text-align: center; margin-bottom: 40px;">
                    <h2 style="font-size: 36px; color: #667eea; margin-bottom: 10px;">JSP Web 开发实验</h2>
                    <p style="font-size: 18px; color: #666;">掌握 JSP 基础语法、常用指令与动作标签</p>
                </div>

                <div class="card-grid">
                    <a href="register.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">📝</div>
                            <h3>实验 2-1: 用户注册</h3>
                            <p>包含 JSP 基础语法、表单处理以及 CSS 页面美化。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入实验</span>
                        </div>
                    </a>

                    <a href="register.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">🛡️</div>
                            <h3>实验 2-2: 客户端验证</h3>
                            <p>使用 JavaScript 进行用户注册信息的实时验证和提交检查。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">查看效果</span>
                        </div>
                    </a>

                    <a href="demo-include.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">📦</div>
                            <h3>实验 2-4: Include 动作</h3>
                            <p>演示 &lt;jsp:include&gt; 的使用，动态包含页面组件。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入演示</span>
                        </div>
                    </a>

                    <a href="demo-forward.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">➡️</div>
                            <h3>实验 2-5: Forward 动作</h3>
                            <p>演示 &lt;jsp:forward&gt; 的使用，实现页面请求转发。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入演示</span>
                        </div>
                    </a>

                    <a href="login.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">🔐</div>
                            <h3>实验 3-1: 用户登录</h3>
                            <p>模拟用户登录功能，Session 管理和 Cookie 自动登录。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入登录</span>
                        </div>
                    </a>

                    <a href="demo-session.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">🔄</div>
                            <h3>实验 3-2: Session 演示</h3>
                            <p>Session 生命周期和属性管理的完整演示。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">查看演示</span>
                        </div>
                    </a>

                    <a href="demo-form.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">📋</div>
                            <h3>实验 3-3: 表单交互</h3>
                            <p>GET vs POST 方法对比，request 对象方法展示。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入演示</span>
                        </div>
                    </a>

                    <a href="products.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">🛍️</div>
                            <h3>实验 4-1: 购物车系统</h3>
                            <p>使用 Session 实现购物车功能，包含商品管理和订单汇总。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入商城</span>
                        </div>
                    </a>

                    <a href="demo-cookie.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">🍪</div>
                            <h3>实验 4-2: Cookie 演示</h3>
                            <p>Cookie 生命周期管理，Session vs Cookie 对比分析。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">查看演示</span>
                        </div>
                    </a>

                    <a href="books.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">📚</div>
                            <h3>实验 5-6: 图书管理系统</h3>
                            <p>使用 JDBC 连接 SQLite 数据库，JavaBean 实现完整的图书管理功能。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入系统</span>
                        </div>
                    </a>

                    <a href="servlet-demo.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">⚙️</div>
                            <h3>实验 7: Servlet 技术</h3>
                            <p>简单 Servlet、登录验证、不缓存过滤器、登录验证过滤器。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">查看演示</span>
                        </div>
                    </a>

                    <a href="calculator-model1.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">🧮</div>
                            <h3>实验 8: Model1 & Model2</h3>
                            <p>MVC 模式对比：Model1 (JSP+JavaBean) vs Model2 (MVC) 四则运算器。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">进入计算器</span>
                        </div>
                    </a>

                    <a href="hello.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card">
                            <div class="icon">👋</div>
                            <h3>Hello World</h3>
                            <p>简单的 JSP 循环演示，输出 1000 行文本。</p>
                            <span class="btn btn-primary" style="padding: 8px 20px; font-size: 14px;">查看示例</span>
                        </div>
                    </a>
                </div>

                <div class="info-card" style="margin-top: 40px;">
                    <h3>📚 实验说明</h3>
                    <p><strong>实验 2</strong>: JSP 基本语法 - 包含用户注册、JavaScript 验证、CSS 美化、Include 和 Forward 动作演示。</p>
                    <p><strong>实验 3</strong>: JSP 表单开发 - 包含用户登录、Session 管理、表单交互和 request 对象使用。</p>
                    <p><strong>实验 4</strong>: Session 和 Cookie - 包含购物车系统、Cookie 管理和自动登录功能。</p>
                    <p><strong>实验 5-6</strong>: JDBC 与 JavaBean - 使用 SQLite 数据库实现图书管理系统，包含增删改查功能。</p>
                    <p><strong>实验 7</strong>: Servlet 技术 - Servlet 开发、登录验证、过滤器应用。</p>
                    <p><strong>实验 8</strong>: MVC 模式 - Model1 和 Model2 架构对比，图书管理系统 MVC 改造。</p>
                    <p>所有页面均采用了统一的 CSS 样式和组件化设计。</p>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
        </div>
    </body>

    </html>