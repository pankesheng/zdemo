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
        <div class="left-menu-list"></div>
    </div>
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/ext/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
    <!--[if lt IE 8]>
    <script type="text/javascript" src="${contextPath}/ext/DD_belatedPNG/DD_belatedPNG.js"></script>
    <script>
        DD_belatedPNG.fix('.first-icon, .right-arrow, background, background');
    </script>
    <![endif]-->
    <script type="text/javascript" src="${contextPath}/admin2/javascripts/jquery-zwbam-0.0.1.js"></script>
    <script>
        $('.left-menu-list').zwbam('initMenu', '${contextPath}/index/menu.ajax?t=<@z.z_now />');
    </script>
</body>
</html>