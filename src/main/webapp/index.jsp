<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>京剧文化平台 - 登录</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">

    <!-- animate.css -->
    <link href="https://cdn.jsdelivr.net/npm/animate.css@4.1.1/animate.min.css" rel="stylesheet">

    <!-- Google Fonts: 思源宋体 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- 自定义样式 -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<div class="login-page">

        <!-- 左上角 Logo -->
        <div class="top-logo animate-fadeInUp">
            <span class="logo-title">京剧文化平台</span>
            <div class="logo-seal">
                <span class="logo-seal-text">雅韵</span>
            </div>
        </div>

    <div class="login-container">

        <!-- 左侧文化展示区 -->
        <div class="culture-panel">
        </div>

        <!-- 右侧登录卡片区 -->
        <div class="login-panel">
            <div class="login-card animate-fadeInRight">

                <!-- 卡片标题 -->
                <div class="login-card-header">
                    <h2>登录</h2>
                    <p>欢迎回来，请输入您的账号信息</p>
                </div>

                <!-- 错误消息提示 -->
                <c:if test="${not empty msg}">
                    <div class="error-alert">
                            ${msg}
                    </div>
                </c:if>

                <!-- 登录表单 -->
                <form action="${pageContext.request.contextPath}/LoginServlet?method=login" method="post">
                    <div class="form-group">
                        <label>用户名</label>
                        <div class="input-wrapper">
                            <input type="text" name="username" placeholder="请输入用户名" required>
                            <i class="bi bi-person-fill input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>密码</label>
                        <div class="input-wrapper">
                            <input type="password" name="password" placeholder="请输入密码" required>
                            <i class="bi bi-lock-fill input-icon"></i>
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember"> 记住密码
                        </label>
                        <a href="#" class="forgot-password">忘记密码？</a>
                    </div>

                    <button type="submit" class="login-btn">登 录</button>
                </form>

                <!-- 注册链接 -->
                <div class="register-link">
                    没有账号？ <a href="${pageContext.request.contextPath}/register.jsp">立即注册</a>
                </div>

                <!-- 测试账号提示 -->
                <div class="test-accounts">
                    <p>📢 测试账号</p>
                    <span class="account">管理员：admin / 123456</span>
                    <span class="account">普通用户：user1 / 123456</span>
                </div>

            </div>
        </div>

    </div>
</div>

<!-- Bootstrap 5 JS (可选，用于交互组件) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 表单提交前自动去除空格 -->
<script>
    document.querySelector('form').addEventListener('submit', function() {
        this.querySelectorAll('input[type="text"], input[type="password"]').forEach(function(input) {
            input.value = input.value.trim();
        });
    });
</script>
</body>
</html>
