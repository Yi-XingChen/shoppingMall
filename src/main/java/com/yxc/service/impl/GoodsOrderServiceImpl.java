package com.yxc.service.impl;

import com.yxc.bean.GoodsOrder;
import com.yxc.dao.GoodsOrderDao;
import com.yxc.service.GoodsOrderService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品订单service实现类
 * @author： yixingchen
 * @date： 2019-05-18
 * @version： 1.0
 **/
@Service("goodsOrderService")
public class GoodsOrderServiceImpl implements GoodsOrderService {

    @Autowired
    private GoodsOrderDao goodsOrderDao;
    // 实例化log4j操作对象
    private Logger log = Logger.getLogger(GoodsOrderServiceImpl.class);

    /**
     * @desc:   创建订单
     * @param: [goodsOrder]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/18 11:31
     */
    @Override
    public void addGoodsOrder(GoodsOrder goodsOrder) {
        try {
            goodsOrderDao.addGoodsOrder(goodsOrder);
        } catch (Exception e) {
            log.error("创建订单失败！",e);
        }
    }

    /**
     * @desc:   分页查询订单
     * @param: [nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/22 22:54
     */
    @Override
    public List<GoodsOrder> listPageGoodsOrder(int nextNum, int pageSize) {
        List<GoodsOrder> list = new ArrayList<>();
        try {
            list = goodsOrderDao.listPageGoodsOrder(nextNum,pageSize);
        } catch (Exception e) {
            log.debug(list);
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   查询所有的商品订单
     * @param: []
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/22 23:10
     */
    @Override
    public List<GoodsOrder> listAllGoodsOrder() {
        List<GoodsOrder> list = new ArrayList<>();
        try {
            list = goodsOrderDao.listAllGoodsOrder();
        } catch (Exception e) {
            log.error("查询所有订单失败！",e);
            log.error(list);
        }
        return list;
    }

    /**
     * @desc:   按订单状态分页查询订单
     * @param: [status, nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/29 23:04
     */
    @Override
    public List<GoodsOrder> selectGoodsOrderByStatus(int status, int nextNum, int pageSize) {
        List<GoodsOrder> list = new ArrayList<>();
        try {
            list = goodsOrderDao.selectGoodsOrderByStatus(status,nextNum,pageSize);
        } catch (Exception e) {
            log.debug(list);
            log.error("按订单状态为"+status+"查询结果失败！",e);
        }
        return list;
    }

    /**
     * @desc:   查询某订单状态下有多少条
     * @param: [status]
     * @return: int
     * @author: yixingchen
     * @date: 2019/5/29 23:14
     */
    @Override
    public int selectCountOrderByStatus(int status) {
        int count = 0;
        try {
            count = goodsOrderDao.selectCountOrderByStatus(status);
        } catch (Exception e) {
            log.debug("查询订单状态为"+status+"的订单总条数失败！");
            log.error(e);
        }
        return count;
    }

    /**
     * @desc:   分页查询某会员在某状态下的订单
     * @param: [status, userId, nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/30 8:17
     */
    @Override
    public List<GoodsOrder> selectPageOrdersByStatusAndUserId(int status, int userId, int nextNum, int pageSize) {
        List<GoodsOrder> list = new ArrayList<>();
        try {
            list = goodsOrderDao.selectPageOrdersByStatusAndUserId(status,userId,nextNum,pageSize);
        } catch (Exception e) {
            log.debug(list);
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   查询某会员在某订单状态下有多少条
     * @param: [status, userId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/5/30 12:32
     */
    @Override
    public int selectCountOrderByStatusAndUserId(int status, int userId) {
        int count = 0;
        try {
            count = goodsOrderDao.selectCountOrderByStatusAndUserId(status,userId);
        } catch (Exception e) {
            log.debug("查询用户id为"+userId+"且订单状态为"+status+"的订单条数失败！");
        }
        return count;
    }

    /**
     * @desc:   更改订单状态
     * @param: [status, orderId]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 11:03
     */
    @Override
    public void editOrderStatus(int status, int orderId) {
        try {
            goodsOrderDao.editOrderStatus(status,orderId);
        } catch (Exception e) {
            log.error("更改订单号为"+orderId+"的订单状态为"+status+"失败！",e);
        }
    }

    /**
     * @desc:   查询某会员的所有订单
     * @param: [userId, nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsOrder>
     * @author: yixingchen
     * @date: 2019/5/30 12:51
     */
    @Override
    public List<GoodsOrder> selectPageOrdersByUserId(int userId, int nextNum, int pageSize) {
        List<GoodsOrder> list = new ArrayList<>();
        try {
            list = goodsOrderDao.selectPageOrdersByUserId(userId,nextNum,pageSize);
        } catch (Exception e) {
            log.debug(list);
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   查询某会员的所有订单的总条数
     * @param: [userId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/5/30 12:52
     */
    @Override
    public int selectCountOrderByUserId(int userId) {
        int count = 0;
        try {
            count = goodsOrderDao.selectCountOrderByUserId(userId);
        } catch (Exception e) {
            log.debug("查询某会员的所有订单的总条数失败！",e);
        }
        return count;
    }

    /**
     * @desc:   添加付款时间
     * @param: [goodsOrder]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 16:31
     */
    @Override
    public void editPaymentTime(GoodsOrder goodsOrder) {
        try {
            goodsOrderDao.editPaymentTime(goodsOrder);
        } catch (Exception e) {
            log.debug("添加付款时间失败！");
        }
    }

    /**
     * @desc:   添加发货时间
     * @param: [goodsOrder]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 16:31
     */
    @Override
    public void editDeliveryTime(GoodsOrder goodsOrder) {
        try {
            goodsOrderDao.editDeliveryTime(goodsOrder);
        } catch (Exception e) {
            log.debug("添加发货时间失败！");
            e.printStackTrace();
        }
    }

}
