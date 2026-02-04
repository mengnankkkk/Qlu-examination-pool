<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.model.CartItem" %>
<%
    // 获取购物车商品数量
    @SuppressWarnings("unchecked")
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
    int cartCount = 0;
    if (cart != null) {
        for (CartItem item : cart.values()) {
            cartCount += item.getQuantity();
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
    <title>商品列表 - JSP 实验</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <style>
        .products-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .products-header h2 {
            font-size: 32px;
            color: #667eea;
            margin-bottom: 10px;
        }

        .cart-badge {
            position: relative;
            display: inline-block;
        }

        .cart-badge .badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #f56565;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.2);
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 64px;
        }

        .product-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .product-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .product-desc {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
            flex: 1;
        }

        .product-price {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 15px;
        }

        .product-actions {
            display: flex;
            gap: 10px;
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
            <div class="products-header">
                <h2>🛍️ 商品列表</h2>
                <p style="color: #666;">选择您喜欢的商品加入购物车</p>
                <div style="margin-top: 15px;">
                    <a href="cart.jsp" class="btn btn-primary cart-badge">
                        🛒 查看购物车
                        <% if (cartCount > 0) { %>
                        <span class="badge"><%= cartCount %></span>
                        <% } %>
                    </a>
                </div>
            </div>

            <% if (message != null && !message.isEmpty()) { %>
            <div class="success-message">
                ✅ <%= message %>
            </div>
            <% } %>

            <div class="products-grid">
                <!-- 商品 1 -->
                <div class="product-card">
                    <div class="product-image">💻</div>
                    <div class="product-info">
                        <div class="product-name">笔记本电脑</div>
                        <div class="product-desc">高性能办公笔记本，轻薄便携，续航持久</div>
                        <div class="product-price">¥5,999</div>
                        <form action="processCart.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="P001">
                            <input type="hidden" name="name" value="笔记本电脑">
                            <input type="hidden" name="price" value="5999">
                            <input type="hidden" name="image" value="💻">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                加入购物车
                            </button>
                        </form>
                    </div>
                </div>

                <!-- 商品 2 -->
                <div class="product-card">
                    <div class="product-image">📱</div>
                    <div class="product-info">
                        <div class="product-name">智能手机</div>
                        <div class="product-desc">旗舰级处理器，超清摄像，5G 网络支持</div>
                        <div class="product-price">¥3,999</div>
                        <form action="processCart.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="P002">
                            <input type="hidden" name="name" value="智能手机">
                            <input type="hidden" name="price" value="3999">
                            <input type="hidden" name="image" value="📱">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                加入购物车
                            </button>
                        </form>
                    </div>
                </div>

                <!-- 商品 3 -->
                <div class="product-card">
                    <div class="product-image">🎧</div>
                    <div class="product-info">
                        <div class="product-name">无线耳机</div>
                        <div class="product-desc">主动降噪，HiFi 音质，长续航设计</div>
                        <div class="product-price">¥899</div>
                        <form action="processCart.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="P003">
                            <input type="hidden" name="name" value="无线耳机">
                            <input type="hidden" name="price" value="899">
                            <input type="hidden" name="image" value="🎧">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                加入购物车
                            </button>
                        </form>
                    </div>
                </div>

                <!-- 商品 4 -->
                <div class="product-card">
                    <div class="product-image">⌚</div>
                    <div class="product-info">
                        <div class="product-name">智能手表</div>
                        <div class="product-desc">健康监测，运动追踪，消息提醒</div>
                        <div class="product-price">¥1,299</div>
                        <form action="processCart.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="P004">
                            <input type="hidden" name="name" value="智能手表">
                            <input type="hidden" name="price" value="1299">
                            <input type="hidden" name="image" value="⌚">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                加入购物车
                            </button>
                        </form>
                    </div>
                </div>

                <!-- 商品 5 -->
                <div class="product-card">
                    <div class="product-image">📷</div>
                    <div class="product-info">
                        <div class="product-name">数码相机</div>
                        <div class="product-desc">专业级传感器，4K 视频录制</div>
                        <div class="product-price">¥6,999</div>
                        <form action="processCart.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="P005">
                            <input type="hidden" name="name" value="数码相机">
                            <input type="hidden" name="price" value="6999">
                            <input type="hidden" name="image" value="📷">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                加入购物车
                            </button>
                        </form>
                    </div>
                </div>

                <!-- 商品 6 -->
                <div class="product-card">
                    <div class="product-image">🖱️</div>
                    <div class="product-info">
                        <div class="product-name">无线鼠标</div>
                        <div class="product-desc">人体工学设计，精准定位，静音按键</div>
                        <div class="product-price">¥199</div>
                        <form action="processCart.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="P006">
                            <input type="hidden" name="name" value="无线鼠标">
                            <input type="hidden" name="price" value="199">
                            <input type="hidden" name="image" value="🖱️">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                加入购物车
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="info-card" style="margin-top: 40px;">
                <h3>💡 购物车知识点</h3>
                <ul>
                    <li><strong>Session 存储</strong>: 购物车数据存储在服务器端的 Session 中</li>
                    <li><strong>数据结构</strong>: 使用 Map&lt;String, CartItem&gt; 存储商品，key 为商品 ID</li>
                    <li><strong>JavaBean</strong>: CartItem 类封装了商品的属性和方法</li>
                    <li><strong>生命周期</strong>: 购物车数据在 Session 有效期内保持，关闭浏览器后可能丢失</li>
                    <li><strong>优点</strong>: 安全性高，数据存储在服务器端</li>
                    <li><strong>缺点</strong>: 占用服务器内存，Session 过期后数据丢失</li>
                </ul>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
