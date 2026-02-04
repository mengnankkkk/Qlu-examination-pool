<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加图书 - 图书管理系统</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            font-size: 28px;
            color: #667eea;
            margin-bottom: 10px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-row-full {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }

        .required {
            color: #f56565;
        }
    </style>
</head>

<body>
    <div class="container">
        <jsp:include page="includes/header.jsp" />

        <div class="content">
            <div class="form-container">
                <div class="form-header">
                    <h2>📖 添加新图书</h2>
                    <p style="color: #666;">填写图书信息并提交</p>
                </div>

                <form action="processBook.jsp" method="post">
                    <input type="hidden" name="action" value="add">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="title">书名 <span class="required">*</span></label>
                            <input type="text" id="title" name="title" placeholder="请输入书名" required>
                        </div>

                        <div class="form-group">
                            <label for="author">作者 <span class="required">*</span></label>
                            <input type="text" id="author" name="author" placeholder="请输入作者" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="publisher">出版社</label>
                            <input type="text" id="publisher" name="publisher" placeholder="请输入出版社">
                        </div>

                        <div class="form-group">
                            <label for="category">分类</label>
                            <select id="category" name="category">
                                <option value="编程语言">编程语言</option>
                                <option value="计算机科学">计算机科学</option>
                                <option value="算法">算法</option>
                                <option value="软件工程">软件工程</option>
                                <option value="数据库">数据库</option>
                                <option value="网络技术">网络技术</option>
                                <option value="人工智能">人工智能</option>
                                <option value="其他">其他</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">价格 (元) <span class="required">*</span></label>
                            <input type="number" id="price" name="price" step="0.01" min="0" placeholder="0.00" required>
                        </div>

                        <div class="form-group">
                            <label for="stock">库存 <span class="required">*</span></label>
                            <input type="number" id="stock" name="stock" min="0" placeholder="0" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="isbn">ISBN 编号</label>
                            <input type="text" id="isbn" name="isbn" placeholder="请输入 ISBN 编号">
                        </div>

                        <div class="form-group">
                            <label for="publishDate">出版日期</label>
                            <input type="date" id="publishDate" name="publishDate">
                        </div>
                    </div>

                    <div class="form-row-full">
                        <div class="form-group">
                            <label for="description">图书描述</label>
                            <textarea id="description" name="description" placeholder="请输入图书描述..."></textarea>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary" style="padding: 12px 40px;">
                            ✅ 提交
                        </button>
                        <a href="books.jsp" class="btn btn-secondary" style="padding: 12px 40px;">
                            ❌ 取消
                        </a>
                    </div>
                </form>
            </div>

            <div class="info-card" style="margin-top: 40px;">
                <h3>💡 表单提交说明</h3>
                <ul>
                    <li><strong>必填字段</strong>: 标有 <span class="required">*</span> 的字段为必填项</li>
                    <li><strong>数据验证</strong>: 表单提交前会进行客户端验证</li>
                    <li><strong>处理流程</strong>: 提交后由 processBook.jsp 处理，使用 BookDAO 插入数据库</li>
                    <li><strong>重定向</strong>: 添加成功后自动跳转到图书列表页面</li>
                </ul>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
    </div>
</body>

</html>
