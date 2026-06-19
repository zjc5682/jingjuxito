<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>作品投稿 - 中华京剧文化学习平台</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

        /* 页面头部 */
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
            margin-top: 8px;
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
            border-bottom: 1px solid var(--gold-pale);
        }

        .tab-btn {
            padding: 12px 24px;
            background: none;
            border: none;
            font-size: 16px;
            font-weight: 600;
            color: var(--ink-light);
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            font-family: inherit;
        }

        .tab-btn.active {
            color: var(--red);
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
            color: var(--red);
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
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            padding: 32px;
            box-shadow: var(--shadow-md);
        }

        .form-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--gold-pale);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: var(--ink-soft);
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            border: 1px solid var(--gold-pale);
            border-radius: 6px;
            padding: 12px 16px;
            font-size: 14px;
            transition: all 0.3s;
            background: var(--bg-warm);
            color: var(--ink);
            font-family: inherit;
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: var(--ink-light);
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--red);
            box-shadow: 0 0 0 2px rgba(197,150,58,0.25);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 200px;
        }

        .submit-btn {
            background: var(--red);
            color: var(--bg-warm);
            border: none;
            padding: 12px 36px;
            border-radius: 9999px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: inherit;
        }

        .submit-btn:hover {
            background: var(--red-dark);
            box-shadow: var(--shadow-md);
        }

        /* 提示消息 */
        .alert {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .alert-error {
            background: #ffebee;
            border-color: #ffcdd2;
            color: var(--red);
        }

        /* 加载动画 */
        .loading-state {
            text-align: center;
            padding: 60px;
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 3px solid var(--gold-pale);
            border-top: 3px solid var(--red);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 16px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 我的投稿列表 */
        .submits-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .submit-item {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s;
            border-left: 4px solid;
            box-shadow: var(--shadow-sm);
        }

        .submit-item:hover {
            transform: translateX(4px);
            box-shadow: var(--shadow-md);
        }

        .submit-item.status-0 { border-left-color: #e6a817; }
        .submit-item.status-1 { border-left-color: #2e7d32; }
        .submit-item.status-2 { border-left-color: var(--red); }

        .submit-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .submit-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--ink);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 14px;
            border-radius: 9999px;
            font-size: 12px;
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
            color: var(--red);
            border-color: var(--red);
        }

        .featured-badge {
            background: linear-gradient(135deg, var(--gold-light), var(--gold));
            color: var(--ink);
            margin-left: 8px;
            border-color: var(--gold-deep);
        }

        .submit-content {
            color: var(--ink-soft);
            font-size: 14px;
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
            font-size: 12px;
            color: var(--ink-light);
            flex-wrap: wrap;
            gap: 10px;
        }

        .admin-comment {
            background: var(--bg-parchment);
            border: 1px solid var(--gold-pale);
            padding: 10px 14px;
            border-radius: 6px;
            margin-top: 12px;
            font-size: 13px;
            color: var(--ink-soft);
        }

        .admin-comment strong {
            color: var(--red);
        }

        .empty-state {
            text-align: center;
            padding: 60px;
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
        }

        .empty-state .emoji {
            font-size: 64px;
            margin-bottom: 16px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body { padding: 15px; }
            .tabs {
                justify-content: center;
            }
            .tab-btn {
                padding: 10px 20px;
                font-size: 14px;
            }
            .submit-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面头部 -->
    <div class="page-header">
        <h1>
            <span>✍️</span> 戏曲文稿投稿
            <span>🪭 </span>
        </h1>
        <p>分享你的戏曲心得 · 展示才华 · 传承国粹</p>
        <div class="header-decoration"></div>
    </div>

    <!-- 标签切换 -->
    <div class="tabs">
        <button class="tab-btn" onclick="switchTab('submit')">📝 发布投稿</button>
        <button class="tab-btn" onclick="switchTab('my')">📋 我的投稿</button>
    </div>

    <!-- 发布投稿面板 -->
    <div id="submitPanel" class="tab-panel">
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

    <!-- 我的投稿面板（初始显示加载中） -->
    <div id="myPanel" class="tab-panel">
        <div class="loading-state" id="loadingState">
            <div class="spinner"></div>
            <p>加载中...</p>
        </div>
        <div id="mySubmitsContent" style="display:none;"></div>
    </div>
</div>

<script>
    // 页面加载时，默认显示发布投稿面板，并高亮对应按钮
    document.addEventListener('DOMContentLoaded', function() {
        // 检查URL参数，判断是否要显示我的投稿
        const urlParams = new URLSearchParams(window.location.search);
        const showMy = urlParams.get('show');

        if (showMy === 'my') {
            switchTab('my');
        } else {
            switchTab('submit');
        }

        // 如果有成功消息，延迟刷新我的投稿
        const msgDiv = document.querySelector('.alert');
        if (msgDiv && msgDiv.innerText.includes('成功')) {
            setTimeout(function() {
                // 提交成功后自动切换到我的投稿
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

            // 加载我的投稿数据
            loadMySubmits();
        }
    }

    // 异步加载我的投稿数据
    function loadMySubmits() {
        const loadingState = document.getElementById('loadingState');
        const contentDiv = document.getElementById('mySubmitsContent');

        // 显示加载状态
        loadingState.style.display = 'block';
        contentDiv.style.display = 'none';

        // 使用 fetch 异步请求数据
        fetch('UserSubmitServlet?method=mySubmits&ajax=true', {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.text())
            .then(html => {
                // 隐藏加载状态
                loadingState.style.display = 'none';
                contentDiv.style.display = 'block';
                // 将返回的HTML放入内容区域
                contentDiv.innerHTML = html;
            })
            .catch(error => {
                console.error('加载失败:', error);
                loadingState.innerHTML = '<div class="empty-state"><div class="emoji">❌</div><p>加载失败，请刷新重试</p></div>';
            });
    }
</script>
</body>
</html>