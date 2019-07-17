<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/4
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商品类型列表</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>
</head>


<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });

    //格式校验
    layui.use('form', function () {
        var form = layui.form;
        form.verify({
            goodsTypeName: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '商品类型名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '商品类型名首尾不能出现下划线\'_\'';
                }
                if (!(/^[\u4e00-\u9fa5]{0,}$/).test(value)) {
                    return '商品类型名不能有数字';
                }
                if (!(/^[\S]{3,18}$/).test(value)) {
                    return '商品类型名必须3到18位，且不能出现空格';
                }
            }
        });
    });

    //点击添加按钮之后的事件
    function addClick() {
        var $ = layui.$;
        //新增商品类型弹出层
        layer.open({
            type: 1,
            title: "新增商品类信息",
            closeBtn: 2,
            area: ['400px', '300px'],
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

    //点击编辑事件
    function updateClick(goodsTypeId,goodsTypeName,goodsTypeDesc,href,pIdEdit) {
        $("#goodsTypeId").val(goodsTypeId);
        $("#goodsTypeName").val(goodsTypeName);
        $("#goodsTypeDesc").val(goodsTypeDesc);
        $("#href").val(href);
        $("#pIdEdit").val(pIdEdit); //用于刷新页面的pId
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

</script>

<body>
<button class="layui-btn layui-btn-radius layui-btn-warm"
        onclick="addClick()">添加商品类
</button>
<%-- 数据表格--%>
<div>
    <table class="layui-table">
        <colgroup>
            <col width="120">
            <col width="150">
            <col width="200">
            <col width="230">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>商品类型名</th>
            <th>商品类型图标</th>
            <th>商品类所属链接</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${goodsTypesBypId}">
            <tr>
                <td>${item.goodsTypeName}</td>
                <td>${item.goodsTypeDesc}</td>
                <td>${item.href}</td>
                <td>
                    <button class="layui-btn" onclick="updateClick('${item.goodsTypeId}','${item.goodsTypeName}',
                            '${item.goodsTypeDesc}','${item.href}','${pId}')">修改
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%-- 修改表单 --%>
<div id="editGoodsType" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goodsType/editGoodsType.do" method="post">
        <%-- value这个属性不能删，后台需要通过这个属性来获取值 --%>
        <input type="hidden" id="goodsTypeId" name="goodsTypeId" value=""/>
        <input type="hidden" id="pIdEdit" name="pIdEdit" value=""/>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类型名</label>
            <div class="layui-input-block">
                <input type="text" id="goodsTypeName" placeholder="请输入商品类型名" autocomplete="off"
                       name="goodsTypeName" value="" style="width: 240px" required class="layui-input" lay-verify="required|goodsTypeName">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类图标</label>
            <div class="layui-input-block">
                <input type="text" id="goodsTypeDesc" placeholder="请输入商品类型图标码" autocomplete="off"
                       name="goodsTypeDesc" value="" style="width: 240px" required class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">链接</label>
            <div class="layui-input-block">
                <input type="text" id="href" placeholder="请输入商品类型所属链接" autocomplete="off"
                       name="href" value="" style="width: 240px" required class="layui-input" lay-verify="required">
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

<%-- 添加表单 --%>
<div id="addGoodsType" style="display: none;">
    <br/>
    <form class="layui-form" action="${pageContext.request.contextPath}/goodsType/addGoodsType.do" method="post">
        <input type="hidden" id="pIdAdd" name="pIdAdd" value="${pId}">
        <div class="layui-form-item">
            <label class="layui-form-label">商品类型名</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsTypeName" placeholder="请输入商品类型名" autocomplete="off"
                       name="goodsTypeName" value="" style="width: 240px" required class="layui-input" lay-verify="required|goodsTypeName">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类图标</label>
            <div class="layui-input-block">
                <input type="text" id="addGoodsTypeDesc" placeholder="请输入商品类型图标码" autocomplete="off"
                       name="goodsTypeDesc" value="" style="width: 240px" required class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">链接</label>
            <div class="layui-input-block">
                <input type="text" id="addHref" placeholder="请输入商品类型所属链接" autocomplete="off"
                       name="href" value="" style="width: 240px" required class="layui-input" lay-verify="required">
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
