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
	<script type="text/javascript" src="${contextPath}/ext/laypage/laypage.js"></script>
	<script>
	$(document).ready(function(){
		laypage({
		    cont: 'page1',
		    pages: ${(total/limit+0.9999)?int},
		    curr: ${((start/limit)?int) + 1}, //当前页
		    // skip: true,
		    // skin: '#AF0000',
		    jump: function(e){
		    	if (${((start/limit)?int) + 1} != e.curr) {
		    		var url = '${contextPath}/www/list.do?id=${obj.id}&start='+((e.curr-1)*${limit});
			    	window.location.href = url;
		    	}
		    }
		});
	});
	</script>
	<title></title>
</head>
<body>
<div class="wrapper">

	<#include "/head.html"/>

        <div class="main clearfix">
        
	        <div class="left clearfix">
	        	<#include "/left.html"/>
	        </div>

            <div class="right clearfix">
                <div class="righttop">
                    <img src="${contextPath}/www/images/title8.gif">
                    <span>${(obj.name)!}</span>
                </div>
                <div class="rightlist">
                    <ul>
                    	<#list rows as art>
                        <div class="xian">
                            <li>
                                <a href="${contextPath}/www/detail.do?id=${art.id}" target="_blank">
                                    <span class="time">[${((art.showtime)?string("yyyy-MM-dd"))!}]</span>${(art.title)!}
                                </a>
                            </li>
                        </div>
                        </#list>
                    </ul>
                </div>
                <div id="page1"></div>
            </div>
        </div>
        <#include "/foot.html"/>
    </div>
</body>
</html>