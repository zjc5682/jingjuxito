<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="info-row">
    <div class="info-label">剧目ID</div>
    <div class="info-value">${opera.id}</div>
</div>
<div class="info-row">
    <div class="info-label">剧目名称</div>
    <div class="info-value">${opera.title}</div>
</div>
<div class="info-row">
    <div class="info-label">行当分类</div>
    <div class="info-value">
        <c:choose>
            <c:when test="${opera.type == '青衣'}"><span class="badge badge-qingyi">${opera.type}</span></c:when>
            <c:when test="${opera.type == '老生'}"><span class="badge badge-laosheng">${opera.type}</span></c:when>
            <c:when test="${opera.type == '花脸'}"><span class="badge badge-hualian">${opera.type}</span></c:when>
            <c:otherwise><span class="badge badge-other">${opera.type}</span></c:otherwise>
        </c:choose>
    </div>
</div>
<div class="info-row">
    <div class="info-label">剧目简介</div>
    <div class="info-value">${opera.content != null ? opera.content : '暂无简介'}</div>
</div>
<div class="info-row">
    <div class="info-label">点赞数</div>
    <div class="info-value"><span class="praise-badge"><span class="material-symbols-outlined icon-filled">favorite</span>${opera.praise != null ? opera.praise : 0}</span></div>
</div>
<div class="info-row">
    <div class="info-label">创建时间</div>
    <div class="info-value"><fmt:formatDate value="${opera.createTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></div>
</div>
