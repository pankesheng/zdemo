<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="${contextPath}/admin/stylesheets/common.css?v=${sversion}" />
    <link rel="stylesheet" href="${contextPath}/admin/stylesheets/table.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
    <script type="text/javascript" src="${contextPath}/admin/ext/jquery/selectbox.js"></script>
    <script type="text/javascript" src="${contextPath}/admin/ext/zw/grid.js?v=${sversion}"></script>
    <script type="text/javascript" src="${contextPath}/admin/javascripts/tool.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin/javascripts/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
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
                    <select id="searchRole" class="form-select">
                        <option value="">--请选择角色--</option>
		    			<option value="1">超级管理员</option>
		    			<option value="2">普通用户</option>
                    </select>
                </div>
                <div class="form-group">
                    <select id="searchState" class="form-select">
                        <option value="">--请选择状态--</option>
		    			<option value="1">启用</option>
		    			<option value="0">冻结</option>
                    </select>
                </div>
                <div class="form-group">
                    <input id="searchKey" class="form-control" type="text" />
                </div>
                <div class="form-group">
                    <a href="javascript:void(0);" class="btn" id="search-btn"><i class="iconfont">&#xe61b;</i>搜索</a>
                </div>
            </form>
        </div>
        <div class="panel table-tool-bar">
            <a class="btn" href="###" onclick="add()"><i class="add-btn iconfont">&#xe619;</i>新增</a>
            <a class="btn" href="###" onclick="removeItems()"><i class="remove-btn iconfont">&#xe608;</i>删除</a>
            <a class="btn" href="###" onclick="zexport()"><i class="iconfont">&#xe612;</i>导出</a>
        </div>
        <table class="table" id="table"></table>
    </div>
<script>
    var grid = {};
    
    <#--
    		{
                title: '图片',
                dataIndex: 'pictureUrl',
                renderer: function(cell, row) {
                	return "<a href='${contextPath}"+cell+"' target='_blank'><img height='30' width='60' src='${contextPath}"+cell+"'/></a>";
                }
            },{
				title: '店铺名称',
				dataIndex: 'id',
				renderer: function(cell, row) {
					if (row.store) {
						return (row.store.name||"");
					}
					return "";
				}
			}
     -->
    
    $(function() {
        grid = $('#table').grid({
            store: {
				url: '${contextPath}/user/list.ajax'
            },
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
                dataIndex: 'id',
                width: 300,
                renderer: function(cellData, rowData){
                	var result = '';
                	result += '<div style="width:300px;overflow:hidden;">';
                		result += '<a class="btn btn-primary" href="###" onclick="editItem(\''+cellData+'\');">编辑</a>\n';
                	result += '</div>';
                	return result;
                }
            }]
        });
    });
        
    //添加
	function add(){
		z_openIframe('新增', 700, 400, '${contextPath}/user/toadd.do');
		// window.location.href = '${contextPath}/user/toadd.do';
	}
	
	//编辑
	function editItem(id){
		z_openIframe('编辑', 700, 400, '${contextPath}/user/tomodify/' + id + '.do');
		// window.location.href = '${contextPath}/user/tomodify/' + id + '.do';
	}

	//删除
	function removeItems(){
		var data = grid.getSelectedDataString('id');
		z_delete(data, '${contextPath}/user/delete.ajax');
	}
	
	// 导出
	function zexport() {
		z_export("${contextPath}/user/export.ajax");
	}
	
	$('#search-btn').click(function(){
    	var params = {
    		searchRole: $('#searchRole').val(),
    		searchKey: $('#searchKey').val(),
    		searchState: $('#searchState').val(),
    		start: 0
    	};
    	grid.load(params);
    });
    $('#searchKey').keydown(function(e){
		if(e.keyCode==13){
		   $('#search-btn').click();
		   return false;
		}
	});
	$('#searchRole').add('#searchState').change(function(){
		$('#search-btn').click();
	});
</script>
</body>
</html>