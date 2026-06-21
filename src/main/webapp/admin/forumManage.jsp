<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>论坛管理 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px;">
        <button class="mobile-toggle" onclick="parent.postMessage('toggle-sidebar','*')"><span class="material-symbols-outlined">menu</span></button>
        <div class="breadcrumb"><a href="AdminForumServlet?method=list">首页</a><span class="separator">/</span><span class="current">论坛管理</span></div>
    </div>
    <div class="page-header"><h1><span class="material-symbols-outlined icon-filled">forum</span>论坛帖子管理</h1><p>审核用户发布的帖子，管理论坛内容</p></div>

    <c:set var="pendingCount" value="0"/>
    <c:forEach items="${postList}" var="p"><c:if test="${p.status == 0}"><c:set var="pendingCount" value="${pendingCount+1}"/></c:if></c:forEach>
    <div class="stats">
        <div class="stat-card stat-red"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">forum</span></div><div class="number">${postList.size()}</div><div class="label">总帖子数</div></div>
        <div class="stat-card stat-gold"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">schedule</span></div><div class="number">${pendingCount}</div><div class="label">待审核</div></div>
        <div class="stat-card stat-green"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">check_circle</span></div><div class="number">${postList.size() - pendingCount}</div><div class="label">已处理</div></div>
    </div>

    <div class="action-bar">
        <div class="search-box"><div class="search-wrapper"><span class="material-symbols-outlined search-icon">search</span><input type="text" id="searchInput" placeholder="搜索标题、内容、用户..." onkeyup="searchPost()"></div></div>
        <div class="filter-group"><select id="statusFilter" class="filter-select" onchange="filterByStatus()"><option value="all">全部状态</option><option value="0">待审核</option><option value="1">已通过</option><option value="2">已驳回</option></select></div>
    </div>

    <div class="table-wrap">
        <table><thead><tr><th>ID</th><th>用户</th><th>标题</th><th>内容</th><th>点赞</th><th>状态</th><th>发布时间</th><th>操作</th></tr></thead>
        <tbody id="postTableBody">
        <c:forEach items="${postList}" var="p">
            <tr data-title="${p.title}" data-content="${p.content}" data-username="${p.username}" data-status="${p.status}">
                <td>${p.id}</td><td>${p.username != null ? p.username : '用户'}</td><td>${p.title}</td>
                <td class="content-preview" title="${p.content}">${p.content}</td>
                <td><span class="praise-badge"><span class="material-symbols-outlined icon-filled">favorite</span>${p.praise != null ? p.praise : 0}</span></td>
                <td><c:choose><c:when test="${p.status == 0}"><span class="badge badge-pending"><span class="material-symbols-outlined">schedule</span>待审核</span></c:when><c:when test="${p.status == 1}"><span class="badge badge-approved"><span class="material-symbols-outlined">check_circle</span>已通过</span></c:when><c:when test="${p.status == 2}"><span class="badge badge-rejected"><span class="material-symbols-outlined">cancel</span>已驳回</span></c:when></c:choose></td>
                <td><fmt:formatDate value="${p.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td class="btn-group">
                    <c:if test="${p.status == 0}">
                        <a href="AdminForumServlet?method=approve&id=${p.id}" class="btn btn-success btn-sm" onclick="return confirm('通过该帖子？')"><span class="material-symbols-outlined">check</span>通过</a>
                        <a href="AdminForumServlet?method=reject&id=${p.id}" class="btn btn-warning btn-sm" onclick="return confirm('驳回该帖子？')"><span class="material-symbols-outlined">close</span>驳回</a>
                    </c:if>
                    <a href="AdminForumServlet?method=del&id=${p.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定删除？')"><span class="material-symbols-outlined">delete</span>删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody></table>
        <div class="table-footer"><div class="record-count"><span class="material-symbols-outlined">database</span>共 <strong>${postList.size()}</strong> 条记录</div></div>
    </div>
</div>
<script>
    function searchPost(){var k=document.getElementById('searchInput').value.toLowerCase();document.querySelectorAll('#postTableBody tr').forEach(function(r){var t=r.getAttribute('data-title')||'';var c=r.getAttribute('data-content')||'';var u=r.getAttribute('data-username')||'';r.style.display=(t.includes(k)||c.includes(k)||u.includes(k)||k==='')?'':'none';});}
    function filterByStatus(){var f=document.getElementById('statusFilter').value;document.querySelectorAll('#postTableBody tr').forEach(function(r){var s=r.getAttribute('data-status');r.style.display=(f==='all'||s===f)?'':'none';});}
</script>
</body>
</html>
