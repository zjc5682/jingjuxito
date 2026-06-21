<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加用户 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div class="form-page">
        <div class="form-card-lg">
            <div class="form-card-title">
                <span class="material-symbols-outlined">person_add</span>
                添加新用户
            </div>
            <form action="AdminUserServlet?method=add" method="post">
                <div class="form-group">
                    <label><span class="material-symbols-outlined">person</span>账号 *</label>
                    <input type="text" name="username" placeholder="请输入账号" required>
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">lock</span>密码 *</label>
                    <input type="password" name="password" placeholder="请输入密码" value="123456" required>
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">badge</span>姓名</label>
                    <input type="text" name="name" placeholder="请输入姓名">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">phone</span>手机号</label>
                    <input type="tel" name="phone" placeholder="请输入手机号">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">email</span>邮箱</label>
                    <input type="email" name="email" placeholder="请输入邮箱">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">star</span>初始积分</label>
                    <input type="number" name="score" value="100">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">shield_person</span>角色</label>
                    <select name="role">
                        <option value="0">普通用户</option>
                        <option value="1">管理员</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-success">
                        <span class="material-symbols-outlined">person_add</span>添加用户
                    </button>
                    <a href="AdminUserServlet?method=list" class="btn btn-neutral">
                        <span class="material-symbols-outlined">arrow_back</span>返回列表
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
