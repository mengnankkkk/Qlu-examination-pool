package com.example.servlet;

import com.example.model.Calculator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * 计算器 Servlet 控制器
 * 实验 8-2: 基于 Model2 的四则运算器
 *
 * Model2 模式：JSP + Servlet + JavaBean (MVC)
 * - Model: Calculator JavaBean
 * - View: calculator-model2.jsp
 * - Controller: CalculatorServlet
 */
@WebServlet(name = "CalculatorServlet", urlPatterns = {"/CalculatorServlet"})
public class CalculatorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");

        // 获取表单参数
        String num1Str = request.getParameter("num1");
        String num2Str = request.getParameter("num2");
        String operator = request.getParameter("operator");

        // 创建 Calculator 对象（Model）
        Calculator calculator = new Calculator();

        try {
            // 解析参数
            double num1 = Double.parseDouble(num1Str);
            double num2 = Double.parseDouble(num2Str);

            // 设置参数
            calculator.setNum1(num1);
            calculator.setNum2(num2);
            calculator.setOperator(operator);

            // 执行计算
            calculator.calculate();

        } catch (NumberFormatException e) {
            calculator.setError("请输入有效的数字");
        }

        // 将 Calculator 对象存储到 request 作用域
        request.setAttribute("calculator", calculator);

        // 转发到 View（JSP）
        request.getRequestDispatcher("calculator-model2.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET 请求直接转发到 JSP
        request.getRequestDispatcher("calculator-model2.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "计算器 Servlet - Model2 模式";
    }
}
