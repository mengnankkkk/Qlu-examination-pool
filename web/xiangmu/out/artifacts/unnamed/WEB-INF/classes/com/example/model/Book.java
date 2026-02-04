package com.example.model;

import java.io.Serializable;
import java.sql.Date;

/**
 * 图书 JavaBean
 * 对应数据库 bookinfo 表
 */
public class Book implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;                 // 图书 ID
    private String title;           // 书名
    private String author;          // 作者
    private String publisher;       // 出版社
    private double price;           // 价格
    private Date publishDate;       // 出版日期
    private String isbn;            // ISBN 编号
    private String category;        // 分类
    private String description;     // 描述
    private int stock;              // 库存
    private String createdAt;       // 创建时间

    /**
     * 默认构造函数
     */
    public Book() {
    }

    /**
     * 完整构造函数
     */
    public Book(int id, String title, String author, String publisher, double price,
                Date publishDate, String isbn, String category, String description, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.price = price;
        this.publishDate = publishDate;
        this.isbn = isbn;
        this.category = category;
        this.description = description;
        this.stock = stock;
    }

    // Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", publisher='" + publisher + '\'' +
                ", price=" + price +
                ", publishDate=" + publishDate +
                ", isbn='" + isbn + '\'' +
                ", category='" + category + '\'' +
                ", stock=" + stock +
                '}';
    }
}
