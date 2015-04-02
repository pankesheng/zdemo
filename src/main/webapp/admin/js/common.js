$.ajaxSetup({
	cache: false //关闭AJAX相应的缓存 
});
/**
 * 修复IE6不支持indexOf函数
 */
if (!Array.indexOf) {
	Array.prototype.indexOf = function(obj) {
		for (var i = 0; i < this.length; i++) {
			if (this[i] == obj) {
				return i;
			}
		}
		return -1;
	}
}
/**
 * 保存地址栏哈希值
 * @param {[string]} moduleId [模块ID]
 * @param {[number]} pageId   [页数]
 */
function setNavPosition(moduleId, pageId) {
	pageId = pageId || '';
	var str = '#' + moduleId;
	if (pageId) {
		str += '/' + pageId;
	}
	location.hash = str;
}
/**
 * 根据链接读取页面
 * @param  {[dom]} $domA [点击的带href属性的a标签]
 */
function loadPage($domA) {
	$('.main iframe').attr('src', $domA.attr('href'));
	$domA.addClass('selected').parents('li').addClass('on').find('.item').slideDown('fast');
	return false;
}
