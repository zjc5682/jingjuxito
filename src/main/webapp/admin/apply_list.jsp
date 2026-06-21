<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员申请审核 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px;">
        <button class="mobile-toggle" onclick="parent.postMessage('toggle-sidebar','*')"><span class="material-symbols-outlined">menu</span></button>
        <div class="breadcrumb"><a href="AdminApplyServlet?method=list">首页</a><span class="separator">/</span><span class="current">管理员申请</span></div>
    </div>
    <div class="page-header"><h1><span class="material-symbols-outlined icon-filled">assignment_ind</span>管理员申请审核</h1><p>审核用户提交的管理员权限申请</p></div>

    <div class="table-wrap">
        <c:choose>
            <c:when test="${not empty applies}">
                <table><thead><tr><th>申请人</th><th>联系方式</th><th>申请时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${applies}" var="a">
                    <tr>
                        <td><strong>${a.username}</strong></td>
                        <td>
                            <c:if test="${not empty a.phone}"><span class="material-symbols-outlined" style="font-size:16px;vertical-align:-3px;">phone</span> ${a.phone}</c:if>
                            <c:if test="${not empty a.email}"> <span class="material-symbols-outlined" style="font-size:16px;vertical-align:-3px;">email</span> ${a.email}</c:if>
                        </td>
                        <td>${a.apply_time}</td>
                        <td class="btn-group">
                            <button class="btn btn-success btn-sm" onclick="showModal('approve','${a.id}','${a.user_id}','${a.username}')"><span class="material-symbols-outlined">check</span>通过</button>
                            <button class="btn btn-danger btn-sm" onclick="showModal('reject','${a.id}','${a.user_id}','${a.username}')"><span class="material-symbols-outlined">close</span>拒绝</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody></table>
            </c:when>
            <c:otherwise>
                <div class="table-wrap"><div class="empty-state"><span class="material-symbols-outlined">mail</span><p>暂无待审核的管理员申请</p></div></div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="confirm-modal approve" id="approveModal"><div class="modal-content">
    <div class="modal-header"><div class="modal-icon"><span class="material-symbols-outlined icon-filled">check</span></div><h3>通过管理员申请</h3></div>
    <div class="modal-body"><p>确定通过 <span class="highlight" id="approveUsername"></span> 的申请？</p><p style="margin-top:8px;font-size:13px;color:var(--on-surface-variant);">系统将自动创建管理员账号，密码与原账号相同</p></div>
    <div class="modal-footer"><button class="btn btn-neutral" onclick="closeModal('approveModal')">取消</button><button class="btn btn-gold" id="approveConfirmBtn">确认通过</button></div>
</div></div>

<div class="confirm-modal reject" id="rejectModal"><div class="modal-content">
    <div class="modal-header"><div class="modal-icon"><span class="material-symbols-outlined icon-filled">close</span></div><h3>拒绝管理员申请</h3></div>
    <div class="modal-body"><p>确定拒绝 <span class="highlight" id="rejectUsername"></span> 的申请？</p><p style="margin-top:8px;font-size:13px;color:var(--on-surface-variant);">拒绝后该用户将无法再次申请</p></div>
    <div class="modal-footer"><button class="btn btn-neutral" onclick="closeModal('rejectModal')">取消</button><button class="btn btn-danger" id="rejectConfirmBtn">确认拒绝</button></div>
</div></div>

<script>
    var basePath='${pageContext.request.contextPath}';
    function showModal(type,applyId,userId,username){
        if(type==='approve'){document.getElementById('approveUsername').textContent=username;document.getElementById('approveConfirmBtn').onclick=function(){window.location.href=basePath+'/admin/AdminApplyServlet?method=approve&applyId='+applyId+'&userId='+userId;};document.getElementById('approveModal').style.display='flex';}
        else{document.getElementById('rejectUsername').textContent=username;document.getElementById('rejectConfirmBtn').onclick=function(){window.location.href=basePath+'/admin/AdminApplyServlet?method=reject&applyId='+applyId;};document.getElementById('rejectModal').style.display='flex';}
    }
    function closeModal(id){document.getElementById(id).style.display='none';}
    document.querySelectorAll('.confirm-modal').forEach(function(o){o.addEventListener('click',function(e){if(e.target===o)o.style.display='none';});});
</script>
</body>
</html>
