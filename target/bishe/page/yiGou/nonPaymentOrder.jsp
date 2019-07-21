<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/22
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>未付款</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>
</head>
<body>
<div class="ddzxbt">未付款订单</div>
<table id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <a class="layui-btn layui-btn-xs layui-btn-small" lay-event="pay">付款</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-small" lay-event="off">取消订单</a>
</script>

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

    layui.use(['jquery', 'table'], function () {
        var table = layui.table, $ = layui.$;
        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , url: '${pageContext.request.contextPath}/goodsOrder/selectPageOrdersByStatusAndUserId.do?status=1' //后台SpringMVC接收路径
            , method: 'get'
            , page: true    //true表示分页
            , limit: 7                     //每页显示条数
            , limits: [3, 7]        //下拉选择每页显示多少条数据
            , toolbar: '<title>未付款订单列表</title>'    //工具栏
            , title: '未付款订单列表'
            , cols: [[
                {type: 'numbers', title: '序号', width: 65},
                {field: 'orderId', title: '订单id', hide:true},
                {field: 'goodsId', title: '商品id', hide:true},
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
                {field: 'goodsName', title: '商品名', width: 160},
                {field: 'count', title: '购买数量', width: 100},
                {field: 'createTime', title: '创建时间', width: 120,
                    templet: function (row) {
                        return createTime(row.createTime);
                    }
                },
                {title: '操作', toolbar: '#toolbarDemo', width: 150}
            ]]
        });
        //监听工具条
        table.on('tool(test)', function (obj) {
            var data = obj.data;    //获得当前行数据
            var money =${user.money}; //获得当前会员的余额
            //付款
            if (obj.event === 'pay') {
                layer.confirm('是否付款？', function (index) {
                    //余额大于订单总价
                    if (money > data.orderCost) {
                        //获取该商品的库存
                        $.ajax({
                            type: "GET",
                            url: "${pageContext.request.contextPath}/goodsOrder/getStock.do",
                            data: "goodsId="+data.goodsId+"&count="+data.count,
                            dataType: "json",
                            success: function(stock){
                                //根据返回的值，对应不同的结果
                                if (stock==1) {
                                    location.href = "${pageContext.request.contextPath}/goodsOrder/stockGreaterCount.do?goodsId="
                                        +data.goodsId+"&count="+data.count+"&orderCost="+data.orderCost+"&orderId="+data.orderId;
                                } else {
                                    alert("该商品库存不足！！");
                                }
                            },
                            error: function () {
                                alert("错误");
                            }
                        });
                    } else {
                        alert("余额不足！请充值！");
                    }
                    layer.close(index);
                });
            } else if (obj.event === 'off') {
                layer.confirm('确认取消订单？', function (index) {
                    location.href = "${pageContext.request.contextPath}/goodsOrder/editOrderStatus.do?status=5&orderId=" + data.orderId;
                });
            }
        });
    });
</script>
</body>
</html>
