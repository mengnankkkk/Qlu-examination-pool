package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 * 简单 Servlet 示例
 * 实验 7-1: 简单 Servlet 的开发
 */
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello", "/HelloServlet"})
public class HelloServlet extends HttpServlet {

    private int visitCount = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");

        // 增加访问计数
        visitCount++;

        // 获取输出流
        PrintWriter out = response.getWriter();

        // 输出 HTML 页面
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Hello Servlet</title>");
        out.println("<link rel='stylesheet' href='css/style.css'>");
        out.println("<style>");
        out.println("body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }");
        out.println(".servlet-container { max-width: 800px; margin: 50px auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 8px 16px rgba(0,0,0,0.2); }");
        out.println(".servlet-header { text-align: center; margin-bottom: 30px; }");
        out.println(".servlet-header h1 { color: #667eea; font-size: 36px; margin-bottom: 10px; }");
        out.println(".info-box { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #667eea; }");
        out.println(".info-box h3 { color: #333; margin-top: 0; }");
        out.println(".info-item { padding: 10px 0; border-bottom: 1px solid #e0e0e0; }");
        out.println(".info-item:last-child { border-bottom: none; }");
        out.println(".label { font-weight: 600; color: #667eea; display: inline-block; width: 150px; }");
        out.println(".btn { display: inline-block; padding: 12px 30px; background: #667eea; color: white; text-decoration: none; border-radius: 8px; margin: 10px 5px; transition: all 0.3s; }");
        out.println(".btn:hover { background: #5568d3; transform: translateY(-2px); }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='servlet-container'>");
        out.println("<div class='servlet-header'>");
        out.println("<h1>👋 Hello Servlet!</h1>");
        out.println("<p style='color: #666;'>这是一个简单的 Servlet 示例</p>");
        out.println("</div>");

        out.println("<div class='info-box'>");
        out.println("<h3>📊 Servlet 信息</h3>");
        out.println("<div class='info-item'><span class='label'>Servlet 名称:</span> " + getServletName() + "</div>");
        out.println("<div class='info-item'><span class='label'>访问次数:</span> " + visitCount + "</div>");
        out.println("<div class='info-item'><span class='label'>当前时间:</span> " + new Date() + "</div>");
        out.println("<div class='info-item'><span class='label'>请求方法:</span> " + request.getMethod() + "</div>");
        out.println("<div class='info-item'><span class='label'>请求 URI:</span> " + request.getRequestURI() + "</div>");
        out.println("<div class='info-item'><span class='label'>客户端 IP:</span> " + request.getRemoteAddr() + "</div>");
        out.println("</div>");

        out.println("<div class='info-box'>");
        out.println("<h3>💡 Servlet 知识点</h3>");
        out.println("<ul style='line-height: 1.8;'>");
        out.println("<li><strong>Servlet 生命周期</strong>: init() → service() → destroy()</li>");
        out.println("<li><strong>@WebServlet 注解</strong>: 用于配置 Servlet 映射，无需在 web.xml 中配置</li>");
        out.println("<li><strong>doGet/doPost</strong>: 处理 GET 和 POST 请求的方法</li>");
        out.println("<li><strong>HttpServletRequest</strong>: 封装客户端请求信息</li>");
        out.println("<li><strong>HttpServletResponse</strong>: 用于向客户端发送响应</li>");
        out.println("<li><strong>线程安全</strong>: Servlet 是单例的，需要注意实例变量的线程安全问题</li>");
        out.println("</ul>");
        out.println("</div>");

        out.println("<div style='text-align: center; margin-top: 30px;'>");
        out.println("<a href='hello' class='btn'>🔄 刷新页面</a>");
        out.println("<a href='index.jsp' class='btn'>🏠 返回首页</a>");
        out.println("</div>");

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "简单 Servlet 示例 - 实验 7-1";
    }
}
