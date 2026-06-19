package com.jingju.servlet;

import com.jingju.dao.GoodsDao;
import com.jingju.entity.ShopGoods;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/AdminShopServlet")
public class AdminShopServlet extends BaseServlet {
    private GoodsDao goodsDao = new GoodsDao();

    // 显示所有商品
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<ShopGoods> list = goodsDao.findAll();
        req.setAttribute("goodsList", list);
        req.getRequestDispatcher("/admin/shopManage.jsp").forward(req, resp);
    }

    // 新增商品
    public void add(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ShopGoods g = new ShopGoods();
        g.setGoodsName(req.getParameter("goodsName"));
        g.setGoodsScore(Integer.parseInt(req.getParameter("score")));
        g.setStock(Integer.parseInt(req.getParameter("stock")));
        g.setDescription(req.getParameter("description"));
        g.setImg(req.getParameter("img"));
        if (g.getImg() == null || g.getImg().isEmpty()) {
            g.setImg("img/default.jpg");
        }
        goodsDao.add(g);
        resp.sendRedirect("AdminShopServlet?method=list");
    }

    // 修改商品
    public void update(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ShopGoods g = new ShopGoods();
        g.setId(Integer.parseInt(req.getParameter("id")));
        g.setGoodsName(req.getParameter("goodsName"));
        g.setGoodsScore(Integer.parseInt(req.getParameter("score")));
        g.setStock(Integer.parseInt(req.getParameter("stock")));
        g.setDescription(req.getParameter("description"));
        g.setImg(req.getParameter("img"));
        goodsDao.update(g);
        resp.sendRedirect("AdminShopServlet?method=list");
    }

    // 上架商品
    public void up(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        goodsDao.updateStatus(id, 1);
        resp.sendRedirect("AdminShopServlet?method=list");
    }

    // 下架商品
    public void down(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        goodsDao.updateStatus(id, 0);
        resp.sendRedirect("AdminShopServlet?method=list");
    }

    // 删除商品
    public void del(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        goodsDao.del(id);
        resp.sendRedirect("AdminShopServlet?method=list");
    }
}