<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>梨园芳华 - 管理员后台</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>

<!-- Toast 容器 -->
<div class="toast-container" id="toastContainer"></div>

<!-- 移动端遮罩 -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<!-- 侧边栏 -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="sidebar-brand">梨园芳华</div>
        <div class="sidebar-tagline">管理后台</div>
    </div>
    <nav class="sidebar-nav">
        <a href="AdminUserServlet?method=list" target="main" data-page="user" class="active">
            <span class="material-symbols-outlined">group</span>
            <span>用户管理</span>
        </a>
        <a href="AdminOperaServlet?method=list" target="main" data-page="opera">
            <span class="material-symbols-outlined">theater_comedy</span>
            <span>剧目管理</span>
        </a>
        <a href="AdminForumServlet?method=list" target="main" data-page="forum">
            <span class="material-symbols-outlined">forum</span>
            <span>论坛管理</span>
        </a>
        <a href="AdminShopServlet?method=list" target="main" data-page="shop">
            <span class="material-symbols-outlined">storefront</span>
            <span>商品管理</span>
        </a>
        <a href="AdminSubmitServlet?method=list" target="main" data-page="submit">
            <span class="material-symbols-outlined">rate_review</span>
            <span>投稿审核</span>
        </a>
        <a href="AdminApplyServlet?method=list" target="main" data-page="apply">
            <span class="material-symbols-outlined">assignment_ind</span>
            <span>管理员申请</span>
        </a>
        <div class="sidebar-divider"></div>
        <a href="${pageContext.request.contextPath}/LoginServlet?method=logout" class="logout-link">
            <span class="material-symbols-outlined">logout</span>
            <span>退出系统</span>
        </a>
    </nav>
    <div class="sidebar-user">
        <div class="avatar-sm">管</div>
        <div class="sidebar-user-info">
            <div class="sidebar-user-name">管理员</div>
            <div class="sidebar-user-role">超级管理员</div>
        </div>
    </div>
    <button class="sidebar-toggle" id="sidebarToggle" data-tooltip="折叠侧边栏">
        <span class="material-symbols-outlined">chevron_left</span>
    </button>
</div>

<!-- 主内容区 -->
<div class="main-wrap" id="mainWrap">
    <iframe name="main" src="AdminUserServlet?method=list" id="mainFrame"></iframe>
</div>

<script>
    // ===== 侧边栏高亮 =====
    var navLinks = document.querySelectorAll('.sidebar-nav a[data-page]');
    navLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            navLinks.forEach(function(l) { l.classList.remove('active'); });
            this.classList.add('active');
        });
    });

    // ===== 侧边栏折叠 =====
    var sidebar = document.getElementById('sidebar');
    var toggle = document.getElementById('sidebarToggle');
    toggle.addEventListener('click', function() {
        sidebar.classList.toggle('collapsed');
    });

    // ===== 移动端汉堡菜单 =====
    var overlay = document.getElementById('sidebarOverlay');
    overlay.addEventListener('click', function() {
        sidebar.classList.remove('open');
        overlay.classList.remove('show');
    });

    // iframe 内页面可以通过 postMessage 请求打开移动端菜单
    window.addEventListener('message', function(e) {
        if (e.data === 'toggle-sidebar') {
            sidebar.classList.toggle('open');
            overlay.classList.toggle('show');
        }
    });

    // ===== Toast 通知系统（暴露给 iframe） =====
    window.showToast = function(type, title, message, duration) {
        var container = document.getElementById('toastContainer');
        var icons = {
            success: 'check_circle',
            error: 'error',
            warning: 'warning',
            info: 'info'
        };
        var toast = document.createElement('div');
        toast.className = 'toast toast-' + type;
        toast.innerHTML =
            '<div class="toast-icon"><span class="material-symbols-outlined">' + (icons[type] || 'info') + '</span></div>' +
            '<div class="toast-body"><div class="toast-title">' + title + '</div>' +
            (message ? '<div class="toast-message">' + message + '</div>' : '') +
            '</div>' +
            '<button class="toast-close" onclick="this.parentElement.classList.add(\'toast-out\');setTimeout(function(){this.parentElement.remove()}.bind(this),250)">' +
            '<span class="material-symbols-outlined">close</span></button>';
        container.appendChild(toast);
        setTimeout(function() {
            if (toast.parentElement) {
                toast.classList.add('toast-out');
                setTimeout(function() { toast.remove(); }, 250);
            }
        }, duration || 4000);
    };

    // ===== 确认对话框（替代浏览器 confirm） =====
    window.showConfirm = function(options) {
        return new Promise(function(resolve) {
            var overlay = document.createElement('div');
            overlay.className = 'confirm-overlay show';
            var typeClass = options.type || 'confirm-danger';
            overlay.innerHTML =
                '<div class="confirm-box ' + typeClass + '">' +
                '<div class="confirm-header">' +
                '<div class="confirm-icon"><span class="material-symbols-outlined">' + (options.icon || 'warning') + '</span></div>' +
                '<div class="confirm-content"><h4>' + options.title + '</h4>' +
                (options.message ? '<p>' + options.message + '</p>' : '') +
                '</div></div>' +
                '<div class="confirm-actions">' +
                '<button class="btn btn-neutral" id="confirmCancel">取消</button>' +
                '<button class="btn ' + (options.type === 'confirm-warning' ? 'btn-warning' : options.type === 'confirm-info' ? 'btn-primary' : 'btn-danger') + '" id="confirmOk">' + (options.okText || '确定') + '</button>' +
                '</div></div>';
            document.body.appendChild(overlay);

            overlay.querySelector('#confirmCancel').addEventListener('click', function() {
                overlay.remove();
                resolve(false);
            });
            overlay.querySelector('#confirmOk').addEventListener('click', function() {
                overlay.remove();
                resolve(true);
            });
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) {
                    overlay.remove();
                    resolve(false);
                }
            });
        });
    };
</script>
</body>
</html>
