package com.jingju.dao;

import com.jingju.entity.User;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class UserDao {
    private QueryRunner qr = new QueryRunner();

    // 用户登录
    public User login(String username, String pwd) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from user where username=? and password=?";
        User u = null;
        try {
            u = qr.query(conn, sql, new BeanHandler<>(User.class), username, pwd);
            if (u != null) {
                updateLastLoginTime(u.getId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return u;
    }

    // 更新最后登录时间
    public void updateLastLoginTime(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set last_login_time = now() where id = ?";
        try {
            qr.update(conn, sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
    }

    // 查询所有用户
    public List<User> findAll() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from user order by id";
        List<User> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(User.class));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 扣除积分
    public int updateScore(Integer uid, int score) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set score = score - ? where id = ? and score >= ?";
        int r = 0;
        try {
            r = qr.update(conn, sql, score, uid, score);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 增加积分
    public int addScore(Integer uid, int score) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set score = score + ? where id = ?";
        int r = 0;
        try {
            r = qr.update(conn, sql, score, uid);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 根据ID查询用户
    public User getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from user where id=?";
        User u = null;
        try {
            u = qr.query(conn, sql, new BeanHandler<>(User.class), id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return u;
    }

    // 根据用户名查询用户（用于注册查重）
    public User findByUsername(String username) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from user where username = ?";
        User user = null;
        try {
            user = qr.query(conn, sql, new BeanHandler<>(User.class), username);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return user;
    }

    // 更新用户信息
    public int updateUser(User user) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set name=?, phone=?, email=?, avatar=? where id=?";
        int r = 0;
        try {
            r = qr.update(conn, sql, user.getName(), user.getPhone(), user.getEmail(), user.getAvatar(), user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 管理员修改用户信息
    public int updateUserByAdmin(User user) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set username=?, name=?, phone=?, email=?, score=?, role=? where id=?";
        int r = 0;
        try {
            r = qr.update(conn, sql, user.getUsername(), user.getName(), user.getPhone(),
                    user.getEmail(), user.getScore(), user.getRole(), user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 重置密码
    public int resetPassword(Integer id, String newPassword) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set password=? where id=?";
        int r = 0;
        try {
            r = qr.update(conn, sql, newPassword, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 修改密码
    public int updatePassword(Integer id, String newPassword) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user set password=? where id=?";
        int r = 0;
        try {
            r = qr.update(conn, sql, newPassword, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 删除用户
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "delete from user where id=? and role != 1";
        int r = 0;
        try {
            r = qr.update(conn, sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 添加新用户（注册）
    public int addUser(User user) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "insert into user(username, password, name, phone, email, score, role) values(?,?,?,?,?,?,?)";
        int r = 0;
        try {
            r = qr.update(conn, sql, user.getUsername(), user.getPassword(), user.getName(),
                    user.getPhone(), user.getEmail(), user.getScore(), user.getRole());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }
}