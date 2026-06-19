package com.jingju.servlet;

import com.jingju.dao.SubmitDao;
import com.jingju.entity.UserSubmit;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/AdminSubmitServlet")
public class AdminSubmitServlet extends BaseServlet {
    private SubmitDao submitDao = new SubmitDao();

    // 显示所有投稿
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<UserSubmit> list = submitDao.findAll();
        req.setAttribute("submitList", list);
        req.getRequestDispatcher("/admin/submitCheck.jsp").forward(req, resp);
    }

    // 审核通过
    public void approve(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        submitDao.updateStatus(id, 1);
        resp.sendRedirect("AdminSubmitServlet?method=list");
    }

    // 审核驳回
    public void reject(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        submitDao.updateStatus(id, 2);
        resp.sendRedirect("AdminSubmitServlet?method=list");
    }

    // 添加评语
    public void comment(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        String comment = req.getParameter("comment");
        // 获取当前投稿状态
        UserSubmit submit = submitDao.findById(id);
        if (submit != null) {
            submitDao.review(id, submit.getStatus(), comment);
        }
        resp.sendRedirect("AdminSubmitServlet?method=list");
    }

    // 设为优质
    public void feature(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        submitDao.setFeatured(id, 1);
        resp.sendRedirect("AdminSubmitServlet?method=list");
    }

    // 取消优质
    public void unfeature(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        submitDao.setFeatured(id, 0);
        resp.sendRedirect("AdminSubmitServlet?method=list");
    }

    // 删除投稿
    public void del(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        submitDao.delete(id);
        resp.sendRedirect("AdminSubmitServlet?method=list");
    }
}