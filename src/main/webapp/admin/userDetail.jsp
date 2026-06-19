<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="info-row">
    <div class="info-label">用户ID：</div>
    <div class="info-value">${user.id}</div>
</div>
<div class="info-row">
    <div class="info-label">账号：</div>
    <div class="info-value">${user.username}</div>
</div>
<div class="info-row">
    <div class="info-label">姓名：</div>
    <div class="info-value">${user.name != null ? user.name : '未设置'}</div>
</div>
<div class="info-row">
    <div class="info-label">手机号：</div>
    <div class="info-value">${user.phone != null ? user.phone : '未填写'}</div>
</div>
<div class="info-row">
    <div class="info-label">邮箱：</div>
    <div class="info-value">${user.email != null ? user.email : '未填写'}</div>
</div>
<div class="info-row">
    <div class="info-label">积分：</div>
    <div class="info-value">⭐ ${user.score}</div>
</div>
<div class="info-row">
    <div class="info-label">角色：</div>
    <div class="info-value">${user.role == 1 ? '管理员' : '普通用户'}</div>
</div>
<div class="info-row">
    <div class="info-label">注册时间：</div>
    <div class="info-value"><fmt:formatDate value="${user.createTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></div>
</div>
<div class="info-row">
    <div class="info-label">最后登录：</div>
    <div class="info-value"><fmt:formatDate value="${user.lastLoginTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></div>
</div>
