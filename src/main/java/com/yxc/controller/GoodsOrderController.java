package com.yxc.controller;

import com.yxc.bean.Goods;
import com.yxc.bean.GoodsOrder;
import com.yxc.bean.User;
import com.yxc.service.GoodsOrderService;
import com.yxc.service.GoodsService;
import com.yxc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品订单Controller
 * @author： yixingchen
 * @date： 2019-05-18
 * @version： 1.0
 **/
@Controller
@RequestMapping("/goodsOrder")
public class GoodsOrderController {

    @Autowired
    private GoodsOrderService goodsOrderService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private UserService userService;

    /**
     * @desc: 添加订单，并跳转到用户中心
     * @param: [goodsOrder]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/18 11:39
     */
    @RequestMapping(value = "/addGoodsOrder.do")
    public ModelAndView addGoodsOrder(GoodsOrder goodsOrder) {
        ModelAndView modelAndView = new ModelAndView();
        /*设置订单状态为1*/
        goodsOrder.setStatus(1);
        if (goodsOrder.getOrderCost() > 0) {
            goodsOrderService.addGoodsOrder(goodsOrder);
        }
        modelAndView.setViewName("yiGou/userCenter");
        return modelAndView;
    }

    /**
     * @desc: 分页查询所有订单，用于后台
     * @param: [page, limit]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/22 21:58
     */
    @ResponseBody
    @RequestMapping(value = "/listPageGoodsOrder.do")
    public Object listGoodsOrderByStatus(int page, int limit) {
        Map<String, Object> map = new HashMap<>();
        //按照响应的limit条件查询数据
        List<GoodsOrder> list = goodsOrderService.listPageGoodsOrder(limit * (page - 1), limit);
        //查询总条数
        int total = goodsOrderService.listAllGoodsOrder().size();
        map.put("msg", "");
        map.put("code", 0);
        if (list == null) {
            map.put("count", 0);
        } else {
            map.put("count", total);
        }
        map.put("data", list);
        return map;
    }

    /**
     * @desc: 按订单状态分页查询订单，用于后台
     * @param: [status, page, limit]
     * @return: java.lang.Object
     * @author: yixingchen
     * @date: 2019/5/29 23:15
     */
    @ResponseBody
    @RequestMapping(value = "/selectPageOrderByStatus.do")
    public Object selectGoodsOrderByStatus(String status, int page, int limit) {
        Map<String, Object> map = new HashMap<>();
        int order_status = Integer.parseInt(status);
        //按照响应的limit条件查询数据
        List<GoodsOrder> list = goodsOrderService.selectGoodsOrderByStatus(order_status, limit * (page - 1), limit);
        //查询总条数
        int total = goodsOrderService.selectCountOrderByStatus(order_status);
        map.put("msg", "");
        map.put("code", 0);
        if (list == null) {
            map.put("count", 0);
        } else {
            map.put("count", total);
        }
        map.put("data", list);
        return map;
    }

    /**
     * @desc: 分页查询某会员在某状态下的订单
     * @param: [status, page, limit, request]
     * @return: java.lang.Object
     * @author: yixingchen
     * @date: 2019/5/30 8:27
     */
    @ResponseBody
    @RequestMapping(value = "/selectPageOrdersByStatusAndUserId.do")
    public Object selectPageOrdersByStatusAndUserId(String status, int page, int limit, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        int order_status = Integer.parseInt(status);
        //从session中获取登录会员的信息
        User user = (User) request.getSession().getAttribute("user");
        int userId = user.getUserId();
        //按照响应的limit条件查询数据
        List<GoodsOrder> list = goodsOrderService.selectPageOrdersByStatusAndUserId(order_status, userId, limit * (page - 1), limit);
        //查询总条数
        int total = goodsOrderService.selectCountOrderByStatusAndUserId(order_status, userId);
        map.put("msg", "");
        map.put("code", 0);
        if (list == null) {
            map.put("count", 0);
        } else {
            map.put("count", total);
        }
        map.put("data", list);
        return map;
    }

    /**
     * @desc:   获取库存，并判断库存与购买数量哪个大
     * @param: [goodsId, count]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/6/9 21:30
     */
    @ResponseBody
    @RequestMapping(value = "/getStock.do")
    public int getStock(String goodsId,String count) {
        //获取商品库存
        Goods goods = goodsService.selectGoodsById(Integer.parseInt(goodsId));
        int stock = goods.getStock();
        //判断库存是否大于购买数量
        if (stock>Integer.parseInt(count)) {
            return 1;
        }else {
            return 0;
        }
    }

