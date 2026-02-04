# SQLite JDBC 驱动配置说明

## 下载 SQLite JDBC 驱动

### 方法 1：从 Maven 中央仓库下载（推荐）

1. 访问：https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/
2. 选择最新版本（例如：3.45.0.0）
3. 下载 `sqlite-jdbc-3.45.0.0.jar` 文件

### 方法 2：从 GitHub 下载

1. 访问：https://github.com/xerial/sqlite-jdbc/releases
2. 下载最新版本的 JAR 文件

## 安装步骤

1. 将下载的 `sqlite-jdbc-x.x.x.x.jar` 文件复制到以下目录：
   ```
   WEB-INF/lib/
   ```

2. 如果 `WEB-INF/lib/` 目录不存在，请创建它：
   ```bash
   mkdir -p WEB-INF/lib
   ```

3. 重启 Tomcat 服务器

## 验证安装

访问 `books.jsp` 页面，如果能正常显示图书列表，说明驱动安装成功。

## 数据库文件位置

SQLite 数据库文件 `book.db` 会在首次访问 `books.jsp` 时自动创建在项目根目录。

## 示例数据

数据库初始化时会自动插入 5 本示例图书：
- Java 编程思想
- 深入理解计算机系统
- 算法导论
- 设计模式
- 代码大全

## 常见问题

### 1. ClassNotFoundException: org.sqlite.JDBC

**原因**：SQLite JDBC 驱动未正确安装

**解决方法**：
- 确认 JAR 文件已放置在 `WEB-INF/lib/` 目录
- 重启 Tomcat 服务器
- 检查 JAR 文件名是否正确

### 2. 数据库文件无法创建

**原因**：项目目录没有写入权限

**解决方法**：
- 确保 Tomcat 对项目目录有写入权限
- 或者修改 `DBInitializer.java` 中的数据库路径

### 3. 中文乱码

**原因**：编码设置不正确

**解决方法**：
- 确保所有 JSP 文件开头有：`<%@ page contentType="text/html;charset=UTF-8" language="java" %>`
- 确保 Java 文件使用 UTF-8 编码保存
- 编译时使用：`javac -encoding UTF-8`

## 技术栈

- **数据库**：SQLite 3.x
- **JDBC 驱动**：sqlite-jdbc 3.45.0.0
- **Java 版本**：Java 8+
- **Web 服务器**：Tomcat 9.0+

## 项目结构

```
WEB-INF/
├── classes/
│   └── com/
│       └── example/
│           ├── dao/
│           │   └── BookDAO.java          # 数据访问对象
│           ├── db/
│           │   └── DBConnection.java     # 数据库连接
│           ├── model/
│           │   ├── Book.java             # 图书实体类
│           │   └── CartItem.java         # 购物车项
│           └── util/
│               └── DBInitializer.java    # 数据库初始化
├── lib/
│   └── sqlite-jdbc-3.45.0.0.jar         # SQLite JDBC 驱动
└── web.xml
```

## 功能列表

✅ 图书列表展示
✅ 添加新图书
✅ 编辑图书信息
✅ 删除图书
✅ 搜索图书（按书名、作者、出版社）
✅ 库存管理
✅ 分类管理

## 数据库表结构

```sql
CREATE TABLE bookinfo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publisher VARCHAR(100),
    price DECIMAL(10, 2),
    publish_date DATE,
    isbn VARCHAR(20),
    category VARCHAR(50),
    description TEXT,
    stock INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 联系方式

如有问题，请查看项目文档或联系开发者。
