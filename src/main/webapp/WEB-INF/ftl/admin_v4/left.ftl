<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<link rel="stylesheet" href="${contextPath}/admin4/stylesheets/common.css?v=${sversion}" />
	<link rel="stylesheet" href="${contextPath}/admin4/stylesheets/index.css?v=${sversion}" />
</head>
<body>
    <div class="left-menu">
        <div class="left-menu-title">后台管理系统示例</div>
        <div class="left-menu-list">
            <div class="left-menu-first-node">
                <div class="first-title">
                    <div class="text">一级菜单</div>
                </div>
                <div class="first-children" style="display: block;">
                    <div class="left-menu-second-node">
                        <div class="second-title active">
                            <i class="icon"></i>
                            <a href="javascript:void(0);" class="text navigation" target="rightFrame">二级菜单</a>
                        </div>
                        <ul class="menu-son" style="display: block;">
                            <li class="">
                                <i class="li-icon"></i>
                                <a href="#" class="navigation" target="rightFrame">三级菜单</a>
                            </li>
                            <li>
                                <i class="li-icon"></i>
                                <a href="#" class="navigation" target="rightFrame">三级菜单</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/ext/jquery/jquery.nicescroll.min.js"></script>
    <!--[if lt IE 8]>
    <script type="text/javascript" src="${contextPath}/ext/DD_belatedPNG/DD_belatedPNG.js"></script>
    <script>
        DD_belatedPNG.fix('.first-icon, .right-arrow, background, background');
    </script>
    <![endif]-->
    <script type="text/javascript" src="${contextPath}/admin4/javascripts/jquery-zwbam.js"></script>
    <script>
        $(function(){
            //滚动条初始化
            $('.left-menu').niceScroll({
                cursorcolor: '#7db7fb',
                cursorwidth: '6px',
                cursorborderradius: 2,
                autohidemode: true,
                background: '#d0d0d0',
                cursoropacitymin: 1,
                cursorborder: 'none',
                horizrailenabled: false
            });

            $('.left-menu-list').zwbam('initMenu', '${contextPath}/index4/menu.ajax?t=<@z.z_now />');
        });
    </script>
</body>
</html>