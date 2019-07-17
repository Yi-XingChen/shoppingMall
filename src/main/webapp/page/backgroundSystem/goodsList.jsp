<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/4/27
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商品列表</title>
</head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });

    //点击添加新商品按钮之后的响应
    function addClick() {
        var $ = layui.$;
        //新增商品弹出层
        layer.open({
            type: 1,
            title: "新增商品信息",
            closeBtn: 2,
            area: ['400px', '500px'],
            offset: ['100px', '200px'],
            shadeClose: true,
            content: $("#addGoods"),
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
            goodsName: function (value, item) { //value：表单的值、item：表单的DOM对象
                // if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                //     return '商品名不能有特殊字符';
                // }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '商品名首尾不能出现下划线\'_\'';
                }
            }
            //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
            , stock: [
                /^[1-9]\d*$/
                , '请输入正确的入库数量(正整数)'
            ]
        });
    });
</script>
<body style="overflow: hidden">
<button class="layui-btn layui-btn-radius layui-btn-warm"
        onclick="addClick()">添加新商品
</button>
<table id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <a class="layui-btn layui-btn-normal layui-btn-sm" lay-event="up">上架</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="down">下架</a>
    <a class="layui-btn layui-btn-warm layui-btn-sm" lay-event="add">加库存</a>
    <a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs layui-btn-radius" lay-event="recommend">推荐</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-radius" lay-event="off">取消推荐</a>
</script>

