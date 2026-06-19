package com.jingju.servlet;

import com.jingju.dao.OperaDao;
import com.jingju.entity.Opera;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/user/UserOperaServlet")
public class UserOperaServlet extends BaseServlet {
    private OperaDao operaDao = new OperaDao();

    // 展示全部剧目
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Opera> list = operaDao.findAll();
        req.setAttribute("operaList", list);
        req.getRequestDispatcher("/user/opera.jsp").forward(req, resp);
    }

    // 获取前3个剧目用于首页展示
    public void getTop3(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Opera> list = operaDao.findAll();
        List<Opera> top3 = list;
        if (list.size() > 3) {
            top3 = list.subList(0, 3);
        }
        req.setAttribute("operaList", top3);
        req.getRequestDispatcher("/user/home.jsp").forward(req, resp);
    }

    // 点赞功能
    public void praise(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            operaDao.addPraise(id);
        }
        // 点赞后重新查询剧目列表并跳转回剧目页面
        List<Opera> list = operaDao.findAll();
        req.setAttribute("operaList", list);
        req.getRequestDispatcher("/user/opera.jsp").forward(req, resp);
    }
}