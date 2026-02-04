<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% /* 设置请求编码，防止中文乱码 */ request.setCharacterEncoding("UTF-8"); /* 获取表单数据 */ String
        username=request.getParameter("username"); String email=request.getParameter("email"); String
        gender=request.getParameter("gender"); String[] hobbies=request.getParameterValues("hobbies"); String
        region=request.getParameter("region"); String bio=request.getParameter("bio"); /* 简单的性别显示转换 */ String
        genderStr="未知" ; if ("male".equals(gender)) { genderStr="男" ; } else if ("female".equals(gender)) {
        genderStr="女" ; } else if ("other".equals(gender)) { genderStr="其他" ; } /* 爱好处理 */ StringBuilder hobbiesStr=new
        StringBuilder(); if (hobbies !=null) { for (String hobby : hobbies) { if ("reading".equals(hobby))
        hobbiesStr.append("阅读 ");
            else if (" sports".equals(hobby)) hobbiesStr.append("运动 ");
            else if (" music".equals(hobby)) hobbiesStr.append("音乐 ");
            else if (" travel".equals(hobby)) hobbiesStr.append("旅游 ");
            else if (" coding".equals(hobby)) hobbiesStr.append("编程 ");
        }
    } else {
        hobbiesStr.append(" 无"); } %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>注册信息确认</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <div class="container">
                <jsp:include page="includes/header.jsp" />

                <div class="content">
                    <div class="form-container">
                        <div class="success-message">
                            <h2>✅ 注册信息提交成功</h2>
                            <p>感谢您的注册！以下是您提交的信息：</p>
                        </div>

                        <div class="info-card">
                            <h3>👤 个人信息</h3>
                            <p><strong>用户名：</strong>
                                <%= username %>
                            </p>
                            <p><strong>邮箱：</strong>
                                <%= email %>
                            </p>
                            <p><strong>性别：</strong>
                                <%= genderStr %>
                            </p>
                            <p><strong>地区：</strong>
                                <%= region %>
                            </p>
                            <p><strong>爱好：</strong>
                                <%= hobbiesStr.toString() %>
                            </p>
                            <p><strong>个人简介：</strong></p>
                            <div
                                style="background: #fff; padding: 10px; border-radius: 4px; border: 1px solid #eee; margin-top: 5px;">
                                <%= bio !=null && !bio.isEmpty() ? bio : "未填写" %>
                            </div>
                        </div>

                        <div class="form-actions">
                            <a href="index.jsp" class="btn btn-primary">返回首页</a>
                            <a href="register.jsp" class="btn btn-secondary">重新注册</a>
                        </div>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
            </div>
        </body>

        </html>