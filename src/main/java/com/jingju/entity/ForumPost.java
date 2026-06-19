package com.jingju.entity;

import java.util.Date;

public class ForumPost {
    private Integer id;
    private Integer uid;
    private String title;
    private String content;
    private Integer praise;
    private Integer status;      // 0待审核 1已通过 2已驳回
    private Integer replyCount;  // 回复数
    private Date createTime;

    // 关联字段（用于显示用户名）
    private String username;

    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public Integer getUid() {return uid;}
    public void setUid(Integer uid) {this.uid = uid;}
    public String getTitle() {return title;}
    public void setTitle(String title) {this.title = title;}
    public String getContent() {return content;}
    public void setContent(String content) {this.content = content;}
    public Integer getPraise() {return praise;}
    public void setPraise(Integer praise) {this.praise = praise;}
    public Integer getStatus() {return status;}
    public void setStatus(Integer status) {this.status = status;}
    public Integer getReplyCount() {return replyCount;}
    public void setReplyCount(Integer replyCount) {this.replyCount = replyCount;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
    public String getUsername() {return username;}
    public void setUsername(String username) {this.username = username;}
}