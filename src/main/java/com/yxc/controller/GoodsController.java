package com.yxc.controller;

import com.yxc.bean.Goods;
import com.yxc.bean.GoodsType;
import com.yxc.service.GoodsService;
import com.yxc.service.GoodsTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品信息Controller
 * @author： yixingchen
 * @date： 2019-04-28
 * @version： 1.0
 **/
@Controller
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private GoodsTypeService goodsTypeService;

    /**
     * @desc: 分页查询所有商品
     * @param: [page, limit, response]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/29 9:49
     */
    @RequestMapping(value = "/selectPageGoods.do")
    @ResponseBody
    public Object selectPageGoods(int page, int limit) {
        Map<String, Object> map = new HashMap<>();
        //按照响应的 limit条件 查询数据
        List<Goods> list = goodsService.selectPageGoods(limit * (page - 1), limit);
        //所有会员的总条数
        int total = goodsService.listAllGoods().size();
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
     * @desc: 上下架商品
     * @param: [id, flag]。
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/29 10:58
     */
    @RequestMapping(value = "/upDownGoods.do")
    public String upDownGoods(String id, String flag) {
        goodsService.upDownGoods(Integer.parseInt(id), Integer.parseInt(flag));
        //如果下架商品，则要取消推荐
        if (Integer.parseInt(flag) == 1) {
            goodsService.recommendGoods(Integer.parseInt(id), 1);
        }
        //获取下拉选
        return "forward:/goodsType/selectGoodsType.do";
    }

    /**
     * @desc: 编辑更新商品信息
     * @param: [goods]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/29 11:24
     */
    @RequestMapping(value = "/editGoods.do")
    public String editGoods(String id, String goodsName, String goodsDesc, String goodsPrice,
                            String goodsImg, String stock, String goodsHref) {
        Goods goods = new Goods();
        goods.setId(Integer.parseInt(id));
        goods.setGoodsName(goodsName);
        goods.setGoodsDesc(goodsDesc);
        goods.setGoodsPrice(Integer.parseInt(goodsPrice));
        goods.setGoodsImg(goodsImg);
        goods.setStock(Integer.parseInt(stock));
        goods.setGoodsHref(goodsHref);
        goodsService.editGoods(goods);
        return "forward:/goodsType/selectGoodsType.do";
    }

    /**
     * @desc: 加库存
     * @param: [id, num]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/29 14:20
     */
    @RequestMapping(value = "/addStock.do")
    public String addStock(String stockId, String num) {
        goodsService.addStock(Integer.parseInt(stockId), Integer.parseInt(num));
        return "forward:/goodsType/selectGoodsType.do";
    }

    /**
     * @desc: 添加新商品
     * @param: [addId, addGoodsName, addGoodsDesc, addGoodsPrice, addGoodsImg, addStock, addGoodsHref]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/29 15:01
     */
    @RequestMapping(value = "/addGoods.do")
    public String addGoods(String addGoodsName, String addGoodsDesc, String addGoodsPrice, String addGoodsImg,
                           String addGoodsType, String addStock, String addGoodsHref) {
        Goods goods = new Goods();
        goods.setGoodsName(addGoodsName);
        goods.setGoodsDesc(addGoodsDesc);
        goods.setGoodsPrice(Integer.parseInt(addGoodsPrice));
        goods.setGoodsImg(addGoodsImg);
        goods.setGoodsTypeId(Integer.parseInt(addGoodsType));
        goods.setStock(Integer.parseInt(addStock));
        goods.setGoodsHref(addGoodsHref);
        //新增商品时，默认是上架的
        goods.setFlag(0);
        //新增的商品默认是不进行推荐操作的
        goods.setRecommend(1);
        goodsService.addGoods(goods);
        return "forward:/goodsType/selectGoodsType.do";
    }

    /**
     * @desc: 推荐、取消推荐商品
     * @param: [id, recommend]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/5/6 13:01
     */
    @RequestMapping(value = "/recommendGoods.do")
    public String recommendGoods(String id, String recommend) {
        goodsService.recommendGoods(Integer.parseInt(id), Integer.parseInt(recommend));
        return "forward:/goodsType/selectGoodsType.do";
    }

    /**
     * @desc: 查询所有的推荐商品，显示在首页
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/6 11:17
     */
    @RequestMapping(value = "/listAllGoodsRecommend.do")
    public ModelAndView listAllGoodsRecommend() {
        ModelAndView modelAndView = new ModelAndView();
        List<Goods> goodsRecommend = goodsService.listAllGoodsRecommend();
        modelAndView.addObject("goodsRecommend", goodsRecommend);
        modelAndView.setViewName("yiGou/index");
        return modelAndView;
    }

    /**
     * @desc: 通过商品类型id查询某类的所有商品
     * @param: [goodsTypeId]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/16 16:36
     */
    @RequestMapping(value = "/listAllGoodsByGoodsTypeId.do")
    public ModelAndView listAllGoodsByGoodsTypeId(String goodsTypeId) {
        ModelAndView modelAndView = new ModelAndView();
        //通过商品类型id查询其下所有的商品信息
        List<Goods> listAllGoodsByGoodsTypeId = goodsService.listAllGoodsByGoodsTypeId(Integer.parseInt(goodsTypeId));
        modelAndView.addObject("listAllGoodsByGoodsTypeId", listAllGoodsByGoodsTypeId);
        //通过商品类型id查询商品类型信息
        GoodsType nameByGoodsTypeId = goodsTypeService.selectByGoodsTypeId(Integer.parseInt(goodsTypeId));
        modelAndView.addObject("nameByGoodsTypeId", nameByGoodsTypeId);
        //将数据传回前台
        modelAndView.setViewName("yiGou/goodsList");
        return modelAndView;
    }

    /**
     * @desc: 通过关键字搜索
     * @param: [keyword]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/16 22:13
     */
    @RequestMapping(value = "/listGoodsByKeyword.do")
    public ModelAndView listGoodsByKeyword(String keyword) {
        ModelAndView modelAndView = new ModelAndView();
        //通过关键字查询商品信息
        List<Goods> listGoodsByKeyword = goodsService.listGoodsByKeyword(keyword);
        modelAndView.addObject("listGoodsByKeyword", listGoodsByKeyword);
        //将关键字也传过去
        modelAndView.addObject("keyword", keyword);
        modelAndView.setViewName("yiGou/keywordGoodsList");
        return modelAndView;
    }

    /**
     * @desc: 通过商品id查询该商品信息(用于商品详情页)
     * @param: [id]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/17 13:15
     */
    @RequestMapping(value = "/goodsById.do")
    public ModelAndView goodsById(String id) {
        ModelAndView modelAndView = new ModelAndView();
        Goods goodsById = goodsService.selectGoodsById(Integer.parseInt(id));
        modelAndView.addObject("goodsById", goodsById);
        modelAndView.setViewName("yiGou/goodsDetails");
        return modelAndView;
    }

    /**
     * @desc: 将购买商品的id、以及数量传给订单页
     * @param: [id, num]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/17 16:47
     */
    @RequestMapping(value = "/buyGoods.do")
    public ModelAndView buyGoods(String id, String num, String goodsPrice, String goodsName, String goodsImg,String stock) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("id", id);
        modelAndView.addObject("num", num);
        modelAndView.addObject("goodsPrice", goodsPrice);
        modelAndView.addObject("goodsName", goodsName);
        modelAndView.addObject("goodsImg", goodsImg);
        modelAndView.addObject("stock",stock);
        //计算订单总价
        int orderCost = Integer.parseInt(goodsPrice) * Integer.parseInt(num);
        modelAndView.addObject("orderCost", orderCost);
        modelAndView.setViewName("yiGou/goodsOrder");
        return modelAndView;
    }
}
