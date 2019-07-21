<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/6/6
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员个人信息</title>
</head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>
<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });

    //修改会员信息
    function editClick() {
        //弹出编辑信息框
        layer.open({
            type: 1,
            title: "修改会员信息",
            closeBtn: 2,
            area: ['400px', '400px'],
            offset: ['30px', '200px'],
            shadeClose: true,
            content: $("#editUser"),
            //成功后的回调函数，参数为 当前层DOM，当前层索引
            success: function (layero, index) {
            },
            end: function () {
            }
        });
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
            , address: function (value, item) {
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '收货地址不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '收货地址首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '收货地址不能全为数字';
                }
            }
            //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
            , pass: [
                /^[\S]{6,18}$/
                , '密码必须6到18位，且不能出现空格'
            ]
            , num: [
                /^[1-9]\d*$/
                , '请输入正确的充值金额(正整数)'
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
                if (data == 1) {
                    $("#duplicate").html("该会员名已存在");
                }
            },
            error: function (data) {
            }
        });
    }

    //充值
    function addMoneyClick() {
        //弹出信息框
        layer.open({
            type: 1,
            title: "充值余额",
            closeBtn: 2,
            area: ['400px', '200px'],
            offset: ['100px', '200px'],
            shadeClose: true,
            content: $("#addMoney"),
            //成功后的回调函数，参数为 当前层DOM，当前层索引
            success: function (layero, index) {
            },
            end: function () {
            }
        });
    }

    //退出当前账号
    function loginOut() {
        top.location.href="${pageContext.request.contextPath}/user/loginOut.do";
    }

</script>
<body>
<div class="rtcont fr">
    <div class="grzlbt ml40">我的资料</div>
    <div class="subgrzl ml40">
        <span>会员名</span><span>${user.userName}</span>
        <span><button class="layui-btn layui-btn-normal layui-btn-sm" onclick="editClick()">修改</button></span>
    </div>
    <div class="subgrzl ml40">
        <span>密码</span>
        <span><input type="password" readonly value="${user.password}" style="border:0"/></span>
        <span><button class="layui-btn layui-btn-normal layui-btn-sm" onclick="editClick()">修改</button></span>
    </div>
    <div class="subgrzl ml40">
        <span>手机号</span><span>${user.phone}</span>
        <span><button class="layui-btn layui-btn-normal layui-btn-sm" onclick="editClick()">修改</button></span>
    </div>
    <div class="subgrzl ml40">
        <span>收货地址</span><span>${user.address}</span>
        <span><button class="layui-btn layui-btn-normal layui-btn-sm" onclick="editClick()">修改</button></span>
    </div>
    <div class="subgrzl ml40">
        <span>余额</span><span>${user.money}</span>
        <span><button class="layui-btn layui-btn-sm" onclick="addMoneyClick()">充值</button></span>
    </div>
    <div class="layui-row mt30">
        <button type="button" class="layui-btn layui-btn-warm" style="width: 300px;margin-left: 300px;"
            onclick="loginOut()">退出当前账号</button>
    </div>
</div>

<%-- 修改个人信息表单 --%>
<div id="editUser" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/user/editUser.do" method="post">
        <input type="hidden" id="userId" name="userId" value="${user.userId}"/>
        <%-- 不改余额，但是为了展示更新后的信息，需要将这个写到session中 --%>
        <input type="hidden" name="money" value="${user.money}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">会员名</label>
            <div class="layui-input-block">
                <input type="text" id="userName" placeholder="请输入会员名" autocomplete="off"
                       name="userName" value="${user.userName}" style="width: 240px" required class="layui-input"
                       lay-verify="required|userName" onblur="againUserName(this.value)">
                <label style="color: #e00f0fdb;" id="duplicate"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" id="password" placeholder="请输入密码" autocomplete="off"
                       name="password" value="${user.password}" style="width: 240px" required class="layui-input"
                       lay-verify="required|pass">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">电话号码</label>
            <div class="layui-input-block">
                <input type="text" id="phone" placeholder="请输入电话号码" autocomplete="off"
                       name="phone" value="${user.phone}" style="width: 240px" required class="layui-input"
                       lay-verify="required|phone">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">收货地址</label>
            <div class="layui-input-block">
                <input type="text" id="address" placeholder="请输入收货地址" autocomplete="off"
                       name="address" value="${user.address}" style="width: 240px" required class="layui-input"
                       lay-verify="required|address">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit>保存</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

<%-- 充值 --%>
<div id="addMoney" style="display:none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/user/addMoney.do" method="post">
        <input type="hidden" id="addUserId" name="addUserId" value="${user.userId}"/>
        <%-- 用于刷新页面的值 --%>
        <input type="hidden" id="addUserName" name="addUserName" value="${user.userName}"/>
        <input type="hidden" id="addPassword" name="addPassword" value="${user.password}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">充值金额</label>
            <div class="layui-input-block">
                <input type="text" id="num" name="num" placeholder="请输入充值金额" autocomplete="off"
                       value="" style="width: 230px" required class="layui-input" lay-verify="required|number|num">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button lay-submit class="layui-btn" style="position: relative; left: 50px;">立即提交</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
