package com.jingju.servlet;

import com.jingju.dao.ForumDao;
import com.jingju.entity.ForumPost;
import com.jingju.entity.User;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/user/UserForumServlet")
public class UserForumServlet extends BaseServlet {
    private ForumDao forumDao = new ForumDao();

    // 显示论坛首页（只显示已审核通过的帖子）
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<ForumPost> list = forumDao.findApproved();
        req.setAttribute("postList", list);
        req.getRequestDispatcher("/user/forum.jsp").forward(req, resp);
    }

    // 发布帖子
    public void addPost(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User login = (User) req.getSession().getAttribute("loginUser");
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        if (title == null || title.trim().isEmpty()) {
            req.setAttribute("msg", "帖子标题不能为空");
            req.getRequestDispatcher("/user/forum.jsp").forward(req, resp);
            return;
        }

        ForumPost post = new ForumPost();
        post.setUid(login.getId());
        post.setTitle(title);
        post.setContent(content);
        forumDao.add(post);

        req.setAttribute("msg", "帖子发布成功，等待管理员审核后显示");
        List<ForumPost> list = forumDao.findApproved();
        req.setAttribute("postList", list);
        req.getRequestDispatcher("/user/forum.jsp").forward(req, resp);
    }

    // 点赞
    public void praise(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Integer id = Integer.parseInt(idStr);
            forumDao.addPraise(id);
        }
        List<ForumPost> list = forumDao.findApproved();
        req.setAttribute("postList", list);
        req.getRequestDispatcher("/user/forum.jsp").forward(req, resp);
    }
}
