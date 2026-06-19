package com.jingju.util;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.apache.commons.dbutils.DbUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
    //c3p0自动读取resources/db.properties配置文件
    private static final ComboPooledDataSource DS = new ComboPooledDataSource();

    //获取数据库连接
    public static Connection getConn() throws SQLException {
        return DS.getConnection();
    }

    //关闭连接
    public static void close(Connection conn) throws SQLException {
        DbUtils.close(conn);
    }

    //关闭连接+预编译对象
    public static void close(Connection conn, PreparedStatement stmt) throws SQLException {
        DbUtils.close(conn);
    }

    //关闭连接+预编译+结果集
    public static void close(Connection conn, PreparedStatement stmt, ResultSet rs) throws SQLException {
        DbUtils.close(conn);
    }
}