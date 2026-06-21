package com.jingju.dao;

import com.jingju.entity.ShopGoods;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.BasicRowProcessor;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GoodsDao {
    private QueryRunner qr = new QueryRunner();

    // 列名映射：数据库 snake_case → Java camelCase
    private static final Map<String, String> COLUMN_MAP = new HashMap<>();
    static {
        COLUMN_MAP.put("goods_name", "goodsName");
        COLUMN_MAP.put("goods_score", "goodsScore");
    }

    // 带映射的 RowProcessor
    private static final BasicRowProcessor ROW_PROCESSOR =
        new BasicRowProcessor(new BeanProcessor(COLUMN_MAP));

    // 查询所有上架商品（用户端可见）
    public List<ShopGoods> findAvailable() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from shop_goods where status = 1 order by goods_score asc";
        List<ShopGoods> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(ShopGoods.class, ROW_PROCESSOR));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 查询所有商品（管理员端可见）
    public List<ShopGoods> findAll() throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from shop_goods order by id desc";
        List<ShopGoods> list = null;
        try {
            list = qr.query(conn, sql, new BeanListHandler<>(ShopGoods.class, ROW_PROCESSOR));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // 根据ID查询商品
    public ShopGoods findById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "select * from shop_goods where id = ?";
        ShopGoods goods = null;
        try {
            goods = qr.query(conn, sql, new BeanHandler<>(ShopGoods.class, ROW_PROCESSOR), id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return goods;
    }

    // 新增商品
    public int add(ShopGoods g) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "insert into shop_goods(goods_name, goods_score, stock, description, img, status) values(?,?,?,?,?,1)";
        int row = 0;
        try {
            row = qr.update(conn, sql, g.getGoodsName(), g.getGoodsScore(), g.getStock(), g.getDescription(), g.getImg());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 修改商品信息
    public int update(ShopGoods g) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update shop_goods set goods_name=?, goods_score=?, stock=?, description=?, img=? where id=?";
        int row = 0;
        try {
            row = qr.update(conn, sql, g.getGoodsName(), g.getGoodsScore(), g.getStock(), g.getDescription(), g.getImg(), g.getId());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }

    // 上架/下架商品
    public int updateStatus(Integer id, Integer status) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update shop_goods set status=? where id=?";
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

    // 删除商品
    public int del(Integer id) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "delete from shop_goods where id=?";
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

    // 扣减库存
    public int reduceStock(Integer id, int num) throws SQLException {
        Connection conn = DBUtil.getConn();
        String sql = "update shop_goods set stock = stock - ? where id = ? and stock >= ?";
        int row = 0;
        try {
            row = qr.update(conn, sql, num, id, num);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        return row;
    }
}
