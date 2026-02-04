<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.model.CartItem" %>
<%
    // 获取购物车
    @SuppressWarnings("unchecked")
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");

    // 计算总价和总数量
    double totalPrice = 0;
    int totalQuantity = 0;
    if (cart != null) {
        for (CartItem item : cart.values()) {
            totalPrice += item.getTotalPrice();
            totalQuantity += item.getQuantity();
        }
    }

    // 获取操作结果消息
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>购物车 - JSP 实验</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <style>
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .cart-header h2 {
            font-size: 32px;
            color: #667eea;
            margin: 0;
        }

        .cart-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .cart-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .cart-table td {
            padding: 20px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .cart-table tr:last-child td {
            border-bottom: none;
        }

        .cart-item-image {
            font-size: 48px;
            text-align: center;
        }

        .cart-item-name {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }

        .cart-item-price {
            font-size: 18px;
            color: #667eea;
            font-weight: 600;
        }

        .quantity-input {
            width: 80px;
            padding: 8px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            text-align: center;
            font-size: 16px;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .cart-actions {
            display: flex;
            gap: 10px;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .empty-cart-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .cart-summary {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .summary-row:last-child {
            border-bottom: none;
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
            padding-top: 20px;
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
    </style>
</head>

<body>
    <div class="container">
        <jsp:include page="includes/header.jsp" />

        <div class="content">
            <div class="cart-header">
                <h2>🛒 我的购物车</h2>
                <a href="products.jsp" class="btn btn-secondary">继续购物</a>
            </div>

            <% if (message != null && !message.isEmpty()) { %>
            <div class="success-message">
                ✅ <%= message %>
            </div>
            <% } %>

            <% if (cart == null || cart.isEmpty()) { %>
            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h3 style="color: #666; margin-bottom: 10px;">购物车是空的</h3>
                <p style="color: #999; margin-bottom: 25px;">快去挑选您喜欢的商品吧！</p>
                <a href="products.jsp" class="btn btn-primary">去购物</a>
            </div>
            <% } else { %>
            <div class="cart-table">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 100px; text-align: center;">商品</th>
                            <th>名称</th>
                            <th style="width: 120px;">单价</th>
                            <th style="width: 120px;">数量</th>
                            <th style="width: 120px;">小计</th>
                            <th style="width: 180px; text-align: center;">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cart.values()) { %>
                        <tr>
                            <td class="cart-item-image">
                                <%= item.getImage() %>
                            </td>
                            <td class="cart-item-name">
                                <%= item.getName() %>
                            </td>
                            <td class="cart-item-price">¥<%= String.format("%.2f", item.getPrice()) %></td>
                            <td>
                                <form action="processCart.jsp" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= item.getId() %>">
                                    <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1"
                                        max="99" class="quantity-input" onchange="this.form.submit()">
                                </form>
                            </td>
                            <td class="cart-item-price">¥<%= String.format("%.2f", item.getTotalPrice()) %></td>
                            <td style="text-align: center;">
                                <div class="cart-actions">
                                    <a href="processCart.jsp?action=remove&id=<%= item.getId() %>"
                                        class="btn btn-secondary" style="padding: 8px 15px; font-size: 14px;"
                                        onclick="return confirm('确定要删除这个商品吗？')">
                                        删除
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="cart-summary">
                <h3 style="margin-bottom: 20px; color: #333;">📊 订单汇总</h3>
                <div class="summary-row">
                    <span>商品总数：</span>
                    <span><%= totalQuantity %> 件</span>
                </div>
                <div class="summary-row">
                    <span>商品总价：</span>
                    <span>¥<%= String.format("%.2f", totalPrice) %></span>
                </div>
                <div class="summary-row">
                    <span>应付总额：</span>
                    <span>¥<%= String.format("%.2f", totalPrice) %></span>
                </div>

                <div style="margin-top: 25px; display: flex; gap: 15px;">
                    <button class="btn btn-primary" style="flex: 1;"
                        onclick="alert('结算功能演示：实际项目中会跳转到支付页面')">
                        去结算
                    </button>
                    <a href="processCart.jsp?action=clear" class="btn btn-secondary"
                        style="flex: 1; text-align: center; text-decoration: none;"
                        onclick="return confirm('确定要清空购物车吗？')">
                        清空购物车
                    </a>
                </div>
            </div>
            <% } %>

            <div class="info-card" style="margin-top: 40px;">
                <h3>💡 Session 购物车实现原理</h3>
                <ul>
                    <li><strong>数据存储</strong>: 使用 <code>session.setAttribute("cart", cartMap)</code> 存储购物车</li>
                    <li><strong>数据结构</strong>: Map&lt;String, CartItem&gt; - 商品 ID 作为 key，CartItem 对象作为 value</li>
                    <li><strong>添加商品</strong>: 检查商品是否已存在，存在则增加数量，不存在则新建 CartItem</li>
                    <li><strong>更新数量</strong>: 通过商品 ID 找到对应的 CartItem，更新其 quantity 属性</li>
                    <li><strong>删除商品</strong>: 使用 <code>cart.remove(productId)</code> 从 Map 中移除</li>
                    <li><strong>清空购物车</strong>: 使用 <code>session.removeAttribute("cart")</code> 或
                        <code>cart.clear()</code>
                    </li>
                    <li><strong>Session 优势</strong>: 数据安全、服务器端存储、支持复杂对象</li>
                </ul>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
