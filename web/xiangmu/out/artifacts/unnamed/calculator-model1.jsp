<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="calculator" class="com.example.model.Calculator" scope="page"/>
<%
    // Model1 模式：JSP + JavaBean
    // JSP 负责接收请求、调用 JavaBean、显示��果

    String num1Str = request.getParameter("num1");
    String num2Str = request.getParameter("num2");
    String operator = request.getParameter("operator");
    boolean hasCalculated = false;

    if (num1Str != null && num2Str != null && operator != null) {
        try {
            double num1 = Double.parseDouble(num1Str);
            double num2 = Double.parseDouble(num2Str);

            calculator.setNum1(num1);
            calculator.setNum2(num2);
            calculator.setOperator(operator);

            hasCalculated = calculator.calculate();
        } catch (NumberFormatException e) {
            calculator.setError("请输入有效的数字");
        }
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Model1 计算器 - JSP 实验</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <style>
        .calc-container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .calc-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .calc-header h2 {
            color: #667eea;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .calc-form {
            margin: 30px 0;
        }

        .calc-row {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-bottom: 20px;
        }

        .calc-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            text-align: center;
        }

        .calc-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .calc-operator {
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            background: white;
            cursor: pointer;
        }

        .calc-operator:focus {
            outline: none;
            border-color: #667eea;
        }

        .calc-result {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 8px;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            margin: 20px 0;
        }

        .calc-error {
            background: #f56565;
            color: white;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>

<body>
    <div class="container">
        <jsp:include page="includes/header.jsp" />

        <div class="content">
            <div class="calc-container">
                <div class="calc-header">
                    <h2>🧮 四则运算器</h2>
                    <p style="color: #666;">Model1 模式：JSP + JavaBean</p>
                </div>

                <form action="calculator-model1.jsp" method="post" class="calc-form">
                    <div class="calc-row">
                        <input type="number" name="num1" class="calc-input" placeholder="第一个数" step="any"
                            value="<%= num1Str != null ? num1Str : "" %>" required>

                        <select name="operator" class="calc-operator" required>
                            <option value="+" <%= "+".equals(operator) ? "selected" : "" %>>+</option>
                            <option value="-" <%= "-".equals(operator) ? "selected" : "" %>>-</option>
                            <option value="*" <%= "*".equals(operator) ? "selected" : "" %>>×</option>
                            <option value="/" <%= "/".equals(operator) ? "selected" : "" %>>÷</option>
                        </select>

                        <input type="number" name="num2" class="calc-input" placeholder="第二个数" step="any"
                            value="<%= num2Str != null ? num2Str : "" %>" required>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">
                        = 计算结果
                    </button>
                </form>

                <% if (hasCalculated && calculator.getError() == null) { %>
                <div class="calc-result">
                    <%= calculator.getExpression() %>
                </div>
                <% } else if (calculator.getError() != null) { %>
                <div class="calc-error">
                    ❌ <%= calculator.getError() %>
                </div>
                <% } %>

                <div class="info-card" style="margin-top: 30px;">
                    <h3>💡 Model1 模式特点</h3>
                    <ul>
                        <li><strong>架构</strong>: JSP + JavaBean</li>
                        <li><strong>JSP 职责</strong>: 接收请求、调用 JavaBean、显示结果</li>
                        <li><strong>JavaBean 职责</strong>: 封装业务逻辑和数据</li>
                        <li><strong>优点</strong>: 简单直观，适合小型项目</li>
                        <li><strong>缺点</strong>: JSP 中混杂业务逻辑，不利于维护</li>
                        <li><strong>使用场景</strong>: 简单的 CRUD 操作、小型项目</li>
                    </ul>
                </div>

                <div style="text-align: center; margin-top: 20px;">
                    <a href="calculator-model2.jsp" class="btn btn-secondary">查看 Model2 版本</a>
                    <a href="index.jsp" class="btn btn-secondary">返回首页</a>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
