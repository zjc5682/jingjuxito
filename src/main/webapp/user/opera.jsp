<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经典京剧剧目 - 中华京剧文化学习平台</title>
    <style>
        :root {
            --red: #C41E3A;
            --red-dark: #8B1A2B;
            --gold: #C5963A;
            --gold-light: #D4A94E;
            --gold-pale: #E8D5A3;
            --gold-deep: #8B6914;
            --bg-warm: #FFFDF7;
            --bg-cream: #FBF7EF;
            --bg-parchment: #F5F0E5;
            --ink: #1C1410;
            --ink-soft: #3D322B;
            --ink-light: #6B5D53;
            --shadow-sm: 0 1px 3px rgba(28,20,16,0.08);
            --shadow-md: 0 4px 12px rgba(28,20,16,0.1);
            --shadow-lg: 0 8px 24px rgba(28,20,16,0.16);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Serif SC', 'STSong', 'Songti SC', serif;
            background: var(--bg-warm);
            padding: 30px;
            min-height: 100vh;
            color: var(--ink);
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--red);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .page-header p {
            color: var(--ink-light);
            font-size: 16px;
            margin-top: 8px;
        }

        .header-decoration {
            width: 80px;
            height: 2px;
            background: linear-gradient(90deg, var(--gold), transparent);
            margin: 16px auto 0;
        }

        .stats-bar {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            padding: 16px 24px;
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            box-shadow: var(--shadow-sm);
        }

        .total-count {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 16px;
            color: var(--ink-soft);
        }

        .total-count span {
            font-size: 24px;
            font-weight: 700;
            color: var(--red);
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-box input {
            padding: 10px 16px;
            border: 1px solid var(--gold-pale);
            border-radius: 6px;
            width: 250px;
            font-size: 14px;
            background: var(--bg-warm);
            color: var(--ink);
            font-family: inherit;
        }

        .search-box input::placeholder {
            color: var(--ink-light);
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--red);
            box-shadow: 0 0 0 2px rgba(197,150,58,0.25);
        }

        .search-box button {
            padding: 10px 24px;
            background: var(--red);
            color: var(--bg-warm);
            border: none;
            border-radius: 9999px;
            cursor: pointer;
            font-family: inherit;
            font-size: 14px;
            transition: all 0.3s;
        }

        .search-box button:hover {
            background: var(--red-dark);
            box-shadow: var(--shadow-md);
        }

        .opera-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .opera-card {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .opera-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .card-image {
            height: 200px;
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, var(--red), var(--red-dark));
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
            top: 12px;
            right: 12px;
            background: rgba(28,20,16,0.7);
            backdrop-filter: blur(5px);
            padding: 4px 14px;
            border-radius: 9999px;
            font-size: 12px;
            color: var(--gold-light);
            z-index: 2;
            border: 1px solid rgba(197,150,58,0.3);
        }

        .card-content {
            padding: 20px;
        }

        .opera-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .opera-title .id-badge {
            font-size: 12px;
            background: var(--bg-parchment);
            border: 1px solid var(--gold-pale);
            padding: 3px 10px;
            border-radius: 9999px;
            color: var(--ink-light);
            font-weight: normal;
        }

        .opera-desc {
            font-size: 14px;
            color: var(--ink-soft);
            line-height: 1.7;
            margin-bottom: 16px;
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
            padding-top: 12px;
            border-top: 1px solid var(--gold-pale);
        }

        .praise-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            background: none;
            border: 1px solid var(--gold-pale);
            cursor: pointer;
            padding: 6px 16px;
            border-radius: 9999px;
            transition: all 0.3s;
            font-size: 14px;
            color: var(--ink-light);
        }

        .praise-btn:hover {
            background: var(--bg-parchment);
            border-color: var(--gold);
        }

        .praise-btn .heart {
            font-size: 18px;
        }

        .praise-count {
            font-weight: 600;
            font-size: 15px;
        }

        .view-detail {
            color: var(--gold);
            text-decoration: none;
            font-size: 13px;
            transition: color 0.3s;
        }

        .view-detail:hover {
            color: var(--red-dark);
            text-decoration: underline;
        }

        .footer {
            text-align: center;
            padding: 24px;
            color: var(--ink-light);
            font-size: 13px;
        }

        .toast-message {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--ink);
            color: var(--bg-warm);
            padding: 10px 24px;
            border-radius: 9999px;
            font-size: 14px;
            z-index: 1000;
            animation: fadeOut 2s ease forwards;
            border: 1px solid var(--gold-pale);
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