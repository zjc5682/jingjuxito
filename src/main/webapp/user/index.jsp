<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>中华京剧文化学习平台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, 'Noto Sans CJK SC', sans-serif;
            background: linear-gradient(135deg, #f5f0e8 0%, #f0ebe0 100%);
            min-height: 100vh;
        }

        /* 侧边栏样式 */
        .sidebar {
            width: 280px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: linear-gradient(180deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            box-shadow: 2px 0 20px rgba(0, 0, 0, 0.1);
            z-index: 100;
            transition: all 0.3s ease;
            overflow-y: auto;
        }

        .sidebar::-webkit-scrollbar {
            width: 5px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
        }

        /* 用户信息区域 */
        .user-profile {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 20px;
        }

        .avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #e8b88a, #c62828);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 40px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
        }

        .avatar:hover {
            transform: scale(1.05);
        }

        .user-name {
            font-size: 20px;
            font-weight: 600;
            color: #fff;
            margin-bottom: 5px;
        }

        .user-score {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: rgba(255, 215, 0, 0.2);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            color: #ffd700;
            margin-top: 8px;
        }

        /* 导航菜单 */
        .nav-menu {
            padding: 0 15px;
        }

        .nav-item {
            margin-bottom: 8px;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s;
        }

        .nav-item a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 18px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s;
            border-radius: 12px;
        }

        .nav-item a:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            transform: translateX(5px);
        }

        .nav-item.active a {
            background: linear-gradient(135deg, #c62828, #b71c1c);
            color: #fff;
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
        }

        .nav-icon {
            font-size: 22px;
            width: 32px;
            text-align: center;
        }

        .logout-btn {
            margin-top: 40px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 20px;
        }

        .logout-btn a {
            color: rgba(255, 255, 255, 0.6);
        }

        .logout-btn a:hover {
            background: rgba(255, 255, 255, 0.05);
            color: #ff6b6b;
        }

        /* 右侧主内容区 */
        .main-content {
            margin-left: 280px;
            min-height: 100vh;
            padding: 20px 30px;
        }

        /* 顶部导航栏 */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 12px 25px;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title span {
            font-size: 26px;
        }

        .top-actions {
            display: flex;
            gap: 15px;
        }

        .top-actions .date {
            color: #888;
            font-size: 14px;
        }

        /* iframe 容器 */
        .iframe-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            min-height: calc(100vh - 120px);
        }

        iframe {
            width: 100%;
            height: calc(100vh - 120px);
            border: none;
        }

        /* 响应式 */
        @media (max-width: 1000px) {
            .sidebar {
                width: 80px;
            }
            .sidebar .user-name,
            .sidebar .user-score span:first-child,
            .sidebar .nav-item a span:last-child {
                display: none;
            }
            .sidebar .avatar {
                width: 50px;
                height: 50px;
                font-size: 26px;
            }
            .sidebar .nav-icon {
                font-size: 24px;
            }
            .main-content {
                margin-left: 80px;
            }
        }
    </style>
</head>
<body>

