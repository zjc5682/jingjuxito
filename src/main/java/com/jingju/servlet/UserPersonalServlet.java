package com.jingju.servlet;

import com.jingju.dao.AdminApplyDao;
import com.jingju.dao.OperaDao;
import com.jingju.dao.UserDao;
import com.jingju.entity.Opera;
import com.jingju.entity.User;
import com.jingju.util.BaseServlet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/user/UserPersonalServlet")
@MultipartConfig(maxFileSize = 5242880, maxRequestSize = 10485760)
public class UserPersonalServlet extends BaseServlet {
    private UserDao userDao = new UserDao();

    // 显示个人中心
    public void show(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("/user/personal.jsp").forward(req, resp);
    }

    // 跳转首页
    public void toHome(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        OperaDao operaDao = new OperaDao();
        List<Opera> list = operaDao.findAll();
        if (list.size() > 4) {
            list = list.subList(0, 4);
        }
        req.setAttribute("operaList", list);

        // 查询前4热门剧目（轮播图+排行榜）
        List<Opera> hotOperaList = operaDao.getHotestOperas();
        req.setAttribute("hotOperaList", hotOperaList);

        req.getRequestDispatcher("/user/home.jsp").forward(req, resp);
    }

    // 跳转个人中心
    public void toPersonal(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User loginUser = (User) req.getSession().getAttribute("loginUser");

        // 检查是否有已通过但未通知的管理员申请
        if (loginUser != null && loginUser.getRole() == 0) {
            try {
                AdminApplyDao applyDao = new AdminApplyDao();
                boolean hasApprovedApply = applyDao.hasApprovedApply(loginUser.getId());
                req.setAttribute("hasApprovedApply", hasApprovedApply);

                Map<String, Object> approvedApply = applyDao.getApprovedNotNotified(loginUser.getId());
                if (approvedApply != null) {
                    req.setAttribute("notifyAdminAccount", approvedApply.get("admin_username"));
                    applyDao.markAsNotified((Integer) approvedApply.get("id"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        req.getRequestDispatcher("/user/personal.jsp").forward(req, resp);
    }

    // 显示编辑资料页面
    public void toEdit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("/user/personalEdit.jsp").forward(req, resp);
    }

    // 保存编辑资料
    public void save(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        // 接收文本字段
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        // 准备更新的用户对象
        User user = new User();
        user.setId(loginUser.getId());
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);

        // 处理头像上传 - 默认保留原有头像
        String newAvatarPath = loginUser.getAvatar();
        try {
            Part filePart = req.getPart("avatarFile");
            if (filePart != null && filePart.getSize() > 0) {
                // Tomcat 7 兼容：手动解析文件名
                String submittedFileName = getFileName(filePart);
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    // 提取扩展名
                    String ext = ".jpg";
                    int dotIndex = submittedFileName.lastIndexOf(".");
                    if (dotIndex > 0) {
                        ext = submittedFileName.substring(dotIndex);
                    }

                    // 生成唯一文件名
                    String newFileName = "avatar_" + loginUser.getId() + "_" +
                                         UUID.randomUUID().toString().substring(0, 8) + ext;

                    // 保存到 webapp/img/avatars/ 目录
                    String savePath = req.getServletContext().getRealPath("/img/avatars");
                    java.io.File dir = new java.io.File(savePath);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    filePart.write(savePath + java.io.File.separator + newFileName);

                    // 更新头像路径
                    newAvatarPath = "/img/avatars/" + newFileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 上传失败时保留原有头像，不影响姓名等修改
        }
        user.setAvatar(newAvatarPath);

        // 更新数据库
        userDao.updateUser(user);

        // 更新 session 中的用户信息
        User updatedUser = userDao.getById(loginUser.getId());
        req.getSession().setAttribute("loginUser", updatedUser);

        // 重定向回个人中心（避免表单重复提交）
        resp.sendRedirect(req.getContextPath() + "/user/UserPersonalServlet?method=toPersonal");
    }

    // Tomcat 7 兼容：从 Part 的 Content-Disposition 头解析文件名
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    // 修改密码
    public void changePassword(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User loginUser = (User) req.getSession().getAttribute("loginUser");

        String oldPwd = req.getParameter("oldPassword");
        String newPwd = req.getParameter("newPassword");
        String confirmPwd = req.getParameter("confirmPassword");

        if (oldPwd == null || !oldPwd.equals(loginUser.getPassword())) {
            req.setAttribute("pwdMsg", "原密码错误");
        } else if (!newPwd.equals(confirmPwd)) {
            req.setAttribute("pwdMsg", "两次输入的新密码不一致");
        } else if (newPwd.length() < 6) {
            req.setAttribute("pwdMsg", "新密码长度不能少于6位");
        } else {
            userDao.updatePassword(loginUser.getId(), newPwd);
            req.setAttribute("pwdMsg", "密码修改成功，请重新登录");
        }

        req.getRequestDispatcher("/user/personal.jsp").forward(req, resp);
    }

    // 成长记录
    public void growth(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User loginUser = (User) req.getSession().getAttribute("loginUser");

        // 获取成长记录数据
        List<GrowthRecord> records = getGrowthRecords(loginUser.getId());
        req.setAttribute("growthRecords", records);

        String isAjax = req.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(isAjax) || "true".equals(req.getParameter("ajax"))) {
            req.getRequestDispatcher("/user/personalGrowth.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/user/personal.jsp").forward(req, resp);
        }
    }

    // 获取成长记录（模拟数据，实际应从数据库查询）
    private List<GrowthRecord> getGrowthRecords(Integer userId) {
        List<GrowthRecord> records = new ArrayList<>();

        // 示例数据 - 实际应从数据库查询积分变更记录表
        GrowthRecord r1 = new GrowthRecord();
        r1.setTime(new Date());
        r1.setType("签到");
        r1.setEvent("每日签到");
        r1.setScoreChange(5);
        r1.setRemark("连续签到3天");
        records.add(r1);

        GrowthRecord r2 = new GrowthRecord();
        r2.setTime(new Date(System.currentTimeMillis() - 86400000));
        r2.setType("论坛");
        r2.setEvent("发布帖子");
        r2.setScoreChange(10);
        r2.setRemark("帖子《京剧艺术欣赏》审核通过");
        records.add(r2);

        GrowthRecord r3 = new GrowthRecord();
        r3.setTime(new Date(System.currentTimeMillis() - 172800000));
        r3.setType("投稿");
        r3.setEvent("作品投稿");
        r3.setScoreChange(20);
        r3.setRemark("投稿《浅谈京剧脸谱》审核通过");
        records.add(r3);

        GrowthRecord r4 = new GrowthRecord();
        r4.setTime(new Date(System.currentTimeMillis() - 259200000));
        r4.setType("兑换");
        r4.setEvent("积分兑换");
        r4.setScoreChange(-30);
        r4.setRemark("兑换商品：京剧脸谱书签");
        records.add(r4);

        GrowthRecord r5 = new GrowthRecord();
        r5.setTime(new Date(System.currentTimeMillis() - 345600000));
        r5.setType("论坛");
        r5.setEvent("帖子点赞");
        r5.setScoreChange(2);
        r5.setRemark("帖子获得点赞");
        records.add(r5);

        GrowthRecord r6 = new GrowthRecord();
        r6.setTime(new Date(System.currentTimeMillis() - 432000000));
        r6.setType("注册");
        r6.setEvent("新用户注册");
        r6.setScoreChange(100);
        r6.setRemark("欢迎加入京剧文化平台");
        records.add(r6);

        return records;
    }

    // 申请成为管理员
    public void applyAdmin(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }
        AdminApplyDao applyDao = new AdminApplyDao();
        applyDao.addApply(loginUser.getId());
        resp.sendRedirect(req.getContextPath() + "/user/UserPersonalServlet?method=toPersonal");
    }

    // 成长记录内部类
    public static class GrowthRecord {
        private Date time;
        private String type;
        private String event;
        private Integer scoreChange;
        private String remark;

        public Date getTime() { return time; }
        public void setTime(Date time) { this.time = time; }
        public String getType() { return type; }
        public void setType(String type) { this.type = type; }
        public String getEvent() { return event; }
        public void setEvent(String event) { this.event = event; }
        public Integer getScoreChange() { return scoreChange; }
        public void setScoreChange(Integer scoreChange) { this.scoreChange = scoreChange; }
        public String getRemark() { return remark; }
        public void setRemark(String remark) { this.remark = remark; }
    }
}