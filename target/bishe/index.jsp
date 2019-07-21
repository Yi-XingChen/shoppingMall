<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/6
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目首页</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="expires" content="0">
</head>
<script>
    /* 直接跳转到前台首页*/
    window.onload=function () {
        location.href="${pageContext.request.contextPath}/goodsType/listAllGoodsType.do";
    }
</script>
<body>
<%-- 前台首页 --%>
</body>
</html>