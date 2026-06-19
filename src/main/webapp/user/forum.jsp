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
        .forum-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .forum-header h1 {
            font-size: 36px;
            color: #b71c1c;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .forum-header p {
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

        /* 发布帖子区域 */
        .publish-card {
            background: white;
            border-radius: 24px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .publish-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        .publish-title span {
            font-size: 28px;
        }

        .publish-form input,
        .publish-form textarea {
            width: 100%;
            border: 1.5px solid #e5e7eb;
            border-radius: 14px;
            padding: 14px 16px;
            font-size: 14px;
            transition: all 0.3s;
            background: #f9fafb;
        }

        .publish-form input:focus,
        .publish-form textarea:focus {
            outline: none;
            border-color: #b71c1c;
            background: white;
            box-shadow: 0 0 0 3px rgba(183, 28, 28, 0.1);
        }

        .publish-form textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #555;
            margin-bottom: 8px;
        }

        .submit-btn {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(183, 28, 28, 0.4);
        }

        /* 提示消息 */
        .alert {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 12px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-error {
            background: #ffebee;
            border-color: #ffcdd2;
            color: #c62828;
        }

        /* 帖子列表 */
        .posts-section {
            background: white;
            border-radius: 24px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .section-header h3 {
            font-size: 20px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .post-count {
            background: #f0f0f0;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            color: #666;
        }

        /* 帖子卡片 */
        .post-card {
            background: #f9f7f3;
            border-radius: 20px;
            padding: 22px;
            margin-bottom: 18px;
            transition: all 0.3s;
            border: 1px solid #f0e6d8;
        }

        .post-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border-color: #e8b88a;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .post-title {
            font-size: 18px;
            font-weight: 700;
            color: #333;
        }

        .post-meta {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 12px;
            color: #999;
            margin-bottom: 12px;
        }

        .post-author {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-content {
            color: #555;
            line-height: 1.7;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .post-footer {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-top: 12px;
            border-top: 1px solid #e5e5e5;
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 13px;
            color: #888;
            transition: all 0.3s;
        }

        .action-btn:hover {
            background: #fff0f0;
            color: #c62828;
        }

        .action-btn .heart {
            font-size: 18px;
        }

        .praise-count {
            font-weight: 600;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 60px;
        }

        .empty-state .emoji {
            font-size: 64px;
            margin-bottom: 15px;
        }

        .empty-state p {
            color: #999;
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