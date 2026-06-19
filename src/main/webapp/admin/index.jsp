<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, sans-serif;
        }

        .left {
            width: 260px;
            height: 100vh;
            background: linear-gradient(180deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            float: left;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }

        .left::-webkit-scrollbar {
            width: 5px;
        }

        .left::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        .left::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
        }

        .right {
            width: calc(100% - 260px);
            height: 100vh;
            float: right;
            background: #f5f5f5;
        }

        .top {
            padding: 20px;
            color: #fff;
            font-size: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(0, 0, 0, 0.2);
            font-weight: 600;
            letter-spacing: 2px;
        }

        .menu-item {
            display: block;
            color: rgba(255, 255, 255, 0.85);
            padding: 14px 20px;
            text-decoration: none;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.3s;
            font-size: 15px;
        }

        .menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            padding-left: 28px;
        }

        .logout-item {
            margin-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7);
        }

        .logout-item:hover {
            background: rgba(255, 80, 80, 0.2);
            color: #ff6b6b;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body>
<div class="left">
    <div class="top">🪭  管理员后台</div>
    <a class="menu-item" href="AdminUserServlet?method=list" target="main">👥 用户管理</a>
    <a class="menu-item" href="AdminOperaServlet?method=list" target="main">📖 剧目管理</a>
    <a class="menu-item" href="AdminForumServlet?method=list" target="main">💬 论坛管理</a>
    <a class="menu-item" href="AdminShopServlet?method=list" target="main">🎁 商品管理</a>
    <a class="menu-item" href="AdminSubmitServlet?method=list" target="main">📋 投稿审核</a>
    <a class="menu-item logout-item" href="${pageContext.request.contextPath}/LoginServlet?method=logout">🚪 退出系统</a>
</div>
<div class="right">
    <iframe name="main" src="AdminUserServlet?method=list" frameborder="0"></iframe>
</div>
</body>
</html>