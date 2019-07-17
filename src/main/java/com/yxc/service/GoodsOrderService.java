package com.yxc.service;

import com.yxc.bean.GoodsOrder;
import org.apache.ibatis.annotations.Param;

import javax.annotation.Resource;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品订单service接口
 * @author： yixingchen
 * @date： 2019-05-18
 * @version： 1.0
 **/
@Resource(name = "goodsOrderService")
public interface GoodsOrderService {
    /**
     * @desc:   创建订单
     * @param: [goodsOrder]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/18 11:01
     */
    public void addGoodsOrder(GoodsOrder goodsOrder);

    /**
     * @desc:   分页查询订单
     * @param: [nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/22 22:53
     */
    public List<GoodsOrder> listPageGoodsOrder(int nextNum,int pageSize);

    /**
     * @desc:   查询所有的商品订单
     * @param: []
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/22 23:06
     */
    public List<GoodsOrder> listAllGoodsOrder();

    /**
     * @desc:   按订单状态分页查询订单
     * @param: [status, nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/29 23:00
     */
    public List<GoodsOrder> selectGoodsOrderByStatus(@Param("status") int status, @Param("nextNum") int nextNum, @Param("pageSize") int pageSize);

    /**
     * @desc:   查询某订单状态下有多少条
     * @param: [status]
     * @return: int
     * @author: yixingchen
     * @date: 2019/5/29 23:10
     */
    public int selectCountOrderByStatus(int status);

    /**
     * @desc:   分页查询某会员在某状态下的订单
     * @param: [status, userId, nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/30 8:15
     */
    public List<GoodsOrder> selectPageOrdersByStatusAndUserId(@Param("status") int status, @Param("userId") int userId, @Param("nextNum") int nextNum, @Param("pageSize") int pageSize);

    /**
     * @desc:   查询某会员在某订单状态下有多少条
     * @param: [status, userId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/5/30 12:30
     */
    public int selectCountOrderByStatusAndUserId(@Param("status") int status, @Param("userId") int userId);

    /**
     * @desc:   更改订单状态
     * @param: [status, orderId]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 11:01
     */
    public void editOrderStatus(@Param("status") int status,@Param("orderId") int orderId);

    /**
     * @desc:   查询某会员的所有订单
     * @param: [userId, nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/30 12:46
     */
    public List<GoodsOrder> selectPageOrdersByUserId(@Param("userId") int userId, @Param("nextNum") int nextNum, @Param("pageSize") int pageSize);

    /**
     * @desc:   查询某会员的所有订单的总条数
     * @param: [userId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/5/30 12:47
     */
    public int selectCountOrderByUserId(int userId);

    /**
     * @desc:   添加付款时间
     * @param: [goodsOrder]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 16:27
     */
    public void editPaymentTime(GoodsOrder goodsOrder);

    /**
     * @desc:   添加发货时间
     * @param: [goodsOrder]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 16:29
     */
    public void editDeliveryTime(GoodsOrder goodsOrder);

}
