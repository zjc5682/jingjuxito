<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑用户 - 管理员后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background: #f5f5f5;
            padding: 30px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .card-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .card-header h2 {
            color: #b71c1c;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            font-size: 14px;
        }
        .form-group input:focus {
            outline: none;
            border-color: #b71c1c;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }
        .btn-save {
            background: #b71c1c;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-cancel {
            background: #999;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-save:hover, .btn-cancel:hover {
            opacity: 0.85;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h2>✏️ 编辑用户信息</h2>
        </div>
        <form action="AdminUserServlet?method=save" method="post">
            <input type="hidden" name="id" value="${user.id}">
            <div class="form-group">
                <label>账号</label>
                <input type="text" name="username" value="${user.username}" required>
            </div>
            <div class="form-group">
                <label>姓名</label>
                <input type="text" name="name" value="${user.name}">
            </div>
            <div class="form-group">
                <label>手机号</label>
                <input type="tel" name="phone" value="${user.phone}">
            </div>
            <div class="form-group">
                <label>邮箱</label>
                <input type="email" name="email" value="${user.email}">
            </div>
            <div class="form-group">
                <label>积分</label>
                <input type="number" name="score" value="${user.score}" required>
            </div>
            <div class="form-group">
                <label>角色</label>
                <select name="role">
                    <option value="0" ${user.role == 0 ? 'selected' : ''}>普通用户</option>
                    <option value="1" ${user.role == 1 ? 'selected' : ''}>管理员</option>
                </select>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn-save">💾 保存修改</button>
                <a href="AdminUserServlet?method=list" class="btn-cancel">↩️ 返回列表</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>