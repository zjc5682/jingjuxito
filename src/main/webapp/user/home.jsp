<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 中华京剧文化学习平台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f0e8 0%, #f0ebe0 100%);
            padding: 25px;
        }

        .container {
            max-width: 1300px;
            margin: 0 auto;
        }

        /* 欢迎横幅 */
        .hero {
            background: linear-gradient(135deg, #c62828, #b71c1c);
            border-radius: 28px;
            padding: 50px 40px;
            margin-bottom: 35px;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: "🎭";
            position: absolute;
            font-size: 220px;
            opacity: 0.08;
            right: -30px;
            bottom: -50px;
            pointer-events: none;
        }

        .hero h1 {
            font-size: 36px;
            margin-bottom: 15px;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .hero p {
            font-size: 16px;
            opacity: 0.92;
            line-height: 1.8;
            max-width: 70%;
        }

        .hero-badge {
            display: inline-block;
            background: rgba(255, 215, 0, 0.25);
            backdrop-filter: blur(5px);
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 13px;
            margin-bottom: 20px;
        }

        /* 统计卡片 */
        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 28px 20px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .stat-emoji {
            font-size: 44px;
            margin-bottom: 12px;
        }

        .stat-number {
            font-size: 32px;
            font-weight: 800;
            color: #c62828;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
            letter-spacing: 1px;
        }

        /* 特色功能区域 */
        .section-title {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        .section-subtitle {
            text-align: center;
            color: #888;
            margin-bottom: 35px;
            font-size: 15px;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 45px;
        }

        .feature {
            background: white;
            border-radius: 24px;
            padding: 32px 24px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            border: 1px solid #f0f0f0;
        }

        .feature:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border-color: #c62828;
        }

        .feature-icon {
            font-size: 56px;
            margin-bottom: 18px;
        }

        .feature h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }

        .feature p {
            font-size: 14px;
            color: #777;
            line-height: 1.6;
        }

        /* 推荐剧目 */
        .recommend-section {
            background: white;
            border-radius: 24px;
            padding: 35px;
            margin-bottom: 40px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .recommend-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .recommend-header h3 {
            font-size: 22px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .more-link {
            color: #c62828;
            text-decoration: none;
            font-size: 14px;
        }

        .opera-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .opera-item {
            background: #f9f7f3;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
        }

        .opera-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .opera-img {
            height: 160px;
            overflow: hidden;
        }

        .opera-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .opera-item:hover .opera-img img {
            transform: scale(1.05);
        }

        .opera-info {
            padding: 16px;
        }

        .opera-info h4 {
            font-size: 18px;
            color: #333;
            margin-bottom: 6px;
        }

        .opera-info p {
            font-size: 13px;
            color: #888;
            line-height: 1.5;
        }

        /* 文化名言 */
        .quote-block {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            color: white;
        }

        .quote-text {
            font-size: 18px;
            font-style: italic;
            line-height: 1.8;
            margin-bottom: 15px;
        }

        .quote-author {
            font-size: 14px;
            opacity: 0.7;
        }

        /* 响应式 */
        @media (max-width: 1000px) {
            .stats, .features, .opera-list {
                grid-template-columns: repeat(2, 1fr);
            }
            .hero p {
                max-width: 100%;
            }
        }

        @media (max-width: 600px) {
            .stats, .features, .opera-list {
                grid-template-columns: 1fr;
            }
            .hero h1 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 欢迎横幅 -->
    <div class="hero">
        <div class="hero-badge">
            🏛️ 国家级非物质文化遗产 · 人类口述和非物质遗产代表作
        </div>
        <h1>欢迎来到中华京剧文化学习平台</h1>
        <p>
            京剧，又称平剧、京戏，中国国粹，位列中国戏曲三鼎甲榜首。<br>
            平台提供经典剧目查阅、爱好者论坛交流、戏曲周边积分兑换、原创戏曲文稿投稿功能。
        </p>
    </div>

    <!-- 统计卡片 -->
    <div class="stats">
        <div class="stat-card">
            <div class="stat-emoji">📖</div>
            <div class="stat-number">300+</div>
            <div class="stat-label">经典剧目</div>
        </div>
        <div class="stat-card">
            <div class="stat-emoji">👥</div>
            <div class="stat-number">10,000+</div>
            <div class="stat-label">活跃用户</div>
        </div>
        <div class="stat-card">
            <div class="stat-emoji">💬</div>
            <div class="stat-number">5,000+</div>
            <div class="stat-label">论坛帖子</div>
        </div>
        <div class="stat-card">
            <div class="stat-emoji">🎁</div>
            <div class="stat-number">50+</div>
            <div class="stat-label">文创商品</div>
        </div>
    </div>

    <!-- 特色功能 -->
    <div class="section-title">平台特色功能</div>
    <div class="section-subtitle">传承国粹，弘扬中华优秀传统文化</div>

    <div class="features">
        <div class="feature" onclick="parent.frames['main'].location.href='UserOperaServlet?method=list'">
            <div class="feature-icon">📚</div>
            <h3>经典剧目查阅</h3>
            <p>收录经典京剧剧目，了解剧情梗概、行当分类、唱词鉴赏</p>
        </div>
        <div class="feature" onclick="parent.frames['main'].location.href='UserForumServlet?method=list'">
            <div class="feature-icon">🗣️</div>
            <h3>爱好者论坛交流</h3>
            <p>与全国戏迷分享观剧心得，交流学习经验，结交同道好友</p>
        </div>
        <div class="feature" onclick="parent.frames['main'].location.href='UserShopServlet?method=list'">
            <div class="feature-icon">🎁</div>
            <h3>戏曲周边积分商城</h3>
            <p>学习获取积分，兑换精美京剧文创产品</p>
        </div>
        <div class="feature" onclick="parent.frames['main'].location.href='UserSubmitServlet?method=toSubmit'">
            <div class="feature-icon">✍️</div>
            <h3>原创戏曲文稿投稿</h3>
            <p>展示才华，让更多人看到你的戏曲相关作品</p>
        </div>
    </div>

    <!-- 推荐剧目（从数据库读取） -->
    <div class="recommend-section">
        <div class="recommend-header">
            <h3>🪭 热门推荐剧目</h3>
            <a href="#" class="more-link" onclick="parent.frames['main'].location.href='UserOperaServlet?method=list'">查看全部 →</a>
        </div>
        <div class="opera-list">
            <c:forEach items="${operaList}" var="o" end="2">
                <div class="opera-item" onclick="parent.frames['main'].location.href='UserOperaServlet?method=list'">
                    <div class="opera-img">
                        <img src="${o.img}" alt="${o.title}" onerror="this.src='https://picsum.photos/300/160?random=1'">
                    </div>
                    <div class="opera-info">
                        <h4>${o.title}</h4>
                        <p>${o.content != null ? o.content : '经典京剧剧目'}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 文化名言 -->
    <div class="quote-block">
        <div class="quote-text">
            “台上十分钟，台下十年功。一声皮黄腔，多少中华情。”
        </div>
        <div class="quote-author">—— 京剧艺术 · 国粹传承</div>
    </div>
</div>

<script>
    // 统计数字动画
    const statNumbers = document.querySelectorAll('.stat-number');
    statNumbers.forEach(el => {
        const finalValue = el.innerText;
        el.innerText = '0';
        let current = 0;
        const target = parseInt(finalValue);
        const step = target / 50;
        const timer = setInterval(() => {
            current += step;
            if (current >= target) {
                el.innerText = finalValue;
                clearInterval(timer);
            } else {
                el.innerText = Math.floor(current);
            }
        }, 20);
    });
</script>
</body>
</html>