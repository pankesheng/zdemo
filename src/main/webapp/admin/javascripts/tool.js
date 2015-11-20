(function ($) {

	//封装树创建
	$.fn.createTree = function (zSetting, zNodes) {
		//当前对象不存在
		if (this.length === 0) {
			console.error("%c%s%c 对象不存在，请检查", "font-weight:bold;text-decoration:underline", this.selector, "");
			return false;
		}

		//如果有treeContentId，就与左树关联,使右侧内容自已适应，
		//如果没有ID，则自已管自已
		//都会根据setting配置生成树

		var treeContentId = null;
		var eleTreeList = $(this);
		$(this).parent().css("position", "relative");
		//假如treeContentId没有传入，并且自身id并不是treeList
		if ((!zSetting.view||!zSetting.view.treeContentId) && this.selector == "#treeList") {
			treeContentId = "#treeContent";
		} else {
			treeContentId = zSetting.view.treeContentId;
		}

		//更改ztree的默认配置，以适合本项目
		var setting = {
			view: {
				showLine: false,
				showIcon: false,
				selectedMulti: false,
				treeContentId: treeContentId,
				addDiyDom: function addDiyDom(treeId, treeNode) {
					var switchObj = $("#" + treeNode.tId + "_switch"),
						icoObj = $("#" + treeNode.tId + "_ico");
					switchObj.remove();
					icoObj.before(switchObj);
				}
			}
		}

		var eleTreeContent = $(treeContentId);

		//如果id不存在，则不管树内容，直接生成树即可
		if (eleTreeContent.length <= 0) {
			setting = $.extend(true, setting, zSetting);

			var ztree = $.fn.zTree.init(this, setting, zNodes);

			return ztree;
		} else {

			//设置展开与关闭的事件

			setting.callback = {
				onExpand: function (treeId, treeNode) {
					//展开树自动调整右侧尺寸
					var eleTreeListOuterWidth = eleTreeList.outerWidth(),
						documentWidth = $(document).width();
					if (eleTreeListOuterWidth > documentWidth / 2) {
						eleTreeList.css("width", documentWidth / 2);
						eleTreeContent.animate({
							"marginLeft": eleTreeList.outerWidth() + 10
						});
					} else {
						eleTreeList.css("width", "auto");
						eleTreeContent.animate({
							"marginLeft": eleTreeListOuterWidth + 10
						});
					}
				},
				onCollapse: function (treeId, treeNode) {
					eleTreeList.css("width", "auto");
					var eleTreeListOuterWidth = eleTreeList.outerWidth(),
						documentWidth = $(document).width();
					if (eleTreeListOuterWidth > documentWidth / 2) {
						eleTreeList.css("width", documentWidth / 2);
						eleTreeContent.animate({
							"marginLeft": eleTreeList.outerWidth() + 10
						});
					} else {
						eleTreeList.css("width", "auto");
						eleTreeContent.animate({
							"marginLeft": eleTreeListOuterWidth + 10
						});
					}
				}

			}

			setting = $.extend(true, setting, zSetting);

			var ztree = $.fn.zTree.init(this, setting, zNodes);

			//初始化树与树内容布局
			eleTreeContent.css("marginLeft", eleTreeList.outerWidth() + 10);
			//为树设置最大高度
			eleTreeList.css("maxHeight", eleTreeContent.height() - parseInt(eleTreeList.css("paddingTop")) - parseInt(eleTreeList.css("paddingBottom")) - parseInt(eleTreeList.css("borderTop")) - parseInt(eleTreeList.css("borderBottom")));

			return ztree;

		}






	};

	//封装按钮下拉
	$.fn.dropList = function () {
		this.each(function () {
			var droplistOption = $(this).find(".ui-droplist-option");
			var uiSelectboxOption = droplistOption.find(".ui-selectbox-option");
			var btn = $(this).find(".btn");
			var icon = $(this).find(".arrow-selectbox-container");
			var btnInnerWidth = btn.innerWidth();
			droplistOption.css({
				"minWidth": btnInnerWidth,
			});

			if ($(this).is(".arrow-droplist")) {
				icon.bind("click", function (event) {
						event.stopPropagation();

						if (droplistOption.is(":visible")) {

							btn.removeClass("active");
							droplistOption.hide();

						} else {
							$(".ui-droplist-option").hide();
							btn.addClass("active");
							droplistOption.show();
						}


					})
					/*uiSelectboxOption.bind("click", function (event) {
						event.stopPropagation();

						if (droplistOption.is(":visible")) {
							btn.removeClass("active");
							droplistOption.hide();
						} else {
							btn.addClass("active");
							droplistOption.show();
						}
					})*/
			} else {
				$(this).bind("click", function (event) {
					event.stopPropagation();

					if (droplistOption.is(":visible")) {
						btn.removeClass("active");
						droplistOption.hide();
					} else {
						$(".ui-droplist-option").hide();
						btn.addClass("active");
						droplistOption.show();
					}
				})
			}
		});
		//点击空白区域关闭选框事件
		$("html").click(function () {
			$(".ui-droplist-option").hide();
		});

	};

	//封装文本域字数统计 			
	//字数统计以html里设置的maxLength为最高优先级，参数无法覆盖它
	$.fn.wordCount = function (maxlength) {
		this.each(function () {
			//如果HTML标签存在maxlength属性，则以maxlength
			//如果不存在maxlength属性，则以maxlength参数为准

			var maxlengthP = $(this).attr("maxlength");
			var endlength = 0;
			//参数校验
			if (maxlengthP && maxlengthP > 0) {
				endlength = parseInt(maxlengthP);
			} else if (maxlength && parseInt(maxlength) > 0) {
				endlength = parseInt(maxlength)
				$(this).attr("maxlength", endlength);
			} else {
				return false;
			}

			//创建统计数对象
			var countHtml = $("<span>0/" + endlength + "</span>").insertAfter($(this));
			//将目标框之后的所有内容包裹，
			$(this).nextAll().wrapAll("<div style='position:relative;display:inline-block;vertical-align:top;margin-left:4px;height:" + $(this).outerHeight() + "px;'></div>");
			countHtml.css({
				position: "absolute",
				left: 0,
				bottom: 0,
				color: "#d9534f"
			});

			//判断字数,在键盘按下之时，内容输出之前
			$(this).keyup(function () {
				var nowLength = $(this).val().length;
				//显示到P里
				countHtml.text(nowLength + "/" + endlength);
			});

		});
	}
})(jQuery)


