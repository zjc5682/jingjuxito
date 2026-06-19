<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - 中华京剧文化交流学习平台</title>
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
            max-width: 1000px;
            margin: 0 auto;
        }

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

        .header-decoration {
            width: 80px;
            height: 2px;
            background: linear-gradient(90deg, var(--gold), transparent);
            margin: 16px auto 0;
        }

        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            border-bottom: 1px solid var(--gold-pale);
            flex-wrap: wrap;
        }

        .tab-btn {
            padding: 12px 24px;
            background: none;
            border: none;
            font-size: 15px;
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

        .card {
            background: var(--bg-cream);
            border: 1px solid var(--gold-pale);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
        }

        .card-header {
            background: var(--ink);
            padding: 18px 24px;
            color: var(--bg-warm);
            position: relative;
        }

        .card-header::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--gold), transparent);
        }

        .card-header h3 {
            font-size: 1.1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--gold-pale);
        }

        .card-body {
            padding: 28px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 32px;
            margin-bottom: 28px;
            flex-wrap: wrap;
        }

        .avatar-section {
            text-align: center;
        }

        .avatar-img {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--red), var(--red-dark));
            border: 3px solid var(--gold-pale);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            margin-bottom: 10px;
            box-shadow: var(--shadow-md);
        }

        .info-section {
            flex: 1;
        }

        .info-row {
            display: flex;
            margin-bottom: 14px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--gold-pale);
        }

        .info-label {
            width: 100px;
            font-weight: 600;
            color: var(--ink-light);
            font-size: 14px;
        }

        .info-value {
            flex: 1;
            color: var(--ink);
            font-size: 14px;
        }

        .score-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(197,150,58,0.15);
            border: 1px solid var(--gold-pale);
            padding: 6px 18px;
            border-radius: 9999px;
            color: var(--gold-deep);
            font-weight: 600;
            font-size: 14px;
        }

        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 10px 24px;
            border-radius: 9999px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-family: inherit;
        }

        .btn-primary {
            background: var(--red);
            color: var(--bg-warm);
        }

        .btn-primary:hover {
            background: var(--red-dark);
            box-shadow: var(--shadow-md);
        }

        .btn-outline {
            background: transparent;
            border: 1.5px solid var(--gold);
            color: var(--gold);
        }

        .btn-outline:hover {
            background: var(--gold-pale);
            color: var(--gold-deep);
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

        .form-group input {
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

        .form-group input::placeholder {
            color: var(--ink-light);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--red);
            box-shadow: 0 0 0 2px rgba(197,150,58,0.25);
        }

        .alert {
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .alert-error {
            background: #ffebee;
            color: var(--red);
            border: 1px solid #ffcdd2;
        }

        .growth-table {
            width: 100%;
            border-collapse: collapse;
        }

        .growth-table th,
        .growth-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--gold-pale);
            font-size: 14px;
        }

        .growth-table th {
            background: var(--bg-parchment);
            color: var(--ink-soft);
            font-weight: 600;
        }

        .growth-table tr:hover {
            background: var(--bg-parchment);
        }

        .score-plus {
            color: #2e7d32;
            font-weight: 600;
        }

        .score-minus {
            color: var(--red);
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 48px;
            color: var(--ink-light);
        }

        .empty-state .emoji {
            font-size: 48px;
            margin-bottom: 16px;
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

        @media (max-width: 768px) {
            body { padding: 15px; }
            .profile-header {
                flex-direction: column;
                text-align: center;
            }
            .info-row {
                flex-direction: column;
            }
            .info-label {
                width: 100%;
                margin-bottom: 4px;
            }
            .tabs {
                justify-content: center;
            }
            .tab-btn {
                padding: 8px 16px;
                font-size: 14px;
            }
            .growth-table {
                font-size: 12px;
            }
            .growth-table th,
            .growth-table td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>
            <span>👤</span> 个人中心
            <span>🪭 </span>
        </h1>
        <div class="header-decoration"></div>
    </div>

    <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('profile')">📋 个人资料</button>
        <button class="tab-btn" onclick="switchTab('edit')">✏️ 编辑资料</button>
        <button class="tab-btn" onclick="switchTab('password')">🔒 修改密码</button>
        <button class="tab-btn" onclick="loadGrowth()">📈 成长记录</button>
    </div>

    <!-- 个人资料面板 -->
    <div id="profilePanel" class="tab-panel active">
        <div class="card">
            <div class="card-header">
                <h3>📋 个人信息</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty msg}">
                    <div class="alert alert-success">
                        <span>✅</span> ${msg}
                    </div>
                </c:if>

                <div class="profile-header">
                    <div class="avatar-section">
                        <div class="avatar-img">🪭 </div>
                    </div>
                    <div class="info-section">
                        <div class="info-row">
                            <div class="info-label">账号：</div>
                            <div class="info-value">${loginUser.username}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">姓名：</div>
                            <div class="info-value">${loginUser.name != null ? loginUser.name : '未设置'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">手机号：</div>
                            <div class="info-value">${loginUser.phone != null ? loginUser.phone : '未填写'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">邮箱：</div>
                            <div class="info-value">${loginUser.email != null ? loginUser.email : '未填写'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">可用积分：</div>
                            <div class="info-value">
                                <span class="score-badge">⭐ ${loginUser.score} 积分</span>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">角色：</div>
                            <div class="info-value">${loginUser.role == 1 ? '管理员' : '普通用户'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">注册时间：</div>
                            <div class="info-value">
                                <fmt:formatDate value="${loginUser.createTime}" pattern="yyyy年MM月dd日 HH:mm"/>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">最后登录：</div>
                            <div class="info-value">
                                <fmt:formatDate value="${loginUser.lastLoginTime}" pattern="yyyy年MM月dd日 HH:mm"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 编辑资料面板 -->
    <div id="editPanel" class="tab-panel">
        <div class="card">
            <div class="card-header">
                <h3>✏️ 编辑个人资料</h3>
            </div>
            <div class="card-body">
                <form action="UserPersonalServlet?method=save" method="post">
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" name="name" value="${loginUser.name}" placeholder="请输入姓名">
                    </div>
                    <div class="form-group">
                        <label>手机号</label>
                        <input type="tel" name="phone" value="${loginUser.phone}" placeholder="请输入手机号">
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <input type="email" name="email" value="${loginUser.email}" placeholder="请输入邮箱">
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">💾 保存修改</button>
                        <button type="button" class="btn btn-outline" onclick="switchTab('profile')">↩️ 取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 修改密码面板 -->
    <div id="passwordPanel" class="tab-panel">
        <div class="card">
            <div class="card-header">
                <h3>🔒 修改密码</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty pwdMsg}">
                    <div class="alert ${pwdMsg.contains('成功') ? 'alert-success' : 'alert-error'}">
                        <span>${pwdMsg.contains('成功') ? '✅' : '⚠️'}</span> ${pwdMsg}
                    </div>
                </c:if>
                <form action="UserPersonalServlet?method=changePassword" method="post">
                    <div class="form-group">
                        <label>原密码</label>
                        <input type="password" name="oldPassword" placeholder="请输入原密码" required>
                    </div>
                    <div class="form-group">
                        <label>新密码</label>
                        <input type="password" name="newPassword" placeholder="请输入新密码（至少6位）" required>
                    </div>
                    <div class="form-group">
                        <label>确认新密码</label>
                        <input type="password" name="confirmPassword" placeholder="请再次输入新密码" required>
                    </div>
                    <button type="submit" class="btn btn-primary">🔐 确认修改</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 成长记录面板 -->
    <div id="growthPanel" class="tab-panel">
        <div class="card">
            <div class="card-header">
                <h3>📈 我的成长记录</h3>
            </div>
            <div class="card-body" id="growthContent">
                <div class="empty-state">
                    <div class="spinner"></div>
                    <p>加载中...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function switchTab(tab) {
        // 隐藏所有面板
        document.getElementById('profilePanel').classList.remove('active');
        document.getElementById('editPanel').classList.remove('active');
        document.getElementById('passwordPanel').classList.remove('active');
        document.getElementById('growthPanel').classList.remove('active');

        // 移除所有按钮的active类
        const tabs = document.querySelectorAll('.tab-btn');
        tabs.forEach(btn => btn.classList.remove('active'));

        if (tab === 'profile') {
            document.getElementById('profilePanel').classList.add('active');
            tabs[0].classList.add('active');
        } else if (tab === 'edit') {
            document.getElementById('editPanel').classList.add('active');
            tabs[1].classList.add('active');
        } else if (tab === 'password') {
            document.getElementById('passwordPanel').classList.add('active');
            tabs[2].classList.add('active');
        }
    }

    function loadGrowth() {
        // 切换到成长记录面板
        const tabs = document.querySelectorAll('.tab-btn');
        tabs.forEach(btn => btn.classList.remove('active'));
        tabs[3].classList.add('active');

        document.getElementById('profilePanel').classList.remove('active');
        document.getElementById('editPanel').classList.remove('active');
        document.getElementById('passwordPanel').classList.remove('active');
        document.getElementById('growthPanel').classList.add('active');

        const contentDiv = document.getElementById('growthContent');
        contentDiv.innerHTML = '<div class="empty-state"><div class="spinner"></div><p>加载中...</p></div>';

        fetch('UserPersonalServlet?method=growth&ajax=true', {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.text())
            .then(html => {
                contentDiv.innerHTML = html;
            })
            .catch(error => {
                console.error('加载失败:', error);
                contentDiv.innerHTML = '<div class="empty-state"><div class="emoji">❌</div><p>加载失败，请刷新重试</p></div>';
            });
    }
</script>
</body>
</html>