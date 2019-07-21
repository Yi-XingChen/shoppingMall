<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/4/22
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <title>会员列表</title>
    <meta charset="UTF-8"/>
</head>
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
<script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });
</script>

<body style="overflow: hidden">
<table id="test" lay-filter="test"></table>

<script>
    layui.use(['jquery', 'table'], function () {
        var table = layui.table, $ = layui.$;
        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , url: '${pageContext.request.contextPath}/user/selectPageUser.do' //后台SpringMVC接收路径
            , method: 'get'
            , page: true    //true表示分页
            , limit: 5                  //每页显示条数
            , limits: [3, 5, 10]        //下拉选择每页显示多少条数据
            , toolbar: '<title>会员信息列表</title>'    //工具栏
            , title: '会员信息列表'
            , cols: [[
                {field: 'userId', title: '会员ID', hide: true},  //隐藏
                {type: 'numbers', title: '序号', width: 100},
                {field: 'userName', title: '用户名', width: 150, sort: true},
                {field: 'phone', title: '联系电话', width: 150},
                {
                    field: 'sex', title: '性别', width: 100,
                    templet: function (d) {
                        if (d.sex === '0') {
                            return '男'
                        } else {
                            return '女'
                        }
                    }
                },
                {field: 'age', title: '年龄', width: 100},
                {field: 'address', title: '收货地址', width: 200},
                {field: 'money', title: '剩余金额', width: 100}
            ]]
        });

    });
</script>

</body>
</html>
