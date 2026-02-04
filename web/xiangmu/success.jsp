<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 获取传递的消息参数 */ String msg=(String) request.getAttribute("msg"); if (msg==null) {
        msg=request.getParameter("msg"); } if (msg==null) { msg="您的操作已顺利完成。" ; } /* 获取来源参数 */ String from=(String)
        request.getAttribute("from"); if (from==null) { from=request.getParameter("from"); } %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>操作成功</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <div class="container">
                <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <div style="text-align: center; padding: 50px 0;">
                        <div style="font-size: 64px; margin-bottom: 20px;">🎉</div>
                        <h2 style="color: #27ae60; margin-bottom: 20px;">操作成功！</h2>

                        <p style="font-size: 18px; color: #666; margin-bottom: 30px;">
                            <%= msg %>
                        </p>

                        <% if (from !=null) { %>
                            <p style="color: #999; font-size: 14px; margin-bottom: 20px;">
                                来自: <%= from %> 的跳转
                            </p>
                            <% } %>

                                <a href="index.jsp" class="btn btn-primary">返回首页</a>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
            </div>
        </body>

        </html>