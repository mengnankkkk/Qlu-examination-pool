<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String name=request.getParameter("componentName"); String theme=request.getParameter("theme"); String
        bgColor="light" .equals(theme) ? "#f8f9fa" : "#2d3748" ; String textColor="light" .equals(theme) ? "#333"
        : "#fff" ; %>
        <div style="background-color: <%= bgColor %>; color: <%= textColor %>; padding: 15px; border-radius: 8px;">
            <h4>我是动态组件: <%= name %>
            </h4>
            <p>接收到的参数 theme: <strong>
                    <%= theme %>
                </strong></p>
            <p>生成时间: <%= new java.util.Date() %>
            </p>
        </div>