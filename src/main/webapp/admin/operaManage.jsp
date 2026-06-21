<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>剧目管理 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px;">
        <button class="mobile-toggle" onclick="parent.postMessage('toggle-sidebar','*')"><span class="material-symbols-outlined">menu</span></button>
        <div class="breadcrumb"><a href="AdminOperaServlet?method=list">首页</a><span class="separator">/</span><span class="current">剧目管理</span></div>
    </div>

    <div class="page-header">
        <h1><span class="material-symbols-outlined icon-filled">theater_comedy</span>剧目管理</h1>
        <p>管理京剧剧目库，添加新剧目、编辑或删除现有剧目</p>
    </div>

    <c:set var="qingyiCount" value="0"/><c:set var="laoshengCount" value="0"/><c:set var="hualianCount" value="0"/>
    <c:forEach items="${operaList}" var="o">
        <c:if test="${o.type == '青衣'}"><c:set var="qingyiCount" value="${qingyiCount+1}"/></c:if>
        <c:if test="${o.type == '老生'}"><c:set var="laoshengCount" value="${laoshengCount+1}"/></c:if>
        <c:if test="${o.type == '花脸'}"><c:set var="hualianCount" value="${hualianCount+1}"/></c:if>
    </c:forEach>

    <div class="stats">
        <div class="stat-card stat-red"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">theater_comedy</span></div><div class="number">${operaList.size()}</div><div class="label">总剧目数</div></div>
        <div class="stat-card stat-gold"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">category</span></div><div class="number">${qingyiCount}</div><div class="label">青衣</div></div>
        <div class="stat-card stat-blue"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">category</span></div><div class="number">${laoshengCount}</div><div class="label">老生</div></div>
        <div class="stat-card stat-purple"><div class="stat-icon"><span class="material-symbols-outlined icon-filled">category</span></div><div class="number">${hualianCount}</div><div class="label">花脸</div></div>
    </div>

    <!-- 新增剧目表单 -->
    <div class="form-card">
        <div class="form-card-header">
            <span class="material-symbols-outlined">add_circle</span>
            <h3>新增剧目</h3>
        </div>
        <div class="form-card-body">
            <form action="AdminOperaServlet?method=add" method="post" onsubmit="return checkDuplicate()">
                <div class="form-row">
                    <div class="form-group">
                        <label><span class="material-symbols-outlined">badge</span>剧目名称 *</label>
                        <input type="text" name="title" id="title" placeholder="请输入剧目名称" required>
                    </div>
                    <div class="form-group">
                        <label><span class="material-symbols-outlined">category</span>行当分类 *</label>
                        <select name="type" id="type" required>
                            <option value="">请选择</option>
                            <option value="青衣">青衣</option><option value="老生">老生</option><option value="花脸">花脸</option>
                            <option value="花旦">花旦</option><option value="武生">武生</option><option value="丑角">丑角</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group"><label><span class="material-symbols-outlined">description</span>剧目简介</label><textarea name="content" placeholder="请输入剧目简介..."></textarea></div>
                </div>
                <input type="hidden" name="img" id="operaImgPath" value="${pageContext.request.contextPath}/img/default.jpg">
                <div class="form-row">
                    <div class="form-group">
                        <label><span class="material-symbols-outlined">image</span>剧目图片</label>
                        <div class="upload-area">
                            <div class="upload-preview" id="operaPreview">
                                <div class="placeholder"><span class="material-symbols-outlined">add_photo_alternate</span><span>预览</span></div>
                            </div>
                            <div class="upload-controls">
                                <label class="upload-btn" for="operaFileInput"><span class="material-symbols-outlined">cloud_upload</span>选择图片</label>
                                <input type="file" id="operaFileInput" accept="image/*" style="display:none" onchange="uploadImage(this,'operaPreview','operaImgPath','operaFileName')">
                                <div class="upload-hint">支持 jpg/png/gif/webp，最大 5MB</div>
                                <div class="upload-file-name" id="operaFileName" style="display:none"><span class="material-symbols-outlined">check_circle</span><span></span></div>
                                <div class="upload-progress" id="operaProgress"><div class="upload-progress-bar" id="operaProgressBar"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="duplicateWarning" class="warning" style="display:none;margin-bottom:16px;">
                    <span class="material-symbols-outlined">warning</span>该剧目名称已存在
                </div>
                <button type="submit" class="btn btn-primary"><span class="material-symbols-outlined">add</span>添加剧目</button>
            </form>
        </div>
    </div>

    <div class="action-bar">
        <div class="search-box">
            <div class="search-wrapper">
                <span class="material-symbols-outlined search-icon">search</span>
                <input type="text" id="searchInput" placeholder="搜索剧目名称、行当..." onkeyup="searchOpera()">
            </div>
        </div>
        <div class="filter-group">
            <select id="typeFilter" class="filter-select" onchange="filterByType()">
                <option value="all">全部行当</option>
                <option value="青衣">青衣</option><option value="老生">老生</option><option value="花脸">花脸</option>
                <option value="花旦">花旦</option><option value="武生">武生</option><option value="丑角">丑角</option>
            </select>
        </div>
    </div>

    <div class="table-wrap">
        <table id="operaTable">
            <thead><tr><th>ID</th><th>剧目名称</th><th>行当分类</th><th>简介</th><th>点赞</th><th>创建时间</th><th>操作</th></tr></thead>
            <tbody id="operaTableBody">
            <c:forEach items="${operaList}" var="o">
                <tr data-title="${o.title}" data-type="${o.type}">
                    <td>${o.id}</td><td>${o.title}</td>
                    <td>
                        <c:choose>
                            <c:when test="${o.type == '青衣'}"><span class="badge badge-qingyi">${o.type}</span></c:when>
                            <c:when test="${o.type == '老生'}"><span class="badge badge-laosheng">${o.type}</span></c:when>
                            <c:when test="${o.type == '花脸'}"><span class="badge badge-hualian">${o.type}</span></c:when>
                            <c:otherwise><span class="badge badge-other">${o.type}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td class="content-preview" title="${o.content}">${o.content != null ? o.content : '暂无简介'}</td>
                    <td><span class="praise-badge"><span class="material-symbols-outlined icon-filled">favorite</span>${o.praise != null ? o.praise : 0}</span></td>
                    <td><fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td class="btn-group">
                        <button class="btn btn-secondary btn-sm" onclick="viewOpera(${o.id})"><span class="material-symbols-outlined">visibility</span>查看</button>
                        <button class="btn btn-primary btn-sm" onclick="editOpera(${o.id})"><span class="material-symbols-outlined">edit</span>编辑</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteOpera(${o.id},'${o.title}')"><span class="material-symbols-outlined">delete</span>删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="table-footer">
            <div class="record-count"><span class="material-symbols-outlined">database</span>共 <strong>${operaList.size()}</strong> 条记录</div>
        </div>
    </div>
