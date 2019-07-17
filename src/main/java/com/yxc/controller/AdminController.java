package com.yxc.controller;

import com.yxc.bean.Admin;
import com.yxc.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 管理员信息Controller类
 * @author： yixingchen
 * @date： 2019-05-08
 * @version： 1.0
 **/
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    /**
     * @desc:   查询所有的管理员信息，并将结果传到后台页面
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/8 12:53
     */
    @RequestMapping(value = "/listAllAdmin.do")
    public ModelAndView listAllAdmin() {
        ModelAndView modelAndView = new ModelAndView();
        List<Admin> adminList = adminService.listAllAdmin();
        modelAndView.addObject("adminList",adminList);
        modelAndView.setViewName("/backgroundSystem/adminList");
        return modelAndView;
    }

    /**
     * @desc:   新增管理员
     * @param: [adminName, adminPassword, adminPhoto, adminPhone]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/5/8 13:17
     */
    @RequestMapping(value = "/addAdmin.do")
    public String addAdmin(Admin admin) {
        adminService.addAdmin(admin);
        return "forward:/admin/listAllAdmin.do";
    }

    /**
     * @desc:   登录后台
     * @param: [verifyCodeValue, request, admin]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/9 15:05
     */
    @RequestMapping(value = "/loginAdmin.do")
    public ModelAndView loginAdmin(String verifyCodeValue, HttpServletRequest request,Admin admin) {
        ModelAndView modelAndView = new ModelAndView();
        //验证码校验
        //获取VerifyCodeController中传到session中的验证码值
        String sessionCode=(String)request.getSession().getAttribute("code");

        //将前台输入的值不区分大小写与正确的匹配，如果不匹配，则提示！匹配则跳转
        if(!(sessionCode.equalsIgnoreCase(verifyCodeValue))){
            //验证码输入错误
            //转发回登录界面，发出提示信息
            modelAndView.addObject("error","验证码输入错误！！请重新输入");
            modelAndView.setViewName("/backgroundSystem/login");
        } else {
            Admin login = adminService.login(admin);
            if(login!=null){
                //用户名密码匹配成功
                //将admin的信息放到session中
                request.getSession().setAttribute("admin", login);
                modelAndView.setViewName("/backgroundSystem/index");
            } else {
                //匹配失败
                modelAndView.addObject("error", "管理名/密码错误！！");
                modelAndView.setViewName("/backgroundSystem/login");
            }
        }
        return modelAndView;
    }

    /**
     * @desc:   修改管理员信息
     * @param: [admin]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/16 10:18
     */
    @RequestMapping(value = "editAdmin.do")
    public ModelAndView editAdmin(Admin admin) {
        ModelAndView modelAndView = new ModelAndView();
        String adminName = admin.getAdminName();
        if (adminService.findAdminName(adminName)==0) {
            adminService.editAdmin(admin);
        } else {
            modelAndView.addObject("duplicate","该管理员名已重复，请重新输入！");
        }
        modelAndView.setViewName("/backgroundSystem/adminCenter");
        return modelAndView;
    }

    /**
     * @desc:   管理员重复性校验
     * @param: [adminName]
     * @return: int
     * @author: yixingchen
     * @date: 2019/6/5 16:48
     */
    @RequestMapping(value = "/testAdminName.do")
    @ResponseBody
    public int testAdminName(String adminName){
        return adminService.findAdminName(adminName);
    }
}
