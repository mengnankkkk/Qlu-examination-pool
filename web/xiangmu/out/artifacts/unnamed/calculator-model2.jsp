<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.Calculator" %>
<%
    // Model2 模式：JSP + Servlet + JavaBean (MVC)
    // JSP 只负责显示，不处理业务逻辑

    Calculator calculator = (Calculator) request.getAttribute("calculator");
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Model2 计算器 - JSP 实验</title>
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

        .mvc-diagram {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
        }

        .mvc-box {
            display: inline-block;
            padding: 15px 25px;
            margin: 10px;
            border-radius: 8px;
            font-weight: 600;
        }

        .mvc-model {
            background: #48bb78;
            color: white;
        }

        .mvc-view {
            background: #4299e1;
            color: white;
        }

        .mvc-controller {
            background: #ed8936;
            color: white;
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
                    <p style="color: #666;">Model2 模式：MVC 架构</p>
                </div>

                <form action="CalculatorServlet" method="post" class="calc-form">
                    <div class="calc-row">
                        <input type="number" name="num1" class="calc-input" placeholder="第一个数" step="any"
                            value="<%= calculator != null ? calculator.getNum1() : "" %>" required>

                        <select name="operator" class="calc-operator" required>
                            <option value="+" <%= calculator != null && "+".equals(calculator.getOperator()) ? "selected" : "" %>>+</option>
                            <option value="-" <%= calculator != null && "-".equals(calculator.getOperator()) ? "selected" : "" %>>-</option>
                            <option value="*" <%= calculator != null && "*".equals(calculator.getOperator()) ? "selected" : "" %>>×</option>
                            <option value="/" <%= calculator != null && "/".equals(calculator.getOperator()) ? "selected" : "" %>>÷</option>
                        </select>

                        <input type="number" name="num2" class="calc-input" placeholder="第二个数" step="any"
                            value="<%= calculator != null ? calculator.getNum2() : "" %>" required>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">
                        = 计算结果
                    </button>
                </form>

                <% if (calculator != null) { %>
                    <% if (calculator.getError() == null) { %>
                    <div class="calc-result">
                        <%= calculator.getExpression() %>
                    </div>
                    <% } else { %>
                    <div class="calc-error">
                        ❌ <%= calculator.getError() %>
                    </div>
                    <% } %>
                <% } %>

                <div class="mvc-diagram">
                    <h4 style="margin-bottom: 15px;">MVC 架构流程</h4>
                    <div class="mvc-box mvc-view">View (JSP)</div>
                    <div style="display: inline-block; margin: 0 10px;">→</div>
                    <div class="mvc-box mvc-controller">Controller (Servlet)</div>
                    <div style="display: inline-block; margin: 0 10px;">→</div>
                    <div class="mvc-box mvc-model">Model (JavaBean)</div>
                </div>

                <div class="info-card" style="margin-top: 30px;">
                    <h3>💡 Model2 (MVC) 模式特点</h3>
                    <ul>
                        <li><strong>Model (模型)</strong>: Calculator JavaBean - 封装业务逻辑和数据</li>
                        <li><strong>View (视图)</strong>: calculator-model2.jsp - 只负责显示</li>
                        <li><strong>Controller (控制器)</strong>: CalculatorServlet - 处理请求和流程控制</li>
                        <li><strong>优点</strong>: 职责分离、易于维护、适合大型项目</li>
                        <li><strong>缺点</strong>: 相对复杂，需要更多的类和配置</li>
                        <li><strong>使用场景</strong>: 中大型项目、需要团队协作的项目</li>
                    </ul>
                </div>

                <div style="text-align: center; margin-top: 20px;">
                    <a href="calculator-model1.jsp" class="btn btn-secondary">查看 Model1 版本</a>
                    <a href="index.jsp" class="btn btn-secondary">返回首页</a>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
