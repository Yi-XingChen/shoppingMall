package com.yxc.service.impl;

import com.yxc.bean.Admin;
import com.yxc.dao.AdminDao;
import com.yxc.service.AdminService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 管理员接口实现类
 * @author： yixingchen
 * @date： 2019-05-08
 * @version： 1.0
 **/
@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao adminDao;
    // 实例化log4j操作对象
    private Logger log = Logger.getLogger(AdminServiceImpl.class);

    /**
     * @desc:   查询所有的管理员信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.Admin>
     * @author: yixingchen
     * @date: 2019/5/8 12:44
     */
    @Override
    public List<Admin> listAllAdmin() {
        List<Admin> list = new ArrayList<>();
        try {
            list = adminDao.listAllAdmin();
        } catch (Exception e) {
            log.debug(list);
            log.error(e);
        }
        return list;
    }

    /**
     * @desc:   修改管理员
     * @param: [adminId]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/8 12:44
     */
    @Override
    public void editAdmin(Admin admin) {
        try {
            adminDao.editAdmin(admin);
        } catch (Exception e) {
            log.debug("修改管理员失败！");
            log.error(e);
        }
    }

    /**
     * @desc:   添加管理员
     * @param: [admin]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/8 12:43
     */
    @Override
    public void addAdmin(Admin admin) {
        try {
            adminDao.addAdmin(admin);
        } catch (Exception e) {
            log.debug("添加管理员失败！");
            log.error(e);
        }
    }

    /**
     * @desc:   登录后台
     * @param: [admin]
     * @return: com.yxc.bean.Admin
     * @author: yixingchen
     * @date: 2019/5/9 10:51
     */
    @Override
    public Admin login(Admin admin) {
        Admin adminLogin = new Admin();
        try {
            adminLogin = adminDao.login(admin);
        } catch (Exception e) {
            log.debug(adminLogin);
            log.error(e);
        }
        return adminLogin;
    }

    /**
     * @desc:   管理员重复性校验
     * @param: [adminName]
     * @return: int
     * @author: yixingchen
     * @date: 2019/6/5 13:13
     */
    @Override
    public int findAdminName(String adminName) {
        int result = 0;
        try {
            result = adminDao.findAdminName(adminName);
        } catch (Exception e) {
            log.error("管理员重复性校验失败！",e);
        }
        return result;
    }
}
