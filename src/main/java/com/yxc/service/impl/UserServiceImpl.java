package com.yxc.service.impl;

import com.yxc.bean.User;
import com.yxc.dao.UserDao;
import com.yxc.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 用户service实现类
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    // 实例化log4j操作对象
    private Logger log = Logger.getLogger(UserServiceImpl.class);

    /**
     * @desc: 查询所有学生信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.User>
     * @author: yixingchen
     * @date: 2019/4/22 13:11
     */
    @Override
    public List<User> listAllUser() {
        List<User> list = new ArrayList<>();
        try {
            list = userDao.listAllUser();
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc: 分页查询会员信息
     * @param: [start, pageSize]
     * @return: java.util.List<com.yxc.bean.User>
     * @author: yixingchen
     * @date: 2019/4/27 17:00
     */
    @Override
    public List<User> selectPageUser(int start, int pageSize) {
        List<User> list = new ArrayList<>();
        try {
            list = userDao.selectPageUser(start,pageSize);
        } catch (Exception e) {
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   删除用户信息
     * @param: [userId]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/27 18:15
     */
    @Override
    public int deleteUser(int userId) {
        int result = 0;
        try {
            result = userDao.deleteUser(userId);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc:   修改用户信息
     * @param: [user]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/27 18:15
     */
    @Override
    public int editUser(User user) {
        int result = 0;
        try {
            result = userDao.editUser(user);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc:   注册新增用户信息
     * @param: [user]
     * @return: int
     * @author: yixingchen
     * @date: 2019/4/27 18:15
     */
    @Override
    public int addUser(User user) {
        int result = 0;
        try {
            result = userDao.addUser(user);
        } catch (Exception e) {
            log.error(e);
        }
        return result;
    }

    /**
     * @desc:   会员登录
     * @param: [user]
     * @return: com.yxc.bean.User
     * @author: yixingchen
     * @date: 2019/5/16 14:14
     */
    @Override
    public User loginUser(User user) {
        User userLogin = new User();
        try {
            userLogin = userDao.loginUser(user);
        } catch (Exception e) {
            log.error(e);
        }
        return userLogin;
    }

    /**
     * @desc:   扣余额
     * @param: [orderCost, userId]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/30 10:20
     */
    @Override
    public void editMoney(int orderCost, int userId) {
        try {
            userDao.editMoney(orderCost,userId);
        } catch (Exception e) {
            log.error(e);
        }
    }

    /**
     * @desc:   会员名的重复性校验
     * @param: [userName]
     * @return: com.yxc.bean.User
     * @author: yixingchen
     * @date: 2019/6/6 15:29
     */
    @Override
    public User findUserName(String userName) {
        User user = new User();
        try {
            user = userDao.findUserName(userName);
        } catch (Exception e) {
            log.error("会员名的重复性校验失败！",e);
        }
        return user;
    }
}
