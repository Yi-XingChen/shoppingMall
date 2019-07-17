package com.yxc.bean;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品实体类
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
public class Goods {
    /**
     * 商品id
     */
    private int id;
    /**
     * 商品名
     */
    private String goodsName;
    /**
     * 商品描述
     */
    private String goodsDesc;
    /**
     * 商品价格
     */
    private int goodsPrice;
    /**
     * 商品图片链接
     */
    private String goodsImg;
    /**
     * 商品类型id
     */
    private int goodsTypeId;
    /**
     * 商品库存
     */
    private int stock;
    /**
     * 商品上下架的标志（0：上架中；1：下架了）
     */
    private int flag;
    /**
     * 优品推荐标志（0：推荐该商品；1：平凡，不进行操作）
     */
    private int recommend;
    /**
     * 商品跳转链接
     */
    private String goodsHref;
    /**
     * 商品类型名(外加字段，用于在表格中显示)
     */
    private String goodsTypeName;

    public String getGoodsTypeName() {
        return goodsTypeName;
    }

    public void setGoodsTypeName(String goodsTypeName) {
        this.goodsTypeName = goodsTypeName;
    }

    public String getGoodsHref() {
        return goodsHref;
    }

    public void setGoodsHref(String goodsHref) {
        this.goodsHref = goodsHref;
    }

    public int getRecommend() {
        return recommend;
    }

    public void setRecommend(int recommend) {
        this.recommend = recommend;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsDesc() {
        return goodsDesc;
    }

    public void setGoodsDesc(String goodsDesc) {
        this.goodsDesc = goodsDesc;
    }

    public int getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(int goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public String getGoodsImg() {
        return goodsImg;
    }

    public void setGoodsImg(String goodsImg) {
        this.goodsImg = goodsImg;
    }

    public int getGoodsTypeId() {
        return goodsTypeId;
    }

    public void setGoodsTypeId(int goodsTypeId) {
        this.goodsTypeId = goodsTypeId;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}
