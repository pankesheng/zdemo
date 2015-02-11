/*表格插件
 * 
 * 功能
 * 1. 发送请求获取数据并自动填充
 * 
 */
(function($){
	//分页当前页数
	var curPage = 1;
	//通用配置
	var opts = '';
	//请求参数
	var ajaxParams = '';
	
	$.fn.grid = function(config){
		opts = $.extend({
			//请求地址
			url: '',
			//起始页
			start: 0,
			//单页行数
			limit: 10,
			//数组字段名
			dataField: 'rows',
			//总页数字段名
			totalPageField: 'results',
			//额外参数
			extraParam: {
				
			},
			//是否自动载入
			autoLoad: true,
			//表格模型
			columns: [{
				//类型 checkbox 单选框  string或者默认 字符串 custom 自定义 用 content对象来自定义
				type: 'checkbox'
			},
			{
				type: 'string',
				dataIndex: 'name',
				align: 'left'
			},{
				type: 'custom',
				content: '<div><div>',
				align: 'left'
			}],
			//底部工具栏
			bbar: {
				pagingBar: true
			}
		},config||{});

		ajaxParams = opts.extraParam;

		if(opts.autoLoad){
			//初始化表格
			_initTable(this);
			//载入第一页
			_loadPage(this, 1);
		}
		
		return this;
	};
	
	//获取选中列的值字符串
	$.fn.getSelectedValuesString = function(){
		var $me = this;
		var selections =  $me.find(':checked:not(#selectAll)');
		var len = selections.length;
		var values = new Array();
		
		for(var i = 0; i < len; i++){
			values.push(opts.columns[0].name + '=' + $(selections[i]).val());
		}
		
		return values.join('&');
	}
	
	//刷新表格
	$.fn.reload = function(){
		//载入当前页
		_loadPage(this, curPage);
	}
	
	//附加参数
	$.fn.load = function(params){
		//重置页数
		curPage = 1;
		//额外参数
		_loadPage(this, curPage, params);
	}

	//加载表格
	function _loadPage($me, page, params){
		ajaxParams = $.extend(ajaxParams,{
			start: (page - 1) * opts.limit,
			limit: opts.limit
		},params||{});
		
		//获取数据
		var data = _getData(ajaxParams);

		//渲染表格
		_renderGrid($me, data);
	}
	
	//渲染表格
	function _renderGrid($me, data){
		var html = '';
		var tr = '';
		var rows = null;

		//移除之前的tr
		$me.find('tr:not(.title)').remove();
		//全选按钮重置
		$me.find('#selectAll').prop('checked', false);
		
		if(data == null){
			return false;
		}else{
			rows = data[opts.dataField];
		}
		
		for(var i = 0, len = rows.length; i < len; i++){
			if(i%2 == 0){
				tr = '<tr><td class="hide"><div></div></td>';
			}else{
				tr = '<tr class="bg-color"><td class="hide"><div></div></td>';
			}
			
			tr += _renderTds(rows[i]) + '</tr>';

			$me.append(tr);
			//存储数据
			$me.find('tr:last').data(data[opts.dataField][i]);
		}
		
		//填充剩下的表格行
		if(rows.length < opts.limit){
			var spaceTr = '';
			var curLen = rows.length;
			var rowsNum = opts.limit - curLen;
			//之前行的高度
			var trHeight = $me.find('tr:last').height();
			
			for(var i = 0; i < rowsNum; i++){
				spaceTr = '<tr style="height: ' + trHeight + 'px;">';
				for(var j = 0, len = opts.columns.length; j < len; j ++){
					spaceTr += '<td>&nbsp;</td>';
				}
				$me.append(spaceTr + '</tr>');
			}
		}
		
		_initBbar($me, data[opts.totalPageField]);
	}
	
	//渲染单元格
	function _renderTds(data){
		var tds = '';
		var columns = opts.columns;
		
		for(var i = 0, len = columns.length; i < len; i++){
			//默认居中对齐
			if(!opts.columns[i].align){
				opts.columns[i].align = 'center';
			}
			switch(columns[i].type){
				case 'checkbox':
					tds += '<td><input type="checkbox" name="' + columns[i].name + '" value="' + data[columns[i].dataIndex] + '"></td>';
					break;
				case 'custom':
					if(columns[i].renderer){
						tds += '<td style="text-align: ' + opts.columns[i].align + '">' + columns[i].renderer(data[columns[i].dataIndex], data) + '</td>'
					}else if(columns[i].content){
						tds += '<td style="text-align: ' + opts.columns[i].align + '">' + columns[i].content + '</td>';
					}
					break;
				case 'string':
					tds += '<td style="text-align: ' + opts.columns[i].align + '">' + _fomatCoulum(data[columns[i].dataIndex]) + '</td>';
					break;
				default:
					tds += '<td style="text-align: ' + opts.columns[i].align + '">' + _fomatCoulum(data[columns[i].dataIndex]) + '</td>';
			}
		}

		return tds;
	}
	
	//初始化底部工具栏
	function _initBbar($me, totalPageNum){
		if(opts.bbar.pagingBar){
			//计算总页数
			totalPageNum = function(){
				var limit = opts.limit;
				var rem = totalPageNum % limit;

				if(rem > 0){
					return parseInt(totalPageNum / limit) + 1;
				}else{
					return parseInt(totalPageNum / limit);
				}
			}();
			//组号 以10个按钮为一组
			var groupNum = function(){
				if(curPage%10 == 0){
					return parseInt(curPage/10 -1);
				}else{
					return parseInt(curPage/10);
				}
			}();
			//作用域
			var $aim = '';
			
			if($me.parent().find('.flip')){
				//移除除首页和上一页按钮的所有项
				$me.parent().find('.flip').html(
						'<p>'+
							'<a class="index-page" href="javascript:void(0);">&nbsp;首页&nbsp;</a>'+
							'<a class="prev-page" href="javascript:void(0);">上一页</a>'+
						'</p>'
				);
				$aim = $me.parent().find('.flip p');
			}else{
				$me.after(
						'<div class="flip-box">'+
							'<div class="flip">'+
								'<p>'+
									'<a class="index-page" href="javascript:void(0);">&nbsp;首页&nbsp;</a>'+
									'<a class="prev-page" href="javascript:void(0);">上一页</a>'+
								'</p>'+
							'</div>'+
						'</div>'
				);
				$aim = $me.find('.flip p');
			}
			
			if(totalPageNum == 0){
				$aim.html('');
				return false;
			}
			
			for(var i = 10*groupNum+1, len = (groupNum+1)*10; i <= len && i <= totalPageNum; i++){
				if(i == curPage){
					$aim.append('<a class="num-page on" href="javascript:void(0);">' + i + '</a>');
				}else{//普通页面
					$aim.append('<a class="num-page" href="javascript:void(0);">' + i + '</a>');
				}
			}

			//加入最后页
			if(parseInt($aim.find('.num-page:last').text()) < totalPageNum){
				$aim.append('<span>...</span><a class="num-page" href="javascript:void(0);">' + totalPageNum + '</a>');
			}
			
			//加入下一页和尾页按钮
			if(curPage == totalPageNum){
				$aim.append(
						'<a class="next-page gray" href="javascript:void(0);">&nbsp;下一页&nbsp;</a>'+
						'<a class="last-page gray" href="javascript:void(0);">&nbsp;尾页&nbsp;</a>'
				);
			}else{
				$aim.append(
						'<a class="next-page" href="javascript:void(0);">&nbsp;下一页&nbsp;</a>'+
						'<a class="last-page" href="javascript:void(0);">&nbsp;尾页&nbsp;</a>'
				);
			}
			
			//启用或关闭上一页和首页按钮
			if(curPage == 1){
				$aim.find('.index-page').addClass('gray');
				$aim.find('.prev-page').addClass('gray');
			}else{
				$aim.find('.index-page').removeClass('gray');
				$aim.find('.prev-page').removeClass('gray');
			}
			
			//点击事件
			$aim.find('a:not(.gray)').click(function(){
				var type = $(this).attr('class');
				var limit = opts.limit;
				
				switch(type){
					//首页
					case 'index-page':
						curPage = 1;
						_loadPage($me, 1);
						break;
					//尾页
					case 'last-page':
						curPage = totalPageNum;
						_loadPage($me, totalPageNum);
						break;
					//前一页
					case 'prev-page':
						curPage--;
						_loadPage($me, curPage);
						break;
					//后一页
					case 'next-page':
						curPage++;
						_loadPage($me, curPage);
						break;
					//页码页
					case 'num-page':
						curPage = parseInt($(this).text());
						_loadPage($me, curPage);
						break;
					case 'num-page on':
						curPage = parseInt($(this).text());
						_loadPage($me, curPage);
						break;
				}
			});
		}
	}
	
	//获取数据
	function _getData(config){
		var returnData = null;

		$.ajax({
			url: opts.url,
			async: false,
			data: config,
			dataType: 'JSON',
			type: 'POST',
			success: function(data, textStatus){
				if(data.s == 2){
					alert(data.d);
					returnData = null;
				}else{
					returnData = data;
				}
			}
		});
		
		return returnData;
	}
	
	//初始化表格
	function _initTable($me){
		var $titleTr = '';

		//全选事件
		(function selectAll(){
			$me.on('change', '#selectAll', function(){
				$me.find(':checkbox:not(#selectAll)').prop('checked', this.checked);
			});
			
			$me.on('change', ':checkbox:not(#selectAll)', function(){
				if($(':checkbox:not(#selectAll)', $me).not(':checked').length == 0){
					$me.find('#selectAll').prop('checked', true);
				}else{
					$me.find('#selectAll').prop('checked', false);
				}
			});
		})();
		
		//载入
		$me.html('<tr class="title"></tr>');
		$titleTr = $me.find('tr');
		for(var i = 0; i < opts.columns.length; i++){
			switch(opts.columns[i].type){
				case 'checkbox':
					$titleTr.append('<td><input id="selectAll" type="checkbox"></td>');
					break;
				default:
					$titleTr.append('<td>' + opts.columns[i].header + '</td>');
			}
		}
	}
	
	//过滤字段
	function _fomatCoulum(string){
		if(typeof string == 'undefined'){
			return '';
		}else{
			return string;
		}
	}
})(jQuery);