<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 梨园芳华</title>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- 设计系统CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jingju-design-system.css">
    <style>
        /* ===== Hero区域 ===== */
        .hero-section {
            position: relative;
            width: 100%;
            height: 950px;
            margin-bottom: 0;
            overflow: hidden;
            border-radius: 0;
            background-color: var(--inverse-surface);
        }

        .hero-bg {
            position: absolute;
            inset: 0;
            background: url('${pageContext.request.contextPath}/img/logs/jhk-1781919408085.jpg') center center no-repeat;
            background-size: cover;
        }

        /* 暗色遮罩保证文字可读 */
        .hero-bg::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(51, 48, 42, 0.65), rgba(158, 0, 0, 0.55));
            pointer-events: none;
        }

        .hero-content {
            position: relative;
            z-index: 10;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 0 48px;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero-title {
            font-family: var(--font-headline);
            font-size: 64px;
            font-weight: 700;
            color: var(--on-primary);
            margin-bottom: 28px;
            letter-spacing: 0.15em;
            text-shadow: 0 2px 12px rgba(0, 0, 0, 0.5);
            line-height: 1.2;
        }

        .hero-subtitle {
            font-family: var(--font-body);
            font-size: 22px;
            color: var(--surface-variant);
            max-width: 680px;
            line-height: 1.8;
            margin-bottom: 36px;
            opacity: 0.9;
        }

        .hero-actions {
            display: flex;
            gap: 48px;
        }

        .hero-actions .btn-explore {
            padding: 18px 48px;
            background: linear-gradient(135deg, var(--primary), var(--primary-container));
            color: var(--on-primary);
            border: none;
            border-radius: 8px;
            font-family: var(--font-body);
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 0.08em;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .hero-actions .btn-explore:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .hero-actions .btn-forum {
            padding: 18px 48px;
            background: rgba(255, 255, 255, 0.08);
            color: var(--secondary-container);
            border: 2px solid var(--secondary);
            border-radius: 8px;
            font-family: var(--font-body);
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 0.08em;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .hero-actions .btn-forum:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        /* ===== 统计卡片 ===== */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            margin-bottom: 48px;
        }

        .stat-card {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            padding: 28px 20px;
            text-align: center;
            box-shadow: var(--shadow-md);
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--red);
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            color: var(--ink-light);
            letter-spacing: 1px;
        }

        /* ===== 节标题 ===== */
        .section-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--ink);
            position: relative;
        }

        .section-title::after {
            content: "";
            display: block;
            width: 60px;
            height: 2px;
            background: linear-gradient(to right, var(--gold), transparent);
            margin-top: 12px;
        }

        .section-subtitle {
            color: var(--ink-light);
            font-size: 15px;
            margin-top: 4px;
        }

        .red-seal {
            width: 48px;
            height: 48px;
            background-color: transparent;
            color: var(--red);
            border: 2px solid var(--red);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Noto Serif SC', serif;
            font-size: 20px;
            font-weight: 700;
            border-radius: var(--radius-md);
            writing-mode: vertical-rl;
            text-orientation: upright;
            padding: 10px 8px;
            flex-shrink: 0;
            box-shadow: 0 2px 8px rgba(197, 58, 58, 0.3);
        }

        /* ===== 特色功能卡片 ===== */
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            margin-bottom: 48px;
        }

        .feature-card {
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            border: 1px solid var(--surface-variant);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            text-align: center;
            padding: 36px 24px 28px;
        }

        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: rgba(212, 175, 55, 0.35);
        }

        .feature-icon {
            font-size: 44px;
            margin-bottom: 20px;
            display: block;
            line-height: 1;
        }

        .feature-card h3 {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: var(--on-surface);
            margin-bottom: 10px;
            letter-spacing: 0.03em;
        }

        .feature-card p {
            color: var(--on-surface-variant);
            font-size: var(--text-body-md);
            line-height: 1.7;
        }

        /* ===== 推荐剧目卡片 ===== */
        .recommend-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 48px;
        }

        .opera-card {
            background: var(--bg-parchment);
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
            border: 1px solid var(--gold-pale);
        }

        .opera-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .card-image {
            height: 220px;
            overflow: hidden;
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
            display: none;
        }

        .card-content {
            padding: 16px;
        }

        .opera-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 6px;
        }

        .opera-title .id-badge {
            display: none;
        }

        .opera-desc {
            font-size: 13px;
            color: var(--ink-light);
            line-height: 1.6;
            margin-bottom: 0;
            min-height: auto;
            margin-bottom: 16px;
            min-height: 48px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .praise-section {
            display: none;
        }

        /* ===== 查看全部按钮 ===== */
        .view-all-wrap {
            text-align: center;
            margin-bottom: 64px;
        }

        .view-all-wrap .btn {
            padding: 12px 36px;
            border-radius: var(--radius-full);
        }

        /* ===== 文化名言 - 卷轴样式 ===== */
        .quote-section {
            background: linear-gradient(180deg, #f8f0e3 0%, #f0e6d2 40%, #e8dcc8 100%);
            border: 1px solid var(--gold-pale);
            border-radius: 2px;
            padding: 56px 48px 48px;
            text-align: center;
            position: relative;
            box-shadow:
                inset 0 0 60px rgba(212, 175, 55, 0.06),
                0 4px 24px rgba(0, 0, 0, 0.08);
        }

        /* 上方卷轴装饰 */
        .quote-section::before {
            content: "";
            position: absolute;
            top: -2px;
            left: 40px;
            right: 40px;
            height: 4px;
            background: linear-gradient(90deg, transparent, var(--gold) 20%, var(--gold) 80%, transparent);
            border-radius: 2px;
        }

        /* 下方卷轴装饰 */
        .quote-section::after {
            content: "";
            position: absolute;
            bottom: -2px;
            left: 40px;
            right: 40px;
            height: 4px;
            background: linear-gradient(90deg, transparent, var(--gold) 20%, var(--gold) 80%, transparent);
            border-radius: 2px;
        }

        .quote-text {
            font-family: var(--font-headline);
            font-size: 26px;
            font-weight: 600;
            line-height: 2;
            letter-spacing: 0.15em;
            color: var(--ink);
            margin-bottom: 24px;
            text-shadow: 0 1px 2px rgba(255, 255, 255, 0.6);
        }

        .quote-author {
            font-family: var(--font-body);
            font-size: 14px;
            color: var(--ink-light);
            letter-spacing: 0.2em;
        }

        /* 红色印章装饰 */
        .quote-seal {
            position: absolute;
            bottom: 20px;
            right: 32px;
            width: 48px;
            height: 48px;
            border: 2px solid var(--red);
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-headline);
            font-size: 18px;
            font-weight: 700;
            color: var(--red);
            writing-mode: vertical-rl;
            text-orientation: upright;
            padding: 6px 4px;
            opacity: 0.85;
            box-shadow: 0 2px 8px rgba(197, 58, 58, 0.15);
        }

        /* ===== 金色分割线 ===== */
        .gold-divider {
            max-width: 800px;
            margin: 0 auto 48px;
        }

        /* ===== 页脚增强 ===== */
        .footer {
            background-color: var(--surface-container-highest);
            border-top: 1px solid var(--outline-variant);
            padding: 48px var(--spacing-margin-desktop);
            margin-top: auto;
        }

        .footer-content {
            max-width: var(--container-max);
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 24px;
        }

        .footer-brand {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            color: var(--primary);
            letter-spacing: 0.08em;
        }

        .footer-links {
            display: flex;
            gap: 32px;
        }

        .footer-links a {
            color: var(--on-surface-variant);
            text-decoration: none;
            font-size: var(--text-body-md);
            opacity: 0.85;
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--secondary);
            opacity: 1;
        }

        .footer-copyright {
            color: var(--on-surface-variant);
            font-size: var(--text-body-md);
            opacity: 0.7;
        }

        /* ===== 页面标题（兼容旧page-header） ===== */
        .page-header {
            margin-bottom: 40px;
        }

        .page-header-title {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 12px;
        }

        .page-header-title .seal {
            width: 48px;
            height: 48px;
            background-color: var(--primary-container);
            color: var(--on-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--font-headline);
            font-size: 20px;
            font-weight: 700;
            border-radius: var(--radius-md);
            writing-mode: vertical-rl;
            text-orientation: upright;
            padding: 10px 8px;
            box-shadow: 0 2px 8px rgba(204, 0, 0, 0.2);
        }

        .page-header h2 {
            font-family: var(--font-headline);
            font-size: var(--text-headline-lg);
            font-weight: 600;
            color: var(--on-surface);
            letter-spacing: 0.05em;
        }

        .page-header p {
            font-size: var(--text-body-lg);
            color: var(--on-surface-variant);
            max-width: 600px;
        }

        /* ===== card（兼容旧card类） ===== */
        .card {
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            border: 1px solid var(--surface-variant);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: rgba(212, 175, 55, 0.3);
        }

        /* ===== 响应式 ===== */
        @media (max-width: 1024px) {
            .hero-title {
                font-size: var(--text-display-lg-mobile);
            }

            .hero-section {
                height: 520px;
            }

            .recommend-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .feature-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .hero-section {
                height: 460px;
                border-radius: var(--radius-lg);
            }

            .hero-content {
                padding: 0 24px;
            }

            .hero-title {
                font-size: 28px;
                letter-spacing: 0.06em;
            }

            .hero-subtitle {
                font-size: var(--text-body-md);
            }

            .recommend-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }

            .hero-actions {
                flex-direction: column;
                width: 100%;
                max-width: 280px;
            }

            .hero-actions .btn-explore,
            .hero-actions .btn-forum {
                width: 100%;
                justify-content: center;
            }

            .quote-section {
                padding: 40px 24px;
            }

            .quote-text {
                font-size: var(--text-body-lg);
            }

            .section-header {
                gap: 14px;
                margin-bottom: 28px;
            }

            .section-title {
                font-size: var(--text-headline-md);
            }

            .footer-content {
                flex-direction: column;
                text-align: center;
            }

            .footer-links {
                gap: 20px;
                flex-wrap: wrap;
                justify-content: center;
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
            <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=toHome" class="active">
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
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 40 40'%3E%3Ccircle cx='20' cy='20' r='20' fill='%23e0d9d0'/%3E%3Ctext x='20' y='26' font-size='16' fill='%23926e69' text-anchor='middle'%3E${loginUser.username.substring(0,1)}%3C/text%3E%3C/svg%3E" alt="头像">
                </div>
            </div>
        </header>

        <!-- Hero区域（满宽，独立于content-area） -->
        <section class="hero-section">
            <div class="hero-bg"></div>
            <div class="hero-content">
                <h1 class="hero-title">传承千载 戏梦人生</h1>
                <p class="hero-subtitle">
                    在这里，探索京剧艺术的深厚底蕴。从经典剧目到数字文创，感受传统与现代的交响。
                </p>
                <div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/user/UserOperaServlet?method=list" class="btn-explore">
                        探索经典
                    </a>
                    <a href="${pageContext.request.contextPath}/user/UserForumServlet?method=list" class="btn-forum">
                        进入论坛
                    </a>
                </div>
            </div>
        </section>

        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 金色装饰分隔线 -->
            <div class="gold-divider">
                <hr class="gold-hairline">
            </div>

            <!-- 统计卡片 -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">300+</div>
                    <div class="stat-label">📖 经典剧目</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">10,000+</div>
                    <div class="stat-label">👥 活跃用户</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">5,000+</div>
                    <div class="stat-label">💬 论坛帖子</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">50+</div>
                    <div class="stat-label">🎁 文创商品</div>
                </div>
            </div>

            <!-- 特色功能 -->
            <div class="section-header">
                <div class="red-seal">特</div>
                <div>
                    <h2 class="section-title">平台特色功能</h2>
                    <p class="section-subtitle">传承国粹，弘扬中华优秀传统文化</p>
                </div>
            </div>

            <div class="feature-grid">
                <div class="card" onclick="window.location.href='UserOperaServlet?method=list'" style="cursor:pointer;text-align:center;padding:36px 24px;">
                    <div style="font-size:44px;margin-bottom:20px;">📚</div>
                    <h3 style="font-family:var(--font-headline);font-size:var(--text-headline-md);margin-bottom:10px;">经典剧目查阅</h3>
                    <p style="color:var(--on-surface-variant);font-size:var(--text-body-md);line-height:1.7;">收录经典京剧剧目，了解剧情梗概、行当分类、唱词鉴赏</p>
                </div>
                <div class="card" onclick="window.location.href='UserForumServlet?method=list'" style="cursor:pointer;text-align:center;padding:36px 24px;">
                    <div style="font-size:44px;margin-bottom:20px;">🗣️</div>
                    <h3 style="font-family:var(--font-headline);font-size:var(--text-headline-md);margin-bottom:10px;">爱好者论坛交流</h3>
                    <p style="color:var(--on-surface-variant);font-size:var(--text-body-md);line-height:1.7;">与全国戏迷分享观剧心得，交流学习经验，结交同道好友</p>
                </div>
                <div class="card" onclick="window.location.href='UserShopServlet?method=list'" style="cursor:pointer;text-align:center;padding:36px 24px;">
                    <div style="font-size:44px;margin-bottom:20px;">🎁</div>
                    <h3 style="font-family:var(--font-headline);font-size:var(--text-headline-md);margin-bottom:10px;">戏曲周边积分商城</h3>
                    <p style="color:var(--on-surface-variant);font-size:var(--text-body-md);line-height:1.7;">学习获取积分，兑换精美京剧文创产品</p>
                </div>
                <div class="card" onclick="window.location.href='UserSubmitServlet?method=toSubmit'" style="cursor:pointer;text-align:center;padding:36px 24px;">
                    <div style="font-size:44px;margin-bottom:20px;">✍️</div>
                    <h3 style="font-family:var(--font-headline);font-size:var(--text-headline-md);margin-bottom:10px;">原创戏曲文稿投稿</h3>
                    <p style="color:var(--on-surface-variant);font-size:var(--text-body-md);line-height:1.7;">展示才华，让更多人看到你的戏曲相关作品</p>
                </div>
            </div>

            <hr class="gold-hairline">

            <!-- 推荐剧目 -->
            <div class="section-header" style="margin-top:48px;">
                <div class="red-seal">荐</div>
                <div>
                    <h2 class="section-title">热门推荐剧目</h2>
                </div>
            </div>

            <div class="recommend-grid">
                <c:forEach items="${operaList}" var="o" end="3">
                    <div class="opera-card" data-title="${o.title}" data-type="${o.type != null ? o.type : '经典'}">
                        <div class="card-image">
                            <img src="${o.img}" alt="${o.title}" onerror="this.style.display='none'">
                            <div class="opera-type">${o.type != null ? o.type : '经典'}</div>
                        </div>
                        <div class="card-content">
                            <div class="opera-title">
                                ${o.title}
                                <span class="id-badge">#${o.id}</span>
                            </div>
                            <div class="opera-desc line-clamp-3">
                                ${o.content != null ? o.content : '经典京剧剧目，传承国粹艺术。'}
                            </div>
                            <div class="praise-section">
                                <button class="praise-btn" onclick="addPraise(${o.id}, this)">
                                    <span class="material-symbols-outlined">favorite</span>
                                    <span class="praise-count">${o.praise != null ? o.praise : 0}</span>
                                </button>
                                <a href="#" class="view-detail" onclick="window.location.href='UserOperaServlet?method=list'; return false;">
                                    探索详情
                                    <span class="material-symbols-outlined" style="font-size:18px;">arrow_forward</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="view-all-wrap">
                <a href="#" class="btn btn-secondary" onclick="window.location.href='UserOperaServlet?method=list';return false;">
                    查看全部剧目
                    <span class="material-symbols-outlined">arrow_forward</span>
                </a>
            </div>

            <!-- 文化名言 -->
            <div class="quote-section">
                <div class="quote-text">
                    台上十分钟，台下十年功。<br>一声皮黄腔，多少中华情。
                </div>
                <div class="quote-author">—— 京剧艺术 · 国粹传承</div>
                <div class="quote-seal">韵</div>
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

    // 统计数字动画
    const statNumbers = document.querySelectorAll('.stat-value');
    statNumbers.forEach(el => {
        const finalValue = el.innerText;
        const hasPlus = finalValue.includes('+');
        const hasComma = finalValue.includes(',');
        const numStr = finalValue.replace(/[^0-9]/g, '');
        const target = parseInt(numStr);

        if (isNaN(target)) return;

        el.innerText = '0';
        let current = 0;
        const step = target / 50;
        const timer = setInterval(() => {
            current += step;
            if (current >= target) {
                el.innerText = finalValue;
                clearInterval(timer);
            } else {
                let display = Math.floor(current);
                if (hasComma) {
                    display = display.toLocaleString();
                }
                el.innerText = display + (hasPlus ? '+' : '');
            }
        }, 20);
    });

</script>
</body>
</html>
