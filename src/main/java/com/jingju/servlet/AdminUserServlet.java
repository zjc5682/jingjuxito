package com.jingju.servlet;

import com.jingju.dao.UserDao;
import com.jingju.entity.User;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin/AdminUserServlet")
public class AdminUserServlet extends BaseServlet {
    private UserDao userDao = new UserDao();

    // 显示用户列表
    public void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<User> list = userDao.findAll();
        req.setAttribute("userList", list);
        req.getRequestDispatcher("/admin/userManage.jsp").forward(req, resp);
    }

    // 查看用户详情
    public void detail(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        User user = userDao.getById(id);
        req.setAttribute("user", user);
        req.getRequestDispatcher("/admin/userDetail.jsp").forward(req, resp);
    }

    // 跳转到编辑页面
    public void toEdit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        User user = userDao.getById(id);
        req.setAttribute("user", user);
        req.getRequestDispatcher("/admin/userEdit.jsp").forward(req, resp);
    }

    // 保存编辑
    public void save(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        Integer score = Integer.parseInt(req.getParameter("score"));
        Integer role = Integer.parseInt(req.getParameter("role"));

        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);
        user.setScore(score);
        user.setRole(role);

        userDao.updateUserByAdmin(user);
        resp.sendRedirect("AdminUserServlet?method=list");
    }

    // 重置密码
    public void resetPwd(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        userDao.resetPassword(id, "123456");
        resp.sendRedirect("AdminUserServlet?method=list");
    }

    // 删除用户
    public void delete(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        userDao.delete(id);
        resp.sendRedirect("AdminUserServlet?method=list");
    }

    // 跳转到添加用户页面
    public void toAdd(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("/admin/userAdd.jsp").forward(req, resp);
    }

    // 添加用户
    public void add(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        Integer score = Integer.parseInt(req.getParameter("score"));
        Integer role = Integer.parseInt(req.getParameter("role"));

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);
        user.setScore(score);
        user.setRole(role);

        userDao.addUser(user);
        resp.sendRedirect("AdminUserServlet?method=list");
    }
}