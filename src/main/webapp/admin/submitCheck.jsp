<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>投稿审核 - 管理员后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        h2 {
            color: #b71c1c;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* 统计卡片 */
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            padding: 20px 30px;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            text-align: center;
            flex: 1;
            min-width: 120px;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
            color: #b71c1c;
        }

        .stat-card .label {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
        }

        /* 筛选标签 */
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 20px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            background: white;
        }

        .filter-btn.active {
            background: #b71c1c;
            color: white;
        }

        /* 投稿卡片网格 */
        .submits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 20px;
        }

        .submit-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
        }

        .submit-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            padding: 18px 20px;
            background: linear-gradient(135deg, #faf5f0, #f5f0e8);
            border-bottom: 1px solid #eee;
        }

        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .card-meta {
            display: flex;
            gap: 15px;
            font-size: 12px;
            color: #888;
        }

        .card-content {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }

        .card-content p {
            color: #555;
            line-height: 1.6;
            font-size: 14px;
            max-height: 100px;
            overflow-y: auto;
        }

        .card-footer {
            padding: 15px 20px;
            background: #fafafa;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: space-between;
            align-items: center;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 12px;
            border-radius: 30px;
            font-size: 12px;
        }

        .status-pending {
            background: #fff3e0;
            color: #ff9800;
        }

        .status-approved {
            background: #e8f5e9;
            color: #4caf50;
        }

        .status-rejected {
            background: #ffebee;
            color: #f44336;
        }

        .featured-badge {
            background: linear-gradient(135deg, #ffd700, #ffb300);
            color: #5d4037;
        }

        .btn-group {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 6px 14px;
            border: none;
            border-radius: 20px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-approve {
            background: #4caf50;
            color: white;
        }

        .btn-reject {
            background: #ff9800;
            color: white;
        }

        .btn-featured {
            background: #ffd700;
            color: #5d4037;
        }

        .btn-unfeatured {
            background: #9e9e9e;
            color: white;
        }

        .btn-delete {
            background: #f44336;
            color: white;
        }

        .btn:hover {
            opacity: 0.85;
            transform: translateY(-1px);
        }

        .admin-comment-form {
            margin-top: 10px;
            display: flex;
            gap: 8px;
        }

        .admin-comment-form input {
            flex: 1;
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 12px;
        }

        .comment-display {
            font-size: 12px;
            color: #666;
            background: #f0f0f0;
            padding: 6px 10px;
            border-radius: 10px;
            margin-top: 8px;
        }

        /* 响应式 */
        @media (max-width: 800px) {
            .submits-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>
        <span>📋</span> 投稿审核管理
    </h2>

    <!-- 统计卡片 -->
    <div class="stats">
        <div class="stat-card">
            <div class="number">${submitList.size()}</div>
            <div class="label">总投稿数</div>
        </div>
        <div class="stat-card">
            <c:set var="pendingCount" value="0"/>
            <c:forEach items="${submitList}" var="s">
                <c:if test="${s.status == 0}"><c:set var="pendingCount" value="${pendingCount+1}"/></c:if>
            </c:forEach>
            <div class="number">${pendingCount}</div>
            <div class="label">待审核</div>
        </div>
        <div class="stat-card">
            <c:set var="featuredCount" value="0"/>
            <c:forEach items="${submitList}" var="s">
                <c:if test="${s.isFeatured == 1}"><c:set var="featuredCount" value="${featuredCount+1}"/></c:if>
            </c:forEach>
            <div class="number">${featuredCount}</div>
            <div class="label">优质作品</div>
        </div>
    </div>

    <!-- 筛选标签 -->
    <div class="filter-tabs">
        <button class="filter-btn active" data-filter="all">全部</button>
        <button class="filter-btn" data-filter="0">待审核</button>
        <button class="filter-btn" data-filter="1">已通过</button>
        <button class="filter-btn" data-filter="2">已驳回</button>
    </div>

    <!-- 投稿列表 -->
    <div class="submits-grid" id="submitsGrid">
        <c:forEach items="${submitList}" var="s">
            <div class="submit-card" data-status="${s.status}">
                <div class="card-header">
                    <div class="card-title">
                            ${s.title}
                        <div>
                            <c:if test="${s.isFeatured == 1}">
                                <span class="status-badge featured-badge">⭐ 优质</span>
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
                    <div class="card-meta">
                        <span>👤 ${s.userRealName != null ? s.userRealName : s.username}</span>
                        <span>📅 ${s.createTime}</span>
                        <span>👀 ${s.viewCount} 阅读</span>
                    </div>
                </div>
                <div class="card-content">
                    <p>${s.content}</p>
                </div>
                <div class="card-footer">
                    <div class="btn-group">
                        <c:if test="${s.status == 0}">
                            <a href="AdminSubmitServlet?method=approve&id=${s.id}" class="btn btn-approve" onclick="return confirm('通过该投稿？')">✓ 通过</a>
                            <a href="AdminSubmitServlet?method=reject&id=${s.id}" class="btn btn-reject" onclick="return confirm('驳回该投稿？')">✗ 驳回</a>
                        </c:if>
                        <c:if test="${s.status == 1}">
                            <c:choose>
                                <c:when test="${s.isFeatured == 1}">
                                    <a href="AdminSubmitServlet?method=unfeature&id=${s.id}" class="btn btn-unfeatured" onclick="return confirm('取消优质评选？')">☆ 取消优质</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="AdminSubmitServlet?method=feature&id=${s.id}" class="btn btn-featured" onclick="return confirm('设为优质作品？')">⭐ 设为优质</a>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <a href="AdminSubmitServlet?method=del&id=${s.id}" class="btn btn-delete" onclick="return confirm('确定删除？')">🗑 删除</a>
                    </div>
                </div>
                <c:if test="${not empty s.adminComment}">
                    <div class="comment-display" style="margin:0 20px 15px 20px">
                        💬 评语：${s.adminComment}
                    </div>
                </c:if>
                <div style="padding:0 20px 15px 20px">
                    <form action="AdminSubmitServlet?method=comment&id=${s.id}" method="post" style="display:flex; gap:8px;">
                        <input type="text" name="comment" placeholder="添加管理员评语..." style="flex:1; padding:6px 12px; border:1px solid #ddd; border-radius:20px;">
                        <button type="submit" style="background:#b71c1c; color:white; border:none; padding:6px 15px; border-radius:20px; cursor:pointer;">发布评语</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    // 筛选功能
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            const filter = this.getAttribute('data-filter');
            const cards = document.querySelectorAll('.submit-card');

            cards.forEach(card => {
                if (filter === 'all' || card.getAttribute('data-status') === filter) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
</script>
</body>
</html>