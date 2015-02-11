/*
*@author Ezios
*@description 表格插件： 
*	1.自定义表格字段
*	2.根据json数据渲染表格
*	3.分页功能
*@version 0.1
*@requires JQuery table.css
*
*/
define(function(require, exports, module){
	var $ = require('jquery');
	//分页当前页数
	var curPage = 1;
	//默认配置
	var defaults = {
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
		//表格模型
		columns: [{
			//类型 checkbox 单选框  string或者默认 字符串 custom 自定义 用 content对象来自定义
			type: 'checkbox'
		},
		{
			type: 'string',
			dataIndex: 'name'
		},{
			type: 'custom',
			content: '<div><div>'
		}],
		//底部工具栏
		bbar: {
			pagingBar: true
		}	
	};
	//最终配置
	var opts = new Object();

	/*构造函数
	 * @constructor
	 * @argument config 配置参数对象
	 * @arguments 
	 */
	function Grid($table, config){
		this.$me = $table;

		opts = $.extend({}, defaults, config);
		
	}
});