<!-- 侧边栏 -->
<div class="sidebar">
    <div class="user-profile">
        <div class="avatar">
            🪭
        </div>
        <div class="user-name">${loginUser.name}</div>
        <div class="user-score">
            <span>⭐</span> ${loginUser.score} 积分
        </div>
    </div>

    <div class="nav-menu">
        <div class="nav-item" id="nav-home">
            <a href="UserOperaServlet?method=getTop3" target="main" onclick="setActive('nav-home')">
                <span class="nav-icon">🏠</span>
                <span>平台首页</span>
            </a>
        </div>
        <div class="nav-item" id="nav-opera">
            <a href="UserOperaServlet?method=list" target="main" onclick="setActive('nav-opera')">
                <span class="nav-icon">📖</span>
                <span>京剧剧目</span>
            </a>
        </div>
        <div class="nav-item" id="nav-forum">
            <a href="UserForumServlet?method=list" target="main" onclick="setActive('nav-forum')">
                <span class="nav-icon">💬</span>
                <span>戏曲论坛</span>
            </a>
        </div>
        <div class="nav-item" id="nav-shop">
            <a href="UserShopServlet?method=list" target="main" onclick="setActive('nav-shop')">
                <span class="nav-icon">🎁</span>
                <span>积分商城</span>
            </a>
        </div>
        <div class="nav-item" id="nav-submit">
            <a href="UserSubmitServlet?method=toSubmit" target="main" onclick="setActive('nav-submit')">
                <span class="nav-icon">✍️</span>
                <span>作品投稿</span>
            </a>
        </div>
        <div class="nav-item" id="nav-personal">
            <a href="UserPersonalServlet?method=show" target="main" onclick="setActive('nav-personal')">
                <span class="nav-icon">👤</span>
                <span>个人中心</span>
            </a>
        </div>
        <div class="nav-item logout-btn" id="nav-logout">
            <a href="${pageContext.request.contextPath}/LoginServlet?method=logout" onclick="setActive('nav-logout')">
                <span class="nav-icon">🚪</span>
                <span>退出登录</span>
            </a>
        </div>
    </div>
</div>

<!-- 右侧主内容 -->
<div class="main-content">
    <div class="top-bar">
        <div class="page-title">
            <span>🪭 </span> 中华京剧文化交流学习平台
        </div>
        <div class="top-actions">
            <span class="date" id="currentDate"></span>
        </div>
    </div>

    <div class="iframe-container">
        <iframe name="main" src="UserOperaServlet?method=getTop3" frameborder="0"></iframe>
    </div>
</div>

<script>
    // 显示当前日期
    const date = new Date();
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const weekdays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    const weekday = weekdays[date.getDay()];
    document.getElementById('currentDate').innerHTML = year + '.' + month + '.' + day + ' ' + weekday;

    // 设置当前激活菜单的函数
    function setActive(activeId) {
        const navItems = ['nav-home', 'nav-opera', 'nav-forum', 'nav-shop', 'nav-submit', 'nav-personal', 'nav-logout'];

        navItems.forEach(function(itemId) {
            const element = document.getElementById(itemId);
            if (element) {
                element.classList.remove('active');
            }
        });

        const activeElement = document.getElementById(activeId);
        if (activeElement) {
            activeElement.classList.add('active');
        }

        localStorage.setItem('activeMenu', activeId);
    }

    // 页面加载时恢复高亮状态
    document.addEventListener('DOMContentLoaded', function() {
        const savedActive = localStorage.getItem('activeMenu');
        if (savedActive) {
            setActive(savedActive);
        } else {
            setActive('nav-home');
        }
    });

    // 监听 iframe 内的页面切换
    const iframe = document.querySelector('iframe[name="main"]');
    iframe.addEventListener('load', function() {
        try {
            const iframeUrl = iframe.contentWindow.location.href;
            if (iframeUrl.includes('getTop3')) {
                setActive('nav-home');
            } else if (iframeUrl.includes('UserOperaServlet') || iframeUrl.includes('opera.jsp')) {
                setActive('nav-opera');
            } else if (iframeUrl.includes('UserForumServlet') || iframeUrl.includes('forum.jsp')) {
                setActive('nav-forum');
            } else if (iframeUrl.includes('UserShopServlet') || iframeUrl.includes('shop.jsp')) {
                setActive('nav-shop');
            } else if (iframeUrl.includes('UserSubmitServlet') || iframeUrl.includes('submit.jsp')) {
                setActive('nav-submit');
            } else if (iframeUrl.includes('UserPersonalServlet') || iframeUrl.includes('personal.jsp')) {
                setActive('nav-personal');
            }
        } catch(e) {
            // 跨域问题，忽略
        }
    });
</script>

</body>
</html>