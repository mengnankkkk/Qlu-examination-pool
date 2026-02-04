<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.model.CartItem" %>
<%
    // 设置请求编码
    request.setCharacterEncoding("UTF-8");

    // 获取操作类型
    String action = request.getParameter("action");

    // 获取或创建购物车
    @SuppressWarnings("unchecked")
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
        session.setAttribute("cart", cart);
    }

    // 根据操作类型处理
    String redirectUrl = "cart.jsp";
    String message = "";

    if ("add".equals(action)) {
        // 添加商品到购物车
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String image = request.getParameter("image");

        if (id != null && name != null && priceStr != null) {
            try {
                double price = Double.parseDouble(priceStr);

                // 检查商品是否已在购物车中
                if (cart.containsKey(id)) {
                    // 商品已存在，数量 +1
                    CartItem existingItem = cart.get(id);
                    existingItem.setQuantity(existingItem.getQuantity() + 1);
                    message = "商品数量已更新";
                } else {
                    // 新商品，添加到购物车
                    CartItem newItem = new CartItem(id, name, price, 1, image);
                    cart.put(id, newItem);
                    message = "商品已添加到购物车";
                }

                redirectUrl = "products.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");
            } catch (NumberFormatException e) {
                message = "价格格式错误";
                redirectUrl = "products.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");
            }
        }

    } else if ("update".equals(action)) {
        // 更新商品数量
        String id = request.getParameter("id");
        String quantityStr = request.getParameter("quantity");

        if (id != null && quantityStr != null && cart.containsKey(id)) {
            try {
                int quantity = Integer.parseInt(quantityStr);
                if (quantity > 0 && quantity <= 99) {
                    CartItem item = cart.get(id);
                    item.setQuantity(quantity);
                    message = "数量已更新";
                } else if (quantity <= 0) {
                    // 数量为 0 或负数，删除商品
                    cart.remove(id);
                    message = "商品已删除";
                } else {
                    message = "数量超出范围（1-99）";
                }
            } catch (NumberFormatException e) {
                message = "数量格式错误";
            }
        }

        redirectUrl = "cart.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");

    } else if ("remove".equals(action)) {
        // 删除商品
        String id = request.getParameter("id");

        if (id != null && cart.containsKey(id)) {
            CartItem removedItem = cart.remove(id);
            message = "已删除：" + removedItem.getName();
        } else {
            message = "商品不存在";
        }

        redirectUrl = "cart.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");

    } else if ("clear".equals(action)) {
        // 清空购物车
        int itemCount = cart.size();
        cart.clear();
        message = "购物车已清空（共 " + itemCount + " 件商品）";
        redirectUrl = "cart.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");

    } else {
        // 未知操作
        message = "未知操作";
        redirectUrl = "cart.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8");
    }

    // 重定向
    response.sendRedirect(redirectUrl);
%>
