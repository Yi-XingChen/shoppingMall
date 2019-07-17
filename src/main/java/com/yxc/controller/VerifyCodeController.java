package com.yxc.controller;

import com.yxc.util.VerifyCodeUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 验证码Controller
 * @author： yixingchen
 * @date： 2019-05-08
 * @version： 1.0
 **/
@Controller
@RequestMapping("/verifyCode")
public class VerifyCodeController {

    @RequestMapping(value = "/verifyCode.do")
    public void verifyCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //每次访问该servlet，代表用户刷新了一次验证码操作
        Map<String, Object> codeInfo= VerifyCodeUtil.getCode();
        String code=(String)codeInfo.get("code");
        BufferedImage bi=(BufferedImage)codeInfo.get("image");
        //将验证码的字符串信息保存到session中用于验证
        request.getSession().setAttribute("code", code);

        //设置响应头，禁止图片缓存
        response.setHeader("Pragma", "no-catch");
        response.setHeader("Cache-Control", "no-catch");
        response.setDateHeader("Expires", 0);

        //设置响应格式
        response.setContentType("image/jpeg");
        //获取当前响应的字节输出流
        ServletOutputStream sos=response.getOutputStream();
        //图片输出
        ImageIO.write(bi,"jpeg",sos);
    }
}
