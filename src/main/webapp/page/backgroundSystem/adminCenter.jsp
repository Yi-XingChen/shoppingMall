<%--
  Created by IntelliJ IDEA.
  User: 易星辰
  Date: 2019/5/8
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员个人信息维护</title>
</head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bgStyle.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.4.5/css/layui.css">
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

    //格式校验
    layui.use('form', function () {
        var form = layui.form;
        form.verify({
            adminName: function (value, item) { //value：表单的值、item：表单的DOM对象
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '管理员名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '管理员名首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '管理员名不能全为数字';
                }
                if (!(/^[\S]{3,18}$/).test(value)) {
                    return '管理员名必须3到18位，且不能出现空格';
                }
            }
            //Layui既支持上述函数式的方式，也支持下述数组的形式
            //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
            , pass: [
                /^[\S]{6,18}$/
                , '密码必须6到18位，且不能出现空格'
            ]
        });

    });

    //文件上传
    layui.use('upload', function () {
        var upload = layui.upload;

        //执行实例
        upload.render({
            elem: '#fileBtn' //绑定元素
            , url: '${pageContext.request.contextPath}/upload/fileUpload.do' //上传接口
            , accept: 'images' //允许上传的文件类型
            , size: 500 //最大允许上传的文件大小,单位kb
            , auto: false //不允许自动上传
            , bindAction: '#uploadBtn'
            , done: function (res) {
                //上传完毕回调
                // alert(res.src);
                $("[name=adminPhoto]").val(res.src);
            }
            , error: function () {
                //请求异常回调
                layer.msg('网络异常，请稍后重试！');
            }
        });
    });
</script>

<body>
<%-- 页面顶部 --%>
<header>
    <div>
        <div class="layui-col-md2 layui-col-md-offset2">
            <a href="${pageContext.request.contextPath}/goodsType/listAllGoodsType.do" target="_blank" class="w2h1">
                <img src="${pageContext.request.contextPath}/image/yigou_logo.png" alt="易购商城" class="w2h1">
            </a>
        </div>
    </div>
</header>

<div class="adminCenter">
    <div class="layui-col-md4 layui-col-lg-offset4">
        <div class="adminForm">
            <div class="login_top">
                <div class="left ml20">管理员个人信息维护</div>
                <div class="clear"></div>
                <div class="clear"></div>
            </div>
            <%-- 登录表单提交 --%>
            <form class="layui-form center" method="post"
                  action="${pageContext.request.contextPath}/admin/editAdmin.do">
                <input type="hidden" name="adminId" value="${admin.adminId}"/>
                <div class="layui-form-item">
                    <label class="layui-form-label">管理员名：</label>
                    <div class="layui-input-block">
                        <input type="text" name="adminName" required placeholder="请输入管理员名" autocomplete="off"
                               value="${admin.adminName}" style="width: 240px" class="layui-input"
                               lay-verify="required|adminName">
                        <span style="color: #e00f0fdb;">${duplicate}</span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码：</label>
                    <div class="layui-input-block">
                        <input type="password" name="adminPassword" required placeholder="请输入密码" autocomplete="off"
                               value="${admin.adminPassword}" style="width: 240px" class="layui-input"
                               lay-verify="required|pass">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">联系方式：</label>
                    <div class="layui-input-block">
                        <input type="text" name="adminPhone" required placeholder="请输入联系方式" autocomplete="off"
                               value="${admin.adminPhone}" style="width: 240px" class="layui-input" lay-verify="required|phone">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">当前头像：</label>
                    <img src="${admin.adminPhoto}" class="headPhoto"/>
                    <%-- 用于传到后台的数据 --%>
                    <input type="hidden" name="adminPhoto" value="${admin.adminPhoto}" required
                           lay-verify="required"/>
                    <button type="button" class="layui-btn layui-btn-primary" id="fileBtn">
                        <i class="layui-icon">&#xe67c;</i>选择头像
                    </button>
                    <button type="button" class="layui-btn layui-btn-warm" id="uploadBtn">上传</button>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <%-- lay-submit：绑定触发提交的元素 --%>
                        <button class="layui-btn login center" lay-submit>保存</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

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
