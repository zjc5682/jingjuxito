<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>论坛管理 - 管理员后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* 头部 */
        .page-header {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            border-radius: 16px;
            padding: 25px 30px;
            margin-bottom: 25px;
            color: white;
        }

        .page-header h1 {
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-header p {
            opacity: 0.9;
            margin-top: 8px;
        }

        /* 统计卡片 */
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            padding: 20px 30px;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            flex: 1;
            min-width: 140px;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
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

        /* 操作栏 */
        .action-bar {
            background: white;
            padding: 15px 20px;
            border-radius: 16px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-box input {
            padding: 10px 16px;
            border: 1px solid #ddd;
            border-radius: 30px;
            width: 250px;
            font-size: 14px;
        }

        .search-box input:focus {
            outline: none;
            border-color: #b71c1c;
        }

        .search-box button {
            padding: 10px 20px;
            background: #b71c1c;
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
        }

        /* 帖子表格 */
        .post-table {
            background: white;
            border-radius: 20px;
            overflow-x: auto;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #faf5f0;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #b71c1c;
            border-bottom: 2px solid #f0e6d8;
        }

        td {
            padding: 14px 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }

        tr:hover {
            background: #faf5f0;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
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

        .praise-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #ffebee;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            color: #c62828;
        }

        .btn-group {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            border: none;
        }

        .btn-approve {
            background: #4caf50;
            color: white;
        }

        .btn-reject {
            background: #ff9800;
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

        .content-preview {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #888;
            font-size: 13px;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            .action-bar {
                flex-direction: column;
            }
            .search-box {
                width: 100%;
            }
            .search-box input {
                flex: 1;
            }
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面头部 -->
    <div class="page-header">
        <h1>
            <span>💬</span> 论坛帖子管理
        </h1>
        <p>审核用户发布的帖子，管理论坛内容</p>
    </div>

    <!-- 统计卡片 -->
    <div class="stats">
        <div class="stat-card">
            <div class="number">${postList.size()}</div>
            <div class="label">总帖子数</div>
        </div>
        <c:set var="pendingCount" value="0"/>
        <c:forEach items="${postList}" var="p">
            <c:if test="${p.status == 0}"><c:set var="pendingCount" value="${pendingCount+1}"/></c:if>
        </c:forEach>
        <div class="stat-card">
            <div class="number">${pendingCount}</div>
            <div class="label">待审核</div>
        </div>
        <div class="stat-card">
            <div class="number">${postList.size() - pendingCount}</div>
            <div class="label">已处理</div>
        </div>
    </div>

    <!-- 操作栏 -->
    <div class="action-bar">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="🔍 搜索标题、内容、用户..." onkeyup="searchPost()">
            <button onclick="searchPost()">搜索</button>
        </div>
        <div class="filter-group">
            <select id="statusFilter" class="filter-select" onchange="filterByStatus()" style="padding:8px 16px;border-radius:30px;border:1px solid #ddd;">
                <option value="all">全部状态</option>
                <option value="0">待审核</option>
                <option value="1">已通过</option>
                <option value="2">已驳回</option>
            </select>
        </div>
    </div>

    <!-- 帖子列表 -->
    <div class="post-table">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>用户</th>
                <th>标题</th>
                <th>内容</th>
                <th>点赞</th>
                <th>状态</th>
                <th>发布时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="postTableBody">
            <c:forEach items="${postList}" var="p">
                <tr data-title="${p.title}" data-content="${p.content}" data-username="${p.username}" data-status="${p.status}">
                    <td>${p.id}</td>
                    <td>${p.username != null ? p.username : '用户'} </td>
                    <td>${p.title}</td>
                    <td class="content-preview" title="${p.content}">${p.content}</td>
                    <td><span class="praise-badge">❤️ ${p.praise != null ? p.praise : 0}</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${p.status == 0}">
                                <span class="status-badge status-pending">⏳ 待审核</span>
                            </c:when>
                            <c:when test="${p.status == 1}">
                                <span class="status-badge status-approved">✅ 已通过</span>
                            </c:when>
                            <c:when test="${p.status == 2}">
                                <span class="status-badge status-rejected">❌ 已驳回</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${p.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="btn-group">
                        <c:if test="${p.status == 0}">
                            <a href="AdminForumServlet?method=approve&id=${p.id}" class="btn btn-approve" onclick="return confirm('通过该帖子？')">✓ 通过</a>
                            <a href="AdminForumServlet?method=reject&id=${p.id}" class="btn btn-reject" onclick="return confirm('驳回该帖子？')">✗ 驳回</a>
                        </c:if>
                        <a href="AdminForumServlet?method=del&id=${p.id}" class="btn btn-delete" onclick="return confirm('确定删除？')">🗑 删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    // 搜索功能
    function searchPost() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#postTableBody tr');

        rows.forEach(row => {
            const title = row.getAttribute('data-title') || '';
            const content = row.getAttribute('data-content') || '';
            const username = row.getAttribute('data-username') || '';

            if (title.includes(keyword) || content.includes(keyword) || username.includes(keyword) || keyword === '') {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 按状态筛选
    function filterByStatus() {
        const statusFilter = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('#postTableBody tr');

        rows.forEach(row => {
            const status = row.getAttribute('data-status');

            if (statusFilter === 'all' || status === statusFilter) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
</script>
</body>
</html>