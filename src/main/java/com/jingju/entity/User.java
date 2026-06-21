package com.jingju.entity;

import java.util.Date;

public class User {
    private Integer id;
    private String username;
    private String password;
    private String name;
    private String phone;
    private String email;      // 新增邮箱
    private String avatar;     // 新增头像
    private Integer score;
    private Integer role;
    private Date createTime;
    private Date lastLoginTime; // 新增最后登录时间

    public User(){}

    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public String getUsername() {return username;}
    public void setUsername(String username) {this.username = username;}
    public String getPassword() {return password;}
    public void setPassword(String password) {this.password = password;}
    public String getName() {return name;}
    public void setName(String name) {this.name = name;}
    public String getPhone() {return phone;}
    public void setPhone(String phone) {this.phone = phone;}
    public String getEmail() {return email;}
    public void setEmail(String email) {this.email = email;}
    public String getAvatar() {return avatar;}
    public void setAvatar(String avatar) {this.avatar = avatar;}
    public Integer getScore() {return score;}
    public void setScore(Integer score) {this.score = score;}
    public Integer getRole() {return role;}
    public void setRole(Integer role) {this.role = role;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
    public Date getLastLoginTime() {return lastLoginTime;}
    public void setLastLoginTime(Date lastLoginTime) {this.lastLoginTime = lastLoginTime;}
}
