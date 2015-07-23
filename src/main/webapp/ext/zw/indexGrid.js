
// 已弃用

(function($){
	var ajaxParams = new Object();
	var opts = new Object();
	var $me = new Object();
	var basePath = '';
	var curPage = 1;

	$.fn.indexGrid = function(config){
		$me = this;
		basePath = $('#basePath').val();

		opts = $.extend({
			//请求地址
			url: '',
			//起始页
			start: 0,
			//单页行数
			limit: 15,
			//数组字段名
			dataField: 'rows',
			//总页数字段名
			totalPageField: 'results',
			//额外参数
			extraParam: {
				
			},
			//底部工具栏
			bbar: {
				pagingBar: true
			}
		},config||{});

		ajaxParams = opts.extraParam;
		//载入第一页
		_loadPage(1);
		
		return this;
	};
	
	//加载某页
	function _loadPage(pageNum){
		curPage = pageNum;
		//获取数据
		var data = _getData(pageNum);
		
		_renderGrid(data);
	}
	
	//获取数据
	function _getData(pageNum, params){
		var returnData = '';

		$.extend(ajaxParams,{
			start: (pageNum - 1) * opts.limit,
			limit: opts.limit
		},params||{});

		$.ajax({
			url: opts.url,
			async: false,
			data: ajaxParams,
			dataType: 'JSON',
			type: 'POST',
			success: function(data, textStatus){
				returnData = data;
			}
		});

		return returnData;
	}
	
	//渲染表格
	function _renderGrid(data){
		var rows = data.rows;
		
		if(data.results == 0){
			$me.html('当前搜索条件没有任何记录！');
			return false;
		}
		
		//标题行
		$me.html(
			'<tr>'+
				'<td height="25">&nbsp;</td>'+
				'<td align="left">标题</td>'+
				'<td width="150">发布时间</td>'+
				'<td width="80">浏览数</td>'+
			'</tr>'
		);
		
		for(var i = 0, len = rows.length; i < len; i++){
			$me.append(
				'<tr>'+
					'<td width="15" height="25"><img src="' + basePath + '/www/ohga/images/dot_01.gif"></td>'+
					'<td align="left">'+
						'<a class="link1" target="_blank" title="' + _fomatCoulum(rows[i].title) + '" href="' + basePath + '/www/ohga/detail/' + rows[i].id + '.do">' + _fomatCoulum(rows[i].title) + '</a>'+
					'</td>'+
					'<td>' + _fomatCoulum(rows[i].showtime) + '</td>'+
					'<td>' + _fomatCoulum(rows[i].clicks) + '</td>'+
				'</tr>'
			);
		}
		
		_renderPaging(data);
	}

	//生成分页
	function _renderPaging(data){
		var $aim = $('#paging td');
		var groupNum = function(){
			if(curPage%10 == 0){
				return parseInt(curPage/10 -1);
			}else{
				return parseInt(curPage/10);
			}
		}();
		
		if(data.results == 0){
			$aim.html('');
			return false;
		}
		var totalPage = function(){
			var limit = opts.limit;
			var rem = data.results % limit;

			if(rem > 0){
				return parseInt(data.results / limit) + 1;
			}else{
				return parseInt(data.results / limit);
			}
		}();
		
		$aim.html('<span class="total">共有 ' + data.results + ' 条记录 当前第 ' + curPage + ' | ' + totalPage + ' 页 </span>');
		//第一页和前一页
		$aim.append('<a href="#" class="index-page" title="首页" href=""><font face="Webdings">7</font></a><a href="#" class="prev-page" title="前一页"><font face="Webdings">3</font></a>');
		
		for(var i = 10*groupNum+1, len = (groupNum+1)*10; i <= len && i <= totalPage; i++){
			if(i == curPage){
				$aim.append('<a href="#" class="num-page" nums="' + i + '">[<b>' + i + '</b>]</a>');
			}else{
				$aim.append('<a href="#" class="num-page" nums="' + i + '">' + i + '</a>');
			}
		}

		//最后页和下一页
		$aim.append('<a href="#" class="next-page" title="下一页" href=""><font face="Webdings">4</font></a><a href="#" title="尾页" class="last-page"><font face="Webdings">8</font></a>');
		
		//点击事件
		$aim.find('a').click(function(){
			var type = $(this).attr('class');
			
			switch(type){
				//首页
				case 'index-page':
					curPage = 1;
					_loadPage(1);
					break;
				//尾页
				case 'last-page':
					curPage = totalPage;
					_loadPage(totalPage);
					break;
				//前一页
				case 'prev-page':
					if(curPage == 1){
						break;
					}
					curPage--;
					_loadPage(curPage);
					break;
				//后一页
				case 'next-page':
					if(curPage == totalPage){
						break;
					}
					curPage++;
					_loadPage(curPage);
					break;
				//页码页
				case 'num-page':
					curPage = parseInt($(this).attr('nums'));
					_loadPage(curPage);
					break;
			}
		});
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