package com.jingju.servlet;

import com.jingju.dao.GoodsDao;
import com.jingju.dao.OrderDao;
import com.jingju.dao.UserDao;
import com.jingju.entity.ShopGoods;
import com.jingju.entity.ShopOrder;
import com.jingju.entity.User;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/user/UserShopServlet")
public class UserShopServlet extends BaseServlet {
    private GoodsDao goodsDao = new GoodsDao();
    private UserDao userDao = new UserDao();
    private OrderDao orderDao = new OrderDao();

    // 显示积分商城
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<ShopGoods> list = goodsDao.findAvailable();
        req.setAttribute("goodsList", list);
        req.getRequestDispatcher("/user/shop.jsp").forward(req, resp);
    }

    // 积分兑换商品
    public void exchange(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User user = (User) req.getSession().getAttribute("loginUser");
        String msg = "";

        try {
            String gidStr = req.getParameter("gid");
            if (gidStr == null || gidStr.isEmpty()) {
                msg = "参数错误";
            } else {
                Integer gid = Integer.parseInt(gidStr);
                ShopGoods target = goodsDao.findById(gid);

                if (target == null) {
                    msg = "商品不存在";
                } else if (target.getStatus() != 1) {
                    msg = "商品已下架";
                } else if (target.getStock() <= 0) {
                    msg = "商品库存不足";
                } else if (user.getScore() >= target.getGoodsScore()) {
                    // 扣除积分
                    userDao.updateScore(user.getId(), target.getGoodsScore());
                    // 扣减库存
                    goodsDao.reduceStock(gid, 1);
                    // 生成订单
                    ShopOrder order = new ShopOrder();
                    order.setGid(gid);
                    order.setUid(user.getId());
                    orderDao.add(order);

                    // 关键修复：更新 Session 中的用户积分
                    user.setScore(user.getScore() - target.getGoodsScore());
                    req.getSession().setAttribute("loginUser", user);

                    msg = "兑换成功！已扣除 " + target.getGoodsScore() + " 积分";
                } else {
                    msg = "积分不足，还需 " + (target.getGoodsScore() - user.getScore()) + " 积分";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "兑换失败：" + e.getMessage();
        }

        req.setAttribute("msg", msg);
        List<ShopGoods> list = goodsDao.findAvailable();
        req.setAttribute("goodsList", list);
        req.getRequestDispatcher("/user/shop.jsp").forward(req, resp);
    }
}