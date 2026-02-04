package com.example.dao;

import com.example.db.DBConnection;
import com.example.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 图书数据访问对象 (DAO) JavaBean
 * 实验 6 - 项目 2：使用 JavaBean 实现图书管理系统
 */
public class BookDAO {

    private DBConnection dbConnection;

    /**
     * 默认构造函数
     */
    public BookDAO() {
        this.dbConnection = new DBConnection();
    }

    /**
     * 获取所有图书
     *
     * @return List<Book> 图书列表
     */
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM bookinfo ORDER BY id DESC";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Book book = extractBookFromResultSet(rs);
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("获取图书列表失败：" + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }

        return books;
    }

    /**
     * 根据 ID 获取图书
     *
     * @param id 图书 ID
     * @return Book 图书对象
     */
    public Book getBookById(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Book book = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT * FROM bookinfo WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                book = extractBookFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("获取图书详情失败：" + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }

        return book;
    }

    /**
     * 添加图书
     *
     * @param book 图书对象
     * @return boolean 是否添加成功
     */
    public boolean addBook(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "INSERT INTO bookinfo (title, author, publisher, price, publish_date, isbn, category, description, stock) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getPublisher());
            pstmt.setDouble(4, book.getPrice());
            pstmt.setDate(5, book.getPublishDate());
            pstmt.setString(6, book.getIsbn());
            pstmt.setString(7, book.getCategory());
            pstmt.setString(8, book.getDescription());
            pstmt.setInt(9, book.getStock());

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.err.println("添加图书失败：" + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    /**
     * 更新图书
     *
     * @param book 图书对象
     * @return boolean 是否更新成功
     */
    public boolean updateBook(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "UPDATE bookinfo SET title = ?, author = ?, publisher = ?, price = ?, " +
                    "publish_date = ?, isbn = ?, category = ?, description = ?, stock = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getPublisher());
            pstmt.setDouble(4, book.getPrice());
            pstmt.setDate(5, book.getPublishDate());
            pstmt.setString(6, book.getIsbn());
            pstmt.setString(7, book.getCategory());
            pstmt.setString(8, book.getDescription());
            pstmt.setInt(9, book.getStock());
            pstmt.setInt(10, book.getId());

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.err.println("更新图书失败：" + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    /**
     * 删除图书
     *
     * @param id 图书 ID
     * @return boolean 是否删除成功
     */
    public boolean deleteBook(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "DELETE FROM bookinfo WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.err.println("删除图书失败：" + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    /**
     * 搜索图书
     *
     * @param keyword 关键词
     * @return List<Book> 图书列表
     */
    public List<Book> searchBooks(String keyword) {
        List<Book> books = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            String sql = "SELECT * FROM bookinfo WHERE title LIKE ? OR author LIKE ? OR publisher LIKE ? ORDER BY id DESC";
            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Book book = extractBookFromResultSet(rs);
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("搜索图书失败：" + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }

        return books;
    }

    /**
     * 从 ResultSet 中提取 Book 对象
     *
     * @param rs ResultSet
     * @return Book 图书对象
     * @throws SQLException SQL 异常
     */
    private Book extractBookFromResultSet(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setPublisher(rs.getString("publisher"));
        book.setPrice(rs.getDouble("price"));
        book.setPublishDate(rs.getDate("publish_date"));
        book.setIsbn(rs.getString("isbn"));
        book.setCategory(rs.getString("category"));
        book.setDescription(rs.getString("description"));
        book.setStock(rs.getInt("stock"));
        book.setCreatedAt(rs.getString("created_at"));
        return book;
    }

    /**
     * 关闭资源
     *
     * @param rs   ResultSet
     * @param stmt Statement
     * @param conn Connection
     */
    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.err.println("关闭资源失败：" + e.getMessage());
        }
    }
}
