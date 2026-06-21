<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员申请审核 - 管理员后台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', 'PingFang SC', 'Helvetica Neue', Roboto, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .page-header { background: linear-gradient(135deg, #b71c1c, #c62828); border-radius: 16px; padding: 25px 30px; margin-bottom: 25px; color: white; }
        .page-header h1 { font-size: 28px; display: flex; align-items: center; gap: 12px; }
        .page-header p { opacity: 0.9; margin-top: 8px; }
        .card { background: white; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fafafa; padding: 14px 16px; text-align: left; font-weight: 600; color: #333; border-bottom: 2px solid #f0f0f0; }
        td { padding: 14px 16px; border-bottom: 1px solid #f5f5f5; color: #555; }
        tr:hover { background: #fafafa; }
        .btn { display: inline-block; padding: 6px 16px; border-radius: 20px; text-decoration: none; font-size: 13px; font-weight: 600; cursor: pointer; border: none; transition: all 0.3s; }
        .btn-approve { background: #4caf50; color: white; }
        .btn-approve:hover { background: #388e3c; }
        .btn-reject { background: #f44336; color: white; }
        .btn-reject:hover { background: #c62828; }
        .empty { text-align: center; padding: 60px 20px; color: #999; }
        .empty span { font-size: 48px; display: block; margin-bottom: 16px; }

        /* ===== 模态框遮罩 ===== */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.show {
            display: flex;
        }

        /* ===== 模态框 ===== */
        .modal-box {
            background: white;
            border-radius: 16px;
            width: 420px;
            max-width: 90%;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: modalIn 0.3s ease;
        }
        @keyframes modalIn {
            from { transform: scale(0.9); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        /* 通过 - 绿色主题 */
        .modal-box.approve .modal-header {
            background: linear-gradient(135deg, #f9a825, #f57f17);
        }
        .modal-box.approve .modal-icon {
            background: #f57f17;
        }

        /* 拒绝 - 红色主题 */
        .modal-box.reject .modal-header {
            background: linear-gradient(135deg, #e53935, #b71c1c);
        }
        .modal-box.reject .modal-icon {
            background: #b71c1c;
        }

        .modal-header {
            padding: 24px;
            text-align: center;
            color: white;
        }
        .modal-icon {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 28px;
            color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .modal-header h3 {
            font-size: 18px;
            font-weight: 600;
        }
        .modal-body {
            padding: 24px;
            text-align: center;
            color: #555;
            font-size: 15px;
            line-height: 1.6;
        }
        .modal-body .highlight {
            color: #b71c1c;
            font-weight: 600;
        }
        .modal-footer {
            padding: 16px 24px;
            display: flex;
            gap: 12px;
            justify-content: center;
            border-top: 1px solid #f0f0f0;
        }
        .modal-btn {
            padding: 10px 28px;
            border-radius: 24px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .modal-btn-cancel {
            background: #f5f5f5;
            color: #666;
        }
        .modal-btn-cancel:hover {
            background: #e0e0e0;
        }
        .modal-btn-confirm {
            color: white;
        }
        .modal-box.approve .modal-btn-confirm {
            background: linear-gradient(135deg, #f9a825, #f57f17);
        }
        .modal-box.approve .modal-btn-confirm:hover {
            box-shadow: 0 4px 12px rgba(245,127,23,0.4);
        }
        .modal-box.reject .modal-btn-confirm {
            background: linear-gradient(135deg, #e53935, #b71c1c);
        }
        .modal-box.reject .modal-btn-confirm:hover {
            box-shadow: 0 4px 12px rgba(183,28,28,0.4);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>📝 管理员申请审核</h1>
        <p>审核用户提交的管理员权限申请</p>
    </div>
    <div class="card">
        <c:choose>
            <c:when test="${not empty applies}">
                <table>
                    <tr>
                        <th>申请人</th>
                        <th>联系方式</th>
                        <th>申请时间</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${applies}" var="a">
                        <tr>
                            <td><strong>${a.username}</strong></td>
                            <td>
                                <c:if test="${not empty a.phone}">📱 ${a.phone}</c:if>
                                <c:if test="${not empty a.email}"> 📧 ${a.email}</c:if>
                            </td>
                            <td>${a.apply_time}</td>
                            <td>
                                <button class="btn btn-approve" onclick="showModal('approve', '${a.id}', '${a.user_id}', '${a.username}')">✓ 通过</button>
                                <button class="btn btn-reject" onclick="showModal('reject', '${a.id}', '${a.user_id}', '${a.username}')">✗ 拒绝</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty">
                    <span>📭</span>
                    <p>暂无待审核的管理员申请</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 通过确认模态框 -->
<div class="modal-overlay" id="approveModal">
    <div class="modal-box approve">
        <div class="modal-header">
            <div class="modal-icon">✓</div>
            <h3>通过管理员申请</h3>
        </div>
        <div class="modal-body">
            <p>确定通过 <span class="highlight" id="approveUsername"></span> 的申请？</p>
            <p style="margin-top:8px;font-size:13px;color:#888;">系统将自动创建管理员账号，密码与原账号相同</p>
        </div>
        <div class="modal-footer">
            <button class="modal-btn modal-btn-cancel" onclick="closeModal('approveModal')">取消</button>
            <button class="modal-btn modal-btn-confirm" id="approveConfirmBtn">确认通过</button>
        </div>
    </div>
</div>

<!-- 拒绝确认模态框 -->
<div class="modal-overlay" id="rejectModal">
    <div class="modal-box reject">
        <div class="modal-header">
            <div class="modal-icon">✗</div>
            <h3>拒绝管理员申请</h3>
        </div>
        <div class="modal-body">
            <p>确定拒绝 <span class="highlight" id="rejectUsername"></span> 的申请？</p>
            <p style="margin-top:8px;font-size:13px;color:#888;">拒绝后该用户将无法再次申请</p>
        </div>
        <div class="modal-footer">
            <button class="modal-btn modal-btn-cancel" onclick="closeModal('rejectModal')">取消</button>
            <button class="modal-btn modal-btn-confirm" id="rejectConfirmBtn">确认拒绝</button>
        </div>
    </div>
</div>

<script>
    const basePath = '${pageContext.request.contextPath}';

    function showModal(type, applyId, userId, username) {
        if (type === 'approve') {
            document.getElementById('approveUsername').textContent = username;
            document.getElementById('approveConfirmBtn').onclick = function() {
                window.location.href = basePath + '/admin/AdminApplyServlet?method=approve&applyId=' + applyId + '&userId=' + userId;
            };
            document.getElementById('approveModal').classList.add('show');
        } else {
            document.getElementById('rejectUsername').textContent = username;
            document.getElementById('rejectConfirmBtn').onclick = function() {
                window.location.href = basePath + '/admin/AdminApplyServlet?method=reject&applyId=' + applyId;
            };
            document.getElementById('rejectModal').classList.add('show');
        }
    }

    function closeModal(id) {
        document.getElementById(id).classList.remove('show');
    }

    // 点击遮罩关闭
    document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
        overlay.addEventListener('click', function(e) {
            if (e.target === overlay) {
                overlay.classList.remove('show');
            }
        });
    });
</script>
</body>
</html>
