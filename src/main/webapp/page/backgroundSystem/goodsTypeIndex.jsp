<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/4
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品类型树</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/zTree/demo.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/zTree/zTreeStyle/zTreeStyle.css" type="text/css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/zTree/jquery.ztree.all.min.js"></script>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>

<script>
    $(function () {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/goodsType/goodsTypeTree.do", //查询的路径
            dataType: "json",
            success: function (result) {
                $.fn.zTree.init($("#tree"), setting, result);
            },
            error: function () {
                alert("错误");
            }
        });

        var setting = {
            data: {
                simpleData: {
                    enable: true, //true或false 分别表示 使用或不使用 简单数据模式
                    idKey: "goodsTypeId", //节点数据中保存唯一标识的属性名称
                    pIdKey: "pId", //节点数据中保存其父节点唯一标识的属性名称
                    rootPId: 0 //用于修正根节点父节点数据，即 pIdKey 指定的属性值
                },
                key: {
                    name: "goodsTypeName" //zTree节点数据保存节点名称的属性名称
                }
            },
            callback: {
                onClick: zTreeOnClick //用于捕获节点被点击的事件回调函数
            }
        };

        //event：标准的js event对象；treeId：对应zTree的treeId，便于用户操控；treeNode：被点击的节点JSON数据对象；
        function zTreeOnClick(event, treeId, treeNode) {
            if (treeNode.pId == null || treeNode.pId == 0) {
                var src = "${pageContext.request.contextPath}/goodsType/listGoodsTypeByPId.do?pId="
                    + treeNode.goodsTypeId;
                $("#goodsTypeList").attr("src", src);
            } else {
                src = "${pageContext.request.contextPath}/goodsType/listGoodsTypeByPId.do?pId=0";
                $("#goodsTypeList").attr("src", src);
            }
        }
    });
</script>

<body>
<div>
    <ul id="tree" class="ztree"></ul>
</div>

<div style="position: absolute; left: 250px; top: 30px; width: 950px;">
    <iframe id="goodsTypeList" name="goodsTypeList" frameborder="0" width=100% height=500px
            src="${pageContext.request.contextPath}/goodsType/listGoodsTypeByPId.do?pId=0"></iframe>
</div>
</body>
</html>
