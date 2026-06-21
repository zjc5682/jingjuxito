<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>戏曲论坛 - 梨园芳华</title>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- 设计系统CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jingju-design-system.css">
    <style>
        /* ====== 论坛页面专用样式 - 匹配设计稿03 ====== */

        /* 发帖区域 */
        .publish-card {
            background-color: var(--surface-container-low);
            border-radius: var(--radius-lg);
            padding: 24px;
            margin-bottom: 32px;
            border: 1px solid transparent;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
        }

        .publish-card:hover {
            box-shadow: var(--shadow-md);
            border-color: rgba(212, 175, 55, 0.3);
        }

        .publish-title {
            display: flex;
            align-items: center;
            gap: 12px;
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: var(--on-surface);
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid rgba(232, 189, 182, 0.3);
        }

        /* 发帖讨论按钮（页面标题区） */
        .page-header-action {
            align-self: flex-start;
            background: linear-gradient(135deg, var(--primary), var(--primary-container));
            color: var(--on-primary);
            font-size: var(--text-label-md);
            font-weight: 600;
            letter-spacing: 0.05em;
            padding: 12px 32px;
            border-radius: var(--radius-full);
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            text-decoration: none;
            white-space: nowrap;
        }

        .page-header-action:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* 帖子控制栏（标签切换） */
        .post-controls {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid rgba(232, 189, 182, 0.3);
            padding-bottom: 16px;
            margin-bottom: 24px;
        }

        .post-tabs {
            display: flex;
            gap: 24px;
            font-size: var(--text-label-md);
            font-weight: 600;
        }

        .post-tab {
            background: none;
            border: none;
            cursor: pointer;
            padding-bottom: 4px;
            color: var(--on-surface-variant);
            transition: all 0.3s ease;
            font-family: var(--font-body);
            font-size: var(--text-label-md);
            font-weight: 600;
        }

        .post-tab.active {
            color: var(--primary);
            border-bottom: 2px solid var(--primary);
        }

        .post-tab:hover {
            color: var(--primary);
        }

        .post-filter {
            display: flex;
            align-items: center;
            gap: 4px;
            background: none;
            border: none;
            cursor: pointer;
            color: var(--on-surface-variant);
            font-size: var(--text-body-md);
            transition: color 0.3s ease;
            font-family: var(--font-body);
        }

        .post-filter:hover {
            color: var(--primary);
        }

        .post-filter .material-symbols-outlined {
            font-size: 18px;
        }

        /* 提示消息 */
        .alert {
            background-color: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 12px 20px;
            border-radius: var(--radius-lg);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: var(--text-body-md);
        }

        .alert-error {
            background-color: #ffebee;
            border-color: #ffcdd2;
            color: var(--error);
        }

        /* 帖子卡片 - 匹配设计稿 */
        .post-card {
            background-color: var(--surface-container-low);
            border-radius: var(--radius-lg);
            padding: 24px;
            margin-bottom: 24px;
            border: 1px solid transparent;
            box-shadow: 0 4px 20px -4px rgba(204, 0, 0, 0.06);
            transition: all 0.3s ease;
        }

        .post-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px -4px rgba(204, 0, 0, 0.1);
            border-color: rgba(212, 175, 55, 0.3);
        }

        /* 帖子头部：头像 + 标题/元信息 */
        .post-card-header {
            display: flex;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 16px;
        }

        .post-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            border: 1px solid rgba(212, 175, 55, 0.6);
            overflow: hidden;
            flex-shrink: 0;
            background-color: var(--surface-container);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .post-avatar .material-symbols-outlined {
            font-size: 28px;
            color: var(--on-surface-variant);
            opacity: 0.6;
        }

        .post-card-info {
            flex: 1;
            min-width: 0;
        }

        .post-title {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: var(--on-surface);
            line-height: 1.4;
            margin-bottom: 8px;
            transition: color 0.3s ease;
            cursor: pointer;
        }

        .post-title:hover {
            color: var(--primary);
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .post-meta {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: var(--text-label-md);
            color: var(--on-surface-variant);
            opacity: 0.8;
            flex-wrap: wrap;
        }

        .post-author {
            display: flex;
            align-items: center;
            gap: 4px;
            color: var(--secondary);
            font-weight: 600;
        }

        .post-meta-sep {
            color: var(--outline-variant);
        }

        .post-tag {
            display: inline-block;
            padding: 2px 8px;
            background-color: var(--surface-variant);
            color: var(--on-surface-variant);
            font-size: 12px;
            font-weight: 600;
            border-radius: var(--radius-sm);
        }

        .post-content {
            color: var(--on-surface-variant);
            line-height: 1.6;
            margin-bottom: 16px;
            font-size: var(--text-body-md);
        }

        /* 帖子底部操作栏 */
        .post-footer {
            display: flex;
            align-items: center;
            gap: 24px;
            padding-top: 16px;
            border-top: 1px solid rgba(232, 189, 182, 0.3);
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 4px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 4px 0;
            font-size: var(--text-body-md);
            color: var(--on-surface-variant);
            transition: all 0.3s ease;
            font-family: var(--font-body);
        }

        .action-btn:hover {
            color: var(--primary);
        }

        .action-btn .material-symbols-outlined {
            font-size: 20px;
        }

        .action-btn-spacer {
            margin-left: auto;
        }

        /* 侧边栏 */
        .forum-sidebar {
            display: flex;
            flex-direction: column;
            gap: 32px;
        }

        .sidebar-card {
            background-color: var(--surface-bright);
            border-radius: var(--radius-xl);
            padding: 24px;
            border: 1px solid rgba(232, 189, 182, 0.5);
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

        .sidebar-card-deco {
            position: absolute;
            right: -30px;
            bottom: -30px;
            opacity: 0.04;
            pointer-events: none;
        }

        .sidebar-card-deco .material-symbols-outlined {
            font-size: 150px;
            color: var(--on-surface);
        }

        .sidebar-card-title {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: var(--on-surface);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            z-index: 1;
        }

        .sidebar-card-title .material-symbols-outlined {
            color: var(--primary);
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            position: relative;
            z-index: 1;
        }

        .category-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 4px;
            padding: 12px 16px;
            background-color: var(--surface-container-low);
            border-radius: var(--radius-sm);
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            color: var(--on-surface-variant);
            border: 1px solid transparent;
        }

        .category-item:hover {
            background-color: var(--surface-variant);
            border-color: rgba(212, 175, 55, 0.5);
            color: var(--on-surface);
        }

        .category-item .material-symbols-outlined {
            font-size: 24px;
            color: var(--secondary);
        }

        .category-item span:last-child {
            font-size: var(--text-label-md);
            font-weight: 600;
        }

        /* 热议列表 */
        .hot-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .hot-item {
            display: flex;
            gap: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .hot-item .hot-title {
            transition: color 0.3s ease;
        }

        .hot-item:hover .hot-title {
            color: var(--primary);
        }

        .hot-rank {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: var(--primary);
            min-width: 24px;
            line-height: 1.2;
            opacity: 0.8;
            margin-top: -4px;
        }

        .hot-rank.rank-2 { opacity: 0.6; }
        .hot-rank.rank-3 { opacity: 0.4; }
        .hot-rank.rank-n { opacity: 0.4; color: var(--on-surface-variant); }

        .hot-title {
            font-size: var(--text-body-md);
            color: var(--on-surface);
            line-height: 1.6;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .hot-count {
            font-size: 12px;
            color: var(--on-surface-variant);
            opacity: 0.7;
            margin-top: 2px;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 48px;
        }

        .empty-state .material-symbols-outlined {
            font-size: 64px;
            color: var(--outline-variant);
            margin-bottom: 16px;
        }

        .empty-state p {
            color: var(--on-surface-variant);
            font-size: var(--text-body-lg);
        }

        /* 提示框 */
        .toast {
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

        @keyframes heartbeat {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.3); }
        }

        .heart-animation {
            animation: heartbeat 0.3s ease;
        }

        /* 页面标题区 flex 布局 */
        .page-header-row {
            display: flex;
            flex-direction: row;
            align-items: flex-end;
            justify-content: space-between;
            gap: 24px;
            margin-bottom: 48px;
        }

        .page-header-row .page-header {
            margin-bottom: 0;
        }

        /* 12列网格布局 */
        .forum-layout {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 48px;
            margin-top: 48px;
        }

        .forum-main {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        @media (max-width: 1024px) {
            .forum-layout {
                grid-template-columns: 1fr !important;
            }
            .forum-sidebar {
                order: -1;
            }
            .page-header-row {
                flex-direction: column;
                align-items: flex-start;
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
            <a href="${pageContext.request.contextPath}/user/UserForumServlet?method=list" class="active">
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
            <!-- 页面标题 + 发帖按钮 -->
            <div class="page-header-row">
                <div class="page-header">
                    <div class="page-header-title">
                        <div class="seal">论</div>
                        <h1>戏曲论坛</h1>
                    </div>
                    <p>汇聚票友知音，探讨流派唱腔，交流身段技法，共赏国粹之美。</p>
                </div>
                <a href="#publish-section" class="page-header-action">
                    <span class="material-symbols-outlined">edit_square</span>
                    发帖讨论
                </a>
            </div>

            <hr class="gold-hairline" style="margin-bottom: 48px;">

            <!-- 主内容布局 -->
            <div class="forum-layout">
                <!-- 左侧：发帖 + 帖子列表 -->
                <div class="forum-main">
                    <!-- 发帖区域 -->
                    <div class="publish-card" id="publish-section">
                        <div class="publish-title">
                            <span class="material-symbols-outlined">edit_square</span>
                            发布新帖
                        </div>

                        <!-- 提示消息 -->
                        <c:if test="${not empty msg}">
                            <div class="alert">
                                <span class="material-symbols-outlined">check_circle</span>
                                ${msg}
                            </div>
                        </c:if>

                        <form action="UserForumServlet?method=addPost" method="post">
                            <div class="form-group">
                                <label class="form-label">帖子标题</label>
                                <input type="text" name="title" class="form-input" placeholder="请输入帖子标题..." required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">帖子内容</label>
                                <textarea name="content" class="form-input" placeholder="分享你的戏曲心得、观剧感受、学习经验..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <span class="material-symbols-outlined">send</span>
                                发布帖子
                            </button>
                        </form>
                    </div>

                    <!-- 帖子控制栏 -->
                    <div class="post-controls">
                        <div class="post-tabs">
                            <button class="post-tab active">最新动态</button>
                            <button class="post-tab">热门讨论</button>
                            <button class="post-tab">精华区</button>
                        </div>
                        <button class="post-filter">
                            <span class="material-symbols-outlined">filter_list</span>
                            筛选
                        </button>
                    </div>

                    <!-- 帖子列表 -->
                    <div class="section-header" style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
                        <h3 style="font-family:var(--font-headline);font-size:var(--text-headline-md);display:flex;align-items:center;gap:8px;">
                            <span class="material-symbols-outlined" style="color:var(--primary);">article</span>
                            精选帖子
                        </h3>
                        <span class="tag">共 ${postList.size()} 篇帖子</span>
                    </div>

                    <c:forEach items="${postList}" var="p">
                        <div class="post-card" data-id="${p.id}">
                            <div class="post-card-header">
                                <div class="post-avatar">
                                    <span class="material-symbols-outlined">person</span>
                                </div>
                                <div class="post-card-info">
                                    <h3 class="post-title">${p.title}</h3>
                                    <div class="post-meta">
                                        <span class="post-author">@${p.username != null ? p.username : '用户'}</span>
                                        <span class="post-meta-sep">•</span>
                                        <span>${p.createTime}</span>
                                        <span class="post-meta-sep">•</span>
                                        <span class="post-tag">论坛</span>
                                    </div>
                                </div>
                            </div>
                            <div class="post-content line-clamp-3">
                                ${p.content}
                            </div>
                            <div class="post-footer">
                                <button class="action-btn" onclick="addPraise(${p.id}, this)">
                                    <span class="material-symbols-outlined heart">thumb_up</span>
                                    <span class="praise-count">${p.praise != null ? p.praise : 0}</span>
                                </button>
                                <button class="action-btn">
                                    <span class="material-symbols-outlined">chat_bubble_outline</span>
                                </button>
                                <button class="action-btn action-btn-spacer">
                                    <span class="material-symbols-outlined">share</span>
                                </button>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- 空状态 -->
                    <c:if test="${empty postList}">
                        <div class="empty-state">
                            <span class="material-symbols-outlined">forum</span>
                            <p>暂无帖子，快来发布第一条帖子吧！</p>
                        </div>
                    </c:if>
                </div>

                <!-- 右侧边栏 -->
                <aside class="forum-sidebar">
                    <!-- 版块分类 -->
                    <div class="sidebar-card">
                        <div class="sidebar-card-deco">
                            <span class="material-symbols-outlined">category</span>
                        </div>
                        <h4 class="sidebar-card-title">
                            <span class="material-symbols-outlined">bookmarks</span>
                            版块分类
                        </h4>
                        <div class="category-grid">
                            <a class="category-item" href="#">
                                <span class="material-symbols-outlined">theater_comedy</span>
                                <span>剧目赏析</span>
                            </a>
                            <a class="category-item" href="#">
                                <span class="material-symbols-outlined">accessibility_new</span>
                                <span>唱念做打</span>
                            </a>
                            <a class="category-item" href="#">
                                <span class="material-symbols-outlined">history_edu</span>
                                <span>名家史话</span>
                            </a>
                            <a class="category-item" href="#">
                                <span class="material-symbols-outlined">help_outline</span>
                                <span>新手答疑</span>
                            </a>
                        </div>
                    </div>

                    <!-- 梨园热议 -->
                    <div class="sidebar-card">
                        <h4 class="sidebar-card-title">
                            <span class="material-symbols-outlined">local_fire_department</span>
                            梨园热议
                        </h4>
                        <ul class="hot-list">
                            <li class="hot-item">
                                <span class="hot-rank">1</span>
                                <div>
                                    <div class="hot-title">纪念梅兰芳诞辰130周年系列演出</div>
                                    <div class="hot-count">3.2w 热度</div>
                                </div>
                            </li>
                            <li class="hot-item">
                                <span class="hot-rank rank-2">2</span>
                                <div>
                                    <div class="hot-title">现代京剧创新与传统留存的边界</div>
                                    <div class="hot-count">2.8w 热度</div>
                                </div>
                            </li>
                            <li class="hot-item">
                                <span class="hot-rank rank-3">3</span>
                                <div>
                                    <div class="hot-title">如何评价近期大热的跨界戏腔歌曲？</div>
                                    <div class="hot-count">1.5w 热度</div>
                                </div>
                            </li>
                            <li class="hot-item">
                                <span class="hot-rank rank-n">4</span>
                                <div>
                                    <div class="hot-title">寻旧：民国时期老唱片数字化修复进度</div>
                                    <div class="hot-count">9k 热度</div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </aside>
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

    // 点赞功能
    function addPraise(id, btn) {
        fetch('UserForumServlet?method=praise&id=' + id, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.text())
            .then(() => {
                const praiseCountSpan = btn.querySelector('.praise-count');
                let currentCount = parseInt(praiseCountSpan.innerText);
                if (isNaN(currentCount)) currentCount = 0;
                praiseCountSpan.innerText = currentCount + 1;

                const heart = btn.querySelector('.heart');
                heart.classList.add('heart-animation');
                heart.style.color = 'var(--primary)';
                setTimeout(() => {
                    heart.classList.remove('heart-animation');
                }, 300);

                showToast('❤️ 点赞成功！');
            })
            .catch(error => {
                console.error('点赞失败:', error);
                showToast('点赞失败，请稍后重试');
            });
    }

    function showToast(message) {
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 2000);
    }
</script>
</body>
</html>
