<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 京剧文化平台</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts: 思源宋体 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-paper: #FFF8EE;
            --red-face: #C53A2F;
            --red-dark: #8B1A1A;
            --gold-line: #B8860B;
            --border-sand: #D9CFBF;
            --text-dark: #3E3E3E;
            --text-light: #888888;
            --card-shadow: 0 8px 30px rgba(62, 62, 62, 0.12);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', sans-serif;
            background-color: #f5e6c8;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* 背景图与蒙版 */
        .register-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
            position: relative;
            background-color: #f5e6c8;
            overflow: hidden;
        }

        .register-page::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image: url("img/login-bg.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            pointer-events: none;
        }

        .register-page::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(245,230,200,0.75) 0%, rgba(232,213,168,0.65) 30%, rgba(240,224,184,0.7) 60%, rgba(229,208,160,0.75) 100%);
            pointer-events: none;
        }

        /* 左上角 Logo */
        .top-logo {
            position: fixed;
            top: 20px;
            left: 25px;
            z-index: 10;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .top-logo .logo-title {
            font-family: 'Noto Serif SC', '思源宋体', 'SimSun', serif;
            font-size: 18px;
            font-weight: 700;
            color: var(--red-face);
            letter-spacing: 3px;
        }

        .top-logo .logo-seal {
            width: 42px;
            height: 42px;
            background-color: var(--red-face);
            border: 2px solid var(--red-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            transform: rotate(-5deg);
            box-shadow: 2px 2px 6px rgba(139, 26, 26, 0.25);
        }

        .top-logo .logo-seal-text {
            font-family: 'Noto Serif SC', '思源宋体', 'SimSun', serif;
            font-size: 16px;
            font-weight: 700;
            color: #FFFFFF;
            letter-spacing: 2px;
            writing-mode: vertical-rl;
        }

        /* 主容器 */
        .register-wrapper {
            display: flex;
            width: 100%;
            max-width: 1200px;
            min-height: 650px;
            background: rgba(255, 255, 255, 0.85);
            border-radius: 20px;
            box-shadow: 0 12px 40px rgba(62, 62, 62, 0.15);
            overflow: hidden;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
        }

        /* 左侧图片区 */
        .register-left {
            flex: 0 0 540px;
            background-color: #f5e6c8;
            position: relative;
            overflow: hidden;
        }

        .register-left::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image: url("img/culture-bg.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            opacity: 0.95;
            pointer-events: none;
        }

        .register-left::after {
            content: '';
            position: absolute;
            right: 0;
            top: 10%;
            height: 80%;
            width: 1px;
            background: linear-gradient(to bottom, transparent, var(--gold-line), var(--gold-line), transparent);
            opacity: 0.6;
        }

        /* 右侧表单区 */
        .register-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 40px;
            background: #FFFFFF;
        }

        .register-card {
            width: 100%;
            max-width: 360px;
        }

        .logo-area {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo-area h2 {
            font-size: 24px;
            color: var(--red-face);
            margin-top: 8px;
            font-weight: 600;
        }

        .logo-area p {
            color: var(--text-light);
            font-size: 13px;
            margin-top: 4px;
        }

        .register-title {
            text-align: center;
            margin-bottom: 25px;
        }

        .register-title h3 {
            font-size: 22px;
            color: var(--text-dark);
            font-weight: 500;
        }

        .register-title p {
            font-size: 13px;
            color: var(--text-light);
            margin-top: 5px;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
        }

        .alert-success {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
        }

        .alert-error {
            background: #FEE2E2;
            border: 1px solid #FECACA;
            color: #DC2626;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-dark);
            margin-bottom: 6px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            color: var(--border-sand);
            transition: color 0.3s ease;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 14px 16px 14px 44px;
            background-color: var(--bg-paper);
            border: 1px solid var(--border-sand);
            border-radius: 8px;
            font-size: 15px;
            color: var(--text-dark);
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group input::placeholder {
            color: #C4B8A8;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--red-face);
            box-shadow: 0 0 0 3px rgba(197, 58, 47, 0.2);
            background-color: #FFFFFF;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .register-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--red-face), var(--red-dark));
            color: #FFFFFF;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(197, 58, 47, 0.3);
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(197, 58, 47, 0.4);
        }

        .register-btn:active {
            transform: translateY(0);
            background: linear-gradient(135deg, var(--red-dark), #6B0F0F);
        }

        .login-link {
            text-align: center;
            margin-top: 18px;
            padding-top: 14px;
            border-top: 1px solid #F0EBE3;
            font-size: 14px;
            color: var(--text-light);
        }

        .login-link a {
            color: var(--gold-line);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .login-link a:hover {
            text-decoration: underline;
            color: #D4A017;
        }

        .tips {
            margin-top: 16px;
            padding: 12px;
            background: #FDF8F0;
            border: 1px solid #EDE4D4;
            border-radius: 10px;
            font-size: 12px;
            color: #8B7355;
            text-align: center;
        }

        @media (max-width: 550px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }
    </style>
</head>
<body>
<div class="register-page">

    <!-- 左上角 Logo -->
    <div class="top-logo">
        <span class="logo-title">京剧文化平台</span>
        <div class="logo-seal">
            <span class="logo-seal-text">雅韵</span>
        </div>
    </div>

    <div class="register-wrapper">

        <!-- 左侧文化展示区 -->
        <div class="register-left">
        </div>

        <!-- 右侧注册卡片区 -->
        <div class="register-right">
            <div class="register-card">
                <div class="logo-area">
            <h2>注册新账号</h2>
            <p>加入京剧文化大家庭</p>
        </div>

        <c:if test="${not empty msg}">
            <div class="alert ${msg.contains('成功') ? 'alert-success' : 'alert-error'}">
                <span>${msg.contains('成功') ? '✅' : '⚠️'}</span> ${msg}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/RegisterServlet?method=register" method="post">
            <div class="form-group">
                <label>用户名 *</label>
                <div class="input-wrapper">
                    <span class="input-icon">👤</span>
                    <input type="text" name="username" placeholder="请输入用户名（4-20位）" required>
                </div>
            </div>

            <div class="form-group">
                <label>密码 *</label>
                <div class="input-wrapper">
                    <span class="input-icon">🔒</span>
                    <input type="password" name="password" placeholder="请输入密码（至少6位）" required>
                </div>
            </div>

            <div class="form-group">
                <label>确认密码 *</label>
                <div class="input-wrapper">
                    <span class="input-icon">🔐</span>
                    <input type="password" name="confirmPassword" placeholder="请再次输入密码" required>
                </div>
            </div>

            <div class="form-group">
                <label>手机号</label>
                <div class="input-wrapper">
                    <span class="input-icon">📱</span>
                    <input type="tel" name="phone" placeholder="请输入手机号">
                </div>
            </div>

            <button type="submit" class="register-btn">立即注册</button>
        </form>

        <div class="login-link">
            已有账号？ <a href="${pageContext.request.contextPath}/index.jsp">返回登录</a>
        </div>

        <div class="tips">
            💡 注册即表示同意平台用户协议，初始赠送100积分
        </div>

            </div>
        </div>

    </div>
</div>

<!-- 表单提交前自动去除空格 -->
<script>
    document.querySelector('form').addEventListener('submit', function() {
        this.querySelectorAll('input[type="text"], input[type="password"], input[type="email"], input[type="tel"]').forEach(function(input) {
            input.value = input.value.trim();
        });
    });
</script>
</body>
</html>