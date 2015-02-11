<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<link rel="stylesheet" type="text/css" href="${contextPath}/www/stylesheets/common.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/www/stylesheets/reset.css?v=${sversion}" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/superslide/jquery.SuperSlide.2.1.1.js"></script>
	<title></title>
</head>
<body>
    <div class="wrapper">
    
        <#include "/head.html"/>
        
        <div class="main clearfix">
            <div class="column">当前位置：<a href="${contextPath}/">网站首页</a> &gt;&gt; <a href="${contextPath}/www/list.do?id=${obj.catalogId}">${(obj.catalogName)!}</a>
	            <div class="content ">
	                <h1>${(obj.title)!}</h1>
	                <p>［ 来源：${(obj.userName)!}  点击数：${(obj.clicks)!}  更新时间：${((obj.showtime)?string("yyyy-MM-dd"))!}  ］</p>
	                <HR align=center width=90% color=#333 SIZE=0.1>
	                ${(obj.context)!}
	            </div>
	            <input name="button" type="button" onclick="window.close()" class="btn2" value="关闭窗口">
	            <input name="button" type="button" onclick="javascript:window.print()" class="btn3" value="打印本页">
            </div>
	    </div>
	    <#include "/foot.html"/>
	</div>
</body>
</html>