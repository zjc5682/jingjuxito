package com.jingju.entity;

import java.util.Date;

public class Opera {
    private Integer id;
    private String title;
    private String type;
    private String content;
    private String img;
    private Integer praise;
    private Integer collect;
    private Date createTime;

    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public String getTitle() {return title;}
    public void setTitle(String title) {this.title = title;}
    public String getType() {return type;}
    public void setType(String type) {this.type = type;}
    public String getContent() {return content;}
    public void setContent(String content) {this.content = content;}
    public String getImg() {return img;}
    public void setImg(String img) {this.img = img;}
    public Integer getPraise() {return praise;}
    public void setPraise(Integer praise) {this.praise = praise;}
    public Integer getCollect() {return collect;}
    public void setCollect(Integer collect) {this.collect = collect;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
}
