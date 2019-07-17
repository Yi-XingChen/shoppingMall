package com.yxc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 文件上传
 * @author： yixingchen
 * @date： 2019-05-09
 * @version： 1.0
 **/
@Controller
@RequestMapping("/upload")
public class UploadController {

    private static int num = 0;

    /**
     * @desc: 文件上传
     * @param: [file, description, request]
     * @return: org.springframework.web.servlet.ModelAndView
     * @author: yixingchen
     * @date: 2019/5/9 17:37
     */
    @RequestMapping(value = "/fileUpload.do", method = RequestMethod.POST)
    @ResponseBody
    public Object upload(MultipartFile file, HttpServletRequest request) throws IOException {
        //获取上传的文件名
        String originalFilename = file.getOriginalFilename();
        //获取文件后缀名
        assert originalFilename != null;
        String fileTypeName = originalFilename.substring(originalFilename.lastIndexOf("."));
        //时间格式化
        SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
        //获取当前时间并作为时间戳
        String timeStamp = yyyyMMddHHmmss.format(new Date());
        //获取年月日
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        //拼接新的文件名
        String realFileName = timeStamp + fileTypeName;
        //当文件上传了5个后，就新建一个文件夹
        int foldPath = (num / 5) + 1;
        num++;

        //获取要上传到的目标地址
        String firstPath = request.getSession().getServletContext().getRealPath("/");
        String ctxPath = firstPath + "upload" + File.separator
                + year + File.separator + month + File.separator + day + File.separator + foldPath;

        //如果文件夹不存在，则创建一个文件夹
        File dirPath = new File(ctxPath);
        if (!dirPath.exists()) {
            //mkdir()：只能创建一层目录；
            // mkdirs(): 创建多层目录
            dirPath.mkdirs();
        }

        File[] list = dirPath.listFiles();
        //获取文件夹下所有的文件 不是图片的文件也会被读取的，
        // 如果你是专门用来存放图片的文件，这种方法可行 否则的话就要判断文件的类型了
        int length = list.length;

        //开始执行文件上传
        File uploadFile = new File(dirPath + "\\" + realFileName);
//        System.out.println("上传地址：" + dirPath + "   文件地址：" + ctxPath);
        FileCopyUtils.copy(file.getBytes(), uploadFile);

        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("src", "/mall/upload/" + year +"/"+ month +"/"+ day +"/"+ foldPath +"/"+ realFileName);
        return map;
    }
}
