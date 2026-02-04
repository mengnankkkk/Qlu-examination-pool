<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 处理 Session 操作 */ String action=request.getParameter("action"); if ("add".equals(action)) { String
        key=request.getParameter("key"); String value=request.getParameter("value"); if (key !=null && !key.isEmpty() &&
        value !=null) { session.setAttribute(key, value); } } else if ("remove".equals(action)) { String
        key=request.getParameter("key"); if (key !=null && !key.isEmpty()) { session.removeAttribute(key); } } else if
        ("clear".equals(action)) { /* 清除所有自定义属性，保留系统属性 */ java.util.Enumeration<String> attrs =
        session.getAttributeNames();
        java.util.List<String> toRemove = new java.util.ArrayList<>();
                while (attrs.hasMoreElements()) {
                String attr = attrs.nextElement();
                if (!attr.startsWith("javax.") && !attr.startsWith("org.apache.")) {
                toRemove.add(attr);
                }
                }
                for (String attr : toRemove) {
                session.removeAttribute(attr);
                }
                }

                /* 获取所有 Session 属性 */
                java.util.Map<String, Object> sessionAttrs = new java.util.LinkedHashMap<>();
                        java.util.Enumeration<String> attrNames = session.getAttributeNames();
                            while (attrNames.hasMoreElements()) {
                            String name = attrNames.nextElement();
                            sessionAttrs.put(name, session.getAttribute(name));
                            }
                            %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>Session 演示 - JSP 实验</title>
                                <link rel="stylesheet" href="css/style.css">
                                <link rel="stylesheet" href="css/login.css">
                            </head>

                            <body>
                                <div class="container">
                                    <jsp:include page="includes/header.jsp" />

                                    <div class="content">
                                        <h2>🔄 Session 生命周期演示</h2>

                                        <div class="info-card">
                                            <h3>📝 Session 基本信息</h3>
                                            <dl class="session-info">
                                                <dt>Session ID:</dt>
                                                <dd>
                                                    <%= session.getId() %>
                                                </dd>

                                                <dt>创建时间:</dt>
                                                <dd>
                                                    <%= new java.util.Date(session.getCreationTime()) %>
                                                </dd>

                                                <dt>最后访问时间:</dt>
                                                <dd>
                                                    <%= new java.util.Date(session.getLastAccessedTime()) %>
                                                </dd>

                                                <dt>最大不活动时间:</dt>
                                                <dd>
                                                    <%= session.getMaxInactiveInterval() / 60 %> 分钟
                                                </dd>

                                                <dt>是否新建:</dt>
                                                <dd>
                                                    <%= session.isNew() ? "是" : "否" %>
                                                </dd>
                                            </dl>
                                        </div>

                                        <div class="demo-section">
                                            <h3>➕ 添加 Session 属性</h3>
                                            <form action="demo-session.jsp" method="post" style="max-width: 500px;">
                                                <input type="hidden" name="action" value="add">
                                                <div class="form-group">
                                                    <label>属性名</label>
                                                    <input type="text" name="key" placeholder="例如: favoriteColor"
                                                        required>
                                                </div>
                                                <div class="form-group">
                                                    <label>属性值</label>
                                                    <input type="text" name="value" placeholder="例如: 蓝色" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary">添加属性</button>
                                            </form>
                                        </div>

                                        <div class="demo-section">
                                            <h3>📋 当前 Session 属性列表</h3>
                                            <% if (sessionAttrs.isEmpty()) { %>
                                                <p style="color: #999;">暂无 Session 属性</p>
                                                <% } else { %>
                                                    <table style="width: 100%; border-collapse: collapse;">
                                                        <thead>
                                                            <tr
                                                                style="background: #f8f9fa; border-bottom: 2px solid #e0e0e0;">
                                                                <th style="padding: 12px; text-align: left;">属性名</th>
                                                                <th style="padding: 12px; text-align: left;">属性值</th>
                                                                <th style="padding: 12px; text-align: left;">类型</th>
                                                                <th style="padding: 12px; text-align: center;">操作</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (java.util.Map.Entry<String, Object> entry :
                                                                sessionAttrs.entrySet()) { %>
                                                                <tr style="border-bottom: 1px solid #e0e0e0;">
                                                                    <td
                                                                        style="padding: 12px; font-family: monospace; color: #667eea;">
                                                                        <%= entry.getKey() %>
                                                                    </td>
                                                                    <td style="padding: 12px;">
                                                                        <%= entry.getValue() %>
                                                                    </td>
                                                                    <td
                                                                        style="padding: 12px; font-size: 12px; color: #999;">
                                                                        <%= entry.getValue().getClass().getSimpleName()
                                                                            %>
                                                                    </td>
                                                                    <td style="padding: 12px; text-align: center;">
                                                                        <a href="demo-session.jsp?action=remove&key=<%= entry.getKey() %>"
                                                                            class="btn btn-secondary"
                                                                            style="padding: 5px 15px; font-size: 12px;">删除</a>
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                        </tbody>
                                                    </table>
                                                    <% } %>

                                                        <div style="margin-top: 20px;">
                                                            <a href="demo-session.jsp?action=clear"
                                                                class="btn btn-secondary">清除所有自定义属性</a>
                                                        </div>
                                        </div>

                                        <div class="info-card">
                                            <h3>💡 Session 知识点</h3>
                                            <ul>
                                                <li><strong>Session 作用</strong>: 在多个请求之间保持用户状态信息</li>
                                                <li><strong>Session 存储</strong>: 数据存储在服务器端，客户端只保存 Session ID</li>
                                                <li><strong>Session 生命周期</strong>: 从创建到超时或手动销毁</li>
                                                <li><strong>常用方法</strong>:
                                                    <ul>
                                                        <li><code>setAttribute(name, value)</code> - 设置属性</li>
                                                        <li><code>getAttribute(name)</code> - 获取属性</li>
                                                        <li><code>removeAttribute(name)</code> - 删除属性</li>
                                                        <li><code>invalidate()</code> - 销毁 Session</li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <jsp:include page="includes/footer.jsp" />
                                </div>
                            </body>

                            </html>