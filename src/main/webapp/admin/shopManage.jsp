<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>商品管理 - 管理员后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }

        .container {
            max-width: 1300px;
            margin: 0 auto;
        }

        h2 {
            color: #b71c1c;
            margin-bottom: 20px;
        }

        /* 新增商品表单 */
        .add-form {
            background: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .form-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .form-group label {
            font-size: 13px;
            color: #666;
        }

        .form-group input, .form-group textarea {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .form-group input:focus, .form-group textarea:focus {
            outline: none;
            border-color: #b71c1c;
        }

        .submit-btn {
            background: #b71c1c;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 10px;
        }

        /* 商品表格 */
        .goods-table {
            background: white;
            border-radius: 16px;
            overflow-x: auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #b71c1c;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #faf5f0;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .status-on {
            background: #e8f5e9;
            color: #4caf50;
        }

        .status-off {
            background: #ffebee;
            color: #f44336;
        }

        .btn {
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
            border: none;
        }

        .btn-up {
            background: #4caf50;
            color: white;
        }

        .btn-down {
            background: #ff9800;
            color: white;
        }

        .btn-edit {
            background: #2196f3;
            color: white;
        }

        .btn-del {
            background: #f44336;
            color: white;
        }

        .btn:hover {
            opacity: 0.85;
        }

        .edit-form {
            background: #f9f7f3;
            padding: 15px;
            border-radius: 12px;
            margin-top: 10px;
            display: none;
        }

        .edit-form.show {
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🎁 商品管理</h2>

    <!-- 新增商品表单 -->
    <div class="add-form">
        <div class="form-title">➕ 新增商品</div>
        <form action="AdminShopServlet?method=add" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>商品名称</label>
                    <input type="text" name="goodsName" required>
                </div>
                <div class="form-group">
                    <label>所需积分</label>
                    <input type="number" name="score" required>
                </div>
                <div class="form-group">
                    <label>库存</label>
                    <input type="number" name="stock" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group" style="grid-column: span 2">
                    <label>商品描述</label>
                    <input type="text" name="description" placeholder="简单描述商品">
                </div>
                <div class="form-group">
                    <label>图片路径</label>
                    <input type="text" name="img" value="img/default.jpg">
                </div>
            </div>
            <button type="submit" class="submit-btn">添加商品</button>
        </form>
    </div>

    <!-- 商品列表 -->
    <div class="goods-table">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>商品名称</th>
                <th>所需积分</th>
                <th>库存</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${goodsList}" var="g">
                <tr id="row-${g.id}">
                    <td>${g.id}</td>
                    <td>${g.goodsName}</td>
                    <td>⭐ ${g.goodsScore}</td>
                    <td>${g.stock}</td>
                    <td>
                        <c:choose>
                            <c:when test="${g.status == 1}">
                                <span class="status-badge status-on">✅ 上架</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-off">⛔ 下架</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${g.status == 1}">
                            <a href="AdminShopServlet?method=down&id=${g.id}" class="btn btn-down" onclick="return confirm('下架该商品？')">下架</a>
                        </c:if>
                        <c:if test="${g.status == 0}">
                            <a href="AdminShopServlet?method=up&id=${g.id}" class="btn btn-up" onclick="return confirm('上架该商品？')">上架</a>
                        </c:if>
                        <button class="btn btn-edit" onclick="showEditForm(${g.id})">编辑</button>
                        <a href="AdminShopServlet?method=del&id=${g.id}" class="btn btn-del" onclick="return confirm('确定删除？')">删除</a>
                    </td>
                </tr>
                <tr id="edit-${g.id}" style="display:none; background:#f9f7f3">
                    <td colspan="6">
                        <form action="AdminShopServlet?method=update" method="post" style="display:flex; gap:10px; flex-wrap:wrap; padding:15px">
                            <input type="hidden" name="id" value="${g.id}">
                            <input type="text" name="goodsName" value="${g.goodsName}" placeholder="商品名" required>
                            <input type="number" name="score" value="${g.goodsScore}" placeholder="积分" required style="width:80px">
                            <input type="number" name="stock" value="${g.stock}" placeholder="库存" required style="width:80px">
                            <input type="text" name="description" value="${g.description}" placeholder="描述" style="width:200px">
                            <input type="text" name="img" value="${g.img}" placeholder="图片" style="width:150px">
                            <button type="submit" style="background:#b71c1c;color:white;border:none;padding:5px 15px;border-radius:6px">保存</button>
                            <button type="button" onclick="hideEditForm(${g.id})" style="background:#999;color:white;border:none;padding:5px 15px;border-radius:6px">取消</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function showEditForm(id) {
        document.getElementById('edit-' + id).style.display = 'table-row';
    }
    function hideEditForm(id) {
        document.getElementById('edit-' + id).style.display = 'none';
    }
</script>
</body>
</html>