<script>
    layui.use(['table'], function () {
        var table = layui.table, $ = layui.$;
        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , url: '${pageContext.request.contextPath}/goods/selectPageGoods.do' //后台SpringMVC接收路径
            , method: 'get'
            , page: true    //true表示分页
            , limit: 5                     //每页显示条数
            , limits: [3, 5, 10]        //下拉选择每页显示多少条数据
            , toolbar: '<title>商品列表</title>'    //工具栏
            , title: '商品列表'
            , cols: [[
                {field: 'id', title: '商品ID', hide: true}, //隐藏id列
                {type: 'numbers', title: '序号', width: 65},
                {field: 'goodsName', title: '商品名', width: 120, sort: true},
                {field: 'goodsDesc', title: '商品描述', width: 130},
                {field: 'goodsPrice', title: '商品价格', width: 106, sort: true},
                {field: 'goodsImg', title: '图片链接', width: 100},
                {field: 'goodsTypeName', title: '商品类型名', width: 100},
                {field: 'stock', title: '商品库存', width: 86},
                {field: 'goodsHref', title: '商品链接', width: 100},
                {
                    field: 'flag', title: '状态', width: 75,
                    templet: function (d) {
                        if (d.flag === 0) {
                            return "上架中";
                        } else return "已下架";
                    }
                },
                {
                    field: 'recommend', title: '是否推荐', width: 88,
                    templet: function (d) {
                        if (d.recommend === 0) {
                            return "推荐";
                        } else return "一般";
                    }
                },
                {title: '操作', toolbar: '#toolbarDemo'}
            ]]
        });
        //监听工具条
        table.on('tool(test)', function (obj) {
            var data = obj.data;    //获得当前行数据
            //下架商品
            if (obj.event === 'down') {
                layer.confirm('真的下架该商品？', function (index) {
                    location.href = "${pageContext.request.contextPath}/goods/upDownGoods.do?flag=1&id=" + data.id;
                    layer.close(index);
                });
            }
            //上架商品
            else if (obj.event === 'up') {
                layer.confirm('是否上架该商品？', function (index) {
                    location.href = "${pageContext.request.contextPath}/goods/upDownGoods.do?flag=0&id=" + data.id;
                    layer.close(index);
                });
            }
            //加库存
            else if (obj.event === "add") {
                $("#stockId").val(data.id);
                //弹出信息框
                layer.open({
                    type: 1,
                    title: "添加商品库存信息",
                    closeBtn: 2,
                    area: ['400px', '200px'],
                    offset: ['100px', '200px'],
                    shadeClose: true,
                    content: $("#addStockNum"),
                    //成功后的回调函数，参数为 当前层DOM，当前层索引
                    success: function (layero, index) {
                    },
                    end: function () {
                    }
                });
            }
            //推荐商品
            else if (obj.event === 'recommend') {
                layer.confirm('真的推荐该商品？', function (index) {
                    //如果该商品已经下架，则不能推荐
                    if (data.flag !== 1) {
                        location.href = "${pageContext.request.contextPath}/goods/recommendGoods.do?recommend=0&id=" + data.id;
                    } else {
                        alert("该商品已经下架");
                    }
                    layer.close(index);
                });
            }
            //取消推荐商品
            else if (obj.event === 'off') {
                layer.confirm('真的取消推荐该商品？', function (index) {
                    location.href = "${pageContext.request.contextPath}/goods/recommendGoods.do?recommend=1&id=" + data.id;
                    layer.close(index);
                });
            }
            //点击编辑事件
            else if (obj.event === 'edit') {
                $("#id").val(data.id);
                $("#goodsName").val(data.goodsName);
                $("#goodsDesc").val(data.goodsDesc);
                $("#goodsPrice").val(data.goodsPrice);
                $("#goodsImg").val(data.goodsImg);
                $("#stock").val(data.stock);
                $("#goodsHref").val(data.goodsHref);
                //弹出编辑信息框
                layer.open({
                    type: 1,
                    title: "修改商品信息",
                    closeBtn: 2,
                    area: ['400px', '455px'],
                    offset: ['100px', '200px'],
                    shadeClose: true,
                    content: $("#editGoods"),
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
<%-- 加库存 --%>
<div id="addStockNum" style="display:none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goods/addStock.do" method="post">
        <input type="hidden" id="stockId" name="stockId" value=""/>
        <div class="layui-form-item">
            <label class="layui-form-label">新入库数量</label>
            <div class="layui-input-block">
                <input type="text" id="num" name="num" placeholder="请输入新入库的数量" autocomplete="off"
                       value="" style="width: 230px" required class="layui-input" lay-verify="required|number|stock">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button lay-submit class="layui-btn" style="position: relative; left: 50px;">立即提交</button>
            </div>
        </div>
    </form>
</div>

<!-- 修改表单 -->
<div id="editGoods" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goods/editGoods.do" method="post">
        <input type="hidden" id="id" name="id" value=""/>
        <div class="layui-form-item">
            <label class="layui-form-label">商品名</label>
            <div class="layui-input-block">
                <input type="text" id="goodsName" placeholder="请输入商品名" autocomplete="off"
                       name="goodsName" value="" style="width: 240px" required class="layui-input" lay-verify="required|goodsName">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品描述</label>
            <div class="layui-input-block">
                <input type="text" id="goodsDesc" placeholder="请输入商品描述" autocomplete="off"
                       name="goodsDesc" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品价格</label>
            <div class="layui-input-block">
                <input type="text" id="goodsPrice" placeholder="请输入商品价格" autocomplete="off"
                       name="goodsPrice" value="" style="width: 240px" required class="layui-input" lay-verify="required|number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品图片链接</label>
            <div class="layui-input-block">
                <input type="text" id="goodsImg" placeholder="请输入商品图片链接" autocomplete="off"
                       name="goodsImg" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品库存</label>
            <div class="layui-input-block">
                <input type="text" id="stock" placeholder="请输入商品库存" autocomplete="off"
                       name="stock" value="" style="width: 240px" required class="layui-input" lay-verify="required|number|stock">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品链接</label>
            <div class="layui-input-block">
                <input type="text" id="goodsHref" placeholder="请输入商品链接" autocomplete="off"
                       name="goodsHref" value="" style="width: 240px" required class="layui-input">
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

<%-- 添加新商品表单 --%>
<div id="addGoods" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goods/addGoods.do" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">商品名</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsName" placeholder="请输入商品名" autocomplete="off"
                       name="addGoodsName" value="" style="width: 240px" required class="layui-input" lay-verify="required|goodsName">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品描述</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsDesc" placeholder="请输入商品描述" autocomplete="off"
                       name="addGoodsDesc" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品价格</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsPrice" placeholder="请输入商品价格" autocomplete="off"
                       name="addGoodsPrice" value="" style="width: 240px" required class="layui-input" lay-verify="required|number">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图片链接</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsImg" placeholder="请输入商品图片链接" autocomplete="off"
                       name="addGoodsImg" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类型</label>
            <div class="layui-input-block" style="width: 240px">
                <select id="addGoodsType" name="addGoodsType" lay-verify="required|required">
                    <c:forEach var="item" items="${selectGoodsType}">
                        <c:if test="${item.pId!=0}">
                            <option value="${item.goodsTypeId}">${item.goodsTypeName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品库存</label>
            <div class="layui-input-block">
                <input type="text" id="addStock" placeholder="请输入商品库存" autocomplete="off"
                       name="addStock" value="" style="width: 240px" required class="layui-input" lay-verify="required|number|stock">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品链接</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsHref" placeholder="请输入商品链接" autocomplete="off"
                       name="addGoodsHref" value="" style="width: 240px" required class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button lay-submit class="layui-btn">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

</body>
</html>
