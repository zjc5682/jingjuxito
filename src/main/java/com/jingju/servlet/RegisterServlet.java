package com.jingju.servlet;

import com.jingju.dao.UserDao;
import com.jingju.entity.User;
import com.jingju.util.BaseServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends BaseServlet {
    private UserDao userDao = new UserDao();

    // 用户注册
    public void register(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String roleStr = req.getParameter("role");

        int role = 0;
        if (roleStr != null && !roleStr.isEmpty()) {
            role = Integer.parseInt(roleStr);
        }

        String msg = "";

        // 验证用户名
        if (username == null || username.trim().isEmpty()) {
            msg = "用户名不能为空";
        } else if (username.length() < 4 || username.length() > 20) {
            msg = "用户名长度应在4-20位之间";
        }
        // 验证密码
        else if (password == null || password.trim().isEmpty()) {
            msg = "密码不能为空";
        } else if (password.length() < 6) {
            msg = "密码长度不能少于6位";
        }
        // 验证确认密码
        else if (!password.equals(confirmPassword)) {
            msg = "两次输入的密码不一致";
        }
        // 验证手机号格式（可选）
        else if (phone != null && !phone.trim().isEmpty() && !phone.matches("^1[3-9]\\d{9}$")) {
            msg = "手机号格式不正确";
        }
        // 验证邮箱格式（可选）
        else if (email != null && !email.trim().isEmpty() && !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            msg = "邮箱格式不正确";
        } else {
            // 检查用户名是否已存在
            User existingUser = userDao.findByUsername(username);
            if (existingUser != null) {
                msg = "用户名已存在，请选择其他用户名";
            } else {
                // 创建新用户
                User newUser = new User();
                newUser.setUsername(username);
                newUser.setPassword(password);
                newUser.setName(name);
                newUser.setPhone(phone);
                newUser.setEmail(email);
                newUser.setScore(100);
                newUser.setRole(role);

                int result = userDao.addUser(newUser);
                if (result > 0) {
                    msg = "注册成功！请登录";
                    req.setAttribute("msg", msg);
                    req.getRequestDispatcher("/index.jsp").forward(req, resp);
                    return;
                } else {
                    msg = "注册失败，请稍后重试";
                }
            }
        }

        req.setAttribute("msg", msg);
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }
}