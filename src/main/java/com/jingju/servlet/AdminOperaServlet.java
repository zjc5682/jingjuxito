package com.jingju.servlet;

import com.jingju.dao.OperaDao;
import com.jingju.entity.Opera;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/AdminOperaServlet")
public class AdminOperaServlet extends BaseServlet {
    private OperaDao operaDao = new OperaDao();

    // 显示所有剧目
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Opera> list = operaDao.findAll();
        req.setAttribute("operaList", list);
        req.getRequestDispatcher("/admin/operaManage.jsp").forward(req, resp);
    }

    // 添加剧目
    public void add(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String title = req.getParameter("title");
        String type = req.getParameter("type");
        String content = req.getParameter("content");
        String img = req.getParameter("img");

        if (img == null || img.isEmpty()) {
            img = "img/default.jpg";
        }

        Opera o = new Opera();
        o.setTitle(title);
        o.setType(type);
        o.setContent(content);
        o.setImg(img);

        operaDao.add(o);
        resp.sendRedirect("AdminOperaServlet?method=list");
    }

    // 删除剧目
    public void del(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        operaDao.del(id);
        resp.sendRedirect("AdminOperaServlet?method=list");
    }

    // 查看剧目详情
    public void detail(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        Opera opera = operaDao.findById(id);
        req.setAttribute("opera", opera);
        req.getRequestDispatcher("/admin/operaDetail.jsp").forward(req, resp);
    }

    // 跳转到编辑页面
    public void toEdit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        Opera opera = operaDao.findById(id);
        req.setAttribute("opera", opera);
        req.getRequestDispatcher("/admin/operaEdit.jsp").forward(req, resp);
    }

    // 保存编辑
    public void update(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String type = req.getParameter("type");
        String content = req.getParameter("content");
        String img = req.getParameter("img");

        if (img == null || img.isEmpty()) {
            img = "img/default.jpg";
        }

        Opera opera = new Opera();
        opera.setId(id);
        opera.setTitle(title);
        opera.setType(type);
        opera.setContent(content);
        opera.setImg(img);

        operaDao.update(opera);
        resp.sendRedirect("AdminOperaServlet?method=list");
    }
}