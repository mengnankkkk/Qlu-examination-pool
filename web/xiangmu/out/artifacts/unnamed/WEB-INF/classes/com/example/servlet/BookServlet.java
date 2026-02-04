package com.example.servlet;

import com.example.dao.BookDAO;
import com.example.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * 图书管理 Servlet 控制器
 * 实验 8-3: 基于 Model2 的图书管理系统
 *
 * Model2 (MVC) 架构：
 * - Model: Book, BookDAO
 * - View: books-model2.jsp, book-form.jsp
 * - Controller: BookServlet
 */
@WebServlet(name = "BookServlet", urlPatterns = {"/BookServlet"})
public class BookServlet extends HttpServlet {

    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        // 初始化数据库
        try {
            com.example.util.DBInitializer.initDatabase();
        } catch (Exception e) {
            System.err.println("数据库初始化警告：" + e.getMessage());
        }

        // 初始化 DAO
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listBooks(request, response);
                break;
            case "search":
                searchBooks(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            default:
                listBooks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addBook(request, response);
        } else if ("update".equals(action)) {
            updateBook(request, response);
        } else {
            listBooks(request, response);
        }
    }

    /**
     * 显示图书列表
     */
    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> books = bookDAO.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("books-model2.jsp").forward(request, response);
    }

    /**
     * 搜索图书
     */
    private void searchBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Book> books;

        if (keyword != null && !keyword.trim().isEmpty()) {
            books = bookDAO.searchBooks(keyword);
            request.setAttribute("keyword", keyword);
        } else {
            books = bookDAO.getAllBooks();
        }

        request.setAttribute("books", books);
        request.getRequestDispatcher("books-model2.jsp").forward(request, response);
    }

    /**
     * 显示添加表单
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("book-form.jsp").forward(request, response);
    }

    /**
     * 显示编辑表单
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.getBookById(id);

        if (book != null) {
            request.setAttribute("book", book);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("book-form.jsp").forward(request, response);
        } else {
            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode("图书不存在", "UTF-8"));
        }
    }

    /**
     * 添加图书
     */
    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Book book = extractBookFromRequest(request);
            boolean success = bookDAO.addBook(book);

            String message = success ? "图书《" + book.getTitle() + "》添加成功！" : "图书添加失败";
            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode(message, "UTF-8"));
        } catch (Exception e) {
            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode("添加失败：" + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * 更新图书
     */
    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Book book = extractBookFromRequest(request);
            book.setId(Integer.parseInt(request.getParameter("id")));

            boolean success = bookDAO.updateBook(book);
            String message = success ? "图书《" + book.getTitle() + "》更新成功！" : "图书更新失败";

            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode(message, "UTF-8"));
        } catch (Exception e) {
            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode("更新失败：" + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * 删除图书
     */
    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = bookDAO.getBookById(id);
            String bookTitle = book != null ? book.getTitle() : "未知";

            boolean success = bookDAO.deleteBook(id);
            String message = success ? "图书《" + bookTitle + "》已删除" : "图书删除失败";

            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode(message, "UTF-8"));
        } catch (Exception e) {
            response.sendRedirect("BookServlet?message=" +
                    java.net.URLEncoder.encode("删除失败：" + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * 从请求中提取图书对象
     */
    private Book extractBookFromRequest(HttpServletRequest request) {
        Book book = new Book();
        book.setTitle(request.getParameter("title"));
        book.setAuthor(request.getParameter("author"));
        book.setPublisher(request.getParameter("publisher"));
        book.setPrice(Double.parseDouble(request.getParameter("price")));
        book.setStock(Integer.parseInt(request.getParameter("stock")));
        book.setIsbn(request.getParameter("isbn"));
        book.setCategory(request.getParameter("category"));
        book.setDescription(request.getParameter("description"));

        String publishDateStr = request.getParameter("publishDate");
        if (publishDateStr != null && !publishDateStr.isEmpty()) {
            book.setPublishDate(Date.valueOf(publishDateStr));
        }

        return book;
    }

    @Override
    public String getServletInfo() {
        return "图书管理 Servlet - Model2 (MVC) 模式";
    }
}
