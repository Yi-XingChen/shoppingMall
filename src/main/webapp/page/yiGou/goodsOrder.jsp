<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/17
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>确认订单</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>
<script>
    $(document).ready(function () {
        //加的效果
        $("[name=addNum]").click(function () {
            var n = $("#count").val();
            var num = parseInt(n) + 1;
            /*购买数量不能大于库存*/
            if (num > ${stock}) {
                alert("购买数量不能大于库存哦");
                return;
            }
            $("[name=count]").val(num);
            var orderCost = parseInt(${goodsPrice}) * num;
            $("[name=orderCost]").val(orderCost);
        });
        //减的效果
        $("[name=subNum]").click(function () {
            var n = $("#count").val();
            var num = parseInt(n) - 1;
            if (num === 0) {
                return;
            }
            $("[name=count]").val(num);
            var orderCost = parseInt(${goodsPrice}) * num;
            $("[name=orderCost]").val(orderCost);
        });

        /**
         * 获取当前时间
         */
        function getNow(s) {
            return s < 10 ? '0' + s : s;
        }
        var myDate = new Date();
        //获取当前年
        var year = myDate.getFullYear();
        //获取当前月
        var month = myDate.getMonth() + 1;
        //获取当前日
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        var s = myDate.getSeconds();    //获取当前秒
        var ms = myDate.getMilliseconds(); //获取当前毫秒

        var now = year + '-' + getNow(month) + "-" + getNow(date) + " " + getNow(h) + ':'
            + getNow(m) + ":" + getNow(s) + ":" + getNow(ms);
        $("[name=createTime]").val(now);
        /*合成订单号的格式*/
        var orderNoTime = year + getNow(month) + getNow(date) + getNow(h) + getNow(m) + getNow(s) + getNow(ms);
        var orderNo = orderNoTime+${user.userId}${orderCost}${id};
        $("[name=orderNo]").val(orderNo);
    });

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

    //校验最大购买数量
    function blurCount(count) {
        if (count>${stock}) {
            alert("购买数量最多${stock}件哦！");
            $("[name=count]").val(1);
            $("[name=orderCost]").val(${goodsPrice});
        } else {
            var orderCost = parseInt(${goodsPrice}) * count;
            $("[name=orderCost]").val(orderCost);
        }
    }
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

<%-- start 商品列表 --%>
<div class="danpin center">
    <div class="biaoti center">确认订单</div>
    <div class="imgbg">
        <div class="layui-col-md6 layui-col-md-offset3" style="position: relative;">
            <div class="from">
                <div class="order">
                    <div class="left ml40">订单详情</div>
                    <div class="clear"></div>
                    <div class="clear"></div>
                </div>
                <form class="layui-form" action="${pageContext.request.contextPath}/goodsOrder/addGoodsOrder.do"
                      method="post">
                    <div class="layui-form-item mt20">
                        <label class="layui-form-label">商品名：</label>
                        <div class="layui-input-block">
                            <input type="text" id="goodsName" placeholder="商品名" autocomplete="off" readonly
                                   name="goodsName" value="${goodsName}" style="width: 280px" required
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item mt20">
                        <label class="layui-form-label">购买数量：</label>
                        <div class="stock mt20 ml20 mb20">
                            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" name="subNum">
                                <i class="layui-icon">&#xe61a;1</i>
                            </button>
                            <%-- 购买数量 --%>
                            <input name="count" id="count" value="${num}" class="buyNum" autocomplete="off"
                                   lay-verify="required" required onblur="blurCount(this.value)"/>
                            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" name="addNum">
                                <i class="layui-icon">&#xe654;1</i>
                            </button>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">收货人：</label>
                        <div class="layui-input-block">
                            <input type="text" placeholder="收货人" autocomplete="off"
                                   name="" value="${user.userName}&nbsp;&nbsp;${user.phone}"
                                   style="width: 280px" required class="layui-input" lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">收货地址：</label>
                        <div class="layui-input-block">
                            <input type="text" id="" placeholder="收货地址" autocomplete="off"
                                   name="address" value="${user.address}" style="width: 280px" required
                                   class="layui-input" lay-verify="required" />
                        </div>
                    </div>
                    <%-- 显示在右侧的商品图片 --%>
                    <img src="${goodsImg}" class="orderImg"/>

                    <%-- 用户id --%>
                    <input type="hidden" name="userId" value="${user.userId}">
                    <%-- 商品id --%>
                    <input type="hidden" name="goodsId" value="${id}">
                    <%-- 订单创建时间 --%>
                    <input type="hidden" name="createTime" value="">
                    <%-- 订单号 --%>
                    <input type="hidden" name="orderNo" value="">
                    <div class="mt20 ft20 ml20">合计：￥
                        <input type="text" name="orderCost" value="${orderCost}" class="layui-input"
                               readonly style="width: 86px;display: inline-block;">元
                        <button class="layui-btn" lay-submit style="margin-left: 80px;">提交订单</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<hr/>

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
