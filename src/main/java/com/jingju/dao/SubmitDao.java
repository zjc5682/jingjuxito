package com.jingju.dao;

import com.jingju.entity.UserSubmit;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class SubmitDao {
    private QueryRunner qr = new QueryRunner();

    // 用户投稿
    public int add(UserSubmit s) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "insert into user_submit(uid, title, content, status, is_featured) values(?,?,?,0,0)";
        int row = 0;
        try {
            row = qr.update(conn, sql, s.getUid(), s.getTitle(), s.getContent());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 查询用户自己的投稿（普通用户）
    public List<UserSubmit> findByUid(Integer uid) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from user_submit where uid = ? order by create_time desc";
        List<UserSubmit> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(UserSubmit.class), uid);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 查询所有投稿（管理员）
    public List<UserSubmit> findAll() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select s.*, u.username, u.name as userRealName " +
                "from user_submit s left join user u on s.uid = u.id " +
                "order by s.create_time desc";
        List<UserSubmit> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(UserSubmit.class));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 查询已通过的投稿（用于展示）
    public List<UserSubmit> findApproved() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select s.*, u.username, u.name as userRealName " +
                "from user_submit s left join user u on s.uid = u.id " +
                "where s.status = 1 order by s.is_featured desc, s.create_time desc";
        List<UserSubmit> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(UserSubmit.class));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 根据ID查询投稿
    public UserSubmit findById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select s.*, u.username, u.name as userRealName " +
                "from user_submit s left join user u on s.uid = u.id " +
                "where s.id = ?";
        UserSubmit submit = null;
        try {
            submit = qr.query(conn, sql, new BeanHandler<>(UserSubmit.class), id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return submit;
    }

    // 审核修改状态 0待审1通过2驳回
    public int updateStatus(Integer id, Integer status) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user_submit set status=? where id=?";
        int row = 0;
        try {
            row = qr.update(conn, sql, status, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 审核并添加评语
    public int review(Integer id, Integer status, String adminComment) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user_submit set status=?, admin_comment=? where id=?";
        int row = 0;
        try {
            row = qr.update(conn, sql, status, adminComment, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 优质评选
    public int setFeatured(Integer id, Integer isFeatured) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user_submit set is_featured=? where id=?";
        int row = 0;
        try {
            row = qr.update(conn, sql, isFeatured, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 删除投稿
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "delete from user_submit where id=?";
        int row = 0;
        try {
            row = qr.update(conn, sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 增加浏览量
    public int addViewCount(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update user_submit set view_count = view_count + 1 where id=?";
        int row = 0;
        try {
            row = qr.update(conn, sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }
}