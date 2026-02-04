<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%-- 页面底部组件 - 演示 jsp:include 的使用 --%>
        <% /* 获取当前年份 */ java.util.Calendar calendar=java.util.Calendar.getInstance(); int
            currentYear=calendar.get(java.util.Calendar.YEAR); %>
            <footer>
                <p>&copy; <%= currentYear %> JSP 基本语法实验项目 | 期末 Web 开发作业</p>
                <p style="margin-top: 5px; font-size: 12px;">
                    演示内容：JSP 基础语法 | JavaScript 验证 | CSS 美化 | JSP 动作标签
                </p>
                <p style="margin-top: 5px; font-size: 11px; color: #999;">
                    页面生成时间: <%= new java.util.Date() %>
                </p>
            </footer>