<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>作品投稿 - 梨园芳华</title>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- 设计系统CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jingju-design-system.css">
    <style>
        /* ===== 页面特有样式 ===== */
        .content-area {
            padding: 32px 40px;
        }
        .page-header {
            text-align: center;
            margin-bottom: 32px;
        }
        .page-header h1 {
            font-family: var(--font-headline);
            font-size: var(--text-display-md);
            font-weight: 700;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        .page-header p {
            color: var(--on-surface-variant);
            margin-top: 8px;
            font-size: var(--text-body-md);
        }
        .header-decoration {
            width: 80px;
            height: 2px;
            background: linear-gradient(90deg, var(--gold), transparent);
            margin: 16px auto 0;
        }

        /* 标签切换 */
        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            border-bottom: 1px solid var(--outline-variant);
        }
        .tab-btn {
            padding: 12px 24px;
            background: none;
            border: none;
            font-size: var(--text-label-lg);
            font-weight: 600;
            color: var(--on-surface-variant);
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            font-family: var(--font-body);
        }
        .tab-btn.active {
            color: var(--primary);
        }
        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--gold);
        }
        .tab-btn:hover {
            color: var(--primary);
        }

        /* 面板 */
        .tab-panel {
            display: none;
            animation: fadeIn 0.3s ease;
        }
        .tab-panel.active {
            display: block;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* 投稿表单 */
        .submit-card {
            background: var(--surface-1);
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-lg);
            padding: 32px;
            box-shadow: var(--shadow-md);
        }
        .form-title {
            font-size: var(--text-headline-sm);
            font-weight: 600;
            color: var(--on-surface);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--outline-variant);
            font-family: var(--font-headline);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: var(--text-label-md);
            font-weight: 500;
            color: var(--on-surface-variant);
            margin-bottom: 8px;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-sm);
            padding: 12px 16px;
            font-size: var(--text-body-md);
            transition: all 0.3s;
            background: var(--surface);
            color: var(--on-surface);
            font-family: var(--font-body);
        }
        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: var(--on-surface-variant);
        }
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(197,150,58,0.25);
        }
        .form-group textarea {
            resize: vertical;
            min-height: 200px;
        }
        .submit-btn {
            background: linear-gradient(135deg, var(--primary), var(--primary-container));
            color: var(--on-primary);
            border: none;
            padding: 12px 36px;
            border-radius: var(--radius-full);
            font-size: var(--text-label-lg);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: var(--font-body);
        }
        .submit-btn:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-1px);
        }

        /* 提示消息 */
        .alert {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 12px 20px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: var(--text-body-sm);
        }
        .alert-error {
            background: #ffebee;
            border-color: #ffcdd2;
            color: var(--primary);
        }

        /* 加载动画 */
        .loading-state {
            text-align: center;
            padding: 60px;
            background: var(--surface-1);
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-lg);
        }
        .spinner {
            width: 40px;
            height: 40px;
            border: 3px solid var(--outline-variant);
            border-top: 3px solid var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 16px;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 我的投稿列表 */
        .submit-item {
            background: var(--surface-1);
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-md);
            padding: 20px;
            transition: all 0.3s;
            border-left: 4px solid;
            box-shadow: var(--shadow-sm);
            margin-bottom: 16px;
        }
        .submit-item:hover {
            transform: translateX(4px);
            box-shadow: var(--shadow-md);
        }
        .submit-item.status-0 { border-left-color: #e6a817; }
        .submit-item.status-1 { border-left-color: #2e7d32; }
        .submit-item.status-2 { border-left-color: var(--primary); }
        .submit-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .submit-title {
            font-size: var(--text-title-sm);
            font-weight: 600;
            color: var(--on-surface);
            font-family: var(--font-headline);
        }
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 14px;
            border-radius: var(--radius-full);
            font-size: var(--text-label-sm);
            border: 1px solid;
        }
        .status-pending {
            background: #fff8e1;
            color: #e6a817;
            border-color: #e6a817;
        }
        .status-approved {
            background: #e8f5e9;
            color: #2e7d32;
            border-color: #2e7d32;
        }
        .status-rejected {
            background: #ffebee;
            color: var(--primary);
            border-color: var(--primary);
        }
        .featured-badge {
            background: linear-gradient(135deg, var(--gold-light), var(--gold));
            color: var(--on-surface);
            margin-left: 8px;
            border-color: var(--gold-deep);
        }
        .submit-content {
            color: var(--on-surface-variant);
            font-size: var(--text-body-sm);
            line-height: 1.7;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .submit-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: var(--text-label-sm);
            color: var(--on-surface-variant);
            flex-wrap: wrap;
            gap: 10px;
        }
        .admin-comment {
            background: var(--surface-2);
            border: 1px solid var(--outline-variant);
            padding: 10px 14px;
            border-radius: var(--radius-sm);
            margin-top: 12px;
            font-size: var(--text-body-sm);
            color: var(--on-surface-variant);
        }
        .admin-comment strong {
            color: var(--primary);
        }
        .empty-state {
            text-align: center;
            padding: 60px;
            background: var(--surface-1);
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius-lg);
        }
        .empty-state .emoji {
            font-size: 64px;
            margin-bottom: 16px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .content-area { padding: 20px 16px; }
            .tabs { justify-content: center; }
            .tab-btn { padding: 10px 20px; font-size: 14px; }
            .submit-header { flex-direction: column; align-items: flex-start; }
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
            <a href="${pageContext.request.contextPath}/user/UserShopServlet?method=list">
                <span class="material-symbols-outlined">local_mall</span>
                <span>积分商城</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserSubmitServlet?method=toSubmit" class="active">
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
        </header>

        <!-- 内容区域 -->
        <div class="content-area">
            <div class="page-header">
                <h1>
                    <span>✍️</span> 戏曲文稿投稿
                    <span>🪭</span>
                </h1>
                <p>分享你的戏曲心得 · 展示才华 · 传承国粹</p>
                <div class="header-decoration"></div>
            </div>

            <!-- 标签切换 -->
            <div class="tabs">
                <button class="tab-btn active" onclick="switchTab('submit')">📝 发布投稿</button>
                <button class="tab-btn" onclick="switchTab('my')">📋 我的投稿</button>
            </div>

            <!-- 发布投稿面板 -->
            <div id="submitPanel" class="tab-panel active">
                <div class="submit-card">
                    <div class="form-title">
                        <span>🎨</span> 创作你的戏曲作品
                    </div>

                    <c:if test="${not empty msg}">
                        <div class="alert ${msg.contains('成功') ? '' : 'alert-error'}">
                            <span>${msg.contains('成功') ? '✅' : '⚠️'}</span> ${msg}
                        </div>
                    </c:if>

                    <form id="submitForm" action="UserSubmitServlet?method=add" method="post">
                        <div class="form-group">
                            <label>📌 文章标题</label>
                            <input type="text" name="title" placeholder="请输入文章标题..." required>
                        </div>
                        <div class="form-group">
                            <label>📝 正文内容</label>
                            <textarea name="content" placeholder="分享你的戏曲观后感、学习心得、京剧知识科普..." required></textarea>
                        </div>
                        <button type="submit" class="submit-btn">提交投稿</button>
                    </form>
                </div>
            </div>

            <!-- 我的投稿面板 -->
            <div id="myPanel" class="tab-panel">
                <div class="loading-state" id="loadingState">
                    <div class="spinner"></div>
                    <p>加载中...</p>
                </div>
                <div id="mySubmitsContent" style="display:none;"></div>
            </div>
        </div>
    </div>
</div>

<script>
    // 页面加载时，默认显示发布投稿面板
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const showMy = urlParams.get('show');

        if (showMy === 'my') {
            switchTab('my');
        } else {
            switchTab('submit');
        }

        const msgDiv = document.querySelector('.alert');
        if (msgDiv && msgDiv.innerText.includes('成功')) {
            setTimeout(function() {
                switchTab('my');
            }, 1500);
        }
    });

    // 切换标签页
    function switchTab(tab) {
        const submitPanel = document.getElementById('submitPanel');
        const myPanel = document.getElementById('myPanel');
        const tabs = document.querySelectorAll('.tab-btn');

        if (tab === 'submit') {
            submitPanel.classList.add('active');
            myPanel.classList.remove('active');
            tabs[0].classList.add('active');
            tabs[1].classList.remove('active');
        } else {
            submitPanel.classList.remove('active');
            myPanel.classList.add('active');
            tabs[0].classList.remove('active');
            tabs[1].classList.add('active');
            loadMySubmits();
        }
    }

    // 异步加载我的投稿数据
    function loadMySubmits() {
        const loadingState = document.getElementById('loadingState');
        const contentDiv = document.getElementById('mySubmitsContent');

        loadingState.style.display = 'block';
        contentDiv.style.display = 'none';

        fetch('UserSubmitServlet?method=mySubmits&ajax=true', {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(response => response.text())
        .then(html => {
            loadingState.style.display = 'none';
            contentDiv.style.display = 'block';
            contentDiv.innerHTML = html;
        })
        .catch(error => {
            console.error('加载失败:', error);
            loadingState.innerHTML = '<div class="empty-state"><div class="emoji">❌</div><p>加载失败，请刷新重试</p></div>';
        });
    }

    // 侧边栏切换
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
    }
    document.querySelector('.main-content').addEventListener('click', function(e) {
        if (window.innerWidth <= 768 && !e.target.closest('.sidebar')) {
            document.getElementById('sidebar').classList.remove('open');
        }
    });
</script>
</body>
</html>
