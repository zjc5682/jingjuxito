package com.jingju.servlet;

import com.jingju.dao.UserDao;
import com.jingju.entity.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String method = req.getParameter("method");
        if (method == null) method = "";

        switch (method) {
            case "login":
                doLogin(req, resp);
                break;
            case "logout":
                doLogout(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
                break;
        }
    }

    // 用户登录
    private void doLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = userDao.login(username, password);

            if (user == null) {
                req.setAttribute("msg", "账号或密码错误");
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
                return;
            }

            // 登录成功，保存用户信息到session
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", user);

            // 根据角色跳转不同页面：1管理员 0普通用户
            if (user.getRole() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/UserPersonalServlet?method=toHome");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "登录失败：" + e.getMessage());
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }

    // 退出登录
    private void doLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().invalidate();
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}