</div>

<div id="viewModal" class="modal"><div class="modal-content"><div class="modal-header"><span class="material-symbols-outlined icon-filled">theater_comedy</span><h3>剧目详情</h3></div><div class="modal-body" id="viewModalBody"></div><div class="modal-footer"><button class="btn btn-neutral" onclick="closeModal('viewModal')">关闭</button></div></div></div>
<div id="editModal" class="modal"><div class="modal-content"><div class="modal-header"><span class="material-symbols-outlined icon-filled">edit</span><h3>编辑剧目</h3></div><div class="modal-body" id="editModalBody"></div></div></div>

<script>
    function searchOpera(){var k=document.getElementById('searchInput').value.toLowerCase();document.querySelectorAll('#operaTableBody tr').forEach(function(r){var t=r.getAttribute('data-title')||'';var y=r.getAttribute('data-type')||'';r.style.display=(t.includes(k)||y.includes(k)||k==='')?'':'none';})}
    function filterByType(){var f=document.getElementById('typeFilter').value;document.querySelectorAll('#operaTableBody tr').forEach(function(r){var t=r.getAttribute('data-type')||'';r.style.display=(f==='all'||t==='f')?'':'none';r.style.display=(f==='all'||t===f)?'':'none';})}
    function checkDuplicate(){var t=document.getElementById('title').value.trim();var d=false;document.querySelectorAll('#operaTableBody tr').forEach(function(r){if(r.getAttribute('data-title')===t)d=true;});if(d){var w=document.getElementById('duplicateWarning');w.style.display='flex';setTimeout(function(){w.style.display='none';},3000);return false;}return true;}
    function viewOpera(id){fetch('AdminOperaServlet?method=detail&id='+id,{method:'GET',headers:{'X-Requested-With':'XMLHttpRequest'}}).then(function(r){return r.text();}).then(function(h){document.getElementById('viewModalBody').innerHTML=h;document.getElementById('viewModal').style.display='flex';}).catch(function(){parent.showToast('error','加载失败','无法获取剧目详情');});}
    function editOpera(id){fetch('AdminOperaServlet?method=toEdit&id='+id,{method:'GET',headers:{'X-Requested-With':'XMLHttpRequest'}}).then(function(r){return r.text();}).then(function(h){document.getElementById('editModalBody').innerHTML=h;document.getElementById('editModal').style.display='flex';}).catch(function(){parent.showToast('error','加载失败','无法获取编辑表单');});}
    function deleteOpera(id,title){parent.showConfirm({title:'删除剧目',message:'确定要删除剧目《'+title+'》吗？此操作不可恢复！',icon:'delete_forever',type:'confirm-danger',okText:'确认删除'}).then(function(ok){if(ok)window.location.href='AdminOperaServlet?method=del&id='+id;});}
    function closeModal(id){document.getElementById(id).style.display='none';}
    window.onclick=function(e){if(e.target.classList.contains('modal'))e.target.style.display='none';};

    // ===== 图片上传 =====
    function uploadImage(input, previewId, pathId, nameId) {
        var file = input.files[0];
        if (!file) return;

        var preview = document.getElementById(previewId);
        var pathField = document.getElementById(pathId);
        var nameEl = document.getElementById(nameId);
        var progressWrap = preview.parentElement.querySelector('.upload-progress');
        var progressBar = progressWrap ? progressWrap.querySelector('.upload-progress-bar') : null;

        // 预览
        var reader = new FileReader();
        reader.onload = function(e) {
            preview.innerHTML = '<img src="' + e.target.result + '" alt="预览">';
        };
        reader.readAsDataURL(file);

        // 上传
        var formData = new FormData();
        formData.append('file', file);

        if (progressWrap) progressWrap.classList.add('show');
        if (progressBar) progressBar.style.width = '30%';

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'UploadServlet', true);

        xhr.upload.onprogress = function(e) {
            if (e.lengthComputable && progressBar) {
                progressBar.style.width = Math.round(e.loaded / e.total * 100) + '%';
            }
        };

        xhr.onload = function() {
            if (progressWrap) progressWrap.classList.remove('show');
            if (xhr.status === 200) {
                try {
                    var result = JSON.parse(xhr.responseText);
                    if (result.success) {
                        pathField.value = result.url;
                        preview.classList.add('upload-success');
                        setTimeout(function() { preview.classList.remove('upload-success'); }, 600);
                        if (nameEl) {
                            nameEl.style.display = 'flex';
                            nameEl.querySelector('span:last-child').textContent = file.name;
                        }
                        parent.showToast('success', '上传成功', file.name);
                    } else {
                        parent.showToast('error', '上传失败', result.message);
                        input.value = '';
                    }
                } catch(ex) {
                    parent.showToast('error', '上传失败', '服务器返回异常');
                }
            } else {
                parent.showToast('error', '上传失败', 'HTTP ' + xhr.status);
            }
        };

        xhr.onerror = function() {
            if (progressWrap) progressWrap.classList.remove('show');
            parent.showToast('error', '上传失败', '网络错误');
        };

        xhr.send(formData);
    }
</script>
</body>
</html>
