<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>易购商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/layui.js"></script>
    <script src="${pageContext.request.contextPath}/layui-v2.4.5/css/modules/layui-icon-extend/iconfont.js"></script>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>
<style type="text/css">
    .alSvgIcon {
        width: 2em;
        height: 2em;
        fill: currentColor; /*填充颜色*/
        overflow: hidden;
        vertical-align: middle;
    }
</style>
<script>
/*    layui.use('layer', function () {
        var layer = layui.layer;
        var $ = layer.jquery;
    });*/

    layui.use('element', function () {
        var element = layui.element;
        //更新渲染
        element.render('nav', 'side-main');
    });
    //轮播
    layui.use('carousel', function () {
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#carousel'
            , width: '1026px' //设置容器宽度
            , height: '460px' //设置容器的高度
            , arrow: 'always' //始终显示箭头
            , anim: 'fade' //切换动画方式
            , interval: '5000' //切换的时间间隔
        });
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

<!-- start banner_y -->
<%-- 左侧商品类型导航栏 --%>
<div class="banner_y center">
    <div class="y_left">
        <ul class="layui-nav layui-nav-tree layui-nav-side" style="position: absolute;" lay-filter="side-main">
            <c:forEach var="item1" items="${goodsTypeList}">
                <c:if test="${item1.pId==0}">
                    <li class="layui-nav-item">
                        <a href="javascript:;" style="color: #fff;">
                                <%-- 商品类型图标 --%>
                            <svg class="alSvgIcon" aria-hidden="true">
                                <use xlink:href="${item1.goodsTypeDesc}"></use>
                            </svg>&nbsp;-- ${item1.goodsTypeName}
                        </a>
                        <c:forEach var="item2" items="${goodsTypeList}">
                            <c:if test="${item2.pId==item1.goodsTypeId}">
                                <dl class="layui-nav-child">
                                    <dd>
                                        <a href="${item2.href}" target="_blank" style="color: #fff;">
                                            <svg class="alSvgIcon" aria-hidden="true">
                                                <use xlink:href="${item2.goodsTypeDesc}"></use>
                                            </svg>&nbsp;-- ${item2.goodsTypeName}
                                        </a>
                                    </dd>
                                </dl>
                            </c:if>
                        </c:forEach>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>

    <%-- 轮播 --%>
    <div class="y_right">
        <div class="layui-carousel" id="carousel">
            <div carousel-item>
                <div>
                    <a href="${pageContext.request.contextPath}/goods/goodsById.do?id=1">
                        <img src="${pageContext.request.contextPath}/image/banner3.jpg">
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/goods/goodsById.do?id=25">
                        <img src="${pageContext.request.contextPath}/image/banner2.jpg">
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/goods/goodsById.do?id=11">
                        <img src="${pageContext.request.contextPath}/image/banner1.jpg">
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/goods/goodsById.do?id=26">
                        <img src="${pageContext.request.contextPath}/image/banner4.jpg">
                    </a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/goods/goodsById.do?id=18">
                        <img src="${pageContext.request.contextPath}/image/banner5.jpg">
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end banner_y -->

<%-- start advertising 隔开轮播与推荐商品列表的广告--%>
<div class="center adver1">
    <img src="${pageContext.request.contextPath}/image/ad1.jpg">
</div>
<%-- end advertising--%>

<%-- start goods list --%>
<div class="layui-fluid" style="background-color: #eeeeee;">
    <div class="layui-row">
        <div class="biaoti center">推荐商品</div>
        <c:forEach var="item" items="${goodsRecommend}" varStatus="vs">
            <%-- 给每行开头(对5求模等于1)添加偏移，使这一行相对居中 --%>
            <c:choose>
                <c:when test="${vs.count%5==1}">
                    <div class="layui-col-md2 layui-col-md-offset1">
                        <div class="remen fl">
                            <div class="xinpin"><span style="background:#fff"></span></div>
                            <div class="tu">
                                <a href="${item.goodsHref}">
                                    <img style="width: 150px;height: 150px;"
                                         src="${item.goodsImg}">
                                </a>
                            </div>
                            <div class="miaoshu"><a href="${item.goodsHref}">${item.goodsName}</a></div>
                            <div class="jiage">${item.goodsPrice}元</div>
                            <div class="pingjia">还有${item.stock}件</div>
                        </div>
                    </div>
                </c:when>
                <%-- 如果不是该行的首个，则没有偏移 --%>
                <c:otherwise>
                    <div class="layui-col-md2">
                        <div class="remen fl">
                            <div class="xinpin"><span style="background:#fff"></span></div>
                            <div class="tu">
                                <a href="${item.goodsHref}">
                                    <img style="width: 150px;height: 150px;"
                                         src="${item.goodsImg}">
                                </a>
                            </div>
                            <div class="miaoshu"><a href="${item.goodsHref}">${item.goodsName}</a></div>
                            <div class="jiage">${item.goodsPrice}元</div>
                            <div class="pingjia">还有${item.stock}件</div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
            <%-- 让每行只显示5个 --%>
            <c:if test="${vs.count%5==0}">
                <hr/>
            </c:if>
            <%-- 为了与footer分隔开 --%>
            <c:if test="${vs.last}">
                <hr/>
                <hr/>
            </c:if>
        </c:forEach>

    </div>
</div>
<%-- end goods list --%>

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
