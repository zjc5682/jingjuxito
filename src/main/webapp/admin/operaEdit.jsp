<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .edit-form-group {
        margin-bottom: 18px;
    }
    .edit-form-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        color: #555;
        margin-bottom: 6px;
    }
    .edit-form-group input,
    .edit-form-group textarea,
    .edit-form-group select {
        width: 100%;
        padding: 10px;
        border: 1.5px solid #e5e7eb;
        border-radius: 10px;
        font-size: 14px;
    }
    .edit-form-group input:focus,
    .edit-form-group textarea:focus,
    .edit-form-group select:focus {
        outline: none;
        border-color: #b71c1c;
    }
    .edit-form-group textarea {
        resize: vertical;
        min-height: 80px;
    }
    .edit-btn-group {
        display: flex;
        gap: 12px;
        margin-top: 20px;
    }
    .btn-save {
        background: #b71c1c;
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 25px;
        cursor: pointer;
    }
    .btn-cancel {
        background: #999;
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 25px;
        cursor: pointer;
    }
</style>

<form action="AdminOperaServlet?method=update" method="post">
    <input type="hidden" name="id" value="${opera.id}">
    <div class="edit-form-group">
        <label>剧目名称 *</label>
        <input type="text" name="title" value="${opera.title}" required>
    </div>
    <div class="edit-form-group">
        <label>行当分类 *</label>
        <select name="type" required>
            <option value="青衣" ${opera.type == '青衣' ? 'selected' : ''}>青衣</option>
            <option value="老生" ${opera.type == '老生' ? 'selected' : ''}>老生</option>
            <option value="花脸" ${opera.type == '花脸' ? 'selected' : ''}>花脸</option>
            <option value="花旦" ${opera.type == '花旦' ? 'selected' : ''}>花旦</option>
            <option value="武生" ${opera.type == '武生' ? 'selected' : ''}>武生</option>
            <option value="丑角" ${opera.type == '丑角' ? 'selected' : ''}>丑角</option>
        </select>
    </div>
    <div class="edit-form-group">
        <label>剧目简介</label>
        <textarea name="content">${opera.content}</textarea>
    </div>
    <div class="edit-form-group">
        <label>图片路径</label>
        <input type="text" name="img" value="${opera.img}">
    </div>
    <div class="edit-btn-group">
        <button type="submit" class="btn-save">💾 保存修改</button>
        <button type="button" class="btn-cancel" onclick="closeModal('editModal')">取消</button>
    </div>
</form>