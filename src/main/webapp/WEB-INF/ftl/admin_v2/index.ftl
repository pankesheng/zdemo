<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>XX系统</title>
<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/reset.css?v=${sversion}" media="screen" />
<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/common.css?v=${sversion}" media="screen" />
<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/admin/js/common.js?v=${sversion}"></script>
<script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
<!--[if lt IE 8]>
<script type="text/javascript" src="${contextPath}/ext/DD_belatedPNG/DD_belatedPNG.js"></script>        
<script type="text/javascript">     
	DD_belatedPNG.fix('.round-left-top, .round-left-bottom, .shadow-left');    
</script>
<![endif]-->
</head>
<body class="body"><!--全屏加class="full-left",class="full-top"-->
	<div class="header">
    	<p class="logo"><img src="${contextPath}/admin/images/logo.png" height="35" title="" alt=""></p>
        <div class="user-set">
        	<span>李先生【信访科】</span>
            <span class="line">|</span>
        	<a href="#" title="">修改密码</a>
            <span class="line">|</span>
        	<a href="#" title="">退出</a>
        </div>
    </div>
    
    <div class="content">
        <div class="menu">
            <div class="menu-box">
            	<h2 class="menu-hd">系统菜单</h2>
                <ul></ul>
            </div>
            
            <div class="shadow-left"></div><!--阴影-->
        </div>
        
        <div class="main">
            <div class="tab-body">
            	<iframe class="iframe" scrolling="auto" frameborder="0"></iframe>
            </div>
            <div class="comp-box">
                <div class="comp-hd">
                </div>
                <div class="comp-bd">
                </div>
            </div> 
            
            <div class="screen-left"><a href="javascript:void(0);" title="向左缩进"></a></div>
            <div class="screen-top"><a href="javascript:void(0);" title="向上缩进"></a></div>
            <div class="round-left-top"></div><!--左上圆角-->
            <div class="round-left-bottom"></div><!--左下圆角-->
        </div>
    </div>
    
<script type="text/javascript">
    $(document).ready(function() {
    	//全屏
        $(".screen-left,.screen-top").click(function(){
            var b=$(document.body);
            if($(this).hasClass("screen-left")){
                b.hasClass("full-left")?b.removeClass("full-left"):b.addClass("full-left");
            }
            else{
                b.hasClass("full-top")?b.removeClass("full-top"):b.addClass("full-top");
            }
        });
        
        //初始化菜单
        initMenu();
        
        //左侧菜单导航
        $('.menu li').click(function(){
        	var item = $(this).find('.item');
        	
        	if(!item.is(':hidden')){
        		return false;
        	}
        	
        	//移除选中效果
        	$('.menu li.on').removeClass('on');
        	//添加选中效果
        	$(this).addClass('on');

			//ie6关闭滑动效果
        	if($.browser.msie6 || $.browser.msie7){
        		item.show();
        		//隐藏其他二级栏目
        		$('.menu li .item').hide();
        	}else{
        		$('.menu li .item').slideUp('fast');
        		item.slideDown('fast');
        	}
        });
        
        //导航
        $('.menu li .item a').click(function(){
        	$('.menu li .item a').removeClass('selected');
        	$(this).addClass('selected');
        	
        	//载入页面
        	$('.main iframe').attr('src', $(this).attr('href') + '?n=' + Math.random());
        	//记录hash
        	setNavPosition($(this).attr('title'));
        });
    });
    function initMenu(){
		$.ajax({
			url: '${contextPath}/index2/menu.ajax',
			async: false,
			dataType: 'JSON',
			success: function getMenu(json, textStatus, jqXHR) {
				//获取列表成功
				if(json.s === 1){
					var tree = json.d;
					var hash = window.location.hash;
					
					renderMenu(tree,$('.menu ul'));
					if(hash){
						hash = hash.replace('#', '');
						loadPage($('.menu ul li a[title=' + hash + ']'));
						$('.main iframe').attr('src', $(this).attr('href'));
					}
				}
			}
		});
    }
    function renderMenu(tree, $aim){
    	var $html = '';
    	var $item = '';

    	//清空
    	$aim.html('');

    	for(var i = 0, len1 = tree.length; i < len1; i++){
    		$html = $('<li><h6>' + tree[i].name + '</h6><div class="item hide"></div></li>');
    		$item = $html.find('.item');

			if (tree[i].childs) {
				for(var j = 0, len2 = tree[i].childs.length; j < len2; j++){
	    			$item.append('<a href="${contextPath}' + tree[i].childs[j].url +  '" title="' + tree[i].childs[j].id + '">' + tree[i].childs[j].name + '</a>');
	    		}
	    		$html.append($item);
			}
    		
    		$aim.append($html);
    	}
    }
</script>
</body>
</html>