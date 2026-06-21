<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - 梨园芳华</title>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <!-- 设计系统CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jingju-design-system.css">
    <style>
        /* ========================================
           个人中心 - 梨园雅室风格
           主色: #C41E3A  辅色: #D4A017
           ======================================== */

        /* 用户信息头部 - 京剧红色主题 */
        .user-header {
            background: linear-gradient(135deg, #1a0505 0%, #3a0a0a 40%, #2a0808 100%);
            border-radius: var(--radius-xl);
            padding: 40px;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            gap: 32px;
            flex-wrap: wrap;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(212, 160, 23, 0.25);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2), inset 0 1px 0 rgba(212, 160, 23, 0.15);
        }

        /* 顶部金色装饰线 */
        .user-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent 5%, #D4A017 30%, #f0d060 50%, #D4A017 70%, transparent 95%);
        }

        /* 底部金色装饰线 */
        .user-header::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 10%;
            right: 10%;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(212, 160, 23, 0.3), transparent);
        }

        .user-avatar {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #C41E3A, #8B0000);
            border: 3px solid #D4A017;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 20px rgba(196, 30, 58, 0.4), 0 0 0 6px rgba(212, 160, 23, 0.1);
            position: relative;
            z-index: 1;
            flex-shrink: 0;
        }

        .user-avatar .material-symbols-outlined {
            font-size: 48px;
            color: #fff;
        }

        .user-info {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .user-name {
            font-family: var(--font-headline);
            font-size: 28px;
            font-weight: 700;
            color: #f7f0e6;
            margin-bottom: 10px;
            letter-spacing: 0.05em;
        }

        .user-meta {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .user-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(212, 160, 23, 0.15);
            border: 1px solid rgba(212, 160, 23, 0.35);
            padding: 6px 16px;
            border-radius: var(--radius-full);
            font-size: var(--text-label-md);
            color: #f0d060;
            backdrop-filter: blur(4px);
        }

        .user-score {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(196, 30, 58, 0.2);
            border: 1px solid rgba(196, 30, 58, 0.4);
            padding: 6px 16px;
            border-radius: var(--radius-full);
            font-size: var(--text-label-md);
            font-weight: 600;
            color: #ffb4a8;
            backdrop-filter: blur(4px);
        }

        /* Tab切换 - 胶囊风格 */
        .tabs {
            display: flex;
            gap: 4px;
            margin-bottom: 32px;
            background: var(--surface-container);
            padding: 6px;
            border-radius: var(--radius-xl);
            flex-wrap: wrap;
        }

        .tab-btn {
            padding: 12px 24px;
            background: none;
            border: none;
            font-size: var(--text-body-md);
            font-weight: 600;
            color: var(--on-surface-variant);
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            font-family: var(--font-body);
            display: flex;
            align-items: center;
            gap: 8px;
            border-radius: var(--radius-lg);
            flex: 1;
            justify-content: center;
            min-width: 120px;
        }

        .tab-btn.active {
            color: #fff;
            background: linear-gradient(135deg, #C41E3A, #9e0000);
            box-shadow: 0 4px 12px rgba(196, 30, 58, 0.3);
        }

        .tab-btn.active::after {
            display: none;
        }

        .tab-btn:hover:not(.active) {
            color: var(--primary);
            background: var(--surface-container-low);
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

        /* 信息卡片 - 雅室风格 */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 20px;
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            border: 1px solid var(--surface-container);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            transition: all 0.3s ease;
        }

        .info-item:hover {
            border-color: rgba(212, 160, 23, 0.3);
            box-shadow: 0 4px 16px rgba(196, 30, 58, 0.08);
            transform: translateY(-2px);
        }

        .info-item-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, rgba(196, 30, 58, 0.08), rgba(212, 160, 23, 0.08));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            border: 1px solid rgba(196, 30, 58, 0.1);
        }

        .info-item-icon .material-symbols-outlined {
            font-size: 24px;
            color: #C41E3A;
        }

        .info-item-content {
            flex: 1;
        }

        .info-item-label {
            font-size: var(--text-label-md);
            color: var(--on-surface-variant);
            margin-bottom: 4px;
        }

        .info-item-value {
            font-size: var(--text-body-md);
            font-weight: 600;
            color: var(--on-surface);
        }

        /* 表单卡片 - 金色边框风格 */
        .form-card {
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius-xl);
            border: 1px solid var(--surface-container);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        .form-card-header {
            background: linear-gradient(135deg, #1a0505, #3a0a0a);
            padding: 24px 28px;
            position: relative;
        }

        .form-card-header::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 5%;
            right: 5%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #D4A017, transparent);
        }

        .form-card-header h3 {
            font-family: var(--font-headline);
            font-size: var(--text-headline-md);
            font-weight: 600;
            color: #f0d060;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-card-header h3 .material-symbols-outlined {
            color: #D4A017;
        }

        .form-card-body {
            padding: 32px;
        }

        /* 提示框 */
        .alert {
            padding: 14px 20px;
            border-radius: var(--radius-lg);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: var(--text-body-md);
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .alert-error {
            background: #ffebee;
            color: var(--error);
            border: 1px solid #ffcdd2;
        }

        /* 按钮组 */
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
            flex-wrap: wrap;
        }

        /* 表格 */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th,
        .data-table td {
            padding: 14px 16px;
            text-align: left;
            border-bottom: 1px solid var(--outline-variant);
            font-size: var(--text-body-md);
        }

        .data-table th {
            background-color: var(--surface-container);
            color: var(--on-surface-variant);
            font-weight: 600;
            font-size: var(--text-label-md);
        }

        .data-table tr:hover {
            background-color: var(--surface-container-low);
        }

        .score-plus {
            color: #2e7d32;
            font-weight: 600;
        }

        .score-minus {
            color: var(--error);
            font-weight: 600;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 48px;
            color: var(--on-surface-variant);
        }

        .empty-state .material-symbols-outlined {
            font-size: 64px;
            color: var(--outline-variant);
            margin-bottom: 16px;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 3px solid var(--outline-variant);
            border-top: 3px solid #C41E3A;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 16px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .user-header {
                flex-direction: column;
                text-align: center;
                padding: 32px 24px;
            }
            .user-meta {
                justify-content: center;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
            .tabs {
                gap: 4px;
                padding: 4px;
            }
            .tab-btn {
                padding: 10px 16px;
                font-size: var(--text-label-md);
                min-width: 0;
            }
            .form-card-body {
                padding: 24px 20px;
            }
        }
        /* ===== 退出登录模态框 - 梨园风格 ===== */
        .logout-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(30, 27, 22, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .logout-modal-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .logout-modal {
            background: linear-gradient(180deg, #f8f0e3 0%, #f0e6d2 100%);
            border: 1px solid var(--gold-pale);
            border-radius: var(--radius-xl);
            padding: 0;
            width: 420px;
            max-width: 90vw;
            box-shadow:
                0 24px 64px rgba(0, 0, 0, 0.2),
                0 0 0 1px rgba(212, 175, 55, 0.1);
            transform: scale(0.92) translateY(12px);
            transition: transform 0.3s ease;
            overflow: hidden;
        }

        .logout-modal-overlay.active .logout-modal {
            transform: scale(1) translateY(0);
        }

        /* 顶部金线 */
        .logout-modal::before {
            content: "";
            display: block;
            height: 3px;
            background: linear-gradient(90deg, transparent 5%, var(--gold) 30%, #f0d060 50%, var(--gold) 70%, transparent 95%);
        }

        .logout-modal-body {
            padding: 36px 32px 28px;
            display: flex;
            gap: 20px;
            align-items: flex-start;
        }

        .logout-modal-content {
            flex: 1;
        }

        .logout-modal-title {
            font-family: var(--font-headline);
            font-size: 22px;
            font-weight: 700;
            color: var(--ink);
            margin-bottom: 10px;
            letter-spacing: 0.05em;
        }

        .logout-modal-text {
            font-family: var(--font-body);
            font-size: 15px;
            color: var(--ink-light);
            line-height: 1.7;
        }

        /* 底部分隔线 + 按钮区 */
        .logout-modal-footer {
            padding: 0 32px 28px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .logout-modal-btn {
            padding: 10px 28px;
            border-radius: var(--radius-lg);
            font-family: var(--font-body);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
            letter-spacing: 0.03em;
        }

        .logout-modal-btn-cancel {
            background: transparent;
            color: var(--ink-light);
            border: 1px solid var(--outline-variant);
        }

        .logout-modal-btn-cancel:hover {
            background: var(--surface-container);
            border-color: var(--outline);
        }

        .logout-modal-btn-confirm {
            background: linear-gradient(135deg, var(--primary), var(--primary-container));
            color: var(--on-primary);
            box-shadow: 0 2px 8px rgba(158, 0, 0, 0.25);
        }

        .logout-modal-btn-confirm:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 16px rgba(158, 0, 0, 0.35);
        }

        /* 键盘焦点 */
        .logout-modal-btn:focus-visible {
            outline: 2px solid var(--primary);
            outline-offset: 2px;
        }

    </style>
</head>
<body>
<div class="app-layout">
    <!-- 侧边导航栏 -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ccircle cx='50' cy='50' r='50' fill='%239e0000'/%3E%3Ctext x='50' y='65' font-size='40' fill='white' text-anchor='middle' font-family='serif'%3E梨%3C/text%3E%3C/svg%3E" alt="梨园芳华">
            </div>
            <div class="sidebar-brand">梨园芳华</div>
            <div class="sidebar-tagline">传承国粹 极尽精微</div>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=toHome">
                <span class="material-symbols-outlined">home</span>
                <span>首页</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserOperaServlet?method=list">
                <span class="material-symbols-outlined">theaters</span>
                <span>京剧剧目</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserForumServlet?method=list">
                <span class="material-symbols-outlined">forum</span>
                <span>戏曲论坛</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserShopServlet?method=list">
                <span class="material-symbols-outlined">local_mall</span>
                <span>积分商城</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserSubmitServlet?method=toSubmit">
                <span class="material-symbols-outlined">publish</span>
                <span>作品投稿</span>
            </a>
            <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=toPersonal">
                <span class="material-symbols-outlined">person</span>
                <span>个人中心</span>
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/user/UserSubmitServlet?method=toSubmit" class="btn btn-primary w-full">
                <span class="material-symbols-outlined">edit_square</span>
                即刻投稿
            </a>
        </div>
    </aside>

    <!-- 主内容区 -->
    <div class="main-content">
        <!-- 顶部导航栏（移动端） -->
        <header class="top-nav">
            <button onclick="toggleSidebar()" style="background:none;border:none;color:var(--on-surface);cursor:pointer;">
                <span class="material-symbols-outlined">menu</span>
            </button>
            <span class="top-nav-brand">梨园芳华</span>
            <div class="top-nav-actions">
                <span class="material-symbols-outlined" style="color:var(--on-surface-variant);cursor:pointer;">search</span>
                <div class="avatar">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 40 40'%3E%3Ccircle cx='20' cy='20' r='20' fill='%23e0d9d0'/%3E%3Ctext x='20' y='26' font-size='16' fill='%23926e69' text-anchor='middle'%3E${loginUser.username.substring(0,1)}%3C/text%3E%3C/svg%3E" alt="头像">
                </div>
            </div>
        </header>

        <!-- 内容区域 -->
        <div class="content-area">
            <!-- 页面标题 -->
            <div class="page-header">
                <div class="page-header-title">
                    <div class="seal">我</div>
                    <h1>个人中心</h1>
                </div>
            </div>

            <!-- 用户信息头部 -->
            <div class="user-header">
                <div class="user-avatar">
                    <c:choose>
                        <c:when test="${not empty loginUser.avatar and loginUser.avatar != '/img/default-avatar.svg'}">
                            <img src="${pageContext.request.contextPath}${loginUser.avatar}" alt="头像" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">
                        </c:when>
                        <c:otherwise>
                            <span class="material-symbols-outlined" style="font-size:48px;color:var(--on-surface-variant);">person</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="user-info">
                    <h2 class="user-name">${loginUser.username}</h2>
                    <div class="user-meta">
                        <span class="user-tag">
                            <span class="material-symbols-outlined" style="font-size:16px;">verified</span>
                            ${loginUser.role == 1 ? '管理员' : '戏曲爱好者'}
                        </span>
                        <span class="user-score">
                            <span class="material-symbols-outlined" style="font-size:16px;">stars</span>
                            ${loginUser.score} 积分
                        </span>
                    </div>
                </div>
            </div>

            <!-- Tab切换 -->
            <div class="tabs">
                <button class="tab-btn active" onclick="switchTab('profile')">
                    <span class="material-symbols-outlined" style="font-size:20px;">person</span>
                    个人资料
                </button>
                <button class="tab-btn" onclick="switchTab('edit')">
                    <span class="material-symbols-outlined" style="font-size:20px;">edit</span>
                    编辑资料
                </button>
                <button class="tab-btn" onclick="switchTab('password')">
                    <span class="material-symbols-outlined" style="font-size:20px;">lock</span>
                    修改密码
                </button>
                <button class="tab-btn" onclick="loadGrowth()">
                    <span class="material-symbols-outlined" style="font-size:20px;">trending_up</span>
                    成长记录
                </button>
            </div>

            <!-- 个人资料面板 -->
            <div id="profilePanel" class="tab-panel active">
                <c:if test="${not empty msg}">
                    <div class="alert alert-success">
                        <span class="material-symbols-outlined">check_circle</span>
                        ${msg}
                    </div>
                </c:if>

                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">person</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">账号</div>
                            <div class="info-item-value">${loginUser.username}</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">badge</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">姓名</div>
                            <div class="info-item-value">${loginUser.name != null ? loginUser.name : '未设置'}</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">phone</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">手机号</div>
                            <div class="info-item-value">${loginUser.phone != null ? loginUser.phone : '未填写'}</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">email</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">邮箱</div>
                            <div class="info-item-value">${loginUser.email != null ? loginUser.email : '未填写'}</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">stars</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">可用积分</div>
                            <div class="info-item-value" style="color:#C41E3A;font-weight:700;">${loginUser.score} 积分</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">admin_panel_settings</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">角色</div>
                            <div class="info-item-value">
                                ${loginUser.role == 1 ? '管理员' : '普通用户'}
                                <c:if test="${loginUser.role == 0 && !hasApprovedApply}">
                                    <a href="${pageContext.request.contextPath}/user/UserPersonalServlet?method=applyAdmin"
                                       style="margin-left:12px; padding:6px 16px; background:var(--primary); color:white; border-radius:20px; text-decoration:none; font-size:13px; font-weight:600;">
                                        申请成为管理员
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty notifyAdminAccount}">
                        <div style="margin-top:16px; background:#e8f5e9; padding:16px; border-radius:8px; border-left:4px solid #4caf50;">
                            <span class="material-symbols-outlined" style="color:#2e7d32; vertical-align:middle;">check_circle</span>
                            <strong style="color:#2e7d32;">您的管理员申请已通过！</strong><br/>
                            新管理员账号：<span style="font-family:monospace;font-size:16px;font-weight:bold;">${notifyAdminAccount}</span><br/>
                            <span style="color:#666;font-size:13px;">密码与您当前账号密码相同，请及时登录管理后台并修改密码。</span>
                        </div>
                    </c:if>
                    <div class="info-item">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined">calendar_today</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label">注册时间</div>
                            <div class="info-item-value">
                                <fmt:formatDate value="${loginUser.createTime}" pattern="yyyy年MM月dd日 HH:mm"/>
                            </div>
                        </div>
                    </div>
                    <!-- 退出登录 -->
                    <div class="info-item" onclick="showLogoutModal()" style="cursor:pointer;color:var(--error,#ba1a1a);">
                        <div class="info-item-icon">
                            <span class="material-symbols-outlined" style="color:var(--error,#ba1a1a);">logout</span>
                        </div>
                        <div class="info-item-content">
                            <div class="info-item-label" style="color:var(--error,#ba1a1a);">退出登录</div>
                            <div class="info-item-value" style="color:var(--error,#ba1a1a);">点击退出当前账号</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 编辑资料面板 -->
            <div id="editPanel" class="tab-panel">
                <div class="form-card">
                    <div class="form-card-header">
                        <h3>
                            <span class="material-symbols-outlined">edit</span>
                            编辑个人资料
                        </h3>
                    </div>
                    <div class="form-card-body">
                        <form action="UserPersonalServlet?method=save" method="post" enctype="multipart/form-data">
                            <!-- 头像上传区域 -->
                            <div class="form-group" style="text-align:center;margin-bottom:24px;">
                                <label class="form-label" style="display:block;margin-bottom:12px;">头像</label>
                                <div class="avatar-upload" onclick="document.getElementById('avatarFile').click();" style="cursor:pointer;display:inline-block;position:relative;">
                                    <div id="avatarPreview" style="width:100px;height:100px;border-radius:50%;border:3px solid var(--outline-variant);overflow:hidden;background:var(--surface-container);display:flex;align-items:center;justify-content:center;">
                                        <c:choose>
                                            <c:when test="${not empty loginUser.avatar and loginUser.avatar != '/img/default-avatar.svg'}">
                                                <img id="avatarImg" src="${pageContext.request.contextPath}${loginUser.avatar}" alt="头像" style="width:100%;height:100%;object-fit:cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <span id="avatarIcon" class="material-symbols-outlined" style="font-size:48px;color:var(--on-surface-variant);">person</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div style="position:absolute;bottom:0;right:0;background:var(--primary);color:white;border-radius:50%;width:28px;height:28px;display:flex;align-items:center;justify-content:center;border:2px solid white;">
                                        <span class="material-symbols-outlined" style="font-size:16px;">edit</span>
                                    </div>
                                </div>
                                <input type="file" id="avatarFile" name="avatarFile" accept="image/*" style="display:none;" onchange="previewAvatar(this)">
                                <p style="font-size:12px;color:var(--on-surface-variant);margin-top:8px;">点击头像更换照片</p>
                            </div>
                            <div class="form-group">
                                <label class="form-label">姓名</label>
                                <input type="text" name="name" class="form-input" value="${loginUser.name}" placeholder="请输入姓名">
                            </div>
                            <div class="form-group">
                                <label class="form-label">手机号</label>
                                <input type="tel" name="phone" class="form-input" value="${loginUser.phone}" placeholder="请输入手机号">
                            </div>
                            <div class="form-group">
                                <label class="form-label">邮箱</label>
                                <input type="email" name="email" class="form-input" value="${loginUser.email}" placeholder="请输入邮箱">
                            </div>
                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary">
                                    <span class="material-symbols-outlined">save</span>
                                    保存修改
                                </button>
                                <button type="button" class="btn btn-secondary" onclick="switchTab('profile')">
                                    <span class="material-symbols-outlined">arrow_back</span>
                                    取消
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 修改密码面板 -->
            <div id="passwordPanel" class="tab-panel">
                <div class="form-card">
                    <div class="form-card-header">
                        <h3>
                            <span class="material-symbols-outlined">lock</span>
                            修改密码
                        </h3>
                    </div>
                    <div class="form-card-body">
                        <c:if test="${not empty pwdMsg}">
                            <div class="alert ${pwdMsg.contains('成功') ? 'alert-success' : 'alert-error'}">
                                <span class="material-symbols-outlined">${pwdMsg.contains('成功') ? 'check_circle' : 'warning'}</span>
                                ${pwdMsg}
                            </div>
                        </c:if>
                        <form action="UserPersonalServlet?method=changePassword" method="post">
                            <div class="form-group">
                                <label class="form-label">原密码</label>
                                <input type="password" name="oldPassword" class="form-input" placeholder="请输入原密码" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">新密码</label>
                                <input type="password" name="newPassword" class="form-input" placeholder="请输入新密码（至少6位）" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">确认新密码</label>
                                <input type="password" name="confirmPassword" class="form-input" placeholder="请再次输入新密码" required>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <span class="material-symbols-outlined">lock</span>
                                确认修改
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 成长记录面板 -->
            <div id="growthPanel" class="tab-panel">
                <div class="form-card">
                    <div class="form-card-header">
                        <h3>
                            <span class="material-symbols-outlined">trending_up</span>
                            我的成长记录
                        </h3>
                    </div>
                    <div class="form-card-body" id="growthContent">
                        <div class="empty-state">
                            <div class="spinner"></div>
                            <p>加载中...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 页脚 -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-brand">梨园芳华</div>
                <div class="footer-links">
                    <a href="#">关于我们</a>
                    <a href="#">版权声明</a>
                    <a href="#">非遗合作</a>
                    <a href="#">联系我们</a>
                </div>
                <div class="footer-copyright">
                    © 2024 梨园芳华 文化传承平台. All Rights Reserved. 沪ICP备12345678号
                </div>
            </div>
        </footer>
    </div>
</div>

<script>
    // 切换侧边栏
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }

    // 点击内容区域关闭侧边栏（移动端）
    document.querySelector('.main-content').addEventListener('click', function() {
        if (window.innerWidth <= 1024) {
            document.getElementById('sidebar').classList.remove('open');
        }
    });

    // 头像预览
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var preview = document.getElementById('avatarPreview');
                preview.innerHTML = '<img src="' + e.target.result + '" alt="头像" style="width:100%;height:100%;object-fit:cover;">';
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    // Tab切换
    function switchTab(tab) {
        document.getElementById('profilePanel').classList.remove('active');
        document.getElementById('editPanel').classList.remove('active');
        document.getElementById('passwordPanel').classList.remove('active');
        document.getElementById('growthPanel').classList.remove('active');

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

    // 加载成长记录
    function loadGrowth() {
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
                contentDiv.innerHTML = '<div class="empty-state"><span class="material-symbols-outlined">error</span><p>加载失败，请刷新重试</p></div>';
            });
    }

    // ===== 退出登录模态框 =====
    function showLogoutModal() {
        document.getElementById('logoutModal').classList.add('active');
    }

    function hideLogoutModal() {
        document.getElementById('logoutModal').classList.remove('active');
    }

    function confirmLogout() {
        window.location.href = '${pageContext.request.contextPath}/LoginServlet?method=logout';
    }

    // ESC关闭模态框
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') hideLogoutModal();
    });
</script>

<!-- 退出登录模态框 -->
<div id="logoutModal" class="logout-modal-overlay" onclick="if(event.target===this) hideLogoutModal()">
    <div class="logout-modal">
        <div class="logout-modal-body">
            <div class="logout-modal-content">
                <div class="logout-modal-title">确认退出</div>
                <div class="logout-modal-text">退出后需重新登录才能访问个人中心、论坛互动等功能。</div>
            </div>
        </div>
        <div class="logout-modal-footer">
            <button class="logout-modal-btn logout-modal-btn-cancel" onclick="hideLogoutModal()">取消</button>
            <button class="logout-modal-btn logout-modal-btn-confirm" onclick="confirmLogout()">确认退出</button>
        </div>
    </div>
</div>
</body>
</html>