$(function () {
	//标签页
	$('[data-toggle=tab]').each(function () {
		var $tabsBtn = $(this).find('.tabs-btn');

		$tabsBtn.bind('click', $tabsBtn, changeTab);
	});
	//标签
	$(document).on('click', '.tags .close', function () {
		$(this).parents('.tags').remove();
	});
});

/**
 * 显示提示
 * @param  {String} tipString 提示字符串
 * @param  {[type]} type      success 绿色 danger 红色 info 蓝色 warning 黄色
 */
function tip(tipString, type) {
	var $dom = $(
		'<div class="dialog alert-tip alert alert-' + type + '">' +
		'<div>' + tipString + '</div>' +
		'</div > '
	);
	var offset = '';

	$('body').append($dom);
	offset = _getCenterPoint($dom);

	$dom.show().css({
		top: 15,
		left: offset.left
	});

	window.setTimeout(function () {
		$dom.fadeOut('fast', function () {
			$dom.remove();
		});
	}, 2000);
}

/**
 * 显示iframe
 * @param  {String} title  标题
 * @param  {String} url    url地址
 * @param  {Number} width  宽度
 * @param  {Number} height 高度
 * @return {Number} index  层级
 */
function showIframe(title, url, width, height) {
	if (typeof $.layer !== 'undefined') {
		if (!title) {
			title = false;
		}
		return $.layer({
			type: 2,
			title: title,
			maxmin: true,
			shadeClose: true,
			area: [width + 'px', height + 'px'],
			iframe: {
				src: url
			}
		});
	}
}

/**
 * 显示dom
 * @param  {String} title  标题
 * @param  {Object} dom    dom
 * @param  {Number} width  宽度
 * @param  {Number} height 高度
 * @return {Number} index  层级
 */
function showDom(title, dom, width, height) {
	if (typeof $.layer !== 'undefined') {
		if (!title) {
			title = false;
		}
		$(dom).find('.form-wrap').width(width - 42).height(height - 77);
		return $.layer({
			type: 1,
			title: title,
			maxmin: false,
			shadeClose: true,
			area: [width + 'px', height + 'px'],
			page: {
				dom: dom
			}
		});
	}
}

/**
 * 显示alert
 * @param  {String} msg    字符串
 * @param  {Number} width  宽度
 * @param  {Number} height 高度
 * @return {Number} index  层级
 */
function showAlert(msg, yes, no) {
	if (typeof $.layer !== 'undefined') {
		return $.layer({
			shade: [0.5, '#000'],
			area: ['auto', 'auto'],
			dialog: {
				msg: msg,
				type: -1,
				btns: 2,
				btn: ['确定', '取消'],
				yes: yes
			}
		});
	}
}

function changeTab(event) {
	event.preventDefault();

	event.data.removeClass('selected');
	$(this).addClass('selected');

	$($(this).attr('href')).siblings().hide()
		.end().show();
}

/**
 * 标签
 * @param  {[type]} config [description]
 * @return {[type]}        [description]
 */
function tags(config) {

}

/**
 * 显示遮罩
 */
function showShade() {
	if ($('body .shade').length) {
		return false;
	} else {
		$('body').append('<div class="shade"></div>')
	}
}
/**
 * 隐藏遮罩
 */
function hideShade() {
	$('body .shade').remove();
}

function _getCenterPoint($dom) {
	return {
		left: $(document).width() / 2 - $dom.outerWidth() / 2,
		top: $(document).height() / 2 - $dom.outerHeight() / 2
	};
}