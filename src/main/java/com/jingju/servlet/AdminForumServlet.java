package com.jingju.servlet;

import com.jingju.dao.ForumDao;
import com.jingju.entity.ForumPost;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/AdminForumServlet")
public class AdminForumServlet extends BaseServlet {
    private ForumDao forumDao = new ForumDao();

    // 显示所有帖子
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<ForumPost> list = forumDao.findAll();
        req.setAttribute("postList", list);
        req.getRequestDispatcher("/admin/forumManage.jsp").forward(req, resp);
    }

    // 审核通过
    public void approve(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        forumDao.updateStatus(id, 1);
        resp.sendRedirect("AdminForumServlet?method=list");
    }

    // 审核驳回
    public void reject(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        forumDao.updateStatus(id, 2);
        resp.sendRedirect("AdminForumServlet?method=list");
    }

    // 删除帖子
    public void del(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        forumDao.delete(id);
        resp.sendRedirect("AdminForumServlet?method=list");
    }
}