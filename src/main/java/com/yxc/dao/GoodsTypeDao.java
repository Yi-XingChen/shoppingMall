package com.yxc.dao;

import com.yxc.bean.GoodsType;

import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 商品类型数据处理接口
 * @author： yixingchen
 * @date： 2019-04-23
 * @version： 1.0
 **/
public interface GoodsTypeDao {
    /**
     * @desc: 获取所有的商品类
     * @param: []
     * @return java.util.List<com.yxc.bean.GoodsType>
     * @author yixingchen
     * @date 2019/4/23 16:49
     */
    public List<GoodsType> listAllGoodsType();

    /**
     * @desc: 通过父id查询其下的商品类
     * @param: [pId]
     * @return: java.util.List<com.yxc.bean.GoodsType>
     * @author: yixingchen
     * @date: 2019/4/23 16:53
     */
    public List<GoodsType> listGoodsTypeByPId(int pId);

    /**
     * @desc: 删除某个商品类
     * @param: [goodsTypeId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/23 16:56
     */
    public int deleteGoodsType(int goodsTypeId);

    /**
     * @desc: 添加新的商品类
     * @param: [goodsType]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/23 16:57
     */
    public int addGoodsType(GoodsType goodsType);

    /**
     * @desc: 更新商品类信息
     * @param: [goodsType]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/23 16:58
     */
    public int editGoodsType(GoodsType goodsType);

    /**
     * @desc: 查询商品类表的总条数
     * @param: []
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/25 10:49
     */
    public int selectGoodsTypeTotal();

    /**
     * @desc: 分页查询商品类信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.GoodsType>
     * @author: yixingchen
     * @date: 2019/4/25 17:09
     */
    public List<GoodsType> selectPageGoodsType(int nextNum,int pageSize);

    /**
     * @desc:   通过商品类型id查询商品类型信息
     * @param: [goodsTypeId]
     * @return: com.yxc.bean.GoodsType
     * @author: yixingchen
     * @date: 2019/5/16 16:55
     */
    public GoodsType selectByGoodsTypeId(int goodsTypeId);
}
