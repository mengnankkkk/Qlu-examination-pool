<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%-- 项目1: 用户注册页面的开发 项目2: 使用 JavaScript 进行用户注册信息的客户端验证 项目3: 使用 CSS 美化用户注册页面 项目4: 演示 <jsp:include> 的使用
        --%>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>用户注册 - JSP 实验</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <div class="container">
                <%-- 使用 jsp:include 包含页面头部 --%>
                    <jsp:include page="includes/header.jsp" />

                    <div class="content">
                        <div class="form-container">
                            <h2>📝 用户注册</h2>

                            <%-- JSP 注释：这是一个完整的用户注册表单 --%>
                                <form id="registerForm" action="processRegister.jsp" method="post">

                                    <%-- 用户名 --%>
                                        <div class="form-group">
                                            <label for="username">
                                                用户名 <span class="required">*</span>
                                            </label>
                                            <input type="text" id="username" name="username"
                                                placeholder="请输入用户名（3-20个字符）">
                                            <div class="error-message"></div>
                                        </div>

                                        <%-- 密码 --%>
                                            <div class="form-group">
                                                <label for="password">
                                                    密码 <span class="required">*</span>
                                                </label>
                                                <input type="password" id="password" name="password"
                                                    placeholder="请输入密码（6-20个字符，包含字母和数字）">
                                                <div class="error-message"></div>
                                            </div>

                                            <%-- 确认密码 --%>
                                                <div class="form-group">
                                                    <label for="confirmPassword">
                                                        确认密码 <span class="required">*</span>
                                                    </label>
                                                    <input type="password" id="confirmPassword" name="confirmPassword"
                                                        placeholder="请再次输入密码">
                                                    <div class="error-message"></div>
                                                </div>

                                                <%-- 邮箱 --%>
                                                    <div class="form-group">
                                                        <label for="email">
                                                            邮箱 <span class="required">*</span>
                                                        </label>
                                                        <input type="email" id="email" name="email"
                                                            placeholder="请输入邮箱地址">
                                                        <div class="error-message"></div>
                                                    </div>

                                                    <%-- 性别（单选框） --%>
                                                        <div class="form-group">
                                                            <label>
                                                                性别 <span class="required">*</span>
                                                            </label>
                                                            <div class="radio-group">
                                                                <label>
                                                                    <input type="radio" name="gender" value="male"> 男
                                                                </label>
                                                                <label>
                                                                    <input type="radio" name="gender" value="female"> 女
                                                                </label>
                                                                <label>
                                                                    <input type="radio" name="gender" value="other"> 其他
                                                                </label>
                                                            </div>
                                                            <div class="error-message"></div>
                                                        </div>

                                                        <%-- 兴趣爱好（复选框） --%>
                                                            <div class="form-group">
                                                                <label>兴趣爱好</label>
                                                                <div class="checkbox-group">
                                                                    <label>
                                                                        <input type="checkbox" name="hobbies"
                                                                            value="reading"> 阅读
                                                                    </label>
                                                                    <label>
                                                                        <input type="checkbox" name="hobbies"
                                                                            value="sports"> 运动
                                                                    </label>
                                                                    <label>
                                                                        <input type="checkbox" name="hobbies"
                                                                            value="music"> 音乐
                                                                    </label>
                                                                    <label>
                                                                        <input type="checkbox" name="hobbies"
                                                                            value="travel"> 旅游
                                                                    </label>
                                                                    <label>
                                                                        <input type="checkbox" name="hobbies"
                                                                            value="coding"> 编程
                                                                    </label>
                                                                </div>
                                                            </div>

                                                            <%-- 地区（下拉框） --%>
                                                                <div class="form-group">
                                                                    <label for="region">
                                                                        地区 <span class="required">*</span>
                                                                    </label>
                                                                    <select id="region" name="region">
                                                                        <option value="">请选择地区</option>
                                                                        <option value="beijing">北京</option>
                                                                        <option value="shanghai">上海</option>
                                                                        <option value="guangzhou">广州</option>
                                                                        <option value="shenzhen">深圳</option>
                                                                        <option value="hangzhou">杭州</option>
                                                                        <option value="chengdu">成都</option>
                                                                        <option value="other">其他</option>
                                                                    </select>
                                                                    <div class="error-message"></div>
                                                                </div>

                                                                <%-- 个人简介 --%>
                                                                    <div class="form-group">
                                                                        <label for="bio">个人简介</label>
                                                                        <textarea id="bio" name="bio" rows="4"
                                                                            placeholder="简单介绍一下自己..."
                                                                            style="width: 100%; padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 8px; font-family: inherit; resize: vertical;"></textarea>
                                                                    </div>

                                                                    <%-- 提交按钮 --%>
                                                                        <div class="form-actions">
                                                                            <button type="submit"
                                                                                class="btn btn-primary">立即注册</button>
                                                                            <button type="reset"
                                                                                class="btn btn-secondary">重置表单</button>
                                                                        </div>

                                </form>

                                <%-- 使用 JSP 表达式显示提示信息 --%>
                                    <div style="margin-top: 30px; text-align: center; color: #666; font-size: 14px;">
                                        <p>💡 提示：带 <span style="color: #e74c3c;">*</span> 的为必填项</p>
                                        <p>当前服务器时间: <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new
                                                java.util.Date()) %>
                                        </p>
                                    </div>
                        </div>
                    </div>

                    <%-- 使用 jsp:include 包含页面底部 --%>
                        <jsp:include page="includes/footer.jsp" />
            </div>

            <%-- 引入 JavaScript 验证脚本 --%>
                <script src="js/validation.js"></script>
        </body>

        </html>