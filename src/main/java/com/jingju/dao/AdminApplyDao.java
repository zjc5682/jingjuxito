package com.jingju.dao;

import com.jingju.entity.User;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class AdminApplyDao {
    QueryRunner qr = new QueryRunner();

    // 插入申请
    public void addApply(int userId) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "INSERT INTO admin_apply (user_id, status) VALUES (?, 0)";
        try {
            qr.update(conn, sql, userId);
        } finally {
            DBUtil.close(conn);
        }
    }

    // 查询待审核列表（带申请人用户名）
    public List<Map<String, Object>> getPendingApplies() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "SELECT a.id, a.user_id, u.username, u.phone, u.email, a.apply_time " +
                     "FROM admin_apply a JOIN user u ON a.user_id = u.id " +
                     "WHERE a.status = 0 ORDER BY a.apply_time";
        List<Map<String, Object>> list = null;
        try {
            list = qr.query(conn, sql, new MapListHandler());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 通过申请：创建新管理员账号，更新状态
    public void approve(int applyId, int applicantUserId) throws SQLException {
        Connection conn = DBUtil.getConn();
        try {
            // 获取申请人信息
            UserDao userDao = new UserDao();
            User applicant = userDao.getById(applicantUserId);

            // 生成随机管理员用户名
            String newAdminUsername = "admin_" + UUID.randomUUID().toString().substring(0, 8);
            String password = applicant.getPassword();

            // 创建新管理员账号
            User newAdmin = new User();
            newAdmin.setUsername(newAdminUsername);
            newAdmin.setPassword(password);
            newAdmin.setRole(1);
            newAdmin.setName(applicant.getName());
            newAdmin.setPhone(applicant.getPhone());
            newAdmin.setEmail(applicant.getEmail());
            newAdmin.setAvatar(applicant.getAvatar());
            newAdmin.setScore(0);
            newAdmin.setCreateTime(new Date());
            userDao.addUser(newAdmin);

            // 更新申请表状态
            String updateSql = "UPDATE admin_apply SET status = 1, approve_time = NOW(), approved_admin_id = ?, is_notified = 0 WHERE id = ?";
            qr.update(conn, updateSql, newAdmin.getId(), applyId);
        } finally {
            DBUtil.close(conn);
        }
    }

    // 拒绝申请
    public void reject(int applyId) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "UPDATE admin_apply SET status = 2 WHERE id = ?";
        try {
            qr.update(conn, sql, applyId);
        } finally {
            DBUtil.close(conn);
        }
    }

    // 检查是否存在已通过的申请
    public boolean hasApprovedApply(int userId) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "SELECT COUNT(*) FROM admin_apply WHERE user_id = ? AND status = 1";
        try {
            Number count = qr.query(conn, sql, new ScalarHandler<>(), userId);
            return count.intValue() > 0;
        } finally {
            DBUtil.close(conn);
        }
    }

    // 获取一条已通过且未通知的申请
    public Map<String, Object> getApprovedNotNotified(int userId) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "SELECT a.id, u.username AS admin_username FROM admin_apply a " +
                     "JOIN user u ON a.approved_admin_id = u.id " +
                     "WHERE a.user_id = ? AND a.status = 1 AND (a.is_notified = 0 OR a.is_notified IS NULL) LIMIT 1";
        try {
            List<Map<String, Object>> list = qr.query(conn, sql, new MapListHandler(), userId);
            return list.isEmpty() ? null : list.get(0);
        } finally {
            DBUtil.close(conn);
        }
    }

    // 标记为已通知
    public void markAsNotified(int applyId) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "UPDATE admin_apply SET is_notified = 1 WHERE id = ?";
        try {
            qr.update(conn, sql, applyId);
        } finally {
            DBUtil.close(conn);
        }
    }
}
