<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Book" %>
<%@ page import="com.example.dao.BookDAO" %>
<%
    // 初始化数据库（首次访问时）
    try {
        com.example.util.DBInitializer.initDatabase();
    } catch (Exception e) {
        System.err.println("数据库初始化警告：" + e.getMessage());
    }

    // 获取搜索关键词
    String keyword = request.getParameter("keyword");
    String message = request.getParameter("message");

    // 使用 BookDAO 获取图书列表
    BookDAO bookDAO = new BookDAO();
    List<Book> books;

    if (keyword != null && !keyword.trim().isEmpty()) {
        books = bookDAO.searchBooks(keyword);
    } else {
        books = bookDAO.getAllBooks();
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图书管理系统 - JSP 实验</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <style>
        .books-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .books-header h2 {
            font-size: 32px;
            color: #667eea;
            margin: 0;
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-box input {
            flex: 1;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }

        .books-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .books-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .books-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .books-table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .books-table tr:last-child td {
            border-bottom: none;
        }

        .books-table tr:hover {
            background: #f8f9fa;
        }

        .book-actions {
            display: flex;
            gap: 8px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .empty-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .success-message {
            background: #48bb78;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-success {
            background: #d4edda;
            color: #155724;
        }

        .badge-warning {
            background: #fff3cd;
            color: #856404;
        }

        .badge-danger {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body>
    <div class="container">
        <jsp:include page="includes/header.jsp" />

        <div class="content">
            <div class="books-header">
                <h2>📚 图书管理系统</h2>
                <a href="addBook.jsp" class="btn btn-primary">➕ 添加图书</a>
            </div>

            <% if (message != null && !message.isEmpty()) { %>
            <div class="success-message">
                ✅ <%= message %>
            </div>
            <% } %>

            <div class="search-box">
                <form action="books.jsp" method="get" style="display: flex; gap: 10px; width: 100%;">
                    <input type="text" name="keyword" placeholder="搜索书名、作者或出版社..." value="<%= keyword != null ? keyword : "" %>">
                    <button type="submit" class="btn btn-primary">🔍 搜索</button>
                    <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                    <a href="books.jsp" class="btn btn-secondary">清除</a>
                    <% } %>
                </form>
            </div>

            <% if (books.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-icon">📚</div>
                <h3 style="color: #666; margin-bottom: 10px;">
                    <%= keyword != null && !keyword.trim().isEmpty() ? "未找到相关图书" : "暂无图书数据" %>
                </h3>
                <p style="color: #999; margin-bottom: 25px;">
                    <%= keyword != null && !keyword.trim().isEmpty() ? "请尝试其他关键词" : "点击上方按钮添加第一本图书" %>
                </p>
                <% if (keyword == null || keyword.trim().isEmpty()) { %>
                <a href="addBook.jsp" class="btn btn-primary">添加图书</a>
                <% } %>
            </div>
            <% } else { %>
            <div class="books-table">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th>书名</th>
                            <th>作者</th>
                            <th>出版社</th>
                            <th style="width: 100px;">价格</th>
                            <th style="width: 100px;">库存</th>
                            <th style="width: 100px;">分类</th>
                            <th style="width: 200px; text-align: center;">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Book book : books) { %>
                        <tr>
                            <td><strong>#<%= book.getId() %></strong></td>
                            <td>
                                <strong><%= book.getTitle() %></strong>
                                <% if (book.getIsbn() != null && !book.getIsbn().isEmpty()) { %>
                                <br><small style="color: #999;">ISBN: <%= book.getIsbn() %></small>
                                <% } %>
                            </td>
                            <td><%= book.getAuthor() %></td>
                            <td><%= book.getPublisher() %></td>
                            <td style="color: #667eea; font-weight: 600;">¥<%= String.format("%.2f", book.getPrice()) %></td>
                            <td>
                                <% if (book.getStock() > 50) { %>
                                <span class="badge badge-success"><%= book.getStock() %> 本</span>
                                <% } else if (book.getStock() > 10) { %>
                                <span class="badge badge-warning"><%= book.getStock() %> 本</span>
                                <% } else { %>
                                <span class="badge badge-danger"><%= book.getStock() %> 本</span>
                                <% } %>
                            </td>
                            <td><%= book.getCategory() %></td>
                            <td style="text-align: center;">
                                <div class="book-actions">
                                    <a href="editBook.jsp?id=<%= book.getId() %>" class="btn btn-secondary"
                                        style="padding: 6px 12px; font-size: 13px;">编辑</a>
                                    <a href="processBook.jsp?action=delete&id=<%= book.getId() %>" class="btn btn-secondary"
                                        style="padding: 6px 12px; font-size: 13px; background: #f56565;"
                                        onclick="return confirm('确定要删除《<%= book.getTitle() %>》吗？')">删除</a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div style="margin-top: 20px; text-align: center; color: #666;">
                共找到 <%= books.size() %> 本图书
            </div>
            <% } %>

            <div class="info-card" style="margin-top: 40px;">
                <h3>💡 图书管理系统知识点</h3>
                <ul>
                    <li><strong>JDBC 连接</strong>: 使用 SQLite JDBC 驱动连接数据库</li>
                    <li><strong>JavaBean 封装</strong>: Book 类封装图书属性，BookDAO 类封装数据库操作</li>
                    <li><strong>CRUD 操作</strong>: 实现了增加、查询、更新、删除图书的完整功能</li>
                    <li><strong>PreparedStatement</strong>: 使用预编译语句防止 SQL 注入</li>
                    <li><strong>资源管理</strong>: 正确关闭 Connection、Statement 和 ResultSet</li>
                    <li><strong>搜索功能</strong>: 使用 LIKE 语句实现模糊搜索</li>
                </ul>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
