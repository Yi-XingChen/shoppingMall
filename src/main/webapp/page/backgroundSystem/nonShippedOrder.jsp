<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/30
  Time: 8:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>未发货待处理订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>
</head>
<body>
<table id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <a class="layui-btn layui-btn-xs layui-btn-small" lay-event="ship">发货</a>
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
            , url: '${pageContext.request.contextPath}/goodsOrder/selectPageOrderByStatus.do?status=2' //后台SpringMVC接收路径
            , method: 'get'
            , page: true    //true表示分页
            , limit: 5                     //每页显示条数
            , limits: [3, 5, 10]        //下拉选择每页显示多少条数据
            , toolbar: '<title>未发货订单列表</title>'    //工具栏
            , title: '未发货订单列表'
            , cols: [[
                {type: 'numbers', title: '序号', width: 65},
                {field: 'orderId', title: '订单id', hide: true},
                {field: 'goodsId', title: '商品id', hide: true},
                {field: 'orderNo', title: '订单号', width: 230},
                {field: 'orderCost', title: '订单总价', width: 120, sort: true},
                {
                    field: 'status', title: '订单状态', width: 100,
                    templet: function (d) {
                        if (d.status === 2) {
                            return "未发货";
                        } else {
                            return "已取消";
                        }
                    }
                },
                {field: 'goodsName', title: '商品名', width: 160},
                {field: 'count', title: '购买数量', width: 100},
                {
                    field: 'createTime', title: '创建时间', width: 120,
                    templet: function (row) {
                        return createTime(row.createTime);
                    }
                },
                {
                    field: 'paymentTime', title: '付款时间', width: 120,
                    templet: function (row) {
                        return createTime(row.paymentTime);
                    }
                },
                {title: '操作', toolbar: '#toolbarDemo', width: 100}
            ]]
        });
        //监听工具条
        table.on('tool(test)', function (obj) {
            var data = obj.data;    //获得当前行数据
            //发货,减库存，改状态
            if (obj.event === 'ship') {
                layer.confirm('确认发货？', function (index) {
                    location.href = "${pageContext.request.contextPath}/goodsOrder/shipment.do?status=3&orderId="
                        + data.orderId + "&stockId=" + data.goodsId + "&num=" + data.count;
                    layer.close(index);
                });
            }
        });
    });
</script>
</body>
</html>
