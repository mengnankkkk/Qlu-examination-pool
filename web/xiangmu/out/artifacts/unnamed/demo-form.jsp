<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 处理表单提交 */ String method=request.getMethod(); String submittedData=null; if ("POST".equals(method)) { String
        name=request.getParameter("name"); String email=request.getParameter("email"); String[]
        hobbies=request.getParameterValues("hobbies"); StringBuilder sb=new StringBuilder();
        sb.append("姓名: ").append(name).append(" , ");
        sb.append(" 邮箱: ").append(email).append(" , ");
        sb.append(" 爱好: ");
        if (hobbies != null) {
            sb.append(String.join(" , ", hobbies));
        } else {
            sb.append(" 无"); } submittedData=sb.toString(); } %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>表单交互演示 - JSP 实验</title>
            <link rel="stylesheet" href="css/style.css">
            <link rel="stylesheet" href="css/login.css">
        </head>

        <body>
            <div class="container">
                <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <h2>📝 JSP 表单交互演示</h2>

                    <% if (submittedData !=null) { %>
                        <div class="success-message">
                            <h3>✅ 表单提交成功</h3>
                            <p>
                                <%= submittedData %>
                            </p>
                        </div>
                        <% } %>

                            <div class="method-comparison">
                                <div class="method-box">
                                    <h4>GET 方法</h4>
                                    <p>数据附加在 URL 后面，适合查询操作</p>
                                    <form action="demo-form.jsp" method="get">
                                        <div class="form-group">
                                            <label>搜索关键词</label>
                                            <input type="text" name="keyword" placeholder="输入关键词">
                                        </div>
                                        <button type="submit" class="btn btn-primary">GET 提交</button>
                                    </form>
                                    <div class="code-example">
                                        &lt;form action="demo-form.jsp" method="get"&gt;
                                        &lt;input type="text" name="keyword"&gt;
                                        &lt;/form&gt;
                                    </div>
                                </div>

                                <div class="method-box">
                                    <h4>POST 方法</h4>
                                    <p>数据在请求体中，适合提交敏感数据</p>
                                    <form action="demo-form.jsp" method="post">
                                        <div class="form-group">
                                            <label>姓名</label>
                                            <input type="text" name="name" placeholder="输入姓名">
                                        </div>
                                        <div class="form-group">
                                            <label>邮箱</label>
                                            <input type="email" name="email" placeholder="输入邮箱">
                                        </div>
                                        <div class="form-group">
                                            <label>爱好</label>
                                            <div class="checkbox-group">
                                                <label><input type="checkbox" name="hobbies" value="阅读"> 阅读</label>
                                                <label><input type="checkbox" name="hobbies" value="运动"> 运动</label>
                                                <label><input type="checkbox" name="hobbies" value="音乐"> 音乐</label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">POST 提交</button>
                                    </form>
                                    <div class="code-example">
                                        &lt;form action="demo-form.jsp" method="post"&gt;
                                        &lt;input type="text" name="name"&gt;
                                        &lt;input type="email" name="email"&gt;
                                        &lt;/form&gt;
                                    </div>
                                </div>
                            </div>

                            <div class="demo-section">
                                <h3>🔍 Request 对象常用方法</h3>
                                <table style="width: 100%; border-collapse: collapse;">
                                    <thead>
                                        <tr style="background: #f8f9fa; border-bottom: 2px solid #e0e0e0;">
                                            <th style="padding: 12px; text-align: left;">方法</th>
                                            <th style="padding: 12px; text-align: left;">返回值</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getMethod()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getMethod() %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getRequestURI()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getRequestURI() %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getQueryString()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getQueryString() !=null ? request.getQueryString() : "null"
                                                    %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getRemoteAddr()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getRemoteAddr() %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getServerName()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getServerName() %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getServerPort()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getServerPort() %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getContextPath()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getContextPath() %>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #e0e0e0;">
                                            <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                getProtocol()</td>
                                            <td style="padding: 12px;">
                                                <%= request.getProtocol() %>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="info-card">
                                <h3>💡 表单处理知识点</h3>
                                <ul>
                                    <li><strong>GET vs POST</strong>:
                                        <ul>
                                            <li>GET: 数据在 URL 中可见，有长度限制，适合查询</li>
                                            <li>POST: 数据在请求体中，无长度限制，适合提交</li>
                                        </ul>
                                    </li>
                                    <li><strong>获取参数</strong>:
                                        <ul>
                                            <li><code>request.getParameter("name")</code> - 获取单个值</li>
                                            <li><code>request.getParameterValues("name")</code> - 获取多个值（如复选框）</li>
                                            <li><code>request.getParameterMap()</code> - 获取所有参数</li>
                                        </ul>
                                    </li>
                                    <li><strong>中文乱码处理</strong>:
                                        <ul>
                                            <li>POST: <code>request.setCharacterEncoding("UTF-8")</code></li>
                                            <li>GET: 需要在服务器配置中设置 URIEncoding="UTF-8"</li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
            </div>
        </body>

        </html>