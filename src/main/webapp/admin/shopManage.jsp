<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品管理 - 梨园芳华</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px;">
        <button class="mobile-toggle" onclick="parent.postMessage('toggle-sidebar','*')"><span class="material-symbols-outlined">menu</span></button>
        <div class="breadcrumb"><a href="AdminShopServlet?method=list">首页</a><span class="separator">/</span><span class="current">商品管理</span></div>
    </div>
    <div class="page-header"><h1><span class="material-symbols-outlined icon-filled">storefront</span>商品管理</h1><p>管理积分商城商品，上下架、编辑商品信息</p></div>

    <div class="form-card">
        <div class="form-card-header"><span class="material-symbols-outlined">add_circle</span><h3>新增商品</h3></div>
        <div class="form-card-body">
            <form action="AdminShopServlet?method=add" method="post">
                <div class="form-row">
                    <div class="form-group"><label><span class="material-symbols-outlined">inventory_2</span>商品名称 *</label><input type="text" name="goodsName" required></div>
                    <div class="form-group"><label><span class="material-symbols-outlined">star</span>所需积分 *</label><input type="number" name="score" required></div>
                    <div class="form-group"><label><span class="material-symbols-outlined">warehouse</span>库存 *</label><input type="number" name="stock" required></div>
                </div>
                <div class="form-row">
                    <div class="form-group"><label><span class="material-symbols-outlined">description</span>商品描述</label><input type="text" name="description" placeholder="简单描述商品"></div>
                    <div class="form-group">
                        <label><span class="material-symbols-outlined">image</span>商品图片</label>
                        <div class="upload-area">
                            <div class="upload-preview" id="shopPreview">
                                <div class="placeholder"><span class="material-symbols-outlined">add_photo_alternate</span><span>预览</span></div>
                            </div>
                            <div class="upload-controls">
                                <label class="upload-btn" for="shopFileInput"><span class="material-symbols-outlined">cloud_upload</span>选择图片</label>
                                <input type="file" id="shopFileInput" accept="image/*" style="display:none" onchange="uploadImage(this,'shopPreview','shopImgPath','shopFileName')">
                                <div class="upload-hint">支持 jpg/png/gif/webp，最大 5MB</div>
                                <div class="upload-file-name" id="shopFileName" style="display:none"><span class="material-symbols-outlined">check_circle</span><span></span></div>
                            </div>
                        </div>
                        <input type="hidden" name="img" id="shopImgPath" value="${pageContext.request.contextPath}/img/default.jpg">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary"><span class="material-symbols-outlined">add</span>添加商品</button>
            </form>
        </div>
    </div>

    <div class="table-wrap">
        <table><thead><tr><th>ID</th><th>商品名称</th><th>所需积分</th><th>库存</th><th>状态</th><th>操作</th></tr></thead>
        <tbody>
        <c:forEach items="${goodsList}" var="g">
            <tr id="row-${g.id}">
                <td>${g.id}</td><td>${g.goodsName}</td>
                <td><span class="praise-badge"><span class="material-symbols-outlined icon-filled">star</span>${g.goodsScore}</span></td>
                <td>${g.stock}</td>
                <td><c:choose><c:when test="${g.status == 1}"><span class="badge badge-on"><span class="material-symbols-outlined">check_circle</span>上架</span></c:when><c:otherwise><span class="badge badge-off"><span class="material-symbols-outlined">cancel</span>下架</span></c:otherwise></c:choose></td>
                <td class="btn-group">
                    <c:if test="${g.status == 1}"><a href="AdminShopServlet?method=down&id=${g.id}" class="btn btn-warning btn-sm" onclick="return confirm('下架该商品？')"><span class="material-symbols-outlined">arrow_downward</span>下架</a></c:if>
                    <c:if test="${g.status == 0}"><a href="AdminShopServlet?method=up&id=${g.id}" class="btn btn-success btn-sm" onclick="return confirm('上架该商品？')"><span class="material-symbols-outlined">arrow_upward</span>上架</a></c:if>
                    <button class="btn btn-primary btn-sm" onclick="showEditForm(${g.id})"><span class="material-symbols-outlined">edit</span>编辑</button>
                    <a href="AdminShopServlet?method=del&id=${g.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定删除？')"><span class="material-symbols-outlined">delete</span>删除</a>
                </td>
            </tr>
            <tr id="edit-${g.id}" class="edit-row"><td colspan="6">
                <form action="AdminShopServlet?method=update" method="post" class="edit-inline-form">
                    <input type="hidden" name="id" value="${g.id}">
                    <input type="text" name="goodsName" value="${g.goodsName}" placeholder="商品名" required>
                    <input type="number" name="score" value="${g.goodsScore}" placeholder="积分" required style="width:80px">
                    <input type="number" name="stock" value="${g.stock}" placeholder="库存" required style="width:80px">
                    <input type="text" name="description" value="${g.description}" placeholder="描述" style="width:180px">
                    <input type="text" name="img" value="${g.img}" placeholder="图片" style="width:140px">
                    <button type="submit" class="btn btn-primary btn-sm">保存</button>
                    <button type="button" class="btn btn-neutral btn-sm" onclick="hideEditForm(${g.id})">取消</button>
                </form>
            </td></tr>
        </c:forEach>
        </tbody></table>
        <div class="table-footer"><div class="record-count"><span class="material-symbols-outlined">database</span>共 <strong>${goodsList.size()}</strong> 条记录</div></div>
    </div>
</div>
<script>
    function showEditForm(id){document.getElementById('edit-'+id).classList.add('show');}
    function hideEditForm(id){document.getElementById('edit-'+id).classList.remove('show');}

    // ===== 图片上传 =====
    function uploadImage(input, previewId, pathId, nameId) {
        var file = input.files[0];
        if (!file) return;
        var preview = document.getElementById(previewId);
        var pathField = document.getElementById(pathId);
        var nameEl = document.getElementById(nameId);
        var reader = new FileReader();
        reader.onload = function(e) { preview.innerHTML = '<img src="' + e.target.result + '" alt="预览">'; };
        reader.readAsDataURL(file);
        var formData = new FormData();
        formData.append('file', file);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'UploadServlet', true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var result = JSON.parse(xhr.responseText);
                    if (result.success) {
                        pathField.value = result.url;
                        preview.classList.add('upload-success');
                        setTimeout(function() { preview.classList.remove('upload-success'); }, 600);
                        if (nameEl) { nameEl.style.display = 'flex'; nameEl.querySelector('span:last-child').textContent = file.name; }
                        parent.showToast('success', '上传成功', file.name);
                    } else {
                        parent.showToast('error', '上传失败', result.message);
                        input.value = '';
                    }
                } catch(ex) { parent.showToast('error', '上传失败', '服务器返回异常'); }
            } else { parent.showToast('error', '上传失败', 'HTTP ' + xhr.status); }
        };
        xhr.onerror = function() { parent.showToast('error', '上传失败', '网络错误'); };
        xhr.send(formData);
    }
</script>

<%-- 操作成功/失败提示 --%>
<c:if test="${not empty sessionScope.toastMsg}">
<script>
    parent.showToast('${sessionScope.toastType}', '${sessionScope.toastMsg}', '');
</script>
<% session.removeAttribute("toastMsg"); session.removeAttribute("toastType"); %>
</c:if>
</body>
</html>
