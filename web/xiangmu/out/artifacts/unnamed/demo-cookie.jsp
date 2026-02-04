<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 处理 Cookie 操作 */ String action=request.getParameter("action"); if ("add".equals(action)) { String
        name=request.getParameter("name"); String value=request.getParameter("value"); String
        maxAgeStr=request.getParameter("maxAge"); if (name !=null && !name.isEmpty() && value !=null) { try { int
        maxAge=(maxAgeStr !=null && !maxAgeStr.isEmpty()) ? Integer.parseInt(maxAgeStr) : -1; Cookie cookie=new
        Cookie(name, java.net.URLEncoder.encode(value, "UTF-8" )); cookie.setMaxAge(maxAge);
        cookie.setPath(request.getContextPath() + "/" ); response.addCookie(cookie); } catch (NumberFormatException e) {
        // 忽略错误 } } } else if ("remove".equals(action)) { String name=request.getParameter("name"); if (name !=null &&
        !name.isEmpty()) { Cookie cookie=new Cookie(name, "" ); cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath() + "/" ); response.addCookie(cookie); } } else if
        ("clear".equals(action)) { Cookie[] cookies=request.getCookies(); if (cookies !=null) { for (Cookie cookie :
        cookies) { // 只删除自定义 Cookie，保留 JSESSIONID if (!"JSESSIONID".equals(cookie.getName())) { Cookie deleteCookie=new
        Cookie(cookie.getName(), "" ); deleteCookie.setMaxAge(0); deleteCookie.setPath(request.getContextPath() + "/" );
        response.addCookie(deleteCookie); } } } } /* 获取所有 Cookie */ Cookie[] cookies=request.getCookies(); %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Cookie 演示 - JSP 实验</title>
            <link rel="stylesheet" href="css/style.css">
            <link rel="stylesheet" href="css/login.css">
        </head>

        <body>
            <div class="container">
                <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <h2>🍪 Cookie 生命周期演示</h2>

                    <div class="info-card">
                        <h3>📝 Cookie 基本信息</h3>
                        <p><strong>什么是 Cookie？</strong></p>
                        <p>Cookie 是服务器发送到用户浏览器并保存在本地的一小块数据，它会在浏览器下次向同一服务器再发起请求时被携带并发送到服务器上。</p>
                    </div>

                    <div class="demo-section">
                        <h3>➕ 添加 Cookie</h3>
                        <form action="demo-cookie.jsp" method="post" style="max-width: 600px;">
                            <input type="hidden" name="action" value="add">
                            <div class="form-group">
                                <label>Cookie 名称</label>
                                <input type="text" name="name" placeholder="例如: userPreference" required>
                            </div>
                            <div class="form-group">
                                <label>Cookie 值</label>
                                <input type="text" name="value" placeholder="例如: darkMode" required>
                            </div>
                            <div class="form-group">
                                <label>有效期（秒）</label>
                                <input type="number" name="maxAge" placeholder="-1 表示会话级，0 表示删除，正数表示秒数" value="3600">
                                <small style="color: #666; display: block; margin-top: 5px;">
                                    -1: 会话级（关闭浏览器失效）<br>
                                    0: 立即删除<br>
                                    正数: 有效期（秒），例如 3600 = 1小时
                                </small>
                            </div>
                            <button type="submit" class="btn btn-primary">添加 Cookie</button>
                        </form>
                    </div>

                    <div class="demo-section">
                        <h3>📋 当前 Cookie 列表</h3>
                        <% if (cookies==null || cookies.length==0) { %>
                            <p style="color: #999;">暂无 Cookie</p>
                            <% } else { %>
                                <table style="width: 100%; border-collapse: collapse;">
                                    <thead>
                                        <tr style="background: #f8f9fa; border-bottom: 2px solid #e0e0e0;">
                                            <th style="padding: 12px; text-align: left;">名称</th>
                                            <th style="padding: 12px; text-align: left;">值</th>
                                            <th style="padding: 12px; text-align: left;">路径</th>
                                            <th style="padding: 12px; text-align: left;">最大生存时间</th>
                                            <th style="padding: 12px; text-align: center;">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Cookie cookie : cookies) { %>
                                            <tr style="border-bottom: 1px solid #e0e0e0;">
                                                <td style="padding: 12px; font-family: monospace; color: #667eea;">
                                                    <%= cookie.getName() %>
                                                </td>
                                                <td
                                                    style="padding: 12px; max-width: 300px; overflow: hidden; text-overflow: ellipsis;">
                                                    <%= java.net.URLDecoder.decode(cookie.getValue(), "UTF-8" ) %>
                                                </td>
                                                <td style="padding: 12px; font-size: 12px; color: #999;">
                                                    <%= cookie.getPath() !=null ? cookie.getPath() : "/" %>
                                                </td>
                                                <td style="padding: 12px; font-size: 12px; color: #999;">
                                                    <%= cookie.getMaxAge()==-1 ? "会话级" : (cookie.getMaxAge()==0 ? "已删除"
                                                        : cookie.getMaxAge() + " 秒" ) %>
                                                </td>
                                                <td style="padding: 12px; text-align: center;">
                                                    <% if (!"JSESSIONID".equals(cookie.getName())) { %>
                                                        <a href="demo-cookie.jsp?action=remove&name=<%= cookie.getName() %>"
                                                            class="btn btn-secondary"
                                                            style="padding: 5px 15px; font-size: 12px;">删除</a>
                                                        <% } else { %>
                                                            <span style="color: #999; font-size: 12px;">系统 Cookie</span>
                                                            <% } %>
                                                </td>
                                            </tr>
                                            <% } %>
                                    </tbody>
                                </table>
                                <% } %>

                                    <div style="margin-top: 20px;">
                                        <a href="demo-cookie.jsp?action=clear" class="btn btn-secondary"
                                            onclick="return confirm('确定要清除所有自定义 Cookie 吗？')">
                                            清除所有自定义 Cookie
                                        </a>
                                    </div>
                    </div>

                    <div class="info-card">
                        <h3>💡 Cookie 知识点</h3>
                        <ul>
                            <li><strong>Cookie 作用</strong>: 在客户端保存少量数据，用于会话跟踪、用户偏好设置等</li>
                            <li><strong>Cookie 存储</strong>: 数据存储在客户端浏览器中</li>
                            <li><strong>Cookie 大小限制</strong>: 单个 Cookie 不超过 4KB</li>
                            <li><strong>Cookie 数量限制</strong>: 每个域名下最多 20-50 个 Cookie（浏览器不同）</li>
                            <li><strong>Cookie 生命周期</strong>:
                                <ul>
                                    <li><code>maxAge = -1</code>: 会话级 Cookie，关闭浏览器后失效</li>
                                    <li><code>maxAge = 0</code>: 立即删除 Cookie</li>
                                    <li><code>maxAge > 0</code>: 持久化 Cookie，指定秒数后失效</li>
                                </ul>
                            </li>
                            <li><strong>常用方法</strong>:
                                <ul>
                                    <li><code>new Cookie(name, value)</code> - 创建 Cookie</li>
                                    <li><code>cookie.setMaxAge(seconds)</code> - 设置有效期</li>
                                    <li><code>cookie.setPath(path)</code> - 设置路径</li>
                                    <li><code>response.addCookie(cookie)</code> - 发送 Cookie 到客户端</li>
                                    <li><code>request.getCookies()</code> - 获取所有 Cookie</li>
                                </ul>
                            </li>
                        </ul>
                    </div>

                    <div class="info-card">
                        <h3>🔄 Session vs Cookie 对比</h3>
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background: #f8f9fa;">
                                    <th style="padding: 12px; text-align: left; border: 1px solid #e0e0e0;">特性</th>
                                    <th style="padding: 12px; text-align: left; border: 1px solid #e0e0e0;">Session</th>
                                    <th style="padding: 12px; text-align: left; border: 1px solid #e0e0e0;">Cookie</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>存储位置</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">服务器端</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">客户端（浏览器）</td>
                                </tr>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>安全性</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">高（数据不暴露给客户端）</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">低（可被客户端查看和修改）</td>
                                </tr>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>存储容量</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">无限制（受服务器内存限制）</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">单个 Cookie 最大 4KB</td>
                                </tr>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>数据类型</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">任意 Java 对象</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">只能存储字符串</td>
                                </tr>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>生命周期</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">默认 30 分钟不活动后失效</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">可设置任意有效期</td>
                                </tr>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>服务器负担</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">占用服务器内存</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">不占用服务器资源</td>
                                </tr>
                                <tr>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;"><strong>典型应用</strong></td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">用户登录状态、购物车</td>
                                    <td style="padding: 12px; border: 1px solid #e0e0e0;">记住用户名、用户偏好设置</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
            </div>
        </body>

        </html>