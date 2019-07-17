package com.yxc.dao;

import com.yxc.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 会员数据处理类接口
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
public interface UserDao {
    /**
     * @desc: 查询所有会员信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.User>
     * @author: yixingchen
     * @date: 2019/4/22 12:49
     */
    public List<User> listAllUser();

    /**
     * @desc: 分页查询会员信息
     * @param: [start, pageSize]
     * @return: java.util.List<com.yxc.bean.User>
     * @author: yixingchen
     * @date: 2019/4/27 16:54
     */
    public List<User> selectPageUser(int start,int pageSize);

    /**
     * @desc:   删除会员信息
     * @param: [userId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/27 17:49
     */
    public int deleteUser(int userId);

    /**
     * @desc:   修改会员信息
     * @param: [user]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/27 17:52
     */
    public int editUser(User user);

    /**
     * @desc:   注册会员信息
     * @param: [user]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/27 17:53
     */
    public int addUser(User user);

    /**
     * @desc:   会员登录
     * @param: [user]
     * @return: com.yxc.bean.User
     * @author: yixingchen
     * @date: 2019/5/16 14:09
     */
    public User loginUser(User user);

    /**
     * @desc:   扣余额
     * @param: [orderCost, userId]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 10:19
     */
    public void editMoney(int orderCost,int userId);

    /**
     * @desc:   会员名重复性校验
     * @param: [userName]
     * @return: com.yxc.bean.User
     * @author: yixingchen
     * @date: 2019/6/6 15:25
     */
    public User findUserName(String userName);

}
