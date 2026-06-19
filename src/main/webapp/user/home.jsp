<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 中华京剧文化学习平台</title>
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
            padding: 25px;
            color: var(--ink);
        }

        .container {
            max-width: 1300px;
            margin: 0 auto;
        }

        /* 欢迎横幅 */
        .hero {
            background: linear-gradient(135deg, var(--red), var(--red-dark));
            border-radius: 16px;
            padding: 50px 40px;
            margin-bottom: 32px;
            color: var(--bg-warm);
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            right: -40px;
            bottom: -60px;
            background: radial-gradient(circle, rgba(197,150,58,0.15) 0%, transparent 70%);
            pointer-events: none;
        }

        .hero h1 {
            font-size: 2rem;
            margin-bottom: 16px;
            font-weight: 700;
            letter-spacing: 2px;
            color: var(--bg-warm);
        }

        .hero p {
            font-size: 16px;
            opacity: 0.92;
            line-height: 1.8;
            max-width: 70%;
            color: var(--bg-warm);
        }

        .hero-badge {
            display: inline-block;
            background: rgba(197,150,58,0.25);
            border: 1px solid rgba(197,150,58,0.4);
            padding: 6px 16px;
            border-radius: 9999px;
            font-size: 13px;
            margin-bottom: 20px;
            color: var(--gold-pale);
        }

        /* 统计卡片 */
        .stats {
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

        .stat-emoji {
            font-size: 44px;
            margin-bottom: 12px;
        }

        .stat-number {
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

        /* 特色功能区域 */
        .section-title {
            text-align: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--ink);
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .section-title::after {
            content: "";
            display: block;
            width: 60px;
            height: 2px;
            background: linear-gradient(to right, var(--gold), transparent);
            margin: 12px auto 0;
        }

        .section-subtitle {
            text-align: center;
            color: var(--ink-light);
            margin-bottom: 32px;
            font-size: 15px;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            margin-bottom: 48px;
        }

        .feature {
            background: var(--bg-cream);
            border-radius: 12px;
            padding: 32px 24px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            border: 1px solid var(--gold-pale);
        }

        .feature:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: var(--gold);
        }

        .feature-icon {
            font-size: 56px;
            margin-bottom: 16px;
        }

        .feature h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 10px;
        }

        .feature p {
            font-size: 14px;
            color: var(--ink-soft);
            line-height: 1.7;
        }

        /* 推荐剧目 */
        .recommend-section {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            padding: 32px;
            margin-bottom: 40px;
            box-shadow: var(--shadow-md);
        }

        .recommend-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid linear-gradient(to right, var(--gold), transparent);
        }

        .recommend-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--ink);
            display: flex;
            align-items: center;
            gap: 8px;
            padding-left: 12px;
            border-left: 4px solid var(--gold);
        }

        .more-link {
            color: var(--gold);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .more-link:hover {
            color: var(--red-dark);
            text-decoration: underline;
        }

        .opera-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .opera-item {
            background: var(--bg-parchment);
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
            border: 1px solid var(--gold-pale);
        }

        .opera-item:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
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
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 6px;
        }

        .opera-info p {
            font-size: 13px;
            color: var(--ink-light);
            line-height: 1.6;
        }

        /* 文化名言 */
        .quote-block {
            background: linear-gradient(135deg, var(--ink), #2C2218);
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            color: var(--bg-warm);
            position: relative;
        }

        .quote-block::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--gold), transparent);
        }

        .quote-text {
            font-size: 18px;
            font-style: italic;
            line-height: 1.8;
            margin-bottom: 16px;
            color: var(--gold-pale);
        }

        .quote-author {
            font-size: 14px;
            color: var(--ink-light);
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
                font-size: 1.5rem;
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