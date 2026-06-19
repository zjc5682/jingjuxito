package com.jingju.entity;

import java.util.Date;

public class UserSubmit {
    private Integer id;
    private Integer uid;
    private String title;
    private String content;
    private Integer status;      // 0待审核 1已通过 2已驳回
    private Integer isFeatured;  // 0普通 1优质
    private String adminComment; // 管理员评语
    private Integer viewCount;   // 浏览量
    private Date createTime;

    // 关联字段
    private String username;
    private String userRealName;

    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public Integer getUid() {return uid;}
    public void setUid(Integer uid) {this.uid = uid;}
    public String getTitle() {return title;}
    public void setTitle(String title) {this.title = title;}
    public String getContent() {return content;}
    public void setContent(String content) {this.content = content;}
    public Integer getStatus() {return status;}
    public void setStatus(Integer status) {this.status = status;}
    public Integer getIsFeatured() {return isFeatured;}
    public void setIsFeatured(Integer isFeatured) {this.isFeatured = isFeatured;}
    public String getAdminComment() {return adminComment;}
    public void setAdminComment(String adminComment) {this.adminComment = adminComment;}
    public Integer getViewCount() {return viewCount;}
    public void setViewCount(Integer viewCount) {this.viewCount = viewCount;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
    public String getUsername() {return username;}
    public void setUsername(String username) {this.username = username;}
    public String getUserRealName() {return userRealName;}
    public void setUserRealName(String userRealName) {this.userRealName = userRealName;}
}