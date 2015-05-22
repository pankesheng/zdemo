<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="${contextPath}/admin4/stylesheets/common.css" />
    <link rel="stylesheet" href="${contextPath}/admin4/stylesheets/table.css" />
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/ext/jquery/selectbox.js"></script>
    <script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/ext/zw/grid.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/javascripts/tool.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
</head>
<body>
	<div class="place">
        <span class="label-span">位置：</span>
        <span>设置 - 用户管理</span>
    </div>
    <div class="body-warp">
        <div class="panel filter-block">
            <form class="form-inline">
                <div class="form-group">
                    <input class="form-control" id="search1" type="text" />
                </div>
                <div class="form-group">
                    <select class="form-select">
                        <option selected="" value="">下拉菜单</option>
                        <option value="选项1">选项1</option>
                        <option value="选项2">选项2</option>
                        <option value="选项3">选项3</option>
                    </select>
                </div>
                <div class="form-group">
                    <a href="javascript:void(0);" class="btn" id="search-btn"><i class="iconfont">&#xe61b;</i>搜索</a>
                </div>
            </form>
        </div>
        <div class="panel table-tool-bar">
            <#-- 
            <a class="table-switch switchMode right" data-mode="thumb" title="缩略图模式"><i class="iconfont">&#xe629;</i></a>
            <a class="table-switch switchMode right selected" data-mode="list" title="列表模式"><i class="iconfont">&#xe63d;</i></a>
             -->
            <a class="btn" id="add-btn" href="javascript:void(0);"><i class="add-btn iconfont">&#xe619;</i>新增</a>
            <a class="btn" href="javascript:void(0);"><i class="remove-btn iconfont">&#xe608;</i>删除</a>
        </div>
        <table class="table" id="table"></table>
    </div>
	<script>
	
        var grid = {};
        
        $(function() {
            $('.form-select').each(function(index, el) {
               selectbox(this);
            });
            
            grid = $('#table').grid({
                store: {
					url: '${contextPath}/user4/list.ajax'
                },
                <#-- 
                schema: {
                    thumbRenderer: function(rowData, grid, rowIndex){
                        return '<div class="thumb-content">'+
                            '<a class="thumb-title">瓯海教育OA系统</a>'+
                            '<p class="thumb-section"><b>适用范围</b>：全区</p>'+
                            '<p class="thumb-section"><b>应用类型</b>：系统应用</p>'+
                            '<b>安装人数</b>：123456<b>&nbsp;&nbsp;&nbsp;&nbsp;使用人数</b>：12345'+
                            '<p class="thumb-section"><b>使用状态</b>：启动</p>'+
                            '<p class="thumb-section"><b>应用介绍</b>：这是一段应用介绍霍乱有多种传播途径什</p>'+
                            '<p class="thumb-section thumb-btns"><a class="btn btn-mini btn-primary">编辑</a>\n<a class="btn btn-mini btn-primary">编辑</a>\n<a class="btn btn-mini btn-primary">编辑</a></p>'
                        '</div>';
                    }
                },
                 -->
                tool: {
                    pagingBar: true
                },
                columns: [
                {
                    title: '真实姓名',
                    dataIndex: 'realname'
                },{
					title: '账号',
					dataIndex: 'username',
					nowrap: true
				},{
					title: '密码',
					dataIndex: 'password',
                    align: 'left'
				},{
                    title: '角色',
                    dataIndex: 'role',
                    renderer: function(cellData, rowData){
                        if(cellData == 1){
							return '超级管理员';
						}else if (cellData == 2){
							return '普通用户';
						}
                    }
                },{
                    title: '状态',
                    dataIndex: 'state',
                    renderer: function(cellData, rowData){
                        if(cellData){
							return '<span style="color:blue">启用</span>';
						}else{
							return '<span style="color:red">冻结</span>';
						}
                    }
                },{
                    title: '操作',
                    width: 300,
                    renderer: function(){
                    	var result = '';
                    	result += '<div style="width:300px;overflow:hidden;">';
                    		result += '<a class="btn btn-primary" href="javascript:void(0);" onclick="setManager(this);">警告框</a>\n';
                    	result += '</div>';
                    	return result;
                    }
                }]
            });
            
            $('#add-btn').bind('click', function(){
                var index = showIframe('添加', '${contextPath}/user4/toadd.do', 800, 460);
            });
            <#-- 
            $('.switchMode').bind('click', function(){
                $(this).siblings('.selected').removeClass('selected');
                $(this).addClass('selected');
                grid.switchDisplayMode($(this).data('mode'));
            });
             -->
        });

        function setManager (me){
            showAlert('确认要执行此操作，可能会带来未知的数据异常', function(index){
                layer.close(index);
            });
        }
    </script>












<#-- <div class="space">
    <div>
    	<div id="searchDiv">
    		选择筛选条件：<select id="searchRole" size="1">
    			<option value="">--请选择角色--</option>
    			<option value="1">超级管理员</option>
    			<option value="2">普通用户</option>
			</select>&nbsp;
			<select id="searchState" size="1">
    			<option value="">--请选择状态--</option>
    			<option value="1">启用</option>
    			<option value="0">冻结</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			输入关键字搜索：<input id="searchKey" type="text" size="20"><a id="searchBtn" href="javascript:void(0);" class="c-btn primary-label">搜索</a>
    	</div>
    	<div class="list-hd">
        	<a onclick="add()" href="#" title="" class="c-btn primary-label">添加</a>
        	<a onclick="removeItems()" href="#" title="" class="c-btn primary-label">删除</a>
        	<a onclick="zexport()" href="#" title="" class="c-btn primary-label">导出</a>
            <b class="round-left"></b>
            <b class="round-right"></b>
        </div>
    	<table id="grid" class="list-bd"></table>
        <div class="flip-box">
            <div class="flip"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
	
	var content = '<a href="#" onclick="editItem($(this));" class="c-btn primary-label">编辑</a>';
						
	//添加
	function add(){
		z_openIframe('新增', 620, 400, '${contextPath}/user/toadd.do');
		
		// window.location.href = '${contextPath}/ztTopicArticle/toadd.do';
	}
	
	//编辑
	function editItem(that){
		var data = that.parents('tr').data();
		z_openIframe('编辑', 620, 400, '${contextPath}/user/tomodify/' + data.id + '.do');
		
		// window.location.href = '${contextPath}/ztTopicArticle/tomodify/' + data.id + '.do';
	}

	//删除
	function removeItems(){
		var data = $('#grid').getSelectedValuesString();
		z_delete(data, '${contextPath}/user/delete.ajax');
	}
	
	// 导出
	function zexport() {
		$.ajax({url:"${contextPath}/user/export.ajax",data:{},type:"post",dataType:"json", success: function(data){
	        if(data.s!=1){
	          alert(data.d);
	          return;
	        }
	        var url = "${contextPath}/file/download.ajax?path="+encodeURI(data.d.url)+"&fileName="+encodeURI(data.d.fileName);
	        window.location.href=url;
		}});
	}
	
	$('#searchBtn').click(function(){
    	var params = {
    		searchRole: $('#searchRole').val(),
    		searchKey: $('#searchKey').val(),
    		searchState: $('#searchState').val(),
    		start: 0
    	};
    	//读取数据
    	grid.load(params);
    });
    $('#searchKey').keydown(function(e){
		if(e.keyCode==13){
		   $('#searchBtn').click(); //处理事件
		}
	});
	$('#searchRole').add('#searchState').change(function(){
		$('#searchBtn').click();
	});
	
</script>
 -->


</body>
</html>