package com.jingju.dao;
import com.jingju.entity.ShopOrder;
import com.jingju.util.DBUtil;
import org.apache.commons.dbutils.QueryRunner;
import java.sql.Connection;
import java.sql.SQLException;

public class OrderDao {
    QueryRunner qr=new QueryRunner();
    public int add(ShopOrder o) throws SQLException {
        Connection conn=DBUtil.getConn();
        String sql="insert into shop_order(uid,gid) values(?,?)";
        int r=0;
        try{r=qr.update(conn,sql,o.getUid(),o.getGid());}catch(Exception e){e.printStackTrace();}finally {DBUtil.close(conn);}
        return r;
    }
}