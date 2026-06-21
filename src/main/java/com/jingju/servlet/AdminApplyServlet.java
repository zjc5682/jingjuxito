package com.jingju.servlet;

import com.jingju.dao.AdminApplyDao;
import com.jingju.util.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/AdminApplyServlet")
public class AdminApplyServlet extends BaseServlet {
    private AdminApplyDao applyDao = new AdminApplyDao();

    // 查看待审核列表
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Map<String, Object>> applies = applyDao.getPendingApplies();
        req.setAttribute("applies", applies);
        req.getRequestDispatcher("/admin/apply_list.jsp").forward(req, resp);
    }

    // 通过申请
    public void approve(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int applyId = Integer.parseInt(req.getParameter("applyId"));
        int userId = Integer.parseInt(req.getParameter("userId"));
        applyDao.approve(applyId, userId);
        resp.sendRedirect(req.getContextPath() + "/admin/AdminApplyServlet?method=list");
    }

    // 拒绝申请
    public void reject(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int applyId = Integer.parseInt(req.getParameter("applyId"));
        applyDao.reject(applyId);
        resp.sendRedirect(req.getContextPath() + "/admin/AdminApplyServlet?method=list");
    }
}
