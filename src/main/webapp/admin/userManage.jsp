<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 如果 userList 为空，重定向到 Servlet 加载数据
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
    <title>用户管理 - 管理员后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* 头部 */
        .page-header {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            border-radius: 16px;
            padding: 25px 30px;
            margin-bottom: 25px;
            color: white;
        }

        .page-header h1 {
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-header p {
            opacity: 0.9;
            margin-top: 8px;
        }

        /* 统计卡片 */
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            padding: 20px 30px;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            flex: 1;
            min-width: 150px;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
            color: #b71c1c;
        }

        .stat-card .label {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
        }

        /* 操作栏 */
        .action-bar {
            background: white;
            padding: 15px 20px;
            border-radius: 16px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-box input {
            padding: 10px 16px;
            border: 1px solid #ddd;
            border-radius: 30px;
            width: 250px;
            font-size: 14px;
        }

        .search-box input:focus {
            outline: none;
            border-color: #b71c1c;
        }

        .search-box button {
            padding: 10px 20px;
            background: #b71c1c;
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
        }

        .btn-add {
            background: #4caf50;
            color: white;
            padding: 10px 24px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-add:hover {
            background: #43a047;
        }

        /* 用户表格 */
        .user-table {
            background: white;
            border-radius: 20px;
            overflow-x: auto;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #faf5f0;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #b71c1c;
            border-bottom: 2px solid #f0e6d8;
        }

        td {
            padding: 14px 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }

        tr:hover {
            background: #faf5f0;
        }

        .role-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .role-admin {
            background: #ffebee;
            color: #c62828;
        }

        .role-user {
            background: #e8f5e9;
            color: #4caf50;
        }

        .btn-group {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            border: none;
        }

        .btn-view {
            background: #2196f3;
            color: white;
        }

        .btn-edit {
            background: #ff9800;
            color: white;
        }

        .btn-reset {
            background: #9c27b0;
            color: white;
        }

        .btn-delete {
            background: #f44336;
            color: white;
        }

        .btn:hover {
            opacity: 0.85;
            transform: translateY(-1px);
        }

        /* 模态框 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            border-radius: 20px;
            max-width: 500px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }

        .modal-header {
            padding: 20px;
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
            border-radius: 20px 20px 0 0;
        }

        .modal-body {
            padding: 25px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .close-btn {
            background: #999;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
        }

        .info-row {
            display: flex;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-label {
            width: 100px;
            font-weight: 600;
            color: #666;
        }

        .info-value {
            flex: 1;
            color: #333;
        }

        @media (max-width: 768px) {
            .action-bar {
                flex-direction: column;
            }
            .search-box {
                width: 100%;
            }
            .search-box input {
                flex: 1;
            }
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面头部 -->
    <div class="page-header">
        <h1>
            <span>👥</span> 用户管理
        </h1>
        <p>管理平台所有用户，查看信息、编辑资料、重置密码等</p>
    </div>

    <!-- 统计卡片 -->
    <div class="stats">
        <div class="stat-card">
            <div class="number">${userList.size()}</div>
            <div class="label">总用户数</div>
        </div>
        <c:set var="adminCount" value="0"/>
        <c:forEach items="${userList}" var="u">
            <c:if test="${u.role == 1}"><c:set var="adminCount" value="${adminCount+1}"/></c:if>
        </c:forEach>
        <div class="stat-card">
            <div class="number">${adminCount}</div>
            <div class="label">管理员</div>
        </div>
        <div class="stat-card">
            <div class="number">${userList.size() - adminCount}</div>
            <div class="label">普通用户</div>
        </div>
    </div>

    <!-- 操作栏 -->
    <div class="action-bar">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="🔍 搜索用户名、姓名、手机号..." onkeyup="searchUser()">
            <button onclick="searchUser()">搜索</button>
        </div>
        <a href="AdminUserServlet?method=toAdd" class="btn-add">➕ 添加用户</a>
    </div>

    <!-- 用户表格 -->
    <div class="user-table">
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
                    <td>${u.name != null ? u.name : '未设置'}</td>
                    <td>${u.phone != null ? u.phone : '未填写'}</td>
                    <td>${u.email != null ? u.email : '未填写'}</td>
                    <td>⭐ ${u.score}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.role == 1}">
                                <span class="role-badge role-admin">👑 管理员</span>
                            </c:when>
                            <c:otherwise>
                                <span class="role-badge role-user">👤 普通用户</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td class="btn-group">
                        <button class="btn btn-view" onclick="viewUser(${u.id})">👁️ 查看</button>
                        <button class="btn btn-edit" onclick="editUser(${u.id})">✏️ 编辑</button>
                        <button class="btn btn-reset" onclick="resetPwd(${u.id})">🔑 重置密码</button>
                        <c:if test="${u.role != 1}">
                            <button class="btn btn-delete" onclick="deleteUser(${u.id})">🗑 删除</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 查看用户模态框 -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>👤 用户详情</h3>
        </div>
        <div class="modal-body" id="viewModalBody">
        </div>
        <div class="modal-footer">
            <button class="close-btn" onclick="closeModal('viewModal')">关闭</button>
        </div>
    </div>
</div>

<script>
    // 搜索功能
    function searchUser() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#userTableBody tr');

        rows.forEach(row => {
            const username = row.getAttribute('data-username') || '';
            const name = row.getAttribute('data-name') || '';
            const phone = row.getAttribute('data-phone') || '';

            if (username.includes(keyword) || name.includes(keyword) || phone.includes(keyword) || keyword === '') {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 查看用户详情
    function viewUser(id) {
        fetch('AdminUserServlet?method=detail&id=' + id, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.text())
            .then(html => {
                document.getElementById('viewModalBody').innerHTML = html;
                document.getElementById('viewModal').style.display = 'flex';
            })
            .catch(error => {
                alert('加载失败：' + error);
            });
    }

    // 编辑用户
    function editUser(id) {
        window.location.href = 'AdminUserServlet?method=toEdit&id=' + id;
    }

    // 重置密码
    function resetPwd(id) {
        if (confirm('确定要将该用户的密码重置为 123456 吗？')) {
            window.location.href = 'AdminUserServlet?method=resetPwd&id=' + id;
        }
    }

    // 删除用户
    function deleteUser(id) {
        if (confirm('确定要删除该用户吗？此操作不可恢复！')) {
            window.location.href = 'AdminUserServlet?method=delete&id=' + id;
        }
    }

    // 关闭模态框
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    // 点击模态框背景关闭
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }
</script>
</body>
</html>