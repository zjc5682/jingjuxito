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
            max-width: 1200px;
            margin: 0 auto;
        }

        /* 页面头部 */
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
            margin-top: 10px;
        }

        .header-decoration {
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #b71c1c, #e8b88a, #b71c1c);
            margin: 15px auto 0;
            border-radius: 3px;
        }

        /* 标签切换 */
        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            border-bottom: 2px solid #e5e5e5;
        }

        .tab-btn {
            padding: 12px 28px;
            background: none;
            border: none;
            font-size: 16px;
            font-weight: 600;
            color: #888;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .tab-btn.active {
            color: #b71c1c;
        }

        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 3px;
            background: #b71c1c;
            border-radius: 3px;
        }

        .tab-btn:hover {
            color: #b71c1c;
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
            background: white;
            border-radius: 24px;
            padding: 35px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .form-title {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            border: 1.5px solid #e5e7eb;
            border-radius: 14px;
            padding: 14px 16px;
            font-size: 14px;
            transition: all 0.3s;
            background: #f9fafb;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #b71c1c;
            background: white;
            box-shadow: 0 0 0 3px rgba(183, 28, 28, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 200px;
        }

        .submit-btn {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
            border: none;
            padding: 14px 35px;
            border-radius: 40px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(183, 28, 28, 0.3);
        }

        /* 提示消息 */
        .alert {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 14px 20px;
            border-radius: 14px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-error {
            background: #ffebee;
            border-color: #ffcdd2;
            color: #c62828;
        }

        /* 加载动画 */
        .loading-state {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 24px;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #b71c1c;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 15px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 我的投稿列表 */
        .submits-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .submit-item {
            background: white;
            border-radius: 20px;
            padding: 22px;
            transition: all 0.3s;
            border-left: 5px solid;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .submit-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .submit-item.status-0 { border-left-color: #ff9800; }
        .submit-item.status-1 { border-left-color: #4caf50; }
        .submit-item.status-2 { border-left-color: #f44336; }

        .submit-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .submit-title {
            font-size: 18px;
            font-weight: 700;
            color: #333;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 12px;
            border-radius: 30px;
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

        .featured-badge {
            background: linear-gradient(135deg, #ffd700, #ffb300);
            color: #5d4037;
            margin-left: 8px;
        }

        .submit-content {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
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
            color: #999;
            flex-wrap: wrap;
            gap: 10px;
        }

        .admin-comment {
            background: #f5f5f5;
            padding: 8px 12px;
            border-radius: 10px;
            margin-top: 10px;
            font-size: 13px;
        }

        .admin-comment strong {
            color: #b71c1c;
        }

        .empty-state {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 24px;
        }

        .empty-state .emoji {
            font-size: 64px;
            margin-bottom: 15px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
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