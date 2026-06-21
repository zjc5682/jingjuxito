package com.jingju.entity;
import java.util.Date;
public class ShopOrder {
    private Integer id;
    private Integer uid;
    private Integer gid;
    private Date createTime;
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public Integer getUid() {return uid;}
    public void setUid(Integer uid) {this.uid = uid;}
    public Integer getGid() {return gid;}
    public void setGid(Integer gid) {this.gid = gid;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
}
