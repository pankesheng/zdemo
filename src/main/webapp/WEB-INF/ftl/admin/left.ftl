<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title></title>
    <link rel="stylesheet" href="${contextPath}/admin2/stylesheets/common.css" />
    <link rel="stylesheet" href="${contextPath}/admin2/stylesheets/index.css" />
</head>
<body>
	<div class="left-menu">
        <div class="left-menu-top">
            <ul>
                <!-- 下部边框加 border 最后一个不要加 -->
                <li class="left-menu-top-btn border">
                    <i class="icon">
                        <img src="${contextPath}/admin2/images/top-icon-1.png" width="18" height="18" />
                    </i> 
                    <!-- data-path是存放右侧的路径的 href要对应 -->
                    <a class="navigation" data-path="<li><a href='${contextPath}/admin2/main.html' target='rightFrame'>系统菜单</a></li>" href="${contextPath}/admin2/main.html" target="rightFrame">系统菜单</a>
                </li>
                <li class="left-menu-top-btn border">
                    <i class="icon">
                        <img src="${contextPath}/admin2/images/top-icon-2.png" width="18" height="18" />
                    </i> 
                    <a class="navigation" data-path="<li><a href='${contextPath}/admin2/main.html' target='rightFrame'>系统菜单</a></li>" href="${contextPath}/admin2/main.html" target="rightFrame">系统菜单</a>
                </li>
                <li class="left-menu-top-btn">
                    <i class="icon">
                        <img src="${contextPath}/admin2/images/top-icon-3.png" width="18" height="18" />
                    </i>
                    <a class="navigation" data-path="<li><a href='${contextPath}/admin2/main.html' target='rightFrame'>系统菜单</a></li>" href="${contextPath}/admin2/main.html" target="rightFrame">系统菜单</a>
                </li>
            </ul>
        </div>
        <div class="left-menu-list"></div>
    </div>
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/ext/zcommon.js?v=${sversion}" basepath="${contextPath}"></script>
    <!--[if lt IE 8]>
    <script type="text/javascript" src="${contextPath}/ext/DD_belatedPNG/DD_belatedPNG.js"></script>
    <script>
        DD_belatedPNG.fix('.first-icon, .right-arrow, background, background');
    </script>
    <![endif]-->
    <script type="text/javascript" src="${contextPath}/admin2/javascripts/jquery-zwbam-0.0.1.js"></script>
    <script>
        /*菜单生成
        * $('.left-menu-list').zwbam('initMenu', 第二个参数)
        * 第二个参数可以为 json对象 或 菜单json请求地址，如果是请求地址，则需要带上随机数的参数，因为是get请求，会缓存
        */
        $('.left-menu-list').zwbam('initMenu', {
            "s": 1,
            "d": [{
                "name": "基本设置",
                "url": "#",
                "childs": [{
                    "name": "栏目管理",
                    "url": "#",
                    "childs": [{
                        "name": "用户组管理",
                        "url": "${contextPath}/user/tolist.do"
                    }, {
                        "name": "用户管理",
                        "url": "${contextPath}/user/tolist.do"
                    }, {
                        "name": "广告管理",
                        "url": "${contextPath}/user/tolist.do"
                    }]
                }, {
                    "name": "广告管理",
                    "url": "#",
                    "childs": [{
                        "name": "用户组管理",
                        "url": "${contextPath}/user/tolist.do"
                    }, {
                        "name": "用户管理",
                        "url": "${contextPath}/user/tolist.do"
                    }, {
                        "name": "广告管理",
                        "url": "${contextPath}/user/tolist.do"
                    }]
                }]
            }]
        });
    </script>

</body>
</html>