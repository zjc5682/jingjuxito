package com.jingju.servlet;

import com.jingju.dao.SubmitDao;
import com.jingju.entity.User;
import com.jingju.entity.UserSubmit;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/user/UserSubmitServlet")
public class UserSubmitServlet extends BaseServlet {
    private SubmitDao submitDao = new SubmitDao();

    // 跳转到投稿页面
    public void toSubmit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("/user/submit.jsp").forward(req, resp);  // ✅ 修复：forward 而不是 redirect
    }

    // 查看我的投稿（支持AJAX）
    public void mySubmits(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User user = (User) req.getSession().getAttribute("loginUser");
        if (user == null) {
            resp.setContentType("text/html;charset=utf-8");
            resp.getWriter().write("<div class='empty-state'><div class='emoji'>🔒</div><p>请先登录</p></div>");
            return;
        }
        List<UserSubmit> list = submitDao.findByUid(user.getId());
        req.setAttribute("mySubmits", list);

        // 如果是AJAX请求，只返回片段
        String isAjax = req.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(isAjax) || "true".equals(req.getParameter("ajax"))) {
            req.getRequestDispatcher("/user/submitMyList.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/user/submit.jsp?show=my").forward(req, resp);
        }
    }

    // 提交投稿
    public void add(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User user = (User) req.getSession().getAttribute("loginUser");
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        if (title == null || title.trim().isEmpty()) {
            req.setAttribute("msg", "标题不能为空");
            req.getRequestDispatcher("/user/submit.jsp").forward(req, resp);
            return;
        }

        UserSubmit submit = new UserSubmit();
        submit.setUid(user.getId());
        submit.setTitle(title);
        submit.setContent(content);
        submitDao.add(submit);

        req.setAttribute("msg", "投稿提交成功，等待管理员审核");
        req.setAttribute("mySubmits", submitDao.findByUid(user.getId()));
        req.getRequestDispatcher("/user/submit.jsp?show=my").forward(req, resp);
    }
}