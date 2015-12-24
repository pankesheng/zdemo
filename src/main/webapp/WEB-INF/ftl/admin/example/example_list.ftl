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
        <span>XXXX - XXXX</span>
    </div>
    <div class="body-warp">
        <div class="panel filter-block">
            <form class="form-inline">
                <div class="form-group">
                    <select id="role" class="form-select">
                        <option value="">--请选择角色--</option>
		    			<option value="1">超级管理员</option>
		    			<option value="2">普通用户</option>
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
    $(function() {
        grid = $('#table').grid({
            store: {
				url: '${contextPath}/example/list.ajax'
            },
            tool: {
                pagingBar: true
            },
            columns: [
            {
                title: '用户名',
                dataIndex: 'username'
            },{
                title: '图片',
                dataIndex: 'imgs',
                renderer: function(cell, row) {
                	var imgsArray = cell.split(",");
                	var result = "";
                	for (i in imgsArray) {
                		result = result + "<a href='${contextPath}"+imgsArray[i]+"' target='_blank'><img height='30' width='60' src='${contextPath}"+imgsArray[i]+"'/></a>";
                		result = result + "&nbsp;&nbsp;&nbsp;&nbsp;";
                	}
                	return result;
                }
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
		// z_openIframe('新增', 700, 400, '${contextPath}/example/toadd.do');
		window.location.href = '${contextPath}/example/toadd.do';
	}
	
	//编辑
	function editItem(id){
		// z_openIframe('编辑', 700, 400, '${contextPath}/example/tomodify/' + id + '.do');
		window.location.href = '${contextPath}/example/tomodify/' + id + '.do';
	}

	//删除
	function removeItems(){
		var data = grid.getSelectedData('id');
		z_delete2(data, '${contextPath}/example/delete.ajax');
	}
	
	// 导出
	function zexport() {
		z_export("${contextPath}/example/export.ajax");
	}
	
	$('#search-btn').click(function(){
    	var params = {
    		role: $('#role').val(),
    		searchKey: $('#searchKey').val(),
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
	$('#role').change(function(){
		$('#search-btn').click();
	});
</script>
</body>
</html>