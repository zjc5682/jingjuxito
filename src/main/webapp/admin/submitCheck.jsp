<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>投稿审核 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px;">
        <button class="mobile-toggle" onclick="parent.postMessage('toggle-sidebar','*')"><span class="material-symbols-outlined">menu</span></button>
        <div class="breadcrumb"><a href="AdminSubmitServlet?method=list">首页</a><span class="separator">/</span><span class="current">投稿审核</span></div>
    </div>
    <div class="page-header"><h1><span class="material-symbols-outlined icon-filled">rate_review</span>投稿审核管理</h1><p>审核用户投稿内容，管理优质作品评选</p></div>

    <c:set var="pendingCount" value="0"/><c:set var="featuredCount" value="0"/>
    <c:forEach items="${submitList}" var="s">
        <c:if test="${s.status == 0}"><c:set var="pendingCount" value="${pendingCount+1}"/></c:if>
        <c:if test="${s.isFeatured == 1}"><c:set var="featuredCount" value="${featuredCount+1}"/></c:if>
    </c:forEach>
    <div class="stats">
        <div class="stat-card stat-red"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">rate_review</span></div><div class="number">${submitList.size()}</div><div class="label">总投稿数</div></div>
        <div class="stat-card stat-gold"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">schedule</span></div><div class="number">${pendingCount}</div><div class="label">待审核</div></div>
        <div class="stat-card stat-green"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">star</span></div><div class="number">${featuredCount}</div><div class="label">优质作品</div></div>
    </div>

    <div class="filter-tabs">
        <button class="filter-tab active" data-filter="all">全部</button>
        <button class="filter-tab" data-filter="0">待审核</button>
        <button class="filter-tab" data-filter="1">已通过</button>
        <button class="filter-tab" data-filter="2">已驳回</button>
    </div>

    <div class="card-grid" id="submitsGrid">
        <c:forEach items="${submitList}" var="s">
            <div class="submit-card" data-status="${s.status}">
                <div class="submit-card-header">
                    <div class="submit-card-title">
                        ${s.title}
                        <div>
                            <c:if test="${s.isFeatured == 1}"><span class="badge badge-featured"><span class="material-symbols-outlined icon-filled">star</span>优质</span></c:if>
                            <c:choose>
                                <c:when test="${s.status == 0}"><span class="badge badge-pending"><span class="material-symbols-outlined">schedule</span>待审核</span></c:when>
                                <c:when test="${s.status == 1}"><span class="badge badge-approved"><span class="material-symbols-outlined">check_circle</span>已通过</span></c:when>
                                <c:when test="${s.status == 2}"><span class="badge badge-rejected"><span class="material-symbols-outlined">cancel</span>已驳回</span></c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="submit-card-meta">
                        <span><span class="material-symbols-outlined">person</span> ${s.userRealName != null ? s.userRealName : s.username}</span>
                        <span><span class="material-symbols-outlined">calendar_today</span> ${s.createTime}</span>
                        <span><span class="material-symbols-outlined">visibility</span> ${s.viewCount} 阅读</span>
                    </div>
                </div>
                <div class="submit-card-body"><p>${s.content}</p></div>
                <div class="submit-card-footer">
                    <div class="btn-group">
                        <c:if test="${s.status == 0}">
                            <a href="AdminSubmitServlet?method=approve&id=${s.id}" class="btn btn-success btn-sm" onclick="return confirm('通过该投稿？')"><span class="material-symbols-outlined">check</span>通过</a>
                            <a href="AdminSubmitServlet?method=reject&id=${s.id}" class="btn btn-warning btn-sm" onclick="return confirm('驳回该投稿？')"><span class="material-symbols-outlined">close</span>驳回</a>
                        </c:if>
                        <c:if test="${s.status == 1}">
                            <c:choose>
                                <c:when test="${s.isFeatured == 1}"><a href="AdminSubmitServlet?method=unfeature&id=${s.id}" class="btn btn-neutral btn-sm" onclick="return confirm('取消优质评选？')"><span class="material-symbols-outlined">star</span>取消优质</a></c:when>
                                <c:otherwise><a href="AdminSubmitServlet?method=feature&id=${s.id}" class="btn btn-gold btn-sm" onclick="return confirm('设为优质作品？')"><span class="material-symbols-outlined icon-filled">star</span>设为优质</a></c:otherwise>
                            </c:choose>
                        </c:if>
                        <a href="AdminSubmitServlet?method=del&id=${s.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定删除？')"><span class="material-symbols-outlined">delete</span>删除</a>
                    </div>
                </div>
                <c:if test="${not empty s.adminComment}">
                    <div class="admin-comment"><span class="material-symbols-outlined">chat</span>评语：${s.adminComment}</div>
                </c:if>
                <div class="comment-form">
                    <input type="text" placeholder="添加管理员评语...">
                    <a href="AdminSubmitServlet?method=comment&id=${s.id}" class="btn btn-primary btn-sm" onclick="this.href='AdminSubmitServlet?method=comment&id=${s.id}&comment='+encodeURIComponent(this.previousElementSibling.value)"><span class="material-symbols-outlined">send</span>发布</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    document.querySelectorAll('.filter-tab').forEach(function(btn){btn.addEventListener('click',function(){document.querySelectorAll('.filter-tab').forEach(function(b){b.classList.remove('active');});this.classList.add('active');var f=this.getAttribute('data-filter');document.querySelectorAll('.submit-card').forEach(function(c){c.style.display=(f==='all'||c.getAttribute('data-status')===f)?'block':'none';});});});
</script>
</body>
</html>
