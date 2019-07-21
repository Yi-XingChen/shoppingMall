<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/16
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册会员</title>
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
                if (!(/^[\S]{2,18}$/).test(value)) {
                    return '会员名必须2到18位，且不能出现空格';
                }
            },
            age: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!(/^(?:[1-9][0-9]?|1[01][0-9]|120)$/).test(value)) {
                    return '您输入的年龄不合规范(1-120)';
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

    //会员名重复性校验
    function againUserName(userName) {
        //监听文本框，主要是清掉会员名已存在的校验信息
        $('#userName').on('input propertychange', function () {
            $("#duplicate").html("");
        });
        //异步查询会员名是否已存在
        $.ajax({
            url: "${pageContext.request.contextPath}/user/againUserName.do",
            data: "userName=" + userName,
            type: "get",
            dataType: "text",
            success: function (data) {
                console.log(data);
                if (data == 1) {
                    $("#duplicate").html("该会员名已存在");
                } else {
                    $("#duplicate").html("");
                }
            },
            error: function (data) {
            }
        });
    }
</script>

<body>
<%-- 页面顶部 --%>
<div class="top center">
    <div class="logo center">
        <a href="" target="_blank">
            <img src="${pageContext.request.contextPath}/image/yigou_logo.png" alt="易购商城"
                 style="width: 200px;height: 100px;">
        </a>
    </div>
</div>

<%-- 注册表单 --%>
<form class="layui-form" method="post" action="${pageContext.request.contextPath}/user/addUser.do">
    <div class="regist">
        <div class="regist_center">
            <div class="regist_top">
                <div class="left fl">会员注册</div>
                <div class="right fr">
                    <a href="${pageContext.request.contextPath}/goodsType/listAllGoodsType.do"
                       target="_self">易购商城</a>
                </div>
                <div class="clear"></div>
                <div class="xian center"></div>
            </div>
            <div class="regist_main center">
                <div class="username">会&nbsp;&nbsp;员&nbsp;&nbsp;名:&nbsp;&nbsp;
                    <input class="shurukuang" type="text" name="userName" value="${user.userName}" required
                           autocomplete="off" placeholder="请输入你的会员名" lay-verify="required|userName"
                           onblur="againUserName(this.value)"/>
                    <span>请不要输入特殊字符</span>
                    <label style="color: #e00f0fdb;" id="duplicate"></label>
                </div>

                <div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;
                    <input class="shurukuang" type="password" name="password" value="" required
                           autocomplete="off" placeholder="请输入你的密码" lay-verify="required|pass"/>
                    <span>请输入6-18位字符</span>
                </div>
                <%--
                                <div class="username">确认密码:&nbsp;&nbsp;
                                    <input class="shurukuang" type="password" name="repassword" value="" required
                                           autocomplete="off" placeholder="请确认你的密码"/>
                                    <span>两次密码要输入一致哦</span>
                                </div>--%>
                <div class="username">手&nbsp;&nbsp;机&nbsp;&nbsp;号:&nbsp;&nbsp;
                    <input class="shurukuang" type="text" name="phone" value="${user.phone}" required
                           autocomplete="off" placeholder="请填写正确的手机号" lay-verify="required|phone"/>
                    <span>填写下手机号吧，方便我们联系您！</span>
                </div>

                <div class="username">收货地址:&nbsp;&nbsp;
                    <input class="shurukuang" type="text" name="address" value="${user.address}" required
                           autocomplete="off" placeholder="请输入您的收货地址"/>
                    <span>请确保收货地址正确哦</span>
                </div>

                <div class="username">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄:&nbsp;&nbsp;
                    <input class="shurukuang" type="text" name="age" value="" required
                           autocomplete="off" placeholder="请输入你的年龄" lay-verify="required|number|age"/>
                    <span>请输入正确的年龄</span>
                </div>

                <div class="username">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
                    <div class="layui-input-block" style="top: -43px;left: -30px;">
                        <input type="radio" name="sex" value="0" title="男">
                        <input type="radio" name="sex" value="1" title="女" checked>
                    </div>
                </div>

                <div class="username">
                    <div class="left fl">验&nbsp;&nbsp;证&nbsp;&nbsp;码:&nbsp;&nbsp;
                        <input class="yanzhengma" type="text" name="verifyCodeValue" value="" required
                               autocomplete="off" placeholder="请输入验证码"/>
                        <img id="verifyCode" onclick="changeImg()"
                             src="${pageContext.request.contextPath}/verifyCode/verifyCode.do"/>
                        <br/><span style="color: red;">${error}</span>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="regist_submit">
                <button class="submit" lay-submit>立即注册</button>
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
