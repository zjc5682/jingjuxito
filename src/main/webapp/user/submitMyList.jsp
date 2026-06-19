<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${not empty mySubmits}">
        <div class="submits-list">
            <c:forEach items="${mySubmits}" var="s">
                <div class="submit-item status-${s.status}">
                    <div class="submit-header">
                        <span class="submit-title">${s.title}</span>
                        <div>
                            <c:if test="${s.isFeatured == 1}">
                                <span class="status-badge featured-badge">⭐ 优质作品</span>
                            </c:if>
                            <c:choose>
                                <c:when test="${s.status == 0}">
                                    <span class="status-badge status-pending">⏳ 待审核</span>
                                </c:when>
                                <c:when test="${s.status == 1}">
                                    <span class="status-badge status-approved">✅ 已通过</span>
                                </c:when>
                                <c:when test="${s.status == 2}">
                                    <span class="status-badge status-rejected">❌ 已驳回</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="submit-content">${s.content}</div>
                    <div class="submit-footer">
                        <span>📅 投稿时间：${s.createTime}</span>
                        <span>👀 阅读 ${s.viewCount} 次</span>
                    </div>
                    <c:if test="${not empty s.adminComment}">
                        <div class="admin-comment">
                            <strong>📢 管理员评语：</strong> ${s.adminComment}
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="empty-state">
            <div class="emoji">📭</div>
            <p>暂无投稿，快来发布你的第一篇作品吧！</p>
        </div>
    </c:otherwise>
</c:choose>