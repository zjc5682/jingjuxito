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
            max-width: 1000px;
            margin: 0 auto;
        }

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

        .header-decoration {
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #b71c1c, #e8b88a, #b71c1c);
            margin: 15px auto 0;
            border-radius: 3px;
        }

        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            border-bottom: 2px solid #e5e5e5;
            flex-wrap: wrap;
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
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .card-header {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            padding: 20px 30px;
            color: white;
        }

        .card-header h3 {
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-body {
            padding: 30px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .avatar-section {
            text-align: center;
        }

        .avatar-img {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #e8b88a, #c62828);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            margin-bottom: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .info-section {
            flex: 1;
        }

        .info-row {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-label {
            width: 100px;
            font-weight: 600;
            color: #666;
        }

        .info-value {
            flex: 1;
            color: #333;
        }

        .score-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: linear-gradient(135deg, #ffd700, #ffb300);
            padding: 8px 20px;
            border-radius: 30px;
            color: #5d4037;
            font-weight: bold;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 10px 25px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(183, 28, 28, 0.3);
        }

        .btn-outline {
            background: white;
            border: 2px solid #b71c1c;
            color: #b71c1c;
        }

        .btn-outline:hover {
            background: #b71c1c;
            color: white;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #b71c1c;
            box-shadow: 0 0 0 3px rgba(183, 28, 28, 0.1);
        }

        .alert {
            padding: 12px 18px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
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
            border-bottom: 1px solid #eee;
        }

        .growth-table th {
            background: #faf5f0;
            color: #b71c1c;
            font-weight: 600;
        }

        .growth-table tr:hover {
            background: #faf5f0;
        }

        .score-plus {
            color: #4caf50;
        }

        .score-minus {
            color: #f44336;
        }

        .empty-state {
            text-align: center;
            padding: 60px;
            color: #999;
        }

        .empty-state .emoji {
            font-size: 48px;
            margin-bottom: 15px;
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

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            .profile-header {
                flex-direction: column;
                text-align: center;
            }
            .info-row {
                flex-direction: column;
            }
            .info-label {
                width: 100%;
                margin-bottom: 5px;
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