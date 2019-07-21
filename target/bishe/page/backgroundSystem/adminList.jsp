<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/8
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理员信息列表</title>
</head>
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
<script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });

    //点击添加新管理员按钮之后的响应
    function addClick() {
        var $ = layui.$;
        //新增管理员弹出层
        layer.open({
            type: 1,
            title: "新增管理员信息",
            closeBtn: 2,
            area: ['400px', '350px'],
            offset: ['100px', '200px'],
            shadeClose: true,
            content: $("#addAdmin"),
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
            adminName: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '管理员名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '管理员名首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '管理员名不能全为数字';
                }
                if (!(/^[\S]{3,18}$/).test(value)) {
                    return '管理员名必须3到18位，且不能出现空格';
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

    //管理员重复性校验
    function testAdminName(adminName) {
        //监听文本框，主要是清掉管理员存在的校验信息
        $('#adminName').on('input propertychange', function() {
            $("#duplicate").html("");
        });
        //异步查询管理员名是否已重复
        $.ajax({
            url:"${pageContext.request.contextPath}/admin/testAdminName.do",
            data:"adminName=" + adminName,
            type:"get",
            dataType:"text",
            success:function(data){
                if (data==1) {
                    $("#duplicate").html("该管理员名已存在");
                }
            },
            error:function(data){
            }
        });
    }
</script>

<body>
<button class="layui-btn layui-btn-radius layui-btn-warm"
        onclick="addClick()">添加管理员
</button>
<div>
    <table class="layui-table">
        <colgroup>
            <col width="150">
            <col width="200">
            <col width="200">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>管理员名</th>
            <th>头像</th>
            <th>联系号码</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${adminList}">
            <tr>
                <td>${item.adminName}</td>
                <td>${item.adminPhoto}</td>
                <td>${item.adminPhone}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%-- 新增管理员 --%>
<div id="addAdmin" style="display:none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/admin/addAdmin.do" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">管理员名</label>
            <div class="layui-input-block">
                <input type="text" id="adminName" placeholder="请输入管理员名" autocomplete="off" name="adminName"
                       value="" style="width: 230px" required class="layui-input" lay-verify="required|adminName" onblur="testAdminName(this.value)">
            </div>
            <label style="color: #e00f0fdb;margin-left: 111px;" id="duplicate"></label>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" id="adminPassword" placeholder="请输入密码" autocomplete="off"
                       name="adminPassword" value="" style="width: 230px" required class="layui-input" lay-verify="required|pass">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">头像</label>
            <div class="layui-input-block">
                <input type="text" id="adminPhoto" placeholder="请输入头像链接" autocomplete="off"
                       name="adminPhoto" value="" style="width: 230px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-block">
                <input type="text" id="adminPhone" placeholder="请输入联系方式(手机号)" autocomplete="off"
                       name="adminPhone" value="" style="width: 230px" required class="layui-input" lay-verify="required|phone">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit>立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

</body>
</html>
