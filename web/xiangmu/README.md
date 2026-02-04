# JSP 基本语法实验项目

这是一个完整的 JSP Web 应用，旨在演示 JSP 基本语法、指令和动作标签的使用。

## 实验内容

本项目涵盖了以下实验要求：

1. **项目 1：用户注册页面的开发**
   - 实现了完整的用户注册表单 (`register.jsp`)
   - 使用 JSP 脚本和表达式处理数据 (`processRegister.jsp`)

2. **项目 2：JavaScript 客户端验证**
   - 实现了实时表单验证 (`js/validation.js`)
   - 包含必填项检查、格式验证、密码强度检测等

3. **项目 3：CSS 美化**
   - 使用现代化的 CSS3 样式 (`css/style.css`)
   - 实现了响应式布局、卡片设计和动画效果

4. **项目 4：`<jsp:include>` 的使用**
   - 创建了公共组件 `header.jsp` 和 `footer.jsp`
   - 在 `demo-include.jsp` 中演示了静态包含和动态包含的区别
   - 演示了参数传递 (`<jsp:param>`)

5. **项目 5：`<jsp:forward>` 的使用**
   - 在 `demo-forward.jsp` 中演示了请求转发
   - 实现了根据条件转发到不同页面的逻辑

6. **实验 3：Session 和表单开发**
   - 用户登录验证 (`login.jsp`, `processLogin.jsp`)
   - Session 管理和生命周期演示 (`demo-session.jsp`)
   - 用户中心 (`dashboard.jsp`)
   - 表单交互演示 (`demo-form.jsp`)

7. **实验 4：Session 和 Cookie 技术**
   - 使用 Session 实现购物车系统 (`products.jsp`, `cart.jsp`, `processCart.jsp`)
   - 使用 Cookie 实现自动登录功能 (增强的 `login.jsp`, `processLogin.jsp`)
   - Cookie 生命周期演示 (`demo-cookie.jsp`)
   - Session vs Cookie 对比分析

## 项目结构

```
xiangmu/
├── css/
│   ├── style.css          # 全局样式表
│   └── login.css          # 登录页面样式
├── js/
│   ├── validation.js      # 表单验证脚本
│   └── login.js           # 登录页面脚本
├── includes/              # 公共组件
│   ├── header.jsp         # 头部导航（含购物车徽章）
│   ├── footer.jsp         # 底部版权
│   ├── static-fragment.html # 静态片段示例
│   └── dynamic-component.jsp # 动态组件示例
├── WEB-INF/
│   ├── web.xml            # 配置文件
│   └── classes/
│       └── com/example/model/
│           └── CartItem.java  # 购物车商品 JavaBean
├── index.jsp              # 项目首页（导航中心）
├── register.jsp           # 用户注册页面
├── processRegister.jsp    # 注册处理页面
├── login.jsp              # 用户登录页面（含自动登录）
├── processLogin.jsp       # 登录处理页面（含 Cookie 管理）
├── logout.jsp             # 登出处理页面
├── dashboard.jsp          # 用户中心
├── products.jsp           # 商品列表页面
├── cart.jsp               # 购物车页面
├── processCart.jsp        # 购物车操作处理
├── demo-session.jsp       # Session 演示
├── demo-cookie.jsp        # Cookie 演示
├── demo-include.jsp       # Include 动作演示
├── demo-forward.jsp       # Forward 动作演示
├── demo-form.jsp          # 表单演示
├── success.jsp            # 操作成功页面
├── hello.jsp              # Hello World 示例
└── README.md              # 项目文档
```


## 运行指南

1. **环境要求**
   - JDK 1.8+
   - Tomcat 7.0+
   - 支持 JSP 2.0+ 的 Web 容器

2. **部署方式**
   - 将 `xiangmu` 文件夹直接复制到 Tomcat 的 `webapps` 目录下
   - 或者使用 Maven 打包为 WAR 包进行部署

3. **访问地址**
   - 启动 Tomcat 后，访问：`http://localhost:8080/xiangmu/`

## 核心代码说明

### 1. 页面包含
```jsp
<jsp:include page="includes/header.jsp" />
```

### 2. 页面转发
```jsp
<jsp:forward page="success.jsp">
    <jsp:param name="msg" value="操作成功" />
</jsp:forward>
```

### 3. 表单处理
```java
request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username");
```

### 4. Session 购物车
```java
// 获取或创建购物车
Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
if (cart == null) {
    cart = new HashMap<>();
    session.setAttribute("cart", cart);
}

// 添加商品
CartItem item = new CartItem(id, name, price, 1, image);
cart.put(id, item);
```

### 5. Cookie 自动登录
```java
// 保存 Cookie
Cookie usernameCookie = new Cookie("autoLoginUsername", username);
usernameCookie.setMaxAge(7 * 24 * 60 * 60); // 7 天
usernameCookie.setPath(request.getContextPath() + "/");
response.addCookie(usernameCookie);

// 读取 Cookie
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("autoLoginUsername".equals(cookie.getName())) {
            String savedUsername = URLDecoder.decode(cookie.getValue(), "UTF-8");
        }
    }
}
```

## 实验要点

### Session 技术
- **存储位置**: 服务器端
- **数据类型**: 任意 Java 对象
- **生命周期**: 默认 30 分钟不活动后失效
- **典型应用**: 用户登录状态、购物车数据

### Cookie 技术
- **存储位置**: 客户端浏览器
- **数据类型**: 字符串
- **大小限制**: 单个 Cookie 最大 4KB
- **典型应用**: 记住用户名、用户偏好设置、自动登录

## 技术亮点

1. **完整的购物车系统**: 使用 Session 实现商品增删改查，支持数量调整和总价计算
2. **自动登录功能**: 使用 Cookie 保存加密凭证，实现 7 天免登录
3. **Session vs Cookie 对比**: 详细的对比表格和实际应用场景
4. **现代化 UI 设计**: 使用 CSS3 渐变、阴影、动画效果
5. **JavaBean 封装**: CartItem 类封装购物车商品属性和方法
6. **完善的错误处理**: 表单验证、异常处理、友好的错误提示
