package com.example.model;

import java.io.Serializable;

/**
 * 购物车商品项 JavaBean
 * 用于存储购物车中的商品信息
 */
public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id; // 商品 ID
    private String name; // 商品名称
    private double price; // 商品单价
    private int quantity; // 购买数量
    private String image; // 商品图片路径

    /**
     * 默认构造函数
     */
    public CartItem() {
    }

    /**
     * 完整构造函数
     */
    public CartItem(String id, String name, double price, int quantity, String image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
    }

    // Getter 和 Setter 方法
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    /**
     * 计算商品小计金额
     * 
     * @return 小计金额（单价 × 数量）
     */
    public double getTotalPrice() {
        return price * quantity;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", image='" + image + '\'' +
                '}';
    }
}
