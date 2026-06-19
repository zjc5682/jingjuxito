package com.jingju.dao;

import com.jingju.entity.ForumPost;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class ForumDao {
    QueryRunner qr = new QueryRunner();

    // 查询所有已审核通过的帖子（普通用户看到）
    public List<ForumPost> findApproved() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "SELECT p.*, u.username FROM forum_post p " +
                "LEFT JOIN user u ON p.uid = u.id " +
                "WHERE p.status = 1 ORDER BY p.create_time DESC";
        List<ForumPost> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(ForumPost.class));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 查询所有帖子（管理员看到所有状态）
    public List<ForumPost> findAll() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "SELECT p.*, u.username FROM forum_post p " +
                "LEFT JOIN user u ON p.uid = u.id " +
                "ORDER BY p.create_time DESC";
        List<ForumPost> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(ForumPost.class));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 添加帖子（状态为待审核）
    public int add(ForumPost p) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "insert into forum_post(uid, title, content, status) values(?,?,?,0)";
        int r = 0;
        try {
            r = qr.update(conn, sql, p.getUid(), p.getTitle(), p.getContent());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 审核帖子（修改状态）
    public int updateStatus(Integer id, Integer status) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update forum_post set status=? where id=?";
        int r = 0;
        try {
            r = qr.update(conn, sql, status, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 删除帖子
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "delete from forum_post where id=?";
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

    // 点赞
    public int addPraise(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update forum_post set praise = praise + 1 where id=?";
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
}