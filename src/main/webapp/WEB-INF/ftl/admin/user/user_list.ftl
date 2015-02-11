<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/reset.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/common.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/form.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/table.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/button.css?v=${sversion}" media="screen" />
	
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/zw/grid.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/ext/zcommon.js?v=${sversion}" basepath="${contextPath}"></script>
</head>
<body>
<div class="space">
    <div>
    	<#-- 
    	<div id="searchDiv">
    		<select id="depSelect" size="1">
    			<option value="">--请选择部门--</option>
			</select>
			<input id="checkDea" type="checkbox" name="defaults" value="1" ><label for="checkDea">只看默认</label>
			<input id="searchKey" type="text" size="20"><a id="searchBtn" href="javascript:void(0);" class="c-btn primary-label">搜索</a>
    	</div>
    	 -->
    	<div class="list-hd">
        	<a onclick="add()" href="#" title="" class="c-btn primary-label">添加</a>
        	<a onclick="removeItems()" href="#" title="" class="c-btn primary-label">删除</a>
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
	var grid = '';
	$(function(){
		grid = $('#grid').grid({
			url: '${contextPath}/user/list.ajax',
			start: 0,
			limit: 10,
			bbar: {
				pagingBar: true
			},
			columns: [
				{
					type: 'checkbox',
					name: 'ids',
					dataIndex: 'id'
				},
				{
					dataIndex: 'realname',
					align: 'left',
					header: '名称'
				},
				{
					type: 'custom',
					dataIndex: 'state',
					header: '状态',
					renderer: function(value){
						if(value){
							return '<span style="color:blue">启用</span>';
						}else{
							return '<span style="color:red">停用</span>';
						}
					}
				},
				{
					type: 'custom',
					dataIndex: 'state',
					renderer: function(value, record){
						var content = '<a href="#" onclick="editItem($(this));" class="c-btn primary-label">编辑</a>';
						//显示隐藏切换
						value ? (content += '<a href="#" onclick="showHide($(this));" class="c-btn primary-label" >隐藏</a>'):(content += '<a href="#" onclick="showHide($(this));" class="c-btn primary-label" >显示</a>');
						return content;
					},
                    header: '操作'
				}
			]
		});
	});
	
	//添加
	function add(){
		z_openIframe('新增', 620, 500, '${contextPath}/user/toadd.do');
		
		// window.location.href = '${contextPath}/ztTopicArticle/toadd.do';
	}
	
	//编辑
	function editItem(that){
		var data = that.parents('tr').data();
		z_openIframe('编辑', 620, 500, '${contextPath}/user/tomodify/' + data.id + '.do');
		
		// window.location.href = '${contextPath}/ztTopicArticle/tomodify/' + data.id + '.do';
	}

	//删除
	function removeItems(){
		var data = $('#grid').getSelectedValuesString();
		z_delete(data, '${contextPath}/user/delete.ajax');
	}
	
	//显示隐藏
	function showHide(that){
		var data = that.parents('tr').data();
		if(data.state == 1){
			$.post('${contextPath}/user/cancelvalid/' + data.id + '.do', function(json) {
	            if(json.s){
	                grid.reload();
	            }else{
	                layer.alert(json.d, 8);
	            }
	        }, "json");
		}else{
			$.post('${contextPath}/user/valid/' + data.id + '.do', function(json) {
	            if(json.s){
	                grid.reload();
	            }else{
	                layer.alert(json.d, 8);
	            }
	        }, "json");
		}
	}
	
	<#-- 
	$('#searchBtn').click(function(){
    	var params = {
    		departmentId: $('#depSelect').val(),
    		searchKey: $('#searchKey').val(),
    		defaults: $('#checkDea').is(':checked')?1:0,
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
	$('#depSelect').add('#checkDea').change(function(){
		$('#searchBtn').click();
	});
	-->
</script>
</body>
</html>