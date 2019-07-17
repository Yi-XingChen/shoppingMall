package com.yxc.controller;

import com.yxc.bean.Goods;
import com.yxc.bean.GoodsType;
import com.yxc.service.GoodsService;
import com.yxc.service.GoodsTypeService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品类controller类
 * @author： yixingchen
 * @date： 2019-04-23
 * @version： 1.0
 **/
@Controller
@RequestMapping("/goodsType")
public class GoodsTypeController {
    
    @Autowired
    private GoodsTypeService goodsTypeService;
    @Autowired
    private GoodsService goodsService;

    /**
     * @desc: 获取所有的商品类
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/4/23 17:49
     */
    @RequestMapping("/listAllGoodsType.do")
    public ModelAndView listAllGoodsType() {
        ModelAndView modelAndView = new ModelAndView();
        //查询所有的商品类型信息
        List<GoodsType> goodsTypeList = goodsTypeService.listAllGoodsType();
        modelAndView.addObject("goodsTypeList",goodsTypeList);
        //推荐商品
        List<Goods> goodsRecommend = goodsService.listAllGoodsRecommend();
        modelAndView.addObject("goodsRecommend",goodsRecommend);
        //将数据传到前台（page下的index）
        modelAndView.setViewName("yiGou/index");
        return modelAndView;
    }

    /**
     * @desc:   查找树需要的数据
     * @param: []
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/4 22:13
     */
    @ResponseBody
    @RequestMapping(value = "/goodsTypeTree.do",produces = "text/html;charset=UTF-8")
    public String goodsTypeTree() {
        List<GoodsType> goodsTypesList = goodsTypeService.listAllGoodsType();
        JSONArray jsonArray = new JSONArray().fromObject(goodsTypesList);
        return jsonArray.toString();
    }

    /**
     * @desc: 通过父id查询其下的商品类
     * @param: [pId]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/4/24 9:36
     */
    @RequestMapping("/listGoodsTypeByPId.do")
    public ModelAndView listGoodsTypeByPId(String pId) {
        ModelAndView modelAndView = new ModelAndView();
        List<GoodsType> goodsTypesBypId = goodsTypeService.listGoodsTypeByPId(Integer.parseInt(pId));
        modelAndView.addObject("goodsTypesBypId",goodsTypesBypId);
        modelAndView.addObject("pId",pId);
        modelAndView.setViewName("backgroundSystem/goodsTypeByPId");
        return modelAndView;
    }

    /**
     * @desc: 分页查询商品类
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/4/24 9:53
     */
    @ResponseBody
    @RequestMapping(value = "/selectPageGoodsType.do",method = RequestMethod.GET)
    public Object selectPageGoodsType(int page, int limit) {
        Map<String,Object> map = new HashMap<>();
        //按照响应的limit条件查询数据
        List<GoodsType> list = goodsTypeService.selectPageGoodsType(limit * (page - 1), limit);
        //所有商品类的总条数
        int total = goodsTypeService.selectGoodsTypeTotal();
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
     * @desc: 删除某个商品类
     * @param: [goodsTypeId]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/24 9:44
     */
    @RequestMapping(value = "/deleteGoodsType.do")
    public String deleteGoodsType(int goodsTypeId) {
        goodsTypeService.deleteGoodsType(goodsTypeId);
        return "forward:/page/backgroundSystem/goodsType.jsp";
    }

    /**
     * @desc: 添加新的商品类
     * @param: [goodsType]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/24 9:46
     */
    @RequestMapping(value = "/addGoodsType.do")
    public String addGoodsType(String pIdAdd,String goodsTypeName,String goodsTypeDesc,String href) {
        GoodsType goodsType = new GoodsType();
        goodsType.setpId(Integer.parseInt(pIdAdd));
        goodsType.setGoodsTypeName(goodsTypeName);
        goodsType.setGoodsTypeDesc(goodsTypeDesc);
        goodsType.setHref(href);
        goodsTypeService.addGoodsType(goodsType);
        //刷新页面
        return "forward:/goodsType/listGoodsTypeByPId.do?pId="+pIdAdd;
    }

    /**
     * @desc: 更新商品类信息
     * @param: [goodsType]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/4/24 9:48
     */
    @RequestMapping(value = "/editGoodsType.do",method = RequestMethod.POST)
    public String editGoodsType(String goodsTypeId,String goodsTypeName,String goodsTypeDesc,String href,String pIdEdit) {
        GoodsType goodsType = new GoodsType();
        goodsType.setGoodsTypeId(Integer.parseInt(goodsTypeId));
        goodsType.setGoodsTypeName(goodsTypeName);
        goodsType.setGoodsTypeDesc(goodsTypeDesc);
        goodsType.setHref(href);
        goodsTypeService.editGoodsType(goodsType);
        //刷新页面
        return "forward:/goodsType/listGoodsTypeByPId.do?pId="+pIdEdit;
    }

    /**
     * @desc:   查询所有的商品类型，用于添加新商品时的下拉选
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/5 17:39
     */
    @RequestMapping(value = "/selectGoodsType.do")
    public ModelAndView selectGoodsType() {
        ModelAndView modelAndView = new ModelAndView();
        List<GoodsType> selectGoodsType = goodsTypeService.listAllGoodsType();
        modelAndView.addObject("selectGoodsType",selectGoodsType);
        modelAndView.setViewName("backgroundSystem/goodsList");
        return modelAndView;
    }

}
