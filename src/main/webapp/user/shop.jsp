<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>积分商城 - 梨园芳华</title>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- 设计系统CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jingju-design-system.css">
    <style>
        /* ============================================
           积分商城页面样式 - 琳琅阁风格
           ============================================ */

        /* 金色发丝线装饰（底部） */
        .gold-hairline-bottom {
            position: relative;
        }
        .gold-hairline-bottom::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 1px;
            background: linear-gradient(to right, transparent, #D4AF37, transparent);
        }

        /* 页面标题区域重构 */
        .page-header {
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .page-header-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 24px;
        }

        .page-header-left {
            flex: 1;
        }

        .page-header-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .page-header-title .seal {
            width: 32px;
            height: 32px;
            min-width: 32px;
            background-color: var(--primary-container);
            color: var(--on-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-headline);
            font-size: 16px;
            font-weight: 700;
            border-radius: var(--radius-sm);
            box-shadow: 0 1px 3px rgba(0,0,0,0.15);
            writing-mode: vertical-rl;
        }

        .page-header h1 {
            font-family: var(--font-headline);
            font-size: var(--text-display-lg);
            font-weight: 700;
            color: var(--on-surface);
            letter-spacing: 0.1em;
            margin: 0;
        }

        .page-header > p,
        .page-header-desc {
            font-size: var(--text-body-lg);
            color: var(--on-surface-variant);
            max-width: 640px;
            line-height: 1.6;
            margin-top: 16px;
        }

        /* 积分显示卡片（浅色风格，设计稿样式） */
        .score-card {
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            border: 1px solid var(--outline-variant);
            box-shadow: 0 2px 12px rgba(0,0,0,0.05);
            padding: 20px 28px;
            display: flex;
            align-items: center;
            gap: 24px;
            flex-shrink: 0;
        }

        .score-card-text-right {
            text-align: right;
        }

        .score-card-label {
            font-size: var(--text-label-md);
            color: var(--on-surface-variant);
            font-weight: 600;
            letter-spacing: 0.05em;
            margin-bottom: 4px;
        }

        .score-card-value {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 700;
            color: var(--primary);
            line-height: 1.2;
        }

        .score-card-divider {
            width: 1px;
            height: 40px;
            background-color: var(--outline-variant);
            flex-shrink: 0;
        }

        .score-detail-btn {
            font-size: var(--text-label-md);
            font-weight: 600;
            color: var(--primary);
            border: 1px solid var(--primary);
            background: transparent;
            padding: 8px 20px;
            border-radius: var(--radius-full);
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
            letter-spacing: 0.05em;
            text-decoration: none;
            font-family: var(--font-body);
        }

        .score-detail-btn:hover {
            background-color: var(--primary-container);
            color: var(--on-primary);
        }

        /* 筛选按钮组 */
        .shop-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 32px;
            margin-bottom: 0;
        }

        .shop-filter-btn {
            padding: 10px 28px;
            font-size: var(--text-label-md);
            font-weight: 600;
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-full);
            background: var(--surface-container-lowest);
            color: var(--on-surface);
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: var(--font-body);
            letter-spacing: 0.05em;
        }

        .shop-filter-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        .shop-filter-btn.active {
            background-color: var(--primary);
            color: var(--on-primary);
            border-color: var(--primary);
            box-shadow: 0 2px 8px rgba(158, 0, 0, 0.2);
        }

        /* 商品网格 */
        .goods-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: var(--spacing-gutter);
            margin-top: 48px;
        }

        /* 商品卡片 - 琳琅阁风格 */
        .goods-card {
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            overflow: hidden;
            border: 1px solid var(--surface-container);
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .goods-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px -5px rgba(204, 0, 0, 0.06), 0 8px 10px -6px rgba(204, 0, 0, 0.04);
        }

        /* 商品图片区域 */
        .goods-img {
            height: auto;
            aspect-ratio: 4 / 3;
            background-color: var(--surface-container-low);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 16px;
        }

        .goods-img .traditional-border {
            border: 1px solid #D4AF37;
            padding: 4px;
            background-color: #fff;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .goods-img .emoji {
            font-size: 64px;
            filter: drop-shadow(2px 4px 8px rgba(0, 0, 0, 0.15));
        }

        .goods-img .traditional-border .emoji {
            font-size: 64px;
        }

        .goods-score-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: rgba(26, 26, 46, 0.8);
            backdrop-filter: blur(8px);
            padding: 6px 14px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 600;
            color: var(--secondary-container);
            border: 1px solid rgba(212, 175, 55, 0.3);
            display: flex;
            align-items: center;
            gap: 4px;
            z-index: 5;
        }

        /* 商品信息 */
        .goods-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            border-top: 1px solid rgba(232, 189, 182, 0.3);
        }

        .goods-name {
            font-family: var(--font-headline);
            font-size: 20px;
            font-weight: 600;
            color: var(--on-surface);
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .goods-desc {
            font-size: var(--text-body-md);
            color: var(--on-surface-variant);
            line-height: 1.6;
            margin-bottom: 16px;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .goods-stock {
            font-size: var(--text-label-md);
            color: var(--on-surface-variant);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .stock-low {
            color: #e6a817;
            font-weight: 600;
        }

        .stock-out {
            color: var(--error);
            font-weight: 600;
        }

        /* 底部操作行 */
        .goods-action-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
            padding-top: 12px;
        }

        .goods-score-display {
            display: flex;
            align-items: center;
            gap: 4px;
            color: var(--primary);
        }

        .goods-score-display .material-symbols-outlined {
            font-size: 20px;
            font-variation-settings: 'FILL' 1;
        }

        .goods-score-num {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 700;
            color: var(--primary);
        }

        /* 底部操作行 */
        .exchange-btn {
            color: var(--primary);
            font-size: var(--text-label-md);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 4px;
            cursor: pointer;
            transition: color 0.3s ease;
            background: none;
            border: none;
            padding: 0;
            font-family: var(--font-body);
            letter-spacing: 0.05em;
        }

        .exchange-btn:hover:not(:disabled) {
            color: var(--primary-container);
        }

        .exchange-btn:disabled {
            color: var(--outline);
            cursor: not-allowed;
            opacity: 0.7;
        }

        .exchange-btn .material-symbols-outlined {
            font-size: 16px;
        }

        /* 提示消息 */
        .alert {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 14px 20px;
            border-radius: var(--radius-lg);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            animation: slideDown 0.3s ease, fadeOut 3s ease 2s forwards;
            box-shadow: var(--shadow-md);
        }

        .alert-error {
            background: #ffebee;
            border-color: #ffcdd2;
            color: var(--error);
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateX(-50%) translateY(-20px); }
            to { opacity: 1; transform: translateX(-50%) translateY(0); }
        }

        @keyframes fadeOut {
            to { opacity: 0; visibility: hidden; }
        }

        /* 加载动画 */
        .loading {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid var(--on-primary);
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 64px;
            background-color: var(--surface-container-low);
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-xl);
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
        .shop-footer-tip {
            text-align: center;
            padding: 48px 0 24px;
            color: var(--on-surface-variant);
            font-size: var(--text-body-md);
        }

        .shop-footer-tip .material-symbols-outlined {
            vertical-align: middle;
            color: var(--primary);
            font-variation-settings: 'FILL' 1;
        }

        /* ============================================
           响应式
           ============================================ */
        @media (max-width: 1200px) {
            .goods-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 1024px) {
            .page-header-top {
                flex-direction: column;
                align-items: flex-start;
            }
            .score-card {
                margin-top: 20px;
                width: 100%;
            }
        }

        @media (max-width: 900px) {
            .goods-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: var(--text-display-lg-mobile);
            }
            .goods-grid {
                grid-template-columns: 1fr;
            }
            .score-card {
                flex-direction: column;
                text-align: center;
                gap: 16px;
            }
            .score-card-divider {
                width: 40px;
                height: 1px;
            }
            .score-card-text-right {
                text-align: center;
            }
            .shop-filters {
                gap: 8px;
            }
            .shop-filter-btn {
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
            <a href="${pageContext.request.contextPath}/user/UserOperaServlet?method=list">
                <span class="material-symbols-outlined">theaters</span>
                <span>京剧剧目</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserForumServlet?method=list">
                <span class="material-symbols-outlined">forum</span>
                <span>戏曲论坛</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserShopServlet?method=list" class="active">
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
            <!-- 页面标题区域 + 积分卡片（设计稿布局） -->
            <div class="page-header gold-hairline-bottom" style="margin-bottom: 48px; padding-bottom: 24px;">
                <div class="page-header-top">
                    <div class="page-header-left">
                        <div class="page-header-title">
                            <div class="seal">商城</div>
                            <h1>积分商城</h1>
                        </div>
                        <p class="page-header-desc">精选戏曲周边、定制戏服与文化典籍。用您的梨园积分兑换一份独具匠心的文化传承。</p>
                    </div>
                    <!-- 积分卡片（浅色风格） -->
                    <div class="score-card">
                        <div class="score-card-text-right">
                            <p class="score-card-label">当前积分</p>
                            <p class="score-card-value" id="userScore">${loginUser.score}</p>
                        </div>
                        <div class="score-card-divider"></div>
                        <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=toPersonal" class="score-detail-btn">积分明细</a>
                    </div>
                </div>

                <!-- 筛选按钮组 -->
                <div class="shop-filters">
                    <button class="shop-filter-btn active">全部商品</button>
                    <button class="shop-filter-btn">定制戏服</button>
                    <button class="shop-filter-btn">文创折扇</button>
                    <button class="shop-filter-btn">文化典籍</button>
                    <button class="shop-filter-btn">剧场票务</button>
                </div>
            </div>

            <!-- 商品列表 -->
            <c:choose>
                <c:when test="${empty goodsList}">
                    <div class="empty-state" style="margin-top:48px;">
                        <span class="material-symbols-outlined">shopping_bag</span>
                        <p>暂无商品，敬请期待！</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="goods-grid" id="goodsGrid">
                        <c:forEach items="${goodsList}" var="g">
                            <div class="goods-card" data-id="${g.id}">
                                <div class="goods-img">
                                    <div class="traditional-border">
                                        <div class="emoji">
                                            <c:choose>
                                                <c:when test="${g.goodsName.contains('书签')}">🔖</c:when>
                                                <c:when test="${g.goodsName.contains('明信片')}">📮</c:when>
                                                <c:when test="${g.goodsName.contains('折扇')}">🎐</c:when>
                                                <c:when test="${g.goodsName.contains('书籍')}">📚</c:when>
                                                <c:when test="${g.goodsName.contains('摆件')}">🏺</c:when>
                                                <c:when test="${g.goodsName.contains('笔记本')}">📓</c:when>
                                                <c:when test="${g.goodsName.contains('日历')}">📅</c:when>
                                                <c:otherwise>🎁</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="goods-score-badge">
                                        <span class="material-symbols-outlined" style="font-size:18px;">stars</span>
                                        ${g.goodsScore} 积分
                                    </div>
                                </div>
                                <div class="goods-info">
                                    <div class="goods-name">${g.goodsName}</div>
                                    <div class="goods-desc line-clamp-2">${g.description != null ? g.description : '京剧主题文创产品'}</div>
                                    <div class="goods-stock">
                                        <span class="material-symbols-outlined" style="font-size:18px;">inventory_2</span>
                                        库存：
                                        <c:choose>
                                            <c:when test="${g.stock <= 0}">
                                                <span class="stock-out">已售罄</span>
                                            </c:when>
                                            <c:when test="${g.stock <= 10}">
                                                <span class="stock-low">仅剩 ${g.stock} 件</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${g.stock} 件
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="goods-action-row">
                                        <div class="goods-score-display">
                                            <span class="material-symbols-outlined">stars</span>
                                            <span class="goods-score-num">${g.goodsScore}</span>
                                        </div>
                                        <button class="exchange-btn"
                                                data-id="${g.id}"
                                                data-score="${g.goodsScore}"
                                                data-stock="${g.stock}"
                                                <c:if test="${g.stock <= 0 || loginUser.score < g.goodsScore}">disabled</c:if>>
                                            <c:choose>
                                                <c:when test="${g.stock <= 0}">
                                                    已售罄 <span class="material-symbols-outlined">inventory_2</span>
                                                </c:when>
                                                <c:when test="${loginUser.score < g.goodsScore}">
                                                    积分不足 <span class="material-symbols-outlined">stars</span>
                                                </c:when>
                                                <c:otherwise>
                                                    立即兑换 <span class="material-symbols-outlined">arrow_forward</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- 底部提示 -->
            <div class="shop-footer-tip">
                <span class="material-symbols-outlined">favorite</span>
                用心传承国粹 · 用积分兑换好礼
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
                    &copy; 2024 梨园芳华 文化传承平台. All Rights Reserved. 沪ICP备12345678号
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

    // 显示提示消息
    function showMessage(msg, isError) {
        const oldAlert = document.querySelector('.alert');
        if (oldAlert) oldAlert.remove();

        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert ' + (isError ? 'alert-error' : '');
        alertDiv.innerHTML = `<span class="material-symbols-outlined">${isError ? 'warning' : 'check_circle'}</span> ${msg}`;
        document.body.appendChild(alertDiv);

        setTimeout(() => {
            if (alertDiv) alertDiv.remove();
        }, 3000);
    }

    // 更新页面上的积分显示
    function updateScore(newScore) {
        const scoreElement = document.getElementById('userScore');
        if (scoreElement) {
            scoreElement.innerText = newScore;
        }
    }

    // 兑换功能
    document.querySelectorAll('.exchange-btn').forEach(btn => {
        btn.addEventListener('click', async function(e) {
            e.preventDefault();

            if (this.disabled) return;

            const goodsId = this.getAttribute('data-id');
            const originalText = this.innerHTML;

            this.disabled = true;
            this.innerHTML = '<span class="loading"></span> 处理中...';

            try {
                const response = await fetch('UserShopServlet?method=exchange&gid=' + goodsId, {
                    method: 'GET',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                });

                const text = await response.text();
                let msg = '';
                let isError = true;

                if (text.includes('兑换成功')) {
                    isError = false;
                    msg = '兑换成功！';
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                } else if (text.includes('积分不足')) {
                    msg = '积分不足，无法兑换';
                } else if (text.includes('库存不足')) {
                    msg = '库存不足';
                } else {
                    msg = '兑换失败，请稍后重试';
                }

                showMessage(msg, isError);

                if (!isError) {
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                } else {
                    this.disabled = false;
                    this.innerHTML = originalText;
                }

            } catch (error) {
                console.error('兑换请求失败:', error);
                showMessage('网络错误，请稍后重试', true);
                this.disabled = false;
                this.innerHTML = originalText;
            }
        });
    });
</script>
</body>
</html>
