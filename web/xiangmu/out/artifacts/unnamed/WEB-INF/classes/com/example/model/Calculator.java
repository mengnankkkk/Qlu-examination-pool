package com.example.model;

import java.io.Serializable;

/**
 * 计算器 JavaBean
 * 实验 8: Model1 和 Model2 的四则运算器
 */
public class Calculator implements Serializable {
    private static final long serialVersionUID = 1L;

    private double num1;        // 第一个操作数
    private double num2;        // 第二个操作数
    private String operator;    // 运算符 (+, -, *, /)
    private double result;      // 计算结果
    private String error;       // 错误信息

    /**
     * 默认构造函数
     */
    public Calculator() {
    }

    /**
     * 完整构造函数
     */
    public Calculator(double num1, double num2, String operator) {
        this.num1 = num1;
        this.num2 = num2;
        this.operator = operator;
    }

    /**
     * 执行计算
     *
     * @return boolean 计算是否成功
     */
    public boolean calculate() {
        error = null;

        try {
            switch (operator) {
                case "+":
                    result = num1 + num2;
                    break;
                case "-":
                    result = num1 - num2;
                    break;
                case "*":
                    result = num1 * num2;
                    break;
                case "/":
                    if (num2 == 0) {
                        error = "除数不能为零";
                        return false;
                    }
                    result = num1 / num2;
                    break;
                default:
                    error = "不支持的运算符：" + operator;
                    return false;
            }
            return true;
        } catch (Exception e) {
            error = "计算错误：" + e.getMessage();
            return false;
        }
    }

    /**
     * 获取计算表达式
     *
     * @return String 表达式字符串
     */
    public String getExpression() {
        return num1 + " " + operator + " " + num2 + " = " + result;
    }

    // Getter 和 Setter 方法
    public double getNum1() {
        return num1;
    }

    public void setNum1(double num1) {
        this.num1 = num1;
    }

    public double getNum2() {
        return num2;
    }

    public void setNum2(double num2) {
        this.num2 = num2;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public double getResult() {
        return result;
    }

    public void setResult(double result) {
        this.result = result;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    @Override
    public String toString() {
        return "Calculator{" +
                "num1=" + num1 +
                ", num2=" + num2 +
                ", operator='" + operator + '\'' +
                ", result=" + result +
                ", error='" + error + '\'' +
                '}';
    }
}
