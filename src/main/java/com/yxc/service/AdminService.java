package com.yxc.service;

import com.yxc.bean.Admin;

import javax.annotation.Resource;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 管理员service接口
 * @author： yixingchen
 * @date： 2019-05-08
 * @version： 1.0
 **/
@Resource(name = "adminService")
public interface AdminService {
    /**
     * @desc:   查询所有的管理员信息
     * @param: []
     * @return: java.util.List<com.yxc.bean.Admin>
     * @author: yixingchen
     * @date: 2019/5/8 10:53
     */
    public List<Admin> listAllAdmin();

    /**
     * @desc:   修改管理员信息，只有自己可以修改
     * @param: [admin]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/8 10:55
     */
    public void editAdmin(Admin admin);

    /**
     * @desc:   新增管理员
     * @param: [admin]
     * @return: void
     * @author: yixingchen
     * @date: 2019/5/8 11:25
     */
    public void addAdmin(Admin admin);

    /**
     * @desc:   登录后台
     * @param: [admin]
     * @return: com.yxc.bean.Admin
     * @author: yixingchen
     * @date: 2019/5/9 10:45
     */
    public Admin login(Admin admin);

    /**
     * @desc:   管理员重复性校验
     * @param: [adminName]
     * @return: int
     * @author: yixingchen
     * @date: 2019/6/5 13:09
     */
    public int findAdminName(String adminName);

}
