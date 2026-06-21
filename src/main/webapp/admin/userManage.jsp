<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    if (request.getAttribute("userList") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/AdminUserServlet?method=list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <!-- 顶部操作栏 -->
    <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:20px;">
        <div style="display:flex; align-items:center; gap:12px;">
            <button class="mobile-toggle" onclick="parent.postMessage('toggle-sidebar','*')">
                <span class="material-symbols-outlined">menu</span>
            </button>
            <div class="breadcrumb">
                <a href="AdminUserServlet?method=list">首页</a>
                <span class="separator">/</span>
                <span class="current">用户管理</span>
            </div>
        </div>
    </div>

    <!-- 页面头部 -->
    <div class="page-header">
        <h1>
            <span class="material-symbols-outlined icon-filled">group</span>
            用户管理
        </h1>
        <p>管理平台所有用户，查看信息、编辑资料、重置密码等</p>
    </div>

    <!-- 统计卡片（多色系 + 图标背景） -->
    <div class="stats">
        <c:set var="adminCount" value="0"/>
        <c:forEach items="${userList}" var="u">
            <c:if test="${u.role == 1}"><c:set var="adminCount" value="${adminCount+1}"/></c:if>
        </c:forEach>
        <div class="stat-card stat-red">
            <div class="stat-icon"><span class="material-symbols-outlined icon-filled">group</span></div>
            <div class="number">${userList.size()}</div>
            <div class="label">总用户数</div>
        </div>
        <div class="stat-card stat-gold">
            <div class="stat-icon"><span class="material-symbols-outlined icon-filled">shield_person</span></div>
            <div class="number">${adminCount}</div>
            <div class="label">管理员</div>
        </div>
        <div class="stat-card stat-green">
            <div class="stat-icon"><span class="material-symbols-outlined icon-filled">person</span></div>
            <div class="number">${userList.size() - adminCount}</div>
            <div class="label">普通用户</div>
        </div>
    </div>

    <!-- 操作栏 -->
    <div class="action-bar">
        <div class="search-box">
            <div class="search-wrapper">
                <span class="material-symbols-outlined search-icon">search</span>
                <input type="text" id="searchInput" placeholder="搜索用户名、姓名、手机号..." onkeyup="searchUser()">
            </div>
        </div>
        <a href="AdminUserServlet?method=toAdd" class="btn btn-add">
            <span class="material-symbols-outlined">person_add</span>
            添加用户
        </a>
    </div>

    <!-- 用户表格 -->
    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>账号</th>
                <th>姓名</th>
                <th>手机号</th>
                <th>邮箱</th>
                <th>积分</th>
                <th>身份</th>
                <th>注册时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="userTableBody">
            <c:forEach items="${userList}" var="u">
                <tr data-username="${u.username}" data-name="${u.name}" data-phone="${u.phone}">
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.name != null ? u.name : '<span style="color:var(--on-surface-variant);opacity:0.5">未设置</span>'}</td>
                    <td>${u.phone != null ? u.phone : '<span style="color:var(--on-surface-variant);opacity:0.5">未填写</span>'}</td>
                    <td>${u.email != null ? u.email : '<span style="color:var(--on-surface-variant);opacity:0.5">未填写</span>'}</td>
                    <td><span class="praise-badge"><span class="material-symbols-outlined icon-filled">star</span>${u.score}</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${u.role == 1}">
                                <span class="badge badge-admin"><span class="material-symbols-outlined">shield_person</span>管理员</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-user"><span class="material-symbols-outlined">person</span>普通用户</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td class="btn-group">
                        <button class="btn btn-secondary btn-sm" onclick="viewUser(${u.id})" data-tooltip="查看详情">
                            <span class="material-symbols-outlined">visibility</span>查看
                        </button>
                        <button class="btn btn-primary btn-sm" onclick="editUser(${u.id})" data-tooltip="编辑用户">
                            <span class="material-symbols-outlined">edit</span>编辑
                        </button>
                        <button class="btn btn-warning btn-sm" onclick="resetPwd(${u.id})" data-tooltip="重置密码">
                            <span class="material-symbols-outlined">key</span>重置
                        </button>
                        <c:if test="${u.role != 1}">
                            <button class="btn btn-danger btn-sm" onclick="deleteUser(${u.id}, '${u.username}')" data-tooltip="删除用户">
                                <span class="material-symbols-outlined">delete</span>删除
                            </button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- 表格底部 -->
        <div class="table-footer">
            <div class="record-count">
                <span class="material-symbols-outlined">database</span>
                共 <strong>${userList.size()}</strong> 条记录
            </div>
        </div>
    </div>
</div>

<!-- 查看用户模态框 -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="material-symbols-outlined icon-filled">person</span>
            <h3>用户详情</h3>
        </div>
        <div class="modal-body" id="viewModalBody"></div>
        <div class="modal-footer">
            <button class="btn btn-neutral" onclick="closeModal('viewModal')">关闭</button>
        </div>
    </div>
</div>

<script>
    function searchUser() {
        var keyword = document.getElementById('searchInput').value.toLowerCase();
        var visibleCount = 0;
        var rows = document.querySelectorAll('#userTableBody tr');
        rows.forEach(function(row) {
            var username = row.getAttribute('data-username') || '';
            var name = row.getAttribute('data-name') || '';
            var phone = row.getAttribute('data-phone') || '';
            var match = username.includes(keyword) || name.includes(keyword) || phone.includes(keyword) || keyword === '';
            row.style.display = match ? '' : 'none';
            if (match) visibleCount++;
        });
    }

    function viewUser(id) {
        fetch('AdminUserServlet?method=detail&id=' + id, {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(function(response) { return response.text(); })
        .then(function(html) {
            document.getElementById('viewModalBody').innerHTML = html;
            document.getElementById('viewModal').style.display = 'flex';
        })
        .catch(function() {
            parent.showToast('error', '加载失败', '无法获取用户详情');
        });
    }

    function editUser(id) {
        window.location.href = 'AdminUserServlet?method=toEdit&id=' + id;
    }

    function resetPwd(id) {
        parent.showConfirm({
            title: '重置密码',
            message: '确定要将该用户的密码重置为 123456 吗？',
            icon: 'key',
            type: 'confirm-warning',
            okText: '确认重置'
        }).then(function(ok) {
            if (ok) window.location.href = 'AdminUserServlet?method=resetPwd&id=' + id;
        });
    }

    function deleteUser(id, username) {
        parent.showConfirm({
            title: '删除用户',
            message: '确定要删除用户「' + username + '」吗？此操作不可恢复！',
            icon: 'delete_forever',
            type: 'confirm-danger',
            okText: '确认删除'
        }).then(function(ok) {
            if (ok) window.location.href = 'AdminUserServlet?method=delete&id=' + id;
        });
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }
</script>
</body>
</html>
