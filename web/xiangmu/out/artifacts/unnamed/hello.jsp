<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Hello World 1000 Times</title>
        <link rel="stylesheet" href="css/style.css">
        <style>
            .line-item {
                padding: 5px 10px;
                border-bottom: 1px solid #eee;
                font-family: 'Courier New', monospace;
                font-size: 14px;
                color: #555;
                transition: background 0.2s;
            }

            .line-item:hover {
                background-color: #f8f9fa;
                color: #667eea;
            }

            .line-number {
                display: inline-block;
                width: 50px;
                color: #999;
                text-align: right;
                margin-right: 15px;
                user-select: none;
            }

            .scroll-container {
                height: 600px;
                overflow-y: auto;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                background: white;
                padding: 10px 0;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <jsp:include page="includes/header.jsp" />

            <div class="content">
                <div class="info-card">
                    <h3>👋 Hello World 演示</h3>
                    <p>这是一个简单的 JSP 脚本演示，使用循环输出 1000 行文本。</p>
                </div>

                <div class="scroll-container">
                    <% // 输出1000行 "hello world" for (int i=1; i <=1000; i++) { %>
                        <div class="line-item">
                            <span class="line-number">
                                <%= i %>
                            </span>
                            Hello World from JSP!
                        </div>
                        <% } %>
                </div>

                <div style="text-align: center; margin-top: 20px;">
                    <a href="index.jsp" class="btn btn-primary">返回首页</a>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
        </div>
    </body>

    </html>