<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/4/24
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>易购后台管理系统</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/adminlte.js"></script>

</head>

<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <!-- 导航栏 -->
    <nav class="main-header navbar navbar-expand bg-white navbar-light border-bottom">
        <!-- 左导航栏链接 -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#"><i class="fa fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="${pageContext.request.contextPath}/page/yiGou/login.jsp"
                   target="_blank" class="nav-link">前台登录页</a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="${pageContext.request.contextPath}/goodsType/listAllGoodsType.do"
                   target="_blank" class="nav-link">易购商城首页</a>
            </li>
        </ul>
    </nav>
    <!-- /.导航栏结束 -->

    <!-- 主导航栏 -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Logo -->
        <a href="" class="brand-link">
            <img src="${pageContext.request.contextPath}/image/yi_logo.png" alt="易购"
                 class="brand-image img-circle elevation-3" style="opacity: .8">
            <span class="brand-text font-weight-light">易购后台管理系统</span>
        </a>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar user panel -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <a href="${pageContext.request.contextPath}/page/backgroundSystem/adminCenter.jsp"
                   class="d-block" style="width: 100%;" target="_blank">
                    <div class="image">
                        <img src="${sessionScope.admin.adminPhoto}"
                             class="img-circle elevation-2" alt="头像">
                    </div>
                    <span style="font-size: 20px;margin-left: 16px;">${sessionScope.admin.adminName}</span>
                </a>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                    data-accordion="false">

                    <li class="nav-item has-treeview">
                        <a href="" class="nav-link">
                            <i class="nav-icon fa fa-address-card text-primary"></i>
                            <p>
                                管理员管理
                                <i class="right fa fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/listAllAdmin.do"
                                   target="this_iframe" class="nav-link ">
                                    <i class="fa fa-user nav-icon"></i>
                                    <p>管理员列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="nav-item has-treeview">
                        <a href="" class="nav-link">
                            <i class="nav-icon fa fa-address-book text-success"></i>
                            <p>
                                会员管理
                                <i class="right fa fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/page/backgroundSystem/userList.jsp"
                                   target="this_iframe" class="nav-link ">
                                    <i class="fa fa-users nav-icon"></i>
                                    <p>会员列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="nav-item has-treeview">
                        <a href="" target="this_iframe" class="nav-link">
                            <i class="nav-icon fa fa-pie-chart text-info"></i>
                            <p>
                                商品类型
                                <i class="right fa fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/page/backgroundSystem/goodsTypeIndex.jsp"
                                   target="this_iframe" class="nav-link">
                                    <i class="fa fa-list nav-icon"></i>
                                    <p>商品类型列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="nav-item has-treeview">
                        <a href="" class="nav-link">
                            <i class="nav-icon fa fa-sitemap text-danger"></i>
                            <p>
                                商品
                                <i class="fa fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/goodsType/selectGoodsType.do"
                                   target="this_iframe" class="nav-link">
                                    <i class="fa fa-list nav-icon"></i>
                                    <p>商品列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <%-- menu-open:展开 --%>
                    <li class="nav-item has-treeview menu-open">
                        <%-- active：访问，可以调颜色,bootstrap中的 --%>
                        <a href="" class="nav-link active">
                            <i class="nav-icon fa fa-dashboard"></i>
                            <p>
                                订单管理
                                <i class="fa fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/page/backgroundSystem/goodsOrder.jsp" target="this_iframe" class="nav-link">
                                    <i class="fa fa-list nav-icon"></i>
                                    <p>所有订单列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/page/backgroundSystem/nonShippedOrder.jsp" target="this_iframe" class="nav-link">
                                    <i class="fa fa-list nav-icon text-warning"></i>
                                    <p>待处理订单列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>

                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>

    <%-- body --%>
    <div class="content-wrapper">
        <iframe id="iframe" name="this_iframe"
                style="width: 100%;height: 100%;outline: none;padding: 20px 0 0 20px;"
                src="${pageContext.request.contextPath}/page/backgroundSystem/nonShippedOrder.jsp" frameborder="0">
        </iframe>
    </div>

    <!-- /.content-wrapper -->
    <footer class="main-footer">
        <strong>Copyright &copy; 2015-2019 <a href="#">YiXingChen.io</a>.</strong>
        All rights reserved.
        <div class="float-right d-none d-sm-inline-block">
            <b>Version</b> 1.0.0-YiXingChen
        </div>
    </footer>

</div>

</body>
</html>