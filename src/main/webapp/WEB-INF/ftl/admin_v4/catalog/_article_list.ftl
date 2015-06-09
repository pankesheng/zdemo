<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="${contextPath}/admin4/stylesheets/common.css?v=${sversion}" />
    <link rel="stylesheet" href="${contextPath}/admin4/stylesheets/table.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/ext/jquery/selectbox.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/ext/zw/grid.js?v=${sversion}"></script>
    <script type="text/javascript" src="${contextPath}/admin4/javascripts/tool.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin4/javascripts/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
</head>
<body>
	<div class="place">
        <span class="label-span">位置：</span>
        <span>基本功能 - 资讯管理</span>
    </div>
    <div class="body-warp">
        <div class="panel filter-block">
            <form class="form-inline">
                <div class="form-group">
                    <select id="catalogId" class="form-select">
                        <option value="">--请选择栏目--</option>
                        <#list catalogList as cat>
		    			<option value="${cat.id}">${(cat.name)!}</option>
						</#list>
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
            <a class="btn" href="javascript:void(0);" onclick="add()"><i class="add-btn iconfont">&#xe619;</i>新增</a>
            <a class="btn" href="javascript:void(0);" onclick="removeItems()"><i class="remove-btn iconfont">&#xe608;</i>删除</a>
        </div>
        <table class="table" id="table"></table>
    </div>
<script>
    var grid = {};
    $(function() {
        grid = $('#table').grid({
            store: {
				url: '${contextPath}/web/article/list.ajax'
            },
            tool: {
                pagingBar: true
            },
            columns: [
            {
                title: '栏目',
                dataIndex: 'catalogName'
            },{
                title: '标题',
                dataIndex: 'title'
            },{
				title: '发布时间',
				dataIndex: 'pubDate'
			},{
                title: '操作',
                dataIndex: 'id',
                width: 300,
                renderer: function(cellData, rowData){
                	var result = '';
                	result += '<div style="width:300px;overflow:hidden;">';
                		result += '<a class="btn btn-primary" href="javascript:void(0);" onclick="editItem(\''+cellData+'\');">编辑</a>\n';
                	result += '</div>';
                	return result;
                }
            }]
        });
    });
        
    //添加
	function add(){
		window.location.href = '${contextPath}/web/article/toadd.do';
	}
	
	//编辑
	function editItem(id){
		window.location.href = '${contextPath}/web/article/tomodify/' + id + '.do';
	}

	//删除
	function removeItems(){
		var data = grid.getSelectedDataString('id');
		z_delete(data, '${contextPath}/web/article/delete.ajax');
	}
	
	$('#search-btn').click(function(){
	    	var params = {
	    		catalogId: $('#catalogId').val(),
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
	$('#catalogId').change(function(){
		$('#search-btn').click();
	});
</script>
</body>
</html>