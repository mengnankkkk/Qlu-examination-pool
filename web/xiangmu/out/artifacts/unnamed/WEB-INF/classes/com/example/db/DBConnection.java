package com.example.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 数据库连接 JavaBean
 * 实验 6 - 项目 1：连接数据库的 JavaBean
 */
public class DBConnection {

    private static final String DB_URL = "jdbc:sqlite:book.db";
    private static final String DRIVER_CLASS = "org.sqlite.JDBC";

    private Connection connection;

    /**
     * 默认构造函数
     */
    public DBConnection() {
    }

    /**
     * 获取数据库连接
     *
     * @return Connection 数据库连接对象
     * @throws SQLException SQL 异常
     */
    public Connection getConnection() throws SQLException {
        try {
            // 加载 SQLite JDBC 驱动
            Class.forName(DRIVER_CLASS);

            // 建立连接
            connection = DriverManager.getConnection(DB_URL);

            return connection;
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQLite JDBC 驱动未找到：" + e.getMessage());
        }
    }

    /**
     * 关闭数据库连接
     */
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                System.err.println("关闭数据库连接失败：" + e.getMessage());
            }
        }
    }

    /**
     * 测试数据库连接
     *
     * @return boolean 连接是否成功
     */
    public boolean testConnection() {
        try {
            Connection conn = getConnection();
            boolean isValid = conn != null && !conn.isClosed();
            closeConnection();
            return isValid;
        } catch (SQLException e) {
            System.err.println("数据库连接测试失败：" + e.getMessage());
            return false;
        }
    }

    /**
     * 获取数据库 URL
     *
     * @return String 数据库 URL
     */
    public String getDbUrl() {
        return DB_URL;
    }

    /**
     * 获取驱动类名
     *
     * @return String 驱动类名
     */
    public String getDriverClass() {
        return DRIVER_CLASS;
    }
}
