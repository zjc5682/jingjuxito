package com.jingju.dao;

import com.jingju.entity.Opera;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class OperaDao {
    QueryRunner qr = new QueryRunner();

    // 查询所有剧目
    public List<Opera> findAll() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from opera order by praise desc";
        List<Opera> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(Opera.class));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 根据ID查询单个剧目
    public Opera findById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from opera where id = ?";
        Opera opera = null;
        try {
            opera = qr.query(conn, sql, new BeanHandler<>(Opera.class), id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return opera;
    }

    // 添加剧目
    public int add(Opera o) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "insert into opera(title, type, content, img) values(?,?,?,?)";
        int res = 0;
        try {
            res = qr.update(conn, sql, o.getTitle(), o.getType(), o.getContent(), o.getImg());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return res;
    }

    // 更新剧目
    public int update(Opera o) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update opera set title=?, type=?, content=?, img=? where id=?";
        int r = 0;
        try {
            r = qr.update(conn, sql, o.getTitle(), o.getType(), o.getContent(), o.getImg(), o.getId());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return r;
    }

    // 删除剧目
    public int del(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "delete from opera where id=?";
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

    // 点赞增加
    public int addPraise(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update opera set praise = praise + 1 where id = ?";
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