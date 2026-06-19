<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${not empty growthRecords}">
        <table class="growth-table">
            <thead>
            <tr>
                <th>时间</th>
                <th>类型</th>
                <th>事件</th>
                <th>积分变化</th>
                <th>备注</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${growthRecords}" var="record">
                <tr>
                    <td><fmt:formatDate value="${record.time}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${record.type}</td>
                    <td>${record.event}</td>
                    <td class="${record.scoreChange > 0 ? 'score-plus' : 'score-minus'}">
                            ${record.scoreChange > 0 ? '+' : ''}${record.scoreChange}
                    </td>
                    <td>${record.remark}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <div class="empty-state">
            <div class="emoji">📊</div>
            <p>暂无成长记录</p>
            <p style="font-size: 13px; margin-top: 10px;">参与论坛交流、投稿、兑换商品都会产生记录</p>
        </div>
    </c:otherwise>
</c:choose>