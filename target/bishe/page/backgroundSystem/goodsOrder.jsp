<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/4/27
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有商品订单</title>
</head>
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
<script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });

    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var h = date.getHours();
        h = h<10?("0"+h):h;
        var M = date.getMinutes();
        M = M<10?("0"+M):M;
        var str = y+"-"+m+"-"+d+" "+h+":"+M;
        return str;
    }

</script>

<body style="overflow: hidden">
<table id="test" lay-filter="test"></table>
<%--<script type="text/html" id="toolbarDemo">
    <a class="layui-btn layui-btn-xs layui-btn-small" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-small" lay-event="del">删除</a>
</script>--%>

<script>
    layui.use(['jquery', 'table'], function () {
        var table = layui.table, $ = layui.$;
        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , url: '${pageContext.request.contextPath}/goodsOrder/listPageGoodsOrder.do' //后台SpringMVC接收路径
            , method: 'get'
            , page: true    //true表示分页
            , limit: 5                  //每页显示条数
            , limits: [3, 5, 10]        //下拉选择每页显示多少条数据
            , toolbar: '<title>所有订单列表</title>'    //工具栏
            , title: '所有订单列表'
            , cols: [[
                {type: 'numbers', title: '序号', width: 65},
                {field: 'orderNo', title: '订单号', width: 230},
                {field: 'orderCost', title: '订单总价', width: 120, sort: true},
                {
                    field: 'status', title: '订单状态', width: 100,
                    templet: function (d) {
                        if (d.status === 1) {
                            return "未付款";
                        } else if (d.status === 2) {
                            return "未发货";
                        } else if (d.status === 3) {
                            return "未收货";
                        } else if (d.status === 4) {
                            return "已完成";
                        } else {
                            return "已取消";
                        }
                    }
                },
                {field: 'count', title: '购买数量', width: 100},
                {field: 'userId', title: '会员Id', width: 100, sort: true},
                {field: 'goodsName', title: '商品名', width: 160},
                {field: 'createTime', title: '创建时间', width: 120,
                    templet: function (row) {
                        return createTime(row.createTime);
                    }
                },
                {field: 'paymentTime', title: '付款时间', width: 120,
                    templet: function (row) {
                        console.log(row);
                        if (row.paymentTime == null) {
                            return "";
                        } else {
                            return createTime(row.paymentTime);
                        }
                    }
                },
                {field: 'deliveryTime', title: '发货时间', width: 120,
                    templet: function (row) {
                        if (row.paymentTime == null) {
                            return "";
                        } else {
                            return createTime(row.deliveryTime);
                        }
                    }
                }
                // {title: '操作', toolbar: '#toolbarDemo', width: 150}
            ]]
        });

    });
</script>

</body>
</html>
