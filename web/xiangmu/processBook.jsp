<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.Book" %>
<%@ page import="com.example.dao.BookDAO" %>
<%@ page import="java.sql.Date" %>
<%
    // 设置请求编码
    request.setCharacterEncoding("UTF-8");

    // 获取操作类型
    String action = request.getParameter("action");
    BookDAO bookDAO = new BookDAO();

    String redirectUrl = "books.jsp";
    String message = "";

    if ("add".equals(action)) {
        // 添加图书
        try {
            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setPublisher(request.getParameter("publisher"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setStock(Integer.parseInt(request.getParameter("stock")));
            book.setIsbn(request.getParameter("isbn"));
            book.setCategory(request.getParameter("category"));
            book.setDescription(request.getParameter("description"));

            // 处理出版日期
            String publishDateStr = request.getParameter("publishDate");
            if (publishDateStr != null && !publishDateStr.isEmpty()) {
                book.setPublishDate(Date.valueOf(publishDateStr));
            }

            boolean success = bookDAO.addBook(book);
            if (success) {
                message = "图书《" + book.getTitle() + "》添加成功！";
            } else {
                message = "图书添加失败，请重试";
            }
        } catch (Exception e) {
            message = "添加失败：" + e.getMessage();
            e.printStackTrace();
        }

        redirectUrl = "books.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");

    } else if ("update".equals(action)) {
        // 更新图书
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = new Book();
            book.setId(id);
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setPublisher(request.getParameter("publisher"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setStock(Integer.parseInt(request.getParameter("stock")));
            book.setIsbn(request.getParameter("isbn"));
            book.setCategory(request.getParameter("category"));
            book.setDescription(request.getParameter("description"));

            // 处理出版日期
            String publishDateStr = request.getParameter("publishDate");
            if (publishDateStr != null && !publishDateStr.isEmpty()) {
                book.setPublishDate(Date.valueOf(publishDateStr));
            }

            boolean success = bookDAO.updateBook(book);
            if (success) {
                message = "图书《" + book.getTitle() + "》更新成功！";
            } else {
                message = "图书更新失败，请重试";
            }
        } catch (Exception e) {
            message = "更新失败：" + e.getMessage();
            e.printStackTrace();
        }

        redirectUrl = "books.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");

    } else if ("delete".equals(action)) {
        // 删除图书
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // 先获取图书信息用于显示消息
            Book book = bookDAO.getBookById(id);
            String bookTitle = book != null ? book.getTitle() : "未知";

            boolean success = bookDAO.deleteBook(id);
            if (success) {
                message = "图书《" + bookTitle + "》已删除";
            } else {
                message = "图书删除失败，请重试";
            }
        } catch (Exception e) {
            message = "删除失败：" + e.getMessage();
            e.printStackTrace();
        }

        redirectUrl = "books.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");

    } else {
        // 未知操作
        message = "未知操作";
        redirectUrl = "books.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");
    }

    // 重定向
    response.sendRedirect(redirectUrl);
%>
