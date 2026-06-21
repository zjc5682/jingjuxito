<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>京剧剧目 - 梨园芳华</title>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- 设计系统CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jingju-design-system.css">
    <style>
        /* ===== 剧目长廊页面专属样式 ===== */

        /* 页面标题区域 - 竖向印章风格 */
        .page-header {
            margin-bottom: 0;
        }

        .page-header-title .seal {
            writing-mode: vertical-rl;
            text-orientation: upright;
            background-color: var(--primary-container);
            color: var(--on-primary);
            padding: 14px 10px;
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 700;
            letter-spacing: 0.2em;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            width: 52px;
            height: auto;
            min-height: 80px;
        }

        .page-header h1 {
            font-family: var(--font-headline);
            font-size: var(--text-display-lg);
            font-weight: 700;
            color: var(--on-surface);
            letter-spacing: 0.1em;
            margin-bottom: 8px;
        }

        .page-header p {
            font-size: var(--text-body-lg);
            color: var(--on-surface-variant);
            line-height: 1.6;
        }

        /* 顶部标题行布局 - 标题与搜索并排 */
        .opera-header-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 32px;
            margin-bottom: 48px;
            flex-wrap: wrap;
        }

        /* 搜索框 - 金色边框风格 */
        .header-search {
            position: relative;
            width: 320px;
            flex-shrink: 0;
        }

        .header-search input {
            width: 100%;
            padding: 12px 16px 12px 48px;
            border: 1px solid #D4AF37;
            border-radius: var(--radius-full);
            font-size: var(--text-body-md);
            font-family: var(--font-body);
            background: #FFFBF5;
            color: var(--on-surface);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        }

        .header-search input::placeholder {
            color: var(--on-surface-variant);
            opacity: 0.6;
        }

        .header-search input:focus {
            outline: none;
            border-color: var(--primary-container);
            box-shadow: 0 0 0 3px rgba(204, 0, 0, 0.1);
        }

        .header-search .material-symbols-outlined {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #D4AF37;
            font-size: 22px;
            transition: color 0.3s ease;
        }

        .header-search:focus-within .material-symbols-outlined {
            color: var(--primary-container);
        }

        /* 筛选按钮 - 金色描边风格 */
        .filter-group {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 48px;
        }

        .filter-btn {
            padding: 10px 28px;
            font-size: var(--text-label-md);
            font-weight: 600;
            border: 2px solid #D4AF37;
            border-radius: var(--radius-full);
            background: transparent;
            color: var(--on-surface);
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 0.05em;
        }

        .filter-btn:hover {
            background: rgba(115, 92, 0, 0.05);
        }

        .filter-btn.active {
            background-color: var(--primary);
            color: var(--on-primary);
            border-color: var(--primary);
            box-shadow: var(--shadow-sm);
            transform: translateY(-2px);
        }

        /* 统计栏 */
        .stats-bar {
            background-color: var(--surface-container-low);
            border-radius: var(--radius-xl);
            padding: 16px 24px;
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            border: 1px solid var(--outline-variant);
            box-shadow: var(--shadow-sm);
        }

        .total-count {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: var(--text-body-md);
            color: var(--on-surface-variant);
        }

        .total-count strong {
            font-size: var(--text-headline-md);
            color: var(--primary);
        }

        .search-container {
            display: flex;
            gap: 12px;
        }

        .search-container input {
            padding: 10px 16px;
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-full);
            width: 280px;
            font-size: var(--text-body-md);
            background: var(--surface);
            color: var(--on-surface);
            font-family: var(--font-body);
            transition: all 0.3s ease;
        }

        .search-container input::placeholder {
            color: var(--on-surface-variant);
            opacity: 0.6;
        }

        .search-container input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(158, 0, 0, 0.1);
        }

        /* 剧目网格 - 支持Bento风格 */
        .opera-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-gutter);
            margin-bottom: 48px;
        }

        /* 第一张卡片跨2列 - 大剧目展示 */
        .opera-card:first-child {
            grid-column: span 2;
        }

        /* 剧目卡片 */
        .opera-card {
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            overflow: hidden;
            border: 1px solid var(--surface-container);
            box-shadow: 0 4px 20px rgba(204, 0, 0, 0.06);
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
        }

        .opera-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(204, 0, 0, 0.12);
            border-color: rgba(212, 175, 55, 0.3);
        }

        /* 卡片图片区域 */
        .card-image {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, var(--primary), var(--primary-container));
        }

        /* 第一张卡片 - 16:9 宽幅比例 */
        .opera-card:first-child .card-image {
            aspect-ratio: 16 / 9;
        }

        /* 其他卡片 - 3:4 竖版比例 */
        .opera-card:not(:first-child) .card-image {
            aspect-ratio: 3 / 4;
        }

        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.7s ease;
        }

        .opera-card:hover .card-image img {
            transform: scale(1.05);
        }

        /* 第一张卡片渐变遮罩 */
        .opera-card:first-child .card-image::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(51, 48, 42, 0.8), transparent);
            pointer-events: none;
        }

        /* 角标 - 行当标签 */
        .opera-type {
            position: absolute;
            top: 12px;
            right: 12px;
            background: var(--primary);
            padding: 4px 14px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 700;
            color: var(--on-primary);
            z-index: 2;
            letter-spacing: 0.05em;
        }

        /* 第一张卡片标题覆盖在图片上 */
        .opera-card:first-child .card-image .card-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 24px;
            z-index: 2;
        }

        .opera-card:first-child .card-overlay .opera-overlay-title {
            font-family: var(--font-headline);
            font-size: var(--text-headline-lg);
            font-weight: 600;
            color: #fff;
            margin-bottom: 8px;
        }

        .opera-card:first-child .card-overlay .opera-overlay-desc {
            font-size: var(--text-body-md);
            color: rgba(255, 255, 255, 0.85);
            line-height: 1.6;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .opera-card:first-child .card-overlay .opera-overlay-type {
            display: inline-block;
            padding: 4px 12px;
            background: var(--primary);
            color: var(--on-primary);
            font-size: 12px;
            font-weight: 700;
            border-radius: var(--radius-full);
            margin-bottom: 8px;
            margin-right: 8px;
        }

        .opera-card:first-child .card-overlay .opera-overlay-meta {
            color: var(--secondary-container, #fed65b);
            font-size: var(--text-label-md);
            font-weight: 600;
        }

        /* 卡片内容区域 */
        .card-content {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        /* 金色装饰线 - 内容区顶部 */
        .opera-card:not(:first-child) .card-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 16px;
            right: 16px;
            height: 1px;
            background: linear-gradient(90deg, transparent, #D4AF37, transparent);
            opacity: 0.5;
        }

        .opera-title {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: var(--on-surface);
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
        }

        .opera-title .id-badge {
            font-size: 12px;
            background: var(--surface-container);
            border: 1px solid var(--outline-variant);
            padding: 4px 12px;
            border-radius: var(--radius-full);
            color: var(--on-surface-variant);
            font-weight: normal;
            font-family: var(--font-body);
        }

        .opera-desc {
            font-size: var(--text-body-md);
            color: var(--on-surface-variant);
            line-height: 1.7;
            margin-bottom: 16px;
            min-height: 48px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* 底部交互区 */
        .praise-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 16px;
            border-top: 1px solid var(--outline-variant);
            margin-top: auto;
        }

        .praise-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            background: none;
            border: 1px solid var(--outline-variant);
            cursor: pointer;
            padding: 8px 16px;
            border-radius: var(--radius-full);
            transition: all 0.3s ease;
            font-size: var(--text-label-md);
            color: var(--on-surface-variant);
            font-family: var(--font-body);
        }

        .praise-btn:hover {
            background: var(--surface-container);
            border-color: var(--primary);
            color: var(--primary);
        }

        .praise-btn .material-symbols-outlined {
            font-size: 20px;
        }

        .view-detail {
            color: var(--secondary);
            text-decoration: none;
            font-size: var(--text-label-md);
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .view-detail:hover {
            color: var(--primary);
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 64px;
            background: var(--surface-container-high);
            border-radius: var(--radius-xl);
            border: 1px solid var(--outline-variant);
            position: relative;
            overflow: hidden;
        }

        .empty-state .material-symbols-outlined {
            font-size: 80px;
            color: var(--outline-variant);
            margin-bottom: 24px;
        }

        .empty-state p {
            color: var(--on-surface-variant);
            font-size: var(--text-body-lg);
        }

        /* 底部提示 */
        .footer-hint {
            text-align: center;
            padding: 24px;
            color: var(--on-surface-variant);
            font-size: var(--text-body-md);
        }

        /* 提示框 */
        .toast-message {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--inverse-surface);
            color: var(--inverse-on-surface);
            padding: 12px 24px;
            border-radius: var(--radius-full);
            font-size: var(--text-body-md);
            z-index: 1000;
            animation: fadeOut 2s ease forwards;
            border: 1px solid var(--secondary-container);
        }

        @keyframes fadeOut {
            0% { opacity: 1; transform: translateX(-50%) translateY(0); }
            70% { opacity: 1; }
            100% { opacity: 0; transform: translateX(-50%) translateY(20px); }
        }

        /* 金色装饰分割线 */
        .gold-hairline {
            height: 1px;
            background: linear-gradient(90deg, transparent, #D4AF37, transparent);
            border: none;
            margin: 32px 0;
        }

        /* ===== 响应式 ===== */
        @media (max-width: 1024px) {
            .opera-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .opera-card:first-child {
                grid-column: span 2;
            }
            .opera-header-row {
                flex-direction: column;
                gap: 24px;
            }
            .header-search {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .opera-grid {
                grid-template-columns: 1fr;
            }
            .opera-card:first-child {
                grid-column: span 1;
            }
            .opera-card:first-child .card-image {
                aspect-ratio: 16 / 9;
            }
            .stats-bar {
                flex-direction: column;
            }
            .search-container {
                width: 100%;
            }
            .search-container input {
                flex: 1;
                width: auto;
            }
            .page-header h1 {
                font-size: var(--text-display-lg-mobile);
            }
            .filter-group {
                gap: 10px;
            }
            .filter-btn {
                padding: 8px 18px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="app-layout">
    <!-- 侧边导航栏 -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ccircle cx='50' cy='50' r='50' fill='%239e0000'/%3E%3Ctext x='50' y='65' font-size='40' fill='white' text-anchor='middle' font-family='serif'%3E梨%3C/text%3E%3C/svg%3E" alt="梨园芳华">
            </div>
            <div class="sidebar-brand">梨园芳华</div>
            <div class="sidebar-tagline">传承国粹 极尽精微</div>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=toHome">
                <span class="material-symbols-outlined">home</span>
                <span>首页</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserOperaServlet?method=list" class="active">
                <span class="material-symbols-outlined">theaters</span>
                <span>京剧剧目</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserForumServlet?method=list">
                <span class="material-symbols-outlined">forum</span>
                <span>戏曲论坛</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserShopServlet?method=list">
                <span class="material-symbols-outlined">local_mall</span>
                <span>积分商城</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserSubmitServlet?method=toSubmit">
                <span class="material-symbols-outlined">publish</span>
                <span>作品投稿</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=toPersonal">
                <span class="material-symbols-outlined">person</span>
                <span>个人中心</span>
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/user/UserSubmitServlet?method=toSubmit" class="btn btn-primary w-full">
                <span class="material-symbols-outlined">edit_square</span>
                即刻投稿
            </a>
        </div>
    </aside>

    <!-- 主内容区 -->
    <div class="main-content">
        <!-- 顶部导航栏（移动端） -->
        <header class="top-nav">
            <button onclick="toggleSidebar()" style="background:none;border:none;color:var(--on-surface);cursor:pointer;">
                <span class="material-symbols-outlined">menu</span>
            </button>
            <span class="top-nav-brand">梨园芳华</span>
            <div class="top-nav-actions">
                <span class="material-symbols-outlined" style="color:var(--on-surface-variant);cursor:pointer;">search</span>
                <div class="avatar">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 40 40'%3E%3Ccircle cx='20' cy='20' r='20' fill='%23e0d9d0'/%3E%3Ctext x='20' y='26' font-size='16' fill='%23926e69' text-anchor='middle'%3E用%3C/text%3E%3C/svg%3E" alt="头像">
                </div>
            </div>
        </header>

        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 页面标题 + 搜索框并排 -->
            <div class="opera-header-row">
                <div class="page-header">
                    <div class="page-header-title">
                        <div class="seal">经典</div>
                        <div>
                            <h1>京剧剧目馆</h1>
                            <p>探索百年流芳的生旦净丑经典大戏，品味国粹艺术之精妙绝伦。</p>
                        </div>
                    </div>
                </div>
                <div class="header-search">
                    <input type="text" id="searchInput" placeholder="搜索剧名、流派或演员..." onkeyup="filterOperas()">
                    <span class="material-symbols-outlined">search</span>
                </div>
            </div>

            <!-- 筛选标签 -->
            <div class="filter-group">
                <button class="filter-btn active" onclick="filterByType('', this)">全部</button>
                <button class="filter-btn" onclick="filterByType('生', this)">生 (Sheng)</button>
                <button class="filter-btn" onclick="filterByType('旦', this)">旦 (Dan)</button>
                <button class="filter-btn" onclick="filterByType('净', this)">净 (Jing)</button>
                <button class="filter-btn" onclick="filterByType('丑', this)">丑 (Chou)</button>
            </div>

            <hr class="gold-hairline">

            <!-- 统计栏 -->
            <div class="stats-bar">
                <div class="total-count">
                    <span class="material-symbols-outlined" style="color:var(--primary);">theaters</span>
                    共收录 <strong>${operaList.size()}</strong> 部经典剧目
                </div>
                <div class="search-container">
                    <button class="btn btn-primary" onclick="filterOperas()">
                        <span class="material-symbols-outlined">search</span>
                        搜索
                    </button>
                </div>
            </div>

            <!-- 剧目网格 -->
            <div class="opera-grid" id="operaGrid">
                <c:forEach items="${operaList}" var="o" varStatus="status">
                    <div class="opera-card" data-title="${o.title}" data-type="${o.type}">
                        <div class="card-image">
                            <img src="${o.img}" alt="${o.title}" onerror="this.style.display='none'">
                            <div class="opera-type">${o.type}</div>
                            <!-- 第一张卡片的覆盖层标题 -->
                            <c:if test="${status.first}">
                                <div class="card-overlay">
                                    <span class="opera-overlay-type">${o.type}</span>
                                    <h3 class="opera-overlay-title">${o.title}</h3>
                                    <p class="opera-overlay-desc">${o.content != null ? o.content : '暂无简介'}</p>
                                </div>
                            </c:if>
                        </div>
                        <div class="card-content">
                            <div class="opera-title">
                                ${o.title}
                                <span class="id-badge">#${o.id}</span>
                            </div>
                            <div class="opera-desc line-clamp-3">
                                ${o.content != null ? o.content : '暂无简介'}
                            </div>
                            <div class="praise-section">
                                <button class="praise-btn" onclick="addPraise(${o.id}, this)">
                                    <span class="material-symbols-outlined">favorite</span>
                                    <span class="praise-count">${o.praise != null ? o.praise : 0}</span>
                                </button>
                                <a href="#" class="view-detail" onclick="viewDetail(${o.id}); return false;">
                                    探索详情
                                    <span class="material-symbols-outlined" style="font-size:18px;">arrow_forward</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 空状态 -->
            <c:if test="${empty operaList}">
                <div class="empty-state">
                    <span class="material-symbols-outlined">theater_comedy</span>
                    <p>暂无剧目数据，请先添加剧目</p>
                </div>
            </c:if>

            <!-- 底部提示 -->
            <div class="footer-hint">
                <span class="material-symbols-outlined" style="vertical-align:middle;color:var(--primary);">favorite</span>
                点击红心为喜爱的剧目点赞 | 传承国粹，弘扬中华优秀传统文化
            </div>
        </div>

        <!-- 页脚 -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-brand">梨园芳华</div>
                <div class="footer-links">
                    <a href="#">关于我们</a>
                    <a href="#">版权声明</a>
                    <a href="#">非遗合作</a>
                    <a href="#">联系我们</a>
                </div>
                <div class="footer-copyright">
                    © 2024 梨园芳华 文化传承平台. All Rights Reserved. 沪ICP备12345678号
                </div>
            </div>
        </footer>
    </div>
</div>

<script>
    // 切换侧边栏
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }

    // 点击内容区域关闭侧边栏（移动端）
    document.querySelector('.main-content').addEventListener('click', function() {
        if (window.innerWidth <= 1024) {
            document.getElementById('sidebar').classList.remove('open');
        }
    });

    // 按行当筛选
    let currentType = '';
    function filterByType(type, btn) {
        currentType = type;
        // 更新按钮状态
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        filterOperas();
    }

    // 搜索筛选
    function filterOperas() {
        const keyword = document.getElementById('searchInput').value.toLowerCase();
        const cards = document.querySelectorAll('.opera-card');
        let visibleCount = 0;

        cards.forEach(card => {
            const title = card.getAttribute('data-title').toLowerCase();
            const type = card.getAttribute('data-type').toLowerCase();
            const matchKeyword = title.includes(keyword) || type.includes(keyword) || keyword === '';
            const matchType = currentType === '' || type.includes(currentType.toLowerCase());

            if (matchKeyword && matchType) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        document.querySelector('.total-count strong').innerText = visibleCount;
    }

    // 点赞
    function addPraise(id, btn) {
        fetch('UserOperaServlet?method=praise&id=' + id)
            .then(() => {
                const countSpan = btn.querySelector('.praise-count');
                let current = parseInt(countSpan.innerText);
                countSpan.innerText = (isNaN(current) ? 0 : current) + 1;
                btn.querySelector('.material-symbols-outlined').style.color = 'var(--primary)';
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
