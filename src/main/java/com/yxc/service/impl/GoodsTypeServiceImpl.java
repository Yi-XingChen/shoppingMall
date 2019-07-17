package com.yxc.service.impl;

import com.yxc.bean.GoodsType;
import com.yxc.dao.GoodsTypeDao;
import com.yxc.service.GoodsTypeService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品类型service实现类
 * @author： yixingchen
 * @date： 2019-04-23
 * @version： 1.0
 **/
@Service("goodsTypeService")
public class GoodsTypeServiceImpl implements GoodsTypeService {

    @Autowired
    private GoodsTypeDao goodsTypeDao;
    // 实例化log4j操作对象
    private Logger log = Logger.getLogger(GoodsTypeServiceImpl.class);

    /**
     * @desc: 获取所有的商品类
     * @param: []
     * @return: java.util.List<com.yxc.bean.GoodsType>
     * @author: yixingchen
     * @date: 2019/4/23 17:35
     */
    @Override
    public List<GoodsType> listAllGoodsType() {
        List<GoodsType> list = new ArrayList<>();
        try {
            list = goodsTypeDao.listAllGoodsType();
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc: 通过父id查询其下的商品类
     * @param: [pId]
     * @return: java.util.List<com.yxc.bean.GoodsType>
     * @author: yixingchen
     * @date: 2019/4/23 17:36
     */
    @Override
    public List<GoodsType> listGoodsTypeByPId(int pId) {
        List<GoodsType> list = new ArrayList<>();
        try {
            list = goodsTypeDao.listGoodsTypeByPId(pId);
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc: 删除某个商品类
     * @param: [goodsTypeId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/23 17:39
     */
    @Override
    public int deleteGoodsType(int goodsTypeId) {
        int result = 0;
        try {
            result = goodsTypeDao.deleteGoodsType(goodsTypeId);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc: 添加新的商品类
     * @param: [goodsType]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/23 17:39
     */
    @Override
    public int addGoodsType(GoodsType goodsType) {
        int result = 0;
        try {
            result = goodsTypeDao.addGoodsType(goodsType);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc: 更新商品类信息
     * @param: [goodsType]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/23 17:40
     */
    @Override
    public int editGoodsType(GoodsType goodsType) {
        int result = 0;
        try {
            result = goodsTypeDao.editGoodsType(goodsType);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc: 查询商品类表的总条数
     * @param: []
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/25 10:52
     */
    @Override
    public int selectGoodsTypeTotal() {
        int result = 0;
        try {
            result = goodsTypeDao.selectGoodsTypeTotal();
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc: 分页查询商品类信息
     * @param: [nextNum, pageSize]
     * @return: java.util.List<com.yxc.bean.GoodsType>
     * @author: yixingchen
     * @date: 2019/4/25 17:20
     */
    @Override
    public List<GoodsType> selectPageGoodsType(int nextNum, int pageSize) {
        List<GoodsType> pageGoodsTypes = new ArrayList<>();
        try {
            pageGoodsTypes = goodsTypeDao.selectPageGoodsType(nextNum, pageSize);
        } catch (Exception e) {
            log.error(e);
        }
        return pageGoodsTypes;
    }


    /**
     * @desc:   通过商品类型id查询商品类型信息
     * @param: [goodsTypeId]
     * @return: com.yxc.bean.GoodsType
     * @author: yixingchen
     * @date: 2019/5/16 16:55
     */
    @Override
    public GoodsType selectByGoodsTypeId(int goodsTypeId) {
        GoodsType goodsType = new GoodsType();
        try {
            goodsType = goodsTypeDao.selectByGoodsTypeId(goodsTypeId);
        } catch (Exception e) {
            log.error(e);
        }
        return goodsType;
    }
}
