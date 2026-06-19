<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经典京剧剧目 - 中华京剧文化学习平台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f0e8 0%, #f0ebe0 100%);
            padding: 30px;
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .page-header h1 {
            font-size: 36px;
            color: #b71c1c;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .page-header p {
            color: #666;
            font-size: 16px;
        }

        .header-decoration {
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #b71c1c, #e8b88a, #b71c1c);
            margin: 15px auto 0;
            border-radius: 3px;
        }

        .stats-bar {
            background: white;
            border-radius: 20px;
            padding: 18px 30px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .total-count {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 16px;
            color: #555;
        }

        .total-count span {
            font-size: 24px;
            font-weight: bold;
            color: #b71c1c;
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

        .opera-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .opera-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .opera-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .card-image {
            height: 200px;
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #c62828, #8b0000);
        }

        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .opera-card:hover .card-image img {
            transform: scale(1.05);
        }

        .opera-type {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(5px);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            color: #ffd700;
            z-index: 2;
        }

        .card-content {
            padding: 20px;
        }

        .opera-title {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .opera-title .id-badge {
            font-size: 12px;
            background: #f0f0f0;
            padding: 3px 10px;
            border-radius: 20px;
            color: #888;
            font-weight: normal;
        }

        .opera-desc {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 60px;
        }

        .praise-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .praise-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 8px 16px;
            border-radius: 30px;
            transition: all 0.3s;
            font-size: 15px;
            color: #888;
        }

        .praise-btn:hover {
            background: #fff0f0;
        }

        .praise-btn .heart {
            font-size: 22px;
        }

        .praise-count {
            font-weight: 600;
            font-size: 16px;
        }

        .view-detail {
            color: #b71c1c;
            text-decoration: none;
            font-size: 13px;
        }

        .footer {
            text-align: center;
            padding: 30px;
            color: #999;
            font-size: 13px;
        }

        .toast-message {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 14px;
            z-index: 1000;
            animation: fadeOut 2s ease forwards;
        }

        @keyframes fadeOut {
            0% { opacity: 1; }
            100% { opacity: 0; }
        }

        @media (max-width: 768px) {
            body { padding: 15px; }
            .opera-grid { grid-template-columns: 1fr; }
            .stats-bar { flex-direction: column; }
            .search-box { width: 100%; }
            .search-box input { flex: 1; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1><span>🪭 </span> 经典京剧剧目 <span>📖</span></h1>
        <p>传承国粹艺术 · 品味中华经典</p>
        <div class="header-decoration"></div>
    </div>

    <div class="stats-bar">
        <div class="total-count">📚 共收录 <span>${operaList.size()}</span> 部经典剧目</div>
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="🔍 搜索剧目名称、行当..." onkeyup="filterOperas()">
            <button onclick="filterOperas()">搜索</button>
        </div>
    </div>

    <div class="opera-grid" id="operaGrid">
        <c:forEach items="${operaList}" var="o">
            <div class="opera-card" data-title="${o.title}" data-type="${o.type}">
                <div class="card-image">
                    <!-- 使用绝对URL显示图片 -->
                    <img src="${o.img}" alt="${o.title}" onerror="this.style.display='none'">
                    <div class="opera-type">${o.type}</div>
                </div>
                <div class="card-content">
                    <div class="opera-title">
                            ${o.title}
                        <span class="id-badge">#${o.id}</span>
                    </div>
                    <div class="opera-desc">
                            ${o.content != null ? o.content : '暂无简介'}
                    </div>
                    <div class="praise-section">
                        <button class="praise-btn" onclick="addPraise(${o.id}, this)">
                            <span class="heart">❤️</span>
                            <span class="praise-count">${o.praise != null ? o.praise : 0}</span>
                        </button>
                        <a href="#" class="view-detail" onclick="viewDetail(${o.id}); return false;">查看详情 →</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty operaList}">
        <div class="empty-state"><div class="emoji">🪭 </div><p>暂无剧目数据，请先添加剧目</p></div>
    </c:if>

    <div class="footer"><p>❤️ 点击红心为喜爱的剧目点赞 | 传承国粹，弘扬中华优秀传统文化</p></div>
</div>

<script>
    function filterOperas() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const cards = document.querySelectorAll('.opera-card');
        let visibleCount = 0;
        cards.forEach(card => {
            const title = card.getAttribute('data-title').toLowerCase();
            const type = card.getAttribute('data-type').toLowerCase();
            if (title.includes(keyword) || type.includes(keyword) || keyword === '') {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });
        document.querySelector('.total-count span').innerText = visibleCount;
    }

    function addPraise(id, btn) {
        fetch('UserOperaServlet?method=praise&id=' + id)
            .then(() => {
                const countSpan = btn.querySelector('.praise-count');
                let current = parseInt(countSpan.innerText);
                countSpan.innerText = (isNaN(current) ? 0 : current) + 1;
                showToast('❤️ 点赞成功！');
            })
            .catch(() => showToast('点赞失败，请稍后重试'));
    }

    function showToast(msg) {
        const toast = document.createElement('div');
        toast.className = 'toast-message';
        toast.textContent = msg;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 2000);
    }

    function viewDetail(id) {
        showToast('📖 剧目详情功能开发中...');
    }
</script>
</body>
</html>