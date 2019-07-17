package com.yxc.bean;

import java.util.Date;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品订单实体类
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
public class GoodsOrder {
    /**
     * 订单id
     */
    private int orderId;
    /**
     * 订单金额
     */
    private float orderCost;
    /**
     * 订单编号 -- 当前时间(精确到毫秒)+购买者id+购买数量+商品id
     */
    private String orderNo;
    /**
     * 订单状态，1：创建未付款；2：付款未发货；3：发货未收货；4：完成订单；5：订单取消
     */
    private int status;
    /**
     * 会员id，购买者
     */
    private int userId;
    /**
     * 商品id
     */
    private int goodsId;
    /**
     * 购买数量
     */
    private int count;
    /**
     * 订单创建时间
     */
    private Date createTime;
    /**
     * 订单付款时间
     */
    private Date paymentTime;
    /**
     * 发货时间
     */
    private Date deliveryTime;
    /**
     * 商品名(外加字段)
     */
    private String goodsName;

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public float getOrderCost() {
        return orderCost;
    }

    public void setOrderCost(float orderCost) {
        this.orderCost = orderCost;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Date getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(Date deliveryTime) {
        this.deliveryTime = deliveryTime;
    }
}
