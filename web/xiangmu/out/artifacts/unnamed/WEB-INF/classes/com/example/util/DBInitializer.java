package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * 数据库初始化工具类
 * 用于创建 SQLite 数据库和表结构
 */
public class DBInitializer {

    private static final String DB_PATH = "book.db";
    private static final String DB_URL = "jdbc:sqlite:" + DB_PATH;

    /**
     * 初始化数据库
     */
    public static void initDatabase() {
        Connection conn = null;
        Statement stmt = null;

        try {
            // 加载 SQLite JDBC 驱动
            Class.forName("org.sqlite.JDBC");

            // 连接数据库（如果不存在会自动创建）
            conn = DriverManager.getConnection(DB_URL);
            stmt = conn.createStatement();

            // 创建 bookinfo 表
            String createTableSQL = "CREATE TABLE IF NOT EXISTS bookinfo (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "title VARCHAR(200) NOT NULL, " +
                    "author VARCHAR(100) NOT NULL, " +
                    "publisher VARCHAR(100), " +
                    "price DECIMAL(10, 2), " +
                    "publish_date DATE, " +
                    "isbn VARCHAR(20), " +
                    "category VARCHAR(50), " +
                    "description TEXT, " +
                    "stock INTEGER DEFAULT 0, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";

            stmt.executeUpdate(createTableSQL);

            // 插入示例数据
            String insertSQL = "INSERT INTO bookinfo (title, author, publisher, price, publish_date, isbn, category, description, stock) VALUES " +
                    "('Java 编程思想', 'Bruce Eckel', '机械工业出版社', 108.00, '2007-06-01', '9787111213826', '编程语言', 'Java 学习经典书籍，深入讲解 Java 核心概念', 50), " +
                    "('深入理解计算机系统', 'Randal E. Bryant', '机械工业出版社', 139.00, '2016-11-01', '9787111544937', '计算机科学', '从程序员的视角深入理解计算机系统', 30), " +
                    "('算法导论', 'Thomas H. Cormen', '机械工业出版社', 128.00, '2013-01-01', '9787111407010', '算法', '算法领域的经典教材', 25), " +
                    "('设计模式', 'Erich Gamma', '机械工业出版社', 79.00, '2007-09-01', '9787111211266', '软件工程', '面向对象软件设计的经典之作', 40), " +
                    "('代码大全', 'Steve McConnell', '电子工业出版社', 128.00, '2006-03-01', '9787121022982', '软件工程', '软件构建的百科全书', 35)";

            // 检查是否已有数据
            String checkSQL = "SELECT COUNT(*) as count FROM bookinfo";
            var rs = stmt.executeQuery(checkSQL);
            if (rs.next() && rs.getInt("count") == 0) {
                stmt.executeUpdate(insertSQL);
                System.out.println("示例数据插入成功！");
            }

            System.out.println("数据库初始化成功！");

        } catch (Exception e) {
            System.err.println("数据库初始化失败：" + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 获取数据库路径
     */
    public static String getDbPath() {
        return DB_PATH;
    }

    /**
     * 获取数据库 URL
     */
    public static String getDbUrl() {
        return DB_URL;
    }

    /**
     * 测试方法
     */
    public static void main(String[] args) {
        initDatabase();
    }
}
