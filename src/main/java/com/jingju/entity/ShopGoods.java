package com.jingju.entity;

public class ShopGoods {
    private Integer id;
    private String goodsName;
    private Integer goodsScore;
    private Integer stock;
    private String img;
    private Integer status;      // 1上架 0下架
    private String description;  // 商品描述

    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public String getGoodsName() {return goodsName;}
    public void setGoodsName(String goodsName) {this.goodsName = goodsName;}
    public Integer getGoodsScore() {return goodsScore;}
    public void setGoodsScore(Integer goodsScore) {this.goodsScore = goodsScore;}
    public Integer getStock() {return stock;}
    public void setStock(Integer stock) {this.stock = stock;}
    public String getImg() {return img;}
    public void setImg(String img) {this.img = img;}
    public Integer getStatus() {return status;}
    public void setStatus(Integer status) {this.status = status;}
    public String getDescription() {return description;}
    public void setDescription(String description) {this.description = description;}
}
