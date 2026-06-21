<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="AdminOperaServlet?method=update" method="post">
    <input type="hidden" name="id" value="${opera.id}">
    <input type="hidden" name="img" id="editImgPath" value="${opera.img}">
    <div class="form-group">
        <label><span class="material-symbols-outlined">badge</span>剧目名称 *</label>
        <input type="text" name="title" value="${opera.title}" required>
    </div>
    <div class="form-group">
        <label><span class="material-symbols-outlined">category</span>行当分类 *</label>
        <select name="type" required>
            <option value="青衣" ${opera.type == '青衣' ? 'selected' : ''}>青衣</option>
            <option value="老生" ${opera.type == '老生' ? 'selected' : ''}>老生</option>
            <option value="花脸" ${opera.type == '花脸' ? 'selected' : ''}>花脸</option>
            <option value="花旦" ${opera.type == '花旦' ? 'selected' : ''}>花旦</option>
            <option value="武生" ${opera.type == '武生' ? 'selected' : ''}>武生</option>
            <option value="丑角" ${opera.type == '丑角' ? 'selected' : ''}>丑角</option>
        </select>
    </div>
    <div class="form-group">
        <label><span class="material-symbols-outlined">description</span>剧目简介</label>
        <textarea name="content">${opera.content}</textarea>
    </div>
    <div class="form-group">
        <label><span class="material-symbols-outlined">image</span>剧目图片</label>
        <div class="upload-area">
            <div class="upload-preview" id="editPreview">
                <c:choose>
                    <c:when test="${not empty opera.img && opera.img != 'img/default.jpg'}">
                        <img src="${opera.img}" alt="当前图片">
                    </c:when>
                    <c:otherwise>
                        <div class="placeholder"><span class="material-symbols-outlined">add_photo_alternate</span><span>预览</span></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="upload-controls">
                <label class="upload-btn" for="editFileInput"><span class="material-symbols-outlined">cloud_upload</span>更换图片</label>
                <input type="file" id="editFileInput" accept="image/*" style="display:none" onchange="uploadEditImage(this)">
                <div class="upload-hint">支持 jpg/png/gif/webp，最大 5MB</div>
                <div class="upload-file-name" id="editFileName" style="display:none"><span class="material-symbols-outlined">check_circle</span><span></span></div>
            </div>
        </div>
    </div>
    <div class="form-actions">
        <button type="submit" class="btn btn-primary"><span class="material-symbols-outlined">save</span>保存修改</button>
        <button type="button" class="btn btn-neutral" onclick="closeModal('editModal')"><span class="material-symbols-outlined">close</span>取消</button>
    </div>
</form>

<script>
function uploadEditImage(input) {
    var file = input.files[0];
    if (!file) return;
    var preview = document.getElementById('editPreview');
    var pathField = document.getElementById('editImgPath');
    var nameEl = document.getElementById('editFileName');
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
                } else { parent.showToast('error', '上传失败', result.message); input.value = ''; }
            } catch(ex) { parent.showToast('error', '上传失败', '服务器返回异常'); }
        } else { parent.showToast('error', '上传失败', 'HTTP ' + xhr.status); }
    };
    xhr.onerror = function() { parent.showToast('error', '上传失败', '网络错误'); };
    xhr.send(formData);
}
</script>
