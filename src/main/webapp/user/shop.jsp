<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>积分商城 - 中华京剧文化学习平台</title>
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
            max-width: 1300px;
            margin: 0 auto;
        }

        /* 页面头部 */
        .shop-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .shop-header h1 {
            font-size: 36px;
            color: #b71c1c;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .shop-header p {
            color: #666;
            margin-top: 10px;
        }

        .header-decoration {
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #b71c1c, #e8b88a, #b71c1c);
            margin: 15px auto 0;
            border-radius: 3px;
        }

        /* 积分卡片 */
        .score-card {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            border-radius: 24px;
            padding: 25px 35px;
            margin-bottom: 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            color: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .score-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .score-icon {
            font-size: 48px;
        }

        .score-text h3 {
            font-size: 14px;
            opacity: 0.8;
            font-weight: normal;
        }

        .score-text .score-value {
            font-size: 36px;
            font-weight: bold;
            color: #ffd700;
        }

        .score-tip {
            background: rgba(255, 215, 0, 0.15);
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 13px;
        }

        /* 提示消息 */
        .alert {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 14px 20px;
            border-radius: 16px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            animation: slideDown 0.3s ease, fadeOut 3s ease 2s forwards;
        }

        .alert-error {
            background: #ffebee;
            border-color: #ffcdd2;
            color: #c62828;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateX(-50%) translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }

        @keyframes fadeOut {
            to {
                opacity: 0;
                visibility: hidden;
            }
        }

        /* 商品网格 */
        .goods-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        /* 商品卡片 */
        .goods-card {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .goods-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        /* 商品图片区域 */
        .goods-img {
            height: 180px;
            background: linear-gradient(135deg, #c62828, #8b0000);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .goods-img .emoji {
            font-size: 70px;
            filter: drop-shadow(2px 4px 8px rgba(0, 0, 0, 0.2));
        }

        .goods-score-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 14px;
            color: #ffd700;
        }

        /* 商品信息 */
        .goods-info {
            padding: 20px;
        }

        .goods-name {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }

        .goods-desc {
            font-size: 13px;
            color: #888;
            line-height: 1.5;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .goods-stock {
            font-size: 12px;
            color: #999;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .stock-low {
            color: #ff9800;
        }

        .stock-out {
            color: #f44336;
        }

        .exchange-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #b71c1c, #c62828);
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .exchange-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(183, 28, 28, 0.4);
        }

        .exchange-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        /* 加载动画 */
        .loading {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid white;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px;
            background: white;
            border-radius: 24px;
        }

        .empty-state .emoji {
            font-size: 64px;
            margin-bottom: 15px;
        }

        /* 页脚 */
        .footer {
            text-align: center;
            padding: 30px;
            color: #999;
            font-size: 13px;
            margin-top: 20px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            .score-card {
                flex-direction: column;
                text-align: center;
            }
            .goods-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面头部 -->
    <div class="shop-header">
        <h1>
            <span>🎁</span> 积分商城
            <span>⭐</span>
        </h1>
        <p>学习京剧赚积分 · 兑换精美文创好礼</p>
        <div class="header-decoration"></div>
    </div>

    <!-- 积分卡片 -->
    <div class="score-card">
        <div class="score-info">
            <div class="score-icon">⭐</div>
            <div class="score-text">
                <h3>我的积分</h3>
                <div class="score-value" id="userScore">${loginUser.score}</div>
            </div>
        </div>
        <div class="score-tip">
            💡 观看剧目、发帖交流、投稿均可获得积分
        </div>
    </div>

    <!-- 商品列表 -->
    <c:choose>
        <c:when test="${empty goodsList}">
            <div class="empty-state">
                <div class="emoji">🛒</div>
                <p>暂无商品，敬请期待！</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="goods-grid" id="goodsGrid">
                <c:forEach items="${goodsList}" var="g">
                    <div class="goods-card" data-id="${g.id}">
                        <div class="goods-img">
                            <div class="emoji">
                                <c:choose>
                                    <c:when test="${g.goodsName.contains('书签')}">🔖</c:when>
                                    <c:when test="${g.goodsName.contains('明信片')}">📮</c:when>
                                    <c:when test="${g.goodsName.contains('折扇')}">🎐</c:when>
                                    <c:when test="${g.goodsName.contains('书籍')}">📚</c:when>
                                    <c:when test="${g.goodsName.contains('摆件')}">🏺</c:when>
                                    <c:when test="${g.goodsName.contains('笔记本')}">📓</c:when>
                                    <c:when test="${g.goodsName.contains('日历')}">📅</c:when>
                                    <c:otherwise>🎁</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="goods-score-badge">
                                ⭐ ${g.goodsScore} 积分
                            </div>
                        </div>
                        <div class="goods-info">
                            <div class="goods-name">${g.goodsName}</div>
                            <div class="goods-desc">${g.description != null ? g.description : '京剧主题文创产品'}</div>
                            <div class="goods-stock">
                                📦 库存：
                                <c:choose>
                                    <c:when test="${g.stock <= 0}">
                                        <span class="stock-out">已售罄</span>
                                    </c:when>
                                    <c:when test="${g.stock <= 10}">
                                        <span class="stock-low">仅剩 ${g.stock} 件</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${g.stock} 件
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button class="exchange-btn"
                                    data-id="${g.id}"
                                    data-score="${g.goodsScore}"
                                    data-stock="${g.stock}"
                                    <c:if test="${g.stock <= 0 || loginUser.score < g.goodsScore}">disabled</c:if>>
                                <c:choose>
                                    <c:when test="${g.stock <= 0}">📦 已售罄</c:when>
                                    <c:when test="${loginUser.score < g.goodsScore}">⭐ 积分不足</c:when>
                                    <c:otherwise>🎁 立即兑换</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 页脚 -->
    <div class="footer">
        <p>❤️ 用心传承国粹 · 用积分兑换好礼</p>
    </div>
</div>

<script>
    // 显示提示消息
    function showMessage(msg, isError) {
        // 移除已有的提示
        const oldAlert = document.querySelector('.alert');
        if (oldAlert) oldAlert.remove();

        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert ' + (isError ? 'alert-error' : '');
        alertDiv.innerHTML = `<span>${isError ? '⚠️' : '✅'}</span> ${msg}`;
        document.body.appendChild(alertDiv);

        // 3秒后自动移除
        setTimeout(() => {
            if (alertDiv) alertDiv.remove();
        }, 3000);
    }

    // 更新页面上的积分显示
    function updateScore(newScore) {
        const scoreElement = document.getElementById('userScore');
        if (scoreElement) {
            scoreElement.innerText = newScore;
        }
    }

    // 更新商品卡片的按钮状态
    function updateGoodsCard(goodsId, newStock) {
        const card = document.querySelector(`.goods-card[data-id="${goodsId}"]`);
        if (!card) return;

        const stockSpan = card.querySelector('.goods-stock');
        const btn = card.querySelector('.exchange-btn');
        const btnScore = parseInt(btn.getAttribute('data-score'));
        const currentScore = parseInt(document.getElementById('userScore').innerText);

        // 更新库存显示
        if (newStock <= 0) {
            stockSpan.innerHTML = '📦 库存：<span class="stock-out">已售罄</span>';
            btn.disabled = true;
            btn.innerHTML = '📦 已售罄';
        } else if (newStock <= 10) {
            stockSpan.innerHTML = `📦 库存：<span class="stock-low">仅剩 ${newStock} 件</span>`;
        } else {
            stockSpan.innerHTML = `📦 库存：${newStock} 件`;
        }

        // 更新按钮状态（积分可能不够了）
        if (currentScore < btnScore) {
            btn.disabled = true;
            btn.innerHTML = '⭐ 积分不足';
        }

        // 更新按钮的 data-stock 属性
        btn.setAttribute('data-stock', newStock);
    }

    // 兑换功能（使用 AJAX）
    document.querySelectorAll('.exchange-btn').forEach(btn => {
        btn.addEventListener('click', async function(e) {
            e.preventDefault();

            // 如果按钮被禁用，不执行
            if (this.disabled) return;

            const goodsId = this.getAttribute('data-id');
            const originalText = this.innerHTML;

            // 显示加载状态
            this.disabled = true;
            this.innerHTML = '<span class="loading"></span> 处理中...';

            try {
                const response = await fetch('UserShopServlet?method=exchange&gid=' + goodsId, {
                    method: 'GET',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                });

                const text = await response.text();

                // 尝试从返回的 HTML 中提取消息和新的积分
                // 简单方式：通过正则匹配
                let msg = '';
                let isError = true;

                if (text.includes('兑换成功')) {
                    isError = false;
                    msg = '兑换成功！';

                    // 更新积分显示（需要从返回内容中提取或重新获取）
                    // 简单处理：刷新页面数据
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                } else if (text.includes('积分不足')) {
                    msg = '积分不足，无法兑换';
                } else if (text.includes('库存不足')) {
                    msg = '库存不足';
                } else {
                    msg = '兑换失败，请稍后重试';
                }

                showMessage(msg, isError);

                if (!isError) {
                    // 延迟刷新页面以更新积分
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                } else {
                    // 恢复按钮
                    this.disabled = false;
                    this.innerHTML = originalText;
                }

            } catch (error) {
                console.error('兑换请求失败:', error);
                showMessage('网络错误，请稍后重试', true);
                this.disabled = false;
                this.innerHTML = originalText;
            }
        });
    });
</script>
</body>
</html>