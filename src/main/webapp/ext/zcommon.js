
// 此JS已弃用

// 后台管理系统各页面引入

// 参数
// 		basepath : 根路径，默认""。
//		loginpath : 登陆页的相对路径，默认"/login.jsp"。
//		baseinit : 默认调用哪个方法。可取值：iframeCheckLogin、ajaxCheckLogin。
var _z_basepath=$("script:last").attr("basepath")||"";
var _z_loginpath=$("script:last").attr("loginpath")||"/login.jsp";
var _z_baseinit=$("script:last").attr("baseinit")||"";

if (_z_baseinit == "iframeCheckLogin") {
	z_iframeCheckLogin(_z_basepath+_z_loginpath);
} else if (_z_baseinit == "ajaxCheckLogin") {
	z_ajaxCheckLogin(_z_basepath+_z_loginpath);
}

// 内页调用：验证当前AJAX请求时的登陆状态，如果未登陆，则转到登陆页面
// z_ajaxCheckLogin("/ohedu/login.jsp");
function z_ajaxCheckLogin(loginPage) {
	$(document).ajaxSuccess(function(evt, request, settings){
		   var d=jQuery.parseJSON(request.responseText);
		   if(d.s==2){
			   var ws=_getParents();
			   var w=ws.pop();
			   if(w) {
				   w.location.href=loginPage;
			   } else {
				   window.location.href=loginPage;
			   }
		   }
	});
}

// 登录页调用：当前页面的最顶层页面转到登录页面
// z_iframeCheckLogin("/ohedu/login.jsp");
function z_iframeCheckLogin(loginPage) {
	var ws=_getParents();
	var w=ws.pop();
	if(w) {
		w.location.href=loginPage;
	}
}

function _getParents(w){//获取父级win 
	w=w||window;
	var p=w.parent,ws=[];
	while(p!=w&&p){
	   ws.push(p);
	   w=p;p=p.parent;
	}
	return ws;
}

// 初始化图片上传功能
// z_initImgUpload("upload1", "addOrModify_imgs", "${contextPath}", "Downloads-zt", 1);
function z_initImgUpload(uploadButtonId, imgListId, basePath, saveCatalog, maxCount) {
	
	var multi = false;
	if (maxCount && maxCount > 1) {
		multi = true;
	}
	
	$('#'+uploadButtonId).uploadify({
		
		uploader: basePath+'/file/upload.ajax',
		formData: { type: saveCatalog },
		swf: basePath+'/ext/jquery_uploadify/uploadify.swf',
		
		buttonText: '上传',
		removeTimeout: 0.1,
		
		multi: multi,
		fileSizeLimit: '20MB',// 文件大小限制
		fileTypeExts: '*.gif;*.jpg;*.png;*.bmp;*.jpeg',// 默认为所有类型
		
		onUploadSuccess: function(file, data, response){
			var data2 = JSON.parse(data);
			if(data2.s){
				$("#"+imgListId).zImgslider_addImg(basePath,data2.d.savePath,maxCount);
			}else{
				alert(data2.d);
			}
		}
	});
}

//初始化文件上传功能
// z_initFlieUpload("upload2", "${contextPath}", "Downloads-zt", "linkUrl");
function z_initFlieUpload(uploadButtonId, basePath, saveCatalog, resultPathInputId) {
	
	$('#'+uploadButtonId).uploadify({
		
		uploader: basePath+'/file/upload.ajax',
		formData: { type: saveCatalog },
		swf: basePath+'/ext/jquery_uploadify/uploadify.swf',
		
		// buttonImage: basePath+'/ext/jquery_uploadify/upload-btn.png',
		buttonText: '上传',
		removeTimeout: 0.1,
		// width : 100,
		// height : 32,
		
		multi: false,
		fileSizeLimit: '100MB',// 文件大小限制
		// fileTypeExts: '*.gif;*.jpg;*.png;*.bmp;*.jpeg',// 默认为所有类型
		
		onUploadSuccess: function(file, data, response){
			var data2 = JSON.parse(data);
			if(data2.s){
				$("#"+resultPathInputId).val(basePath+data2.d.savePath);
			}else{
				alert(data2.d);
			}
		}
		
	});
}

// 弹出窗口
// 依赖插件：layer
function z_openIframe(title, width, height, src) {
	//如果没有附加参数
	if (src.indexOf('?') == -1) {
		src += '?n=' + Math.random();
	} else {
		src += '&n=' + Math.random();
	}
	
	$.layer({
		type: 2,// 0：信息框（默认），1：页面层，2：iframe层，3：加载层，4：tips层。
		maxmin: true,// 是否输出窗口最小化/全屏/还原按钮。 
		shadeClose: false,// 用来控制点击遮罩区域是否关闭层。
		title: title,
		area: [width+'px', height+'px'],
		iframe: {
			src: src
		}
	});
}

// 操作
// 依赖插件：layer
function z_oper(dataString, url, oper) {
	if (dataString.length == 0) {
		layer.alert('请选择至少一条记录！', 8);
		return false;
	}
	var theUrl = url + '?' + dataString;
	if (url.indexOf("?") > 0) {
		theUrl = url + '&' + dataString;
	}
	layer.confirm('确认'+oper+'？', function() {
		$.post(theUrl, function(data){
			if(data.s!=1){
				layer.alert(data.d, 8);
	        } else {
	        	grid.reload();
				layer.closeAll();
				alert(data.d||"操作成功！");
	        }
		}, "json");
	});
}

// 删除
// 依赖插件：layer
function z_delete(dataString, url) {
	z_oper(dataString, url, "删除");
}
