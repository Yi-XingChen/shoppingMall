<%@ page import="com.yxc.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/17
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商品详情</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>
<script>
    //格式校验
    layui.use('form', function () {
        var form = layui.form;
        form.verify({
            keyword: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '搜索内容不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '搜索内容首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '搜索内容不能全为数字';
                }
            }
        });
    });

    $(document).ready(function () {
        //加的效果
        $("[name=addNum]").click(function () {
            var n = $("#num").val();
            var num = parseInt(n) + 1;
            /*购买数量不能大于库存*/
            if (num > ${goodsById.stock}) {
                alert("购买数量不能大于库存哦");
                return;
            }
            $("[name=num]").val(num);
        });
        //减的效果
        $("[name=subNum]").click(function () {
            var n = $("#num").val();
            var num = parseInt(n) - 1;
            if (num === 0) {
                return;
            }
            $("[name=num]").val(num);
        });

        //点击购买按钮 响应
        $("[name=buy]").click(function () {
            var num = $("#num").val();
            /*判断是否登录*/
            <%
                User user = (User)session.getAttribute("user");
                if (null == user) {
            %>
            alert("您还未登录！请登录！");
            <%
                } else {
             %>
            if (num==""||num==0) {
                alert("请输入正确的购买数量！");
            } else if (num> ${goodsById.stock}) {
                alert("购买数量不能超过${goodsById.stock}件哦！");
            } else {
                location.href = "${pageContext.request.contextPath}/goods/buyGoods.do?id=" + ${goodsById.id}
                    +"&num=" + num + "&goodsPrice=" + ${goodsById.goodsPrice}+"&stock="+${goodsById.stock}
                    +"&goodsName=" + "${goodsById.goodsName}" + "&goodsImg=" + "${goodsById.goodsImg}";
            }
            <%  }
            %>
        });
    });
</script>
<body>
<!-- start header -->
<header>
    <div class="top center">
        <div class="left fl">
            <ul>
                <li><a href="${pageContext.request.contextPath}/goodsType/listAllGoodsType.do"
                       target="_blank">易购商城</a>
                </li>
                <li>|</li>
                <li><a href="javascript:;">问题反馈</a></li>
                <li>|</li>
                <li><a href="javascript:;">Select Region</a></li>
                <li>
                    <div class="clear"></div>
                </li>
            </ul>
        </div>
        <div class="right fr">
            <div class="fr">
                <ul>
                    <c:choose>
                        <c:when test="${sessionScope.user!=null}">
                            <li class="gouwuche fr">
                                <a href="${pageContext.request.contextPath}/page/yiGou/userCenter.jsp"
                                   target="_blank">${sessionScope.user.userName}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="${pageContext.request.contextPath}/page/yiGou/register.jsp">注册</a>
                            </li>
                            <li class="gouwuche fr">
                                <a href="${pageContext.request.contextPath}/page/yiGou/login.jsp" target="_blank">登录</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</header>
<!-- end header -->

<!-- start 顶部导航栏-->
<div class="banner_x center">
    <a href="${pageContext.request.contextPath}" target="_blank">
        <div class="logo fl"></div>
    </a>
    <a href="">
        <div class="ad_top fl"></div>
    </a>
    <div class="nav fl">
        <ul>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=5"
                   target="_blank">手机/穿戴</a></li>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=8"
                   target="_blank">笔记本</a></li>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=7"
                   target="_blank">单反</a></li>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=9"
                   target="_blank">男装</a></li>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=13"
                   target="_blank">家电</a></li>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=18"
                   target="_blank">休闲食品</a></li>
            <li><a href="${pageContext.request.contextPath}/goods/listAllGoodsByGoodsTypeId.do?goodsTypeId=16"
                   target="_blank">生鲜</a></li>
        </ul>
    </div>
    <div class="search fr">
        <form class="layui-form" action="${pageContext.request.contextPath}/goods/listGoodsByKeyword.do" method="post">
            <div class="text fl">
                <input type="text" class="shuru" name="keyword" value="" autocomplete="off"
                       style="padding: 10px;" placeholder="ThinkPad X1&nbsp;&nbsp;&nbsp;华为MATA20" lay-verify="required|keyword" />
            </div>
            <div class="submit fl">
                <button class="sousuo" lay-submit>搜索</button>
            </div>
            <div class="clear"></div>
        </form>
        <div class="clear"></div>
    </div>
</div>
<!-- end 顶部导航栏 -->

<%-- start 商品详情 --%>
<div style="background-color:#f6f6f6;width: 100%;">
    <div class="biaoti center">${goodsById.goodsName}</div>
</div>

<div class="jieshao mt20 w">
    <div class="left fl ml40">
        <img src="${goodsById.goodsImg}">
    </div>
    <div class="right fr">
        <div class="h3 ml20 mt20">${goodsById.goodsName}</div>
        <div class="jianjie mr40 ml20 mt20">${goodsById.goodsDesc}</div>
        <div class="jiage ml20 mt20">${goodsById.goodsPrice}元</div>

        <div class="stock mt20 ml20">
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" name="subNum">
                <i class="layui-icon">&#xe61a;1</i>
            </button>
            <%-- 购买件数 --%>
            <input name="num" id="num" value="1" class="buyNum" autocomplete="off"/>
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" name="addNum">
                <i class="layui-icon">&#xe654;1</i>
            </button>
            <span class="ml20">库存：还有${goodsById.stock}件</span>
        </div>

        <div class="xiadan ml20 mt20">
            <button type="button" class="jrgwc" name="buy">立即购买</button>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%-- end 商品详情 --%>

<%-- start footer --%>
<footer class="center">
    <div class="mt20">易购商城&nbsp;|&nbsp;诚信合规&nbsp;|&nbsp;政企服务&nbsp;|&nbsp;网盟&nbsp;|&nbsp;
        协议&nbsp;|&nbsp;隐私政策&nbsp;|&nbsp;Select Region
    </div>
    <div>©yi.com <img src="${pageContext.request.contextPath}/image/ghs.png">
        京ICP证152003号 京ICP备10036666号 京公网安备201520010301号 京网文[2019]0059-0009号
    </div>
    <div>违法和不良信息举报电话：150-3510-2867，本网站所列数据，除特殊说明，所有数据均出自本人测试</div>
</footer>
<%-- end footer --%>
</body>
</html>
