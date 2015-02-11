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
/*打开框架弹窗
 * @param title 弹窗标题 字符串
 * @param area 区域大小 数组
 * @example ['420px', '420px']
 * @param src 路径 字符串
 * */
function openIframe(title, area, src) {
	//如果没有附加参数
	if (src.indexOf('?') == -1) {
		src += '?n=' + Math.random();
	} else {
		src += '&n=' + Math.random();
	}

	$.layer({
		type: 2,
		maxmin: true,
		shadeClose: true,
		title: title,
		area: area,
		iframe: {
			src: src
		}
	});
}
/*删除
 * @param dataString 拼接好的参数字符串
 * @example param=1&param=2
 * @param url 接口 字符串
 */
function deleteMethod(dataString, url) {
	if (dataString.length == 0) {
		layer.alert('请选择至少一条记录！', 8);
		return false;
	}

	layer.confirm('确认删除选定记录？', function() {
		$.getJSON(url + '?' + dataString, function(json, textStatus) {
			if (json.s) {
				grid.reload();
				layer.closeAll();
			} else {
				layer.alert(json.d, 8);
			}
		});
	});
}
/**
 * 保持图片纵横比
 * @param {[dom]} ImgD    [dom对象]
 * @param {[number]} maxSize [最大宽度]
 */
function DrawImage(ImgD, maxSize) {
	if (ImgD.width > 0 && ImgD.height > 0) {
		if (ImgD.width / ImgD.height >= 1) {
			if (ImgD.width > maxSize) {
				ImgD.width = maxSize;
				ImgD.height = (ImgD.height * maxSize) / ImgD.width;
			}
		} else {
			if (ImgD.height > maxSize) {
				ImgD.height = maxSize;
				ImgD.width = (ImgD.width * maxSize) / ImgD.height;
			}
		}
	}
}

/** 
 * 图片居中显示
 * @param ImgD
 * @param iwidth
 * @param iheight
 */
function zDrawImage(ImgD,iwidth,iheight){
	var image=new Image();

	image.src=ImgD.src;

	if(image.width > 0 && image.height > 0){
		if(image.width/image.height >= iwidth/iheight){
			if(image.width>iwidth){
				ImgD.width=iwidth;
				ImgD.height=(image.height*iwidth)/image.width;
			}else{
				ImgD.width=image.width;
				ImgD.height=image.height;
			}
		}
		else{
			if(image.height>iheight){
				ImgD.height=iheight;
				ImgD.width=(image.width*iheight)/image.height;
			}else{
				ImgD.width=image.width;
				ImgD.height=image.height;
			}
		}
	}
}