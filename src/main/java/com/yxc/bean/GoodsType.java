package com.yxc.bean;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品类型实体类
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
public class GoodsType {
    /**
     * 商品类型id
     */
    private int goodsTypeId;
    /**
     * 商品类型名
     */
    private String goodsTypeName;
    /**
     * 商品类型父id，一级id
     */
    private int pId;
    /**
     * 商品类型备注 图标
     */
    private String goodsTypeDesc;
    /**
     * 商品类型链接
     */
    private String href;

    public int getGoodsTypeId() {
        return goodsTypeId;
    }

    public void setGoodsTypeId(int goodsTypeId) {
        this.goodsTypeId = goodsTypeId;
    }

    public String getGoodsTypeName() {
        return goodsTypeName;
    }

    public void setGoodsTypeName(String goodsTypeName) {
        this.goodsTypeName = goodsTypeName;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getGoodsTypeDesc() {
        return goodsTypeDesc;
    }

    public void setGoodsTypeDesc(String goodsTypeDesc) {
        this.goodsTypeDesc = goodsTypeDesc;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }
}
