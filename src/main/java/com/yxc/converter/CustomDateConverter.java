package com.yxc.converter;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 自定义参数绑定器String→Date
 * @author： yixingchen
 * @date： 2019-04-16
 * @version： 1.0
 **/
public class CustomDateConverter implements Converter<String, Date> {
    @Override
    public Date convert(String s) {
        //实现将日期字符串转换为date类型
        //格式为yyyy-MM-dd HH:mm:ss (24小时制，如果是hh:mm:ss 则为12小时制 )
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try{
            //开始转换传入的字符串
            return simpleDateFormat.parse(s);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        //如果转换失败则返回null
        return null;
    }
}
