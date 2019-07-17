package com.yxc.service.impl;

import com.yxc.bean.Goods;
import com.yxc.dao.GoodsDao;
import com.yxc.service.GoodsService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品service实现类
 * @author： yixingchen
 * @date： 2019-04-28
 * @version： 1.0
 **/
@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsDao goodsDao;
    // 实例化log4j操作对象
    private Logger log = Logger.getLogger(GoodsServiceImpl.class);

    /**
     * @desc:   查询所有的商品信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/4/28 17:58
     */
    @Override
    public List<Goods> listAllGoods() {
        List<Goods> list = new ArrayList<>();
        try {
            list = goodsDao.listAllGoods();
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   查询某个商品类型下的所有商品信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/4/28 17:59
     */
    @Override
    public List<Goods> listGoodsByGoodsTypeId(int goodsTypeId) {
        List<Goods> list = new ArrayList<>();
        try {
            list = goodsDao.listGoodsByGoodsTypeId(goodsTypeId);
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   添加新商品
     * @param: [goods]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/28 17:59
     */
    @Override
    public int addGoods(Goods goods) {
        int result = 0;
        try {
            result = goodsDao.addGoods(goods);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc:   更新商品信息
     * @param: [goods]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/28 18:00
     */
    @Override
    public int editGoods(Goods goods) {
        int result = 0;
        try {
            result = goodsDao.editGoods(goods);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc:   分页查询所有商品信息
     * @param: [nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/4/28 18:00
     */
    @Override
    public List<Goods> selectPageGoods(int nextNum, int pageSize) {
        List<Goods> list = new ArrayList<>();
        try {
            list = goodsDao.selectPageGoods(nextNum,pageSize);
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   上下架商品
     * @param: [id, flag]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/29 10:53
     */
    @Override
    public void upDownGoods(int id, int flag) {
        try {
            goodsDao.upDownGoods(id,flag);
        } catch (Exception e) {
            log.error(e);
        }
    }

    /**
     * @desc:   加库存
     * @param: [id, num]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/29 14:17
     */
    @Override
    public void addStock(int id, int num) {
        try {
            goodsDao.addStock(id,num);
        } catch (Exception e) {
            log.error(e);
        }
    }

    /**
     * @desc:   推荐、取消推荐商品
     * @param: [id, recommend]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/6 12:56
     */
    @Override
    public void recommendGoods(int id, int recommend) {
        try {
            goodsDao.recommendGoods(id,recommend);
        } catch (Exception e) {
            log.error(e);
        }
    }

    /**
     * @desc:   查询所有被推荐的商品，用于前台首页
     * @param: []
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/5/6 14:14
     */
    @Override
    public List<Goods> listAllGoodsRecommend() {
        List<Goods> list = new ArrayList<>();
        try {
            list = goodsDao.listAllGoodsRecommend();
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   通过商品类型id查询某类的所有商品
     * @param: [goodsTypeId]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/5/16 16:26
     */
    @Override
    public List<Goods> listAllGoodsByGoodsTypeId(int goodsTypeId) {
        List<Goods> list = new ArrayList<>();
        try {
            list = goodsDao.listAllGoodsByGoodsTypeId(goodsTypeId);
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }


    /**
     * @desc:   通过关键字搜索商品
     * @param: [keyword]
     * @return: java.util.List<com.yxc.bean.Goods>
     * @author: yixingchen
     * @date: 2019/5/16 21:36
     */
    @Override
    public List<Goods> listGoodsByKeyword(String keyword) {
        List<Goods> list = new ArrayList<>();
        try {
            list = goodsDao.listGoodsByKeyword(keyword);
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   通过商品id查询该商品信息
     * @param: [id]
     * @return: com.yxc.bean.Goods
     * @author: yixingchen
     * @date: 2019/5/17 13:11
     */
    @Override
    public Goods selectGoodsById(int id) {
        Goods goodsById = new Goods();
        try {
            goodsById = goodsDao.selectGoodsById(id);
        } catch (Exception e) {
            log.error(e);
        }
        return goodsById;
    }


}
