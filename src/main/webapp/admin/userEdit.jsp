<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑用户 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div class="form-page">
        <div class="form-card-lg">
            <div class="form-card-title">
                <span class="material-symbols-outlined">edit</span>
                编辑用户信息
            </div>
            <form action="AdminUserServlet?method=save" method="post">
                <input type="hidden" name="id" value="${user.id}">
                <div class="form-group">
                    <label><span class="material-symbols-outlined">person</span>账号</label>
                    <input type="text" name="username" value="${user.username}" required>
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">badge</span>姓名</label>
                    <input type="text" name="name" value="${user.name}">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">phone</span>手机号</label>
                    <input type="tel" name="phone" value="${user.phone}">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">email</span>邮箱</label>
                    <input type="email" name="email" value="${user.email}">
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">star</span>积分</label>
                    <input type="number" name="score" value="${user.score}" required>
                </div>
                <div class="form-group">
                    <label><span class="material-symbols-outlined">shield_person</span>角色</label>
                    <select name="role">
                        <option value="0" ${user.role == 0 ? 'selected' : ''}>普通用户</option>
                        <option value="1" ${user.role == 1 ? 'selected' : ''}>管理员</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <span class="material-symbols-outlined">save</span>保存修改
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
