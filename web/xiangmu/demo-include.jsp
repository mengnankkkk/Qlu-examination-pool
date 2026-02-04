<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>JSP Include 动作演示</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="container">
            <%-- 静态包含：编译时包含 --%>
                <%@ include file="includes/header.jsp" %>

                    <div class="content">
                        <h2>📦 jsp:include 动作演示</h2>
                        <p style="margin-bottom: 20px;">
                            <code>&lt;jsp:include&gt;</code> 动作元素用于在运行时包含静态或动态资源。
                            与 <code>&lt;%@ include %&gt;</code> 指令不同，它是在请求处理阶段执行的。
                        </p>

                        <div class="demo-section">
                            <h3>1. 包含静态资源</h3>
                            <p>下面是一个被包含的静态 HTML 片段：</p>
                            <div style="border: 2px dashed #667eea; padding: 15px; margin: 10px 0; background: #fff;">
                                <jsp:include page="includes/static-fragment.html" flush="true" />
                            </div>
                        </div>

                        <div class="demo-section">
                            <h3>2. 包含动态资源并传递参数</h3>
                            <p>下面包含了一个动态 JSP 页面，并传递了参数：</p>
                            <div style="border: 2px dashed #764ba2; padding: 15px; margin: 10px 0; background: #fff;">
                                <jsp:include page="includes/dynamic-component.jsp">
                                    <jsp:param name="componentName" value="用户卡片组件" />
                                    <jsp:param name="theme" value="dark" />
                                </jsp:include>
                            </div>
                        </div>

                        <div class="info-card">
                            <h3>📝 知识点：include 指令 vs include 动作</h3>
                            <ul>
                                <li><strong>include 指令 (&lt;%@ include ... %&gt;)</strong>: 编译时包含，将内容合并到一个 Servlet
                                    中。适合包含头部、底部等静态结构。</li>
                                <li><strong>include 动作 (&lt;jsp:include ... /&gt;)</strong>:
                                    运行时包含，请求处理时调用另一个资源。适合包含动态内容或需要传递参数的情况。</li>
                            </ul>
                        </div>
                    </div>

                    <jsp:include page="includes/footer.jsp" />
        </div>
    </body>

    </html>