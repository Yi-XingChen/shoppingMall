<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/6
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>

<script>
    //点击更新验证码
    function changeImg() {
        var imgSrc = $("#verifyCode");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", "${pageContext.request.contextPath}/verifyCode/verifyCode.do" + changeUrl());
    }

    function changeUrl() {
        //为了使每次图片生成的都不一样，即不让浏览器缓存，需要为请求地址添加一个可变参数
        var timeStamp = (new Date()).valueOf();
        return "?timeStamp=" + timeStamp;
    }

    //格式校验
    layui.use('form', function () {
        var form = layui.form;
        form.verify({
            userName: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '会员名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '会员名首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '会员名不能全为数字';
                }
                if (!(/^[\S]{3,18}$/).test(value)) {
                    return '会员名必须3到18位，且不能出现空格';
                }
            }
            //layui既支持上述函数式的方式，也支持下述数组的形式
            //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
            , pass: [
                /^[\S]{6,18}$/
                , '密码必须6到18位，且不能出现空格'
            ]
        });
    });
</script>

<body>
<%-- 页面顶部 --%>
<div class="top center">
    <div class="logo center">
        <a href="${pageContext.request.contextPath}/goodsType/listAllGoodsType.do" target="_blank">
            <img src="${pageContext.request.contextPath}/image/yigou_logo.png" alt="易购商城"
                 style="width: 200px;height: 100px;">
        </a>
    </div>
</div>

<%-- 登录表单提交 --%>
<form method="post" action="${pageContext.request.contextPath}/user/loginUser.do" class="layui-form form center">
    <div class="login">
        <div class="login_center">
            <div class="login_top">
                <div class="left fl">会员登录</div>
                <div class="right fr">您还不是我们的会员？<a href="register.jsp">立即注册</a></div>
                <div class="clear"></div>
                <div class="xian center"></div>
            </div>
            <div class="login_main center">
                <div class="username">会员名:&nbsp;
                    <input class="" type="text" name="userName" value="${user.userName}" required
                           autocomplete="off" placeholder="请输入你的会员名" lay-verify="required|userName"/>
                </div>
                <div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;
                    <input class="" type="password" name="password" value="" required autocomplete="off"
                           lay-verify="required|pass" placeholder="请输入你的密码"/>
                </div>
                <div class="username">
                    <div class="left fl">验证码:&nbsp;
                        <input class="" type="text" name="verifyCodeValue" value="" required
                               autocomplete="off" placeholder="请输入验证码" style="width: 135px;"/>
                        <img id="verifyCode" onclick="changeImg()"
                             src="${pageContext.request.contextPath}/verifyCode/verifyCode.do"/>
                        <br/><span style="color: red;">${error}</span>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="login_submit">
                <button class="submit" lay-submit>立即登录</button>
            </div>

        </div>
    </div>
</form>

<footer>
    <div>简体 | 繁体 | English | 常见问题</div>
    <div>©yi.com <img src="${pageContext.request.contextPath}/image/ghs.png">
        京ICP证152003号 京ICP备10036666号 京公网安备201520010301号 京网文[2019]0059-0009号
    </div>
    <div>违法和不良信息举报电话：150-3510-2867，本网站所列数据，除特殊说明，所有数据均出自本人测试</div>
</footer>
</body>
</html>
