<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>戏曲爱好者论坛 - 中华京剧文化学习平台</title>
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
        .forum-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .forum-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--red);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .forum-header p {
            color: var(--ink-light);
            margin-top: 8px;
        }

        .header-decoration {
            width: 80px;
            height: 2px;
            background: linear-gradient(90deg, var(--gold), transparent);
            margin: 16px auto 0;
        }

        /* 发布帖子区域 */
        .publish-card {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 32px;
            box-shadow: var(--shadow-md);
        }

        .publish-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--gold-pale);
        }

        .publish-title span {
            font-size: 24px;
        }

        .publish-form input,
        .publish-form textarea {
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

        .publish-form input::placeholder,
        .publish-form textarea::placeholder {
            color: var(--ink-light);
        }

        .publish-form input:focus,
        .publish-form textarea:focus {
            outline: none;
            border-color: var(--red);
            box-shadow: 0 0 0 2px rgba(197,150,58,0.25);
        }

        .publish-form textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: var(--ink-soft);
            margin-bottom: 8px;
        }

        .submit-btn {
            background: var(--red);
            color: var(--bg-warm);
            border: none;
            padding: 10px 32px;
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
            margin-bottom: 16px;
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

        /* 帖子列表 */
        .posts-section {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            padding: 24px;
            box-shadow: var(--shadow-md);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--gold-pale);
        }

        .section-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--ink);
            display: flex;
            align-items: center;
            gap: 8px;
            padding-left: 12px;
            border-left: 4px solid var(--gold);
        }

        .post-count {
            background: var(--bg-parchment);
            border: 1px solid var(--gold-pale);
            padding: 4px 14px;
            border-radius: 9999px;
            font-size: 13px;
            color: var(--ink-light);
        }

        /* 帖子卡片 */
        .post-card {
            background: var(--bg-parchment);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 16px;
            transition: all 0.3s;
            border: 1px solid var(--gold-pale);
        }

        .post-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .post-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--ink);
        }

        .post-meta {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 12px;
            color: var(--ink-light);
            margin-bottom: 12px;
        }

        .post-author {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-content {
            color: var(--ink-soft);
            line-height: 1.7;
            margin-bottom: 16px;
            font-size: 14px;
        }

        .post-footer {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-top: 12px;
            border-top: 1px solid var(--gold-pale);
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            background: none;
            border: 1px solid var(--gold-pale);
            cursor: pointer;
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 13px;
            color: var(--ink-light);
            transition: all 0.3s;
        }

        .action-btn:hover {
            background: var(--bg-warm);
            border-color: var(--gold);
            color: var(--red);
        }

        .action-btn .heart {
            font-size: 16px;
        }

        .praise-count {
            font-weight: 600;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 48px;
        }

        .empty-state .emoji {
            font-size: 64px;
            margin-bottom: 16px;
        }

        .empty-state p {
            color: var(--ink-light);
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            .post-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
        }

        /* 点赞动画 */
        @keyframes heartbeat {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.3); }
        }

        .heart-animation {
            animation: heartbeat 0.3s ease;
        }

        .toast {
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
            70% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面头部 -->
    <div class="forum-header">
        <h1>
            <span>💬</span> 戏曲爱好者论坛
            <span>🪭 </span>
        </h1>
        <p>以戏会友 · 交流心得 · 传承国粹</p>
        <div class="header-decoration"></div>
    </div>

    <!-- 发布帖子区域 -->
    <div class="publish-card">
        <div class="publish-title">
            <span>✍️</span> 发布新帖
        </div>

        <!-- 提示消息 -->
        <c:if test="${not empty msg}">
            <div class="alert">
                <span>✅</span> ${msg}
            </div>
        </c:if>

        <form class="publish-form" action="UserForumServlet?method=addPost" method="post">
            <div class="form-group">
                <label>📝 帖子标题</label>
                <input type="text" name="title" placeholder="请输入帖子标题..." required>
            </div>
            <div class="form-group">
                <label>💬 帖子内容</label>
                <textarea name="content" placeholder="分享你的戏曲心得、观剧感受、学习经验..." required></textarea>
            </div>
            <button type="submit" class="submit-btn">发布帖子</button>
        </form>
    </div>

    <!-- 帖子列表 -->
    <div class="posts-section">
        <div class="section-header">
            <h3>
                <span>📰</span> 精选帖子
            </h3>
            <div class="post-count">共 ${postList.size()} 篇帖子</div>
        </div>

        <!-- 帖子列表 -->
        <c:forEach items="${postList}" var="p">
            <div class="post-card" data-id="${p.id}">
                <div class="post-header">
                    <div class="post-title">${p.title}</div>
                </div>
                <div class="post-meta">
                    <span class="post-author">
                        👤 ${p.username != null ? p.username : '用户' }
                    </span>
                    <span>📅 ${p.createTime}</span>
                </div>
                <div class="post-content">
                        ${p.content}
                </div>
                <div class="post-footer">
                    <button class="action-btn" onclick="addPraise(${p.id}, this)">
                        <span class="heart">❤️</span>
                        <span class="praise-count">${p.praise != null ? p.praise : 0}</span>
                    </button>
                </div>
            </div>
        </c:forEach>

        <!-- 空状态 -->
        <c:if test="${empty postList}">
            <div class="empty-state">
                <div class="emoji">📭</div>
                <p>暂无帖子，快来发布第一条帖子吧！</p>
            </div>
        </c:if>
    </div>
</div>

<script>
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