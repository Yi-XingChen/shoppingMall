<%--  已经可以说是没用了
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/4/24
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <title>商品类列表</title>
    <meta charset="UTF-8">
</head>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });

    //点击添加按钮之后的事件
    function addClick() {
        var $ = layui.$;
        //新增商品类型弹出层
        layer.open({
            type: 1,
            title: "新增商品类信息",
            closeBtn: 2,
            area: ['400px', '350px'],
            offset: ['100px', '200px'],
            shadeClose: true,
            content: $("#addGoodsType"),
            //成功后的回调函数，参数为 当前层DOM，当前层索引
            success: function (layero, index) {
            },
            end: function () {
            }
        });
    }
</script>

<body style="overflow: hidden">
<button class="layui-btn layui-btn-radius layui-btn-warm"
        onclick="addClick()">添加商品类
</button>
<table id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <a class="layui-btn layui-btn-xs layui-btn-small" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-small" lay-event="del">删除</a>
</script>

<script>
    layui.use(['jquery', 'table'], function () {
        var table = layui.table, $ = layui.$;
        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , url: '${pageContext.request.contextPath}/goodsType/selectPageGoodsType.do' //后台SpringMVC接收路径
            , method: 'get'
            , page: true    //true表示分页
            , limit: 5                     //每页显示条数
            , limits: [3, 5, 10]        //下拉选择每页显示多少条数据
            , toolbar: '<title>商品类型列表</title>'    //工具栏
            , title: '商品类型列表'
            , cols: [[
                {field: 'goodsTypeId', title: '商品类型ID', width: 150, sort: true},
                {field: 'goodsTypeName', title: '商品类型名', width: 150, sort: true},
                {field: 'goodsTypeDesc', title: '商品类型图标', width: 150},
                {field: 'href', title: '商品类所属链接', width: 300},
                {title: '操作', toolbar: '#toolbarDemo', width: 150}
            ]]
        });
        //监听工具条
        table.on('tool(test)', function (obj) {
            var data = obj.data;    //获得当前行数据
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                    location.href = "${pageContext.request.contextPath}/goodsType/deleteGoodsType.do?goodsTypeId="
                        + data.goodsTypeId;
                });
            }
            //点击编辑事件
            else if (obj.event === 'edit') {
                $("#goodsTypeId").val(data.goodsTypeId);
                $("#goodsTypeName").val(data.goodsTypeName);
                $("#goodsTypeDesc").val(data.goodsTypeDesc);
                $("#href").val(data.href);
                //弹出编辑信息框
                layer.open({
                    type: 1,
                    title: "修改商品类信息",
                    closeBtn: 2,
                    area: ['400px', '300px'],
                    offset: ['100px', '200px'],
                    shadeClose: true,
                    content: $("#editGoodsType"),
                    //成功后的回调函数，参数为 当前层DOM，当前层索引
                    success: function (layero, index) {
                    },
                    end: function () {
                    }
                });
            }
        });
    });
</script>

<!-- 修改表单 -->
<div id="editGoodsType" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goodsType/editGoodsType.do" method="post">
        <input type="hidden" id="goodsTypeId" name="goodsTypeId" value=""/>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类型名</label>
            <div class="layui-input-block">
                <input type="text" id="goodsTypeName" placeholder="请输入商品类型名" autocomplete="off"
                       name="goodsTypeName" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类图标</label>
            <div class="layui-input-block">
                <input type="text" id="goodsTypeDesc" placeholder="请输入商品类型图标码" autocomplete="off"
                       name="goodsTypeDesc" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">链接</label>
            <div class="layui-input-block">
                <input type="text" id="href" placeholder="请输入商品类型所属链接" autocomplete="off"
                      name="href" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

<!-- 添加表单 -->
<div id="addGoodsType" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goodsType/addGoodsType.do" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">商品类父id</label>
            <div class="layui-input-block">
                <input type="text" id="pId" placeholder="请输入商品类型父id" autocomplete="off"
                       name="pId" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类型名</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsTypeName" placeholder="请输入商品类型名" autocomplete="off"
                       name="goodsTypeName" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类图标</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsTypeDesc" placeholder="请输入商品类型图标码" autocomplete="off"
                       name="goodsTypeDesc" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">链接</label>
            <div class="layui-input-block">
                <input type="text" id="addHref" placeholder="请输入商品类型所属链接" autocomplete="off"
                      name="href" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

</body>
</html>
