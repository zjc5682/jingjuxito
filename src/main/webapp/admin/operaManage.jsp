<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>剧目管理 - 管理员后台</title>
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

        /* 新增表单卡片 */
        .form-card {
            background: white;
            border-radius: 20px;
            margin-bottom: 30px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .form-header {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            padding: 18px 25px;
            color: white;
        }

        .form-header h3 {
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-body {
            padding: 25px;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-size: 14px;
            font-weight: 600;
            color: #555;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            padding: 12px;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #b71c1c;
            box-shadow: 0 0 0 3px rgba(183, 28, 28, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .btn-submit {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 30px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(183, 28, 28, 0.3);
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

        .filter-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .filter-select {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 30px;
            font-size: 14px;
            background: white;
            cursor: pointer;
        }

        /* 剧目表格 */
        .opera-table {
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

        .type-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .type-qingyi {
            background: #e8f5e9;
            color: #4caf50;
        }

        .type-laosheng {
            background: #e3f2fd;
            color: #2196f3;
        }

        .type-hualian {
            background: #fff3e0;
            color: #ff9800;
        }

        .type-other {
            background: #f3e5f5;
            color: #9c27b0;
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

        .btn-view {
            background: #2196f3;
            color: white;
        }

        .btn-edit {
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

        /* 内容预览 */
        .content-preview {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #888;
            font-size: 13px;
        }

        /* 模态框 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            border-radius: 20px;
            max-width: 600px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }

        .modal-header {
            padding: 20px;
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
            border-radius: 20px 20px 0 0;
        }

        .modal-body {
            padding: 25px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .close-btn {
            background: #999;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
        }

        .info-row {
            display: flex;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-label {
            width: 100px;
            font-weight: 600;
            color: #666;
        }

        .info-value {
            flex: 1;
            color: #333;
        }

        /* 去重提示 */
        .duplicate-warning {
            background: #fff3e0;
            border-left: 4px solid #ff9800;
            padding: 10px 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            font-size: 13px;
            color: #e65100;
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
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面头部 -->
    <div class="page-header">
        <h1>
            <span>📖</span> 剧目管理
        </h1>
        <p>管理京剧剧目库，添加新剧目、编辑或删除现有剧目</p>
    </div>

    <!-- 统计卡片 -->
    <div class="stats">
        <div class="stat-card">
            <div class="number">${operaList.size()}</div>
            <div class="label">总剧目数</div>
        </div>
        <c:set var="qingyiCount" value="0"/>
        <c:set var="laoshengCount" value="0"/>
        <c:set var="hualianCount" value="0"/>
        <c:forEach items="${operaList}" var="o">
            <c:if test="${o.type == '青衣'}"><c:set var="qingyiCount" value="${qingyiCount+1}"/></c:if>
            <c:if test="${o.type == '老生'}"><c:set var="laoshengCount" value="${laoshengCount+1}"/></c:if>
            <c:if test="${o.type == '花脸'}"><c:set var="hualianCount" value="${hualianCount+1}"/></c:if>
        </c:forEach>
        <div class="stat-card">
            <div class="number">${qingyiCount}</div>
            <div class="label">青衣</div>
        </div>
        <div class="stat-card">
            <div class="number">${laoshengCount}</div>
            <div class="label">老生</div>
        </div>
        <div class="stat-card">
            <div class="number">${hualianCount}</div>
            <div class="label">花脸</div>
        </div>
    </div>

    <!-- 新增剧目表单 -->
    <div class="form-card">
        <div class="form-header">
            <h3>
                <span>➕</span> 新增剧目
            </h3>
        </div>
        <div class="form-body">
            <form action="AdminOperaServlet?method=add" method="post" onsubmit="return checkDuplicate()">
                <div class="form-row">
                    <div class="form-group">
                        <label>📌 剧目名称 *</label>
                        <input type="text" name="title" id="title" placeholder="请输入剧目名称" required>
                    </div>
                    <div class="form-group">
                        <label>🎭 行当分类 *</label>
                        <select name="type" id="type" required>
                            <option value="">请选择</option>
                            <option value="青衣">青衣</option>
                            <option value="老生">老生</option>
                            <option value="花脸">花脸</option>
                            <option value="花旦">花旦</option>
                            <option value="武生">武生</option>
                            <option value="丑角">丑角</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>📝 剧目简介</label>
                        <textarea name="content" id="content" placeholder="请输入剧目简介..."></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>🖼️ 图片路径</label>
                        <input type="text" name="img" value="img/default.jpg" placeholder="图片路径">
                    </div>
                </div>
                <div id="duplicateWarning" class="duplicate-warning" style="display:none;">
                    ⚠️ 该剧目名称已存在，重复添加会产生重复数据！
                </div>
                <button type="submit" class="btn-submit">✅ 添加剧目</button>
            </form>
        </div>
    </div>

    <!-- 操作栏 -->
    <div class="action-bar">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="🔍 搜索剧目名称、行当..." onkeyup="searchOpera()">
            <button onclick="searchOpera()">搜索</button>
        </div>
        <div class="filter-group">
            <select id="typeFilter" class="filter-select" onchange="filterByType()">
                <option value="all">全部行当</option>
                <option value="青衣">青衣</option>
                <option value="老生">老生</option>
                <option value="花脸">花脸</option>
                <option value="花旦">花旦</option>
                <option value="武生">武生</option>
                <option value="丑角">丑角</option>
            </select>
        </div>
    </div>

    <!-- 剧目列表 -->
    <div class="opera-table">
        <table id="operaTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>剧目名称</th>
                <th>行当分类</th>
                <th>简介</th>
                <th>点赞</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="operaTableBody">
            <c:forEach items="${operaList}" var="o">
                <tr data-title="${o.title}" data-type="${o.type}" data-id="${o.id}">
                    <td>${o.id}</td>
                    <td class="opera-title">${o.title}</td>
                    <td>
                        <c:choose>
                            <c:when test="${o.type == '青衣'}">
                                <span class="type-badge type-qingyi">🎭 ${o.type}</span>
                            </c:when>
                            <c:when test="${o.type == '老生'}">
                                <span class="type-badge type-laosheng">🎭 ${o.type}</span>
                            </c:when>
                            <c:when test="${o.type == '花脸'}">
                                <span class="type-badge type-hualian">🎭 ${o.type}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="type-badge type-other"> 🎭${o.type}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="content-preview" title="${o.content}">${o.content != null ? o.content : '暂无简介'}</td>
                    <td><span class="praise-badge">❤️ ${o.praise != null ? o.praise : 0}</span></td>
                    <td><fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td class="btn-group">
                        <button class="btn btn-view" onclick="viewOpera(${o.id})">👁️ 查看</button>
                        <button class="btn btn-edit" onclick="editOpera(${o.id})">✏️ 编辑</button>
                        <button class="btn btn-delete" onclick="deleteOpera(${o.id}, '${o.title}')">🗑 删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 查看剧目模态框 -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>📖 剧目详情</h3>
            </div>
            <div class="modal-body" id="viewModalBody">
            </div>
            <div class="modal-footer">
                <button class="close-btn" onclick="closeModal('viewModal')">关闭</button>
            </div>
        </div>
    </div>

    <!-- 编辑剧目模态框 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>✏️ 编辑剧目</h3>
            </div>
            <div class="modal-body" id="editModalBody">
            </div>
        </div>
    </div>
</div>

<script>
    // 搜索功能
    function searchOpera() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#operaTableBody tr');

        rows.forEach(row => {
            const title = row.getAttribute('data-title') || '';
            const type = row.getAttribute('data-type') || '';

            if (title.includes(keyword) || type.includes(keyword) || keyword === '') {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 按行当筛选
    function filterByType() {
        const typeFilter = document.getElementById('typeFilter').value;
        const rows = document.querySelectorAll('#operaTableBody tr');

        rows.forEach(row => {
            const type = row.getAttribute('data-type') || '';

            if (typeFilter === 'all' || type === typeFilter) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 查重
    function checkDuplicate() {
        const title = document.getElementById('title').value.trim();
        const rows = document.querySelectorAll('#operaTableBody tr');
        let duplicate = false;

        rows.forEach(row => {
            const existingTitle = row.getAttribute('data-title');
            if (existingTitle === title) {
                duplicate = true;
            }
        });

        if (duplicate) {
            const warning = document.getElementById('duplicateWarning');
            warning.style.display = 'block';
            setTimeout(() => {
                warning.style.display = 'none';
            }, 3000);
            return false; // 阻止提交，让用户确认
        }
        return true;
    }

    // 查看剧目详情
    function viewOpera(id) {
        fetch('AdminOperaServlet?method=detail&id=' + id, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.text())
            .then(html => {
                document.getElementById('viewModalBody').innerHTML = html;
                document.getElementById('viewModal').style.display = 'flex';
            })
            .catch(error => {
                alert('加载失败：' + error);
            });
    }

    // 编辑剧目
    function editOpera(id) {
        fetch('AdminOperaServlet?method=toEdit&id=' + id, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.text())
            .then(html => {
                document.getElementById('editModalBody').innerHTML = html;
                document.getElementById('editModal').style.display = 'flex';
            })
            .catch(error => {
                alert('加载失败：' + error);
            });
    }

    // 删除剧目
    function deleteOpera(id, title) {
        if (confirm('确定要删除剧目《' + title + '》吗？此操作不可恢复！')) {
            window.location.href = 'AdminOperaServlet?method=del&id=' + id;
        }
    }

    // 关闭模态框
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    // 点击模态框背景关闭
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }

    // 页面加载后移除重复数据提示的定时器
    document.addEventListener('DOMContentLoaded', function() {
        // 如果表格中有重复数据，显示提示
        const titles = new Set();
        const rows = document.querySelectorAll('#operaTableBody tr');
        let hasDuplicate = false;
        rows.forEach(row => {
            const title = row.getAttribute('data-title');
            if (titles.has(title)) {
                hasDuplicate = true;
            }
            titles.add(title);
        });
        if (hasDuplicate) {
            console.warn('检测到重复剧目数据，建议清理');
        }
    });
</script>
</body>
</html>