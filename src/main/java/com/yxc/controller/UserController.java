package com.yxc.controller;

import com.yxc.bean.Admin;
import com.yxc.bean.Goods;
import com.yxc.bean.GoodsType;
import com.yxc.bean.User;
import com.yxc.service.GoodsService;
import com.yxc.service.GoodsTypeService;
import com.yxc.service.UserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 会员操作管理
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private GoodsTypeService goodsTypeService;
    @Autowired
    private GoodsService goodsService;

    /**
     * @desc: 查询所有会员信息
     * @param: [user]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/4/22 14:22
     */
    @RequestMapping("/listAllUser.do")
    public ModelAndView listAllUser() {
        ModelAndView modelAndView = new ModelAndView();
        List<User> list = userService.listAllUser();
        modelAndView.addObject("list", list);
        modelAndView.setViewName("backgroundSystem/userList");
        return modelAndView;
    }

    /**
     * @desc: 分页查询会员信息
     * @param: [page, limit, response]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/27 17:07
     */
    @RequestMapping(value = "/selectPageUser.do", method = RequestMethod.GET)
    @ResponseBody
    public void selectPageUser(int page, int limit, HttpServletResponse response) {
        JSONObject jsonObject = new JSONObject();
        //按照响应的 limit条件 查询数据
        List<User> list = userService.selectPageUser(limit * (page - 1), page * limit);
        //所有会员的总条数
        int total = userService.listAllUser().size();
        jsonObject.put("msg", "");
        jsonObject.put("code", 0);
        if (list == null) {
            jsonObject.put("count", 0);
        } else {
            jsonObject.put("count", total);
        }
        jsonObject.put("data", list);
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.print(jsonObject);
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.flush(); //清空缓冲区数据
        out.close();
    }

    /**
     * @desc: 删除用户
     * @param: [userId]
     * @return: void
     * @author: yixingchen
     * @date: 2019/4/27 18:21
     */
    @RequestMapping(value = "/deleteUser.do")
    public String deleteUser(int userId) {
        userService.deleteUser(userId);
        return "forward:/page/backgroundSystem/userList.jsp";
    }

    /**
     * @desc: 会员登录
     * @param: [verifyCodeValue, request, user]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/16 13:42
     */
    @RequestMapping(value = "/loginUser.do")
    public ModelAndView loginUser(String verifyCodeValue, HttpServletRequest request, User user) {
        ModelAndView modelAndView = new ModelAndView();
        //验证码校验
        //获取VerifyCodeController中传到session中的验证码值
        String sessionCode = (String) request.getSession().getAttribute("code");

        //将前台输入的值不区分大小写与正确的匹配，如果不匹配，则提示！匹配则跳转
        if (!(sessionCode.equalsIgnoreCase(verifyCodeValue))) {
            //验证码输入错误
            //转发回登录界面，发出提示信息
            modelAndView.addObject("error", "验证码输入错误！！请重新输入");
            modelAndView.setViewName("/yiGou/login");
        } else {
            User login = userService.loginUser(user);
            if (login != null) {
                //用户名密码匹配成功
                //将user的信息放到session中
                request.getSession().setAttribute("user", login);
                //查询所有的商品类型信息
                List<GoodsType> goodsTypeList = goodsTypeService.listAllGoodsType();
                modelAndView.addObject("goodsTypeList", goodsTypeList);
                //推荐商品
                List<Goods> goodsRecommend = goodsService.listAllGoodsRecommend();
                modelAndView.addObject("goodsRecommend", goodsRecommend);
                //将数据传到前台（page下的index）
                modelAndView.setViewName("yiGou/index");
            } else {
                //匹配失败
                modelAndView.addObject("error", "会员名/密码错误！！");
                modelAndView.setViewName("/yiGou/login");
            }
        }
        return modelAndView;
    }

    /**
     * @desc:   注册用户
     * @param: [verifyCodeValue, request, user]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/17 11:17
     */
    @RequestMapping(value = "/addUser.do")
    public ModelAndView addUser(String verifyCodeValue, HttpServletRequest request, User user) {
        ModelAndView modelAndView = new ModelAndView();
        //验证码校验
        //获取VerifyCodeController中传到session中的验证码值
        String sessionCode = (String) request.getSession().getAttribute("code");

        //将前台输入的值不区分大小写与正确的匹配，如果不匹配，则提示！匹配则跳转
        if (!(sessionCode.equalsIgnoreCase(verifyCodeValue))) {
            //验证码输入错误
            //转发回注册界面，发出提示信息
            modelAndView.addObject("error", "验证码输入错误！！请重新输入");
            modelAndView.setViewName("/yiGou/register");
            //如果用户名未存在，则添加用户
        } else if (userService.findUserName(user.getUserName())==null){
            //添加用户
            userService.addUser(user);
            //注册成功，前往登录页
            modelAndView.setViewName("yiGou/login");
        } else {
            modelAndView.addObject("duplicate","会员名已存在！");
        }
        return modelAndView;
    }

    /**
     * @desc:   修改会员信息
     * @param: [user]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/6/6 12:39
     */
    @RequestMapping(value = "/editUser.do")
    public ModelAndView editUser(User user,HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        //仅仅提示会员，该改的时候还得改！修改非会员名时，会导致改不了。
//        if (userService.findUserName(user.getUserName())==null) {
        userService.editUser(user);
        //将修改后的数据再次放到session中，覆盖掉以前的值。
        request.getSession().setAttribute("user", user);
        modelAndView.setViewName("yiGou/selfInfo");
        return modelAndView;
    }

    /**
     * @desc:   会员名的重复性校验
     * @param: [userName]
     * @return: com.yxc.bean.User
     * @author: yixingchen
     * @date: 2019/6/6 15:33
     */
    @RequestMapping("/againUserName.do")
    @ResponseBody
    public int againUserName(String userName) {
        if (userService.findUserName(userName)== null) {
            return 0;
        } else {
            return 1;
        }
    }

    /**
     * @desc:   充值金额
     * @param: [addUserId, num]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/6/6 20:55
     */
    @RequestMapping(value = "/addMoney.do")
    public ModelAndView addMoney(String addUserId,String num,String addUserName,String addPassword,HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        userService.editMoney(-Integer.parseInt(num),Integer.parseInt(addUserId));
        //将session的用户信息重新覆盖
        User user = new User();
        user.setUserName(addUserName);
        user.setPassword(addPassword);
        User loginUser = userService.loginUser(user);
        request.getSession().setAttribute("user",loginUser);

        modelAndView.setViewName("yiGou/selfInfo");
        return modelAndView;
    }

    /**
     * @desc:   会员注销
     * @param: [request]
     * @return: java.lang.String
     * @author: yixingchen
     * @date: 2019/6/9 18:06
     */
    @RequestMapping(value = "/loginOut.do")
    public String loginOut(HttpServletRequest request) {
        //清空user的信息
        request.getSession().removeAttribute("user");
        //跳转到首页
        return "redirect:/goodsType/listAllGoodsType.do";
    }

}
