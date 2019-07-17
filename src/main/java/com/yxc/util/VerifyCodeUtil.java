package com.yxc.util;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 验证码工具类
 * @author： yixingchen
 * @date： 2019-05-08
 * @version： 1.0
 **/
public class VerifyCodeUtil {
    //图片的宽
    private static int width = 100;
    //图片的高
    private static int height = 32;
    //图片上验证码的个数
    private static int codeCount = 4;
    //图片中字体的高
    private static int fontHeight = 22;
    //生成验证码的y坐标
    private static int codeY = 26;
    //生成验证码的x坐标
    private static int codeX = 20;
    //可选验证码字符数组
    private static char[] codeSquence = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
            'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
            '2', '3', '4', '5', '6', '7', '8', '9'};

    /**
     * 生成验证码的方法
     */
    public static Map<String, Object> getCode() {
        //定义图像buffer对象
        BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        //获取图形处理器
        Graphics gd = buffImg.getGraphics();

        //将图片填充为粉色
        gd.setColor(Color.pink);
        gd.fillRect(0, 0, width, height);

        //创建字体
        Font font = new Font("Arial", Font.BOLD, fontHeight);
        gd.setFont(font);

        //随机产生20条干扰线，使图片中的验证码不会轻易被程序检测到
        Random random = new Random();
        gd.setColor(Color.black);
        for (int i = 0; i < 20; i++) {
            //干扰线出现的x坐标
            int x = random.nextInt(width);
            //干扰线出现的y坐标
            int y = random.nextInt(height);
            //干扰线结束的x坐标(12不是固定的)
            int x1 = random.nextInt(18) + x;
            //干扰线结束的y坐标
            int y1 = random.nextInt(18) + y;
            gd.drawLine(x, y, x1, y1);
        }

        //产生随机验证码绘入图片
        int red = 0, green = 0, blue = 0;
        StringBuffer stringBuffer = new StringBuffer();

        for (int i = 0; i < codeCount; i++) {
            //获取随机验证码
            String code = String.valueOf(codeSquence[random.nextInt(codeSquence.length)]);
            //随机给颜色
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            gd.setColor(new Color(red, green, blue));
            gd.drawString(code, codeX * i + 10, codeY);
            //将生成的随机验证码依次添加到stringBuffer（一开始是空字符串）
            stringBuffer.append(code);
        }

        Map<String, Object> codeInfo = new HashMap<String, Object>();
        //将绘制好的图片添加到map中
        codeInfo.put("image", buffImg);
        //将随机生成的验证码的具体值添加到map中
        codeInfo.put("code", stringBuffer.toString());
        return codeInfo;
    }

}