    /**
     * @desc:   扣钱并改变订单状态为2、添加付款时间
     * @param: [goodsId, count, orderCost, request]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/5/30 10:51
     */
    @RequestMapping(value = "/stockGreaterCount.do")
    public String stockGreaterCount(String goodsId, String count, String orderCost, String orderId, HttpServletRequest request) {
        //获取商品信息
        Goods goods = goodsService.selectGoodsById(Integer.parseInt(goodsId));
        int stock = goods.getStock();
        //获取会员信息
        User user = (User) request.getSession().getAttribute("user");
        int userId = user.getUserId();
        //获取当前系统时间
        Date date = new Date();
        GoodsOrder goodsOrder = new GoodsOrder();
        goodsOrder.setPaymentTime(date);
        goodsOrder.setOrderId(Integer.parseInt(orderId));

        //扣余额且给订单添加付款时间
        if (stock > Integer.parseInt(count)) {
            //扣余额
            userService.editMoney(Integer.parseInt(orderCost), userId);
            //更新session中的user值
            User loginUser = userService.loginUser(user);
            request.getSession().setAttribute("user",loginUser);
            //添加付款时间
            goodsOrderService.editPaymentTime(goodsOrder);
            return "forward:/goodsOrder/editOrderStatus.do?status=2";
        } else {
            return "forward:/goodsOrder/editOrderStatus.do?status=1";
        }
    }


    /**
     * @desc: 更改订单状态
     * @param: [status, orderId]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/30 11:06
     */
    @RequestMapping(value = "/editOrderStatus.do")
    public ModelAndView editOrderStatus(String status, String orderId) {
        ModelAndView modelAndView = new ModelAndView();
        int order_status = Integer.parseInt(status);
        int order_id = Integer.parseInt(orderId);
        goodsOrderService.editOrderStatus(order_status, order_id);
        if (order_status == 2) {
            modelAndView.setViewName("yiGou/nonShippedOrder");
        } else if (order_status == 3) {
            modelAndView.setViewName("yiGou/nonDeliveryOrder");
        } else {
            modelAndView.setViewName("yiGou/allGoodsOrder");
        }
        return modelAndView;
    }

    /**
     * @desc: 查询某会员的所有订单
     * @param: [page, limit, request]
     * @return: java.lang.Object
     * @author: yixingchen
     * @date: 2019/5/30 12:56
     */
    @ResponseBody
    @RequestMapping(value = "/selectPageOrdersByUserId.do")
    public Object selectPageOrdersByUserId(int page, int limit, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        //从session中获取登录会员的信息
        User user = (User) request.getSession().getAttribute("user");
        int userId = user.getUserId();
        //按照响应的limit条件查询数据
        List<GoodsOrder> list = goodsOrderService.selectPageOrdersByUserId(userId, limit * (page - 1), limit);
        //查询总条数
        int total = goodsOrderService.selectCountOrderByUserId(userId);
        map.put("msg", "");
        map.put("code", 0);
        if (list == null) {
            map.put("count", 0);
        } else {
            map.put("count", total);
        }
        map.put("data", list);
        return map;
    }

    /**
     * @desc:   管理员发货
     * @param: [stockId, num, status, orderId]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/30 15:53
     */
    @RequestMapping(value = "/shipment.do")
    public ModelAndView shipment(String stockId, String num, String status, String orderId) {
        ModelAndView modelAndView = new ModelAndView();
        //减库存
        goodsService.addStock(Integer.parseInt(stockId), -Integer.parseInt(num));
        //改订单状态
        goodsOrderService.editOrderStatus(Integer.parseInt(status),Integer.parseInt(orderId));
        //添加发货时间
        Date date = new Date();
        GoodsOrder goodsOrder = new GoodsOrder();
        goodsOrder.setOrderId(Integer.parseInt(orderId));
        goodsOrder.setDeliveryTime(date);
        goodsOrderService.editDeliveryTime(goodsOrder);

        modelAndView.setViewName("backgroundSystem/nonShippedOrder");
        return modelAndView;
    }
}
