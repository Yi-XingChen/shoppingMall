package com.yxc.service;

import com.yxc.bean.Goods;

import javax.annotation.Resource;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品service类接口
 * @author： yixingchen
 * @date： 2019-04-28
 * @version： 1.0
 **/
@Resource(name = "goodsService")
public interface GoodsService {
    /**
     * @desc:   查询所有的商品信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/4/28 16:51
     */
    public List<Goods> listAllGoods();

    /**
     * @desc:   查询某个商品类型下的所有商品信息
     * @param: [goodsTypeId]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/4/28 16:55
     */
    public List<Goods> listGoodsByGoodsTypeId(int goodsTypeId);

    /**
     * @desc:   添加新商品
     * @param: [goods]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/28 16:58
     */
    public int addGoods(Goods goods);

    /**
     * @desc:   更新商品信息
     * @param: [goods]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/28 17:00
     */
    public int editGoods(Goods goods);

    /**
     * @desc:   分页查询所有商品信息
     * @param: [nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/4/28 17:35
     */
    public List<Goods> selectPageGoods(int nextNum, int pageSize);

    /**
     * @desc:   上下架商品(flag = 0：上架，1：下架)
     * @param: [id]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/29 10:39
     */
    public void upDownGoods(int id,int flag);

    /**
     * @desc:   加库存
     * @param: [num]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/29 13:17
     */
    public void addStock(int id,int num);

    /**
     * @desc:   推荐、取消推荐商品
     * @param: [id, recommend]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/6 12:55
     */
    public void recommendGoods(int id,int recommend);

    /**
     * @desc:   查询所有被推荐的商品，用于前台首页
     * @param: []
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/5/6 14:10
     */
    public List<Goods> listAllGoodsRecommend();

    /**
     * @desc:   通过商品类型id查询某类的所有商品
     * @param: [goodsTypeId]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/5/16 16:21
     */
    public List<Goods>  listAllGoodsByGoodsTypeId(int goodsTypeId);

    /**
     * @desc:   通过关键字搜索商品
     * @param: [keyword]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/5/16 21:36
     */
    public List<Goods> listGoodsByKeyword(String keyword);

    /**
     * @desc:   通过商品id查询该商品信息
     * @param: [id]
     * @return: com.yxc.bean.Goods
     * @author: yixingchen
     * @date: 2019/5/17 13:05
     */
    public Goods selectGoodsById(int id);
}
