<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/stylesheets/common.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/stylesheets/table.css?v=${sversion}" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/jquery_form/jquery.form.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/laydate/laydate.js"></script>
	
	<#-- 图片功能 -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/ext/uploadify/uploadify.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/admin/ext/uploadify/jquery.uploadify.min.js?t=<@z.z_now />"></script>
	<link rel="stylesheet" href="${contextPath}/ext/jquery_zcj/jquery.zimgslider.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_zcj/jquery.zimgslider.js?v=${sversion}"></script>
	
	<script type="text/javascript" src="${contextPath}/admin/ext/jquery/selectbox.js"></script>
	<script type="text/javascript" src="${contextPath}/admin/ext/zw/check.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin/javascripts/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>

	<#-- 编辑器功能 -->
	<script type="text/javascript" src="${contextPath}/ext/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/ueditor/lang/zh-cn/zh-cn.js"></script>
	
</head>
<body>
<div class="place">
    <span class="label-span">位置：</span>
    <ul id="place-list" class="place-ul">
        <li>XX</li>
    </ul>
</div>
<div class="body-warp">
    <div class="panel">
        <div class="panel-title">
            <i class="form-icon"></i>
            <span class="title-text">XXXX</span>
        </div>
        <div class="panel-body">
		    <form id="saveform" method="post">
		    	<input type="hidden" name="id" value="${(obj.id)!}"/>
		        <table class="form-table">
		            <tr>
		                <td><label class="form-label">用户名<b class="red">*</b></label></td>
		                <td>
		                	<input class="form-control" name="username" type="text" data-check="must|min-len: 2" maxlength="10" value="${(obj.username)!}"/>
		                </td>
		            </tr>
		            <tr>
		                <td><label class="form-label">密码<b class="red">*</b></label></td>
		                <td>
		                	<input class="form-control" name="password" type="text" data-check="must|min-len: 4" maxlength="20" value="${(obj.password)!'888888'}"/>
		                </td>
		            </tr>
		            <tr>
						<td><label class="form-label">URL地址</label></td>
						<td>
							<span class="form-hint">HTTP://</span>
							<input class="form-control" name="url" type="text" style="width:281px" value="${(obj.url)!}"/>
						</td>
					</tr>
					
					<#-- 图片功能 -->
					<tr>
		                <td><label class="form-label">图片<b class="red">*</b></label></td>
		                <td>
		                	<input type="hidden" name="imgs">
							<div id="addOrModify_imgs"></div>
							<input id="upload1" type="file"/>
		                </td>
		            </tr>
		            
		            <tr>
		                <td><label class="form-label">时间</label></td>
		                <td>
		                    <input class="form-control date" id="theTime" name="theTime" type="text" value="${((obj.theTime)?string("yyyy-MM-dd HH:mm:ss"))!'${.now}'}"/>
		                </td>
		            </tr>
		            <tr>
		                <td><label class="form-label">角色<b class="red">*</b></label></td>
		                <td>
		                    <select class="form-select" name="role">
		                        <option value="2" <#if (obj.role)?? && obj.role=="2">selected</#if>>普通用户</option>
								<option value="1" <#if (obj.role)?? && obj.role=="1">selected</#if>>超级管理员</option>
		                    </select>
		                </td>
		            </tr>
		            <tr>
		                <td><label class="form-label">状态<b class="red">*</b></label></td>
		                <td>
		                    <select class="form-select" name="valid">
		                        <option value="1" <#if (obj.valid)?? && obj.valid=="1">selected</#if>>启用</option>
								<option value="0" <#if (obj.valid)?? && obj.valid=="0">selected</#if>>冻结</option>
		                    </select>
		                </td>
		            </tr>
		            <tr class="valign-top">
						<td><label class="form-label">描述</label></td>
						<td>
							<textarea class="form-textarea" name="descr">${(obj.descr)!}</textarea>
						</td>
					</tr>
					
					<#-- 编辑器功能 -->
					<tr class="valign-top">
						<td><label class="form-label">编辑器</label></td>
						<td>
							<script id="editor" name="content" type="text/plain" style="width:800px;height:300px;"><#noescape>${(obj.content)!}</#noescape></script>
						</td>
					</tr>
					
		            <tr>
		                <td><label class="form-label">&nbsp;</label></td>
		                <td>
		                    <input class="btn btn-success btn-large" type="button" onclick="_save()" value="提交">
		                    <input class="btn btn-danger btn-large" type="reset" value="重置">
		                    <input class="btn btn-danger btn-large return-btn" type="button" onclick="_back()" value="返回">
		                </td>
		            </tr>
		        </table>
		    </form>
        </div>
    </div>
</div>
<script type="text/javascript">

<#-- 编辑器功能 -->
var prefix = "${contextPath}";
var ue = UE.getEditor('editor', {
	toolbars : [ [ 'fullscreen', 'source', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough',
			'removeformat', '|', 'forecolor', 'insertorderedlist', 'insertunorderedlist', '|', 'fontfamily',
			'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'link', 'unlink', '|',
			'simpleupload', 'insertimage', 'insertvideo', 'attachment', '|', 'wordimage',
			'inserttable', 'preview' ] ],
	"imageUrlPrefix" : prefix,
	"scrawlUrlPrefix" : prefix,
	"snapscreenUrlPrefix" : prefix,
	"catcherUrlPrefix" : prefix,
	"videoUrlPrefix" : prefix,
	"fileUrlPrefix" : prefix,
	elementPathEnabled : false,
	saveInterval : 3600000,
	wordCount : false
});

<#-- 图片功能 -->
// 提交前设置图片地址
function _initImgPath() {
	var logo = $("#addOrModify_imgs").zImgslider_getImgUrls("${contextPath}");
	if (logo && logo != '') {
		$("input[name='imgs']").val(logo);
	}
}

function _save() {

	<#-- 图片功能 -->
	_initImgPath();
	
	$("#saveform").ajaxSubmit({
		url : '${contextPath}/example/modify.ajax',
		dataType : 'json',
		beforeSubmit : function(formData, jqForm, options) {
			if(!$("#saveform").check())return false;

			<#-- 图片功能 -->
			if($("input[name='imgs']").val()=="") {
				alert("请上传图片");
				return false;
			}

			if(!window.confirm("确定提交?"))return false;
		    return true;
		},
		success : function(data, statusText, xhr) {
			if(data.s){
				z_alert_success(data.d||"操作成功！");
				_back();
			}else{
				z_alert_error(data.d);
			}
		    return true;
		}
	});
}
function _back() {
	window.location.href = '${contextPath}/example/tolist.do';
}
$(document).ready(function(){

	<#-- 图片功能 -->
	// 初始化上传控件，8张及以内可以正常显示
	z_initImgUpload("upload1", "addOrModify_imgs", "${contextPath}", "upload-${.now?string("yyyyMM")}", 8);
	
	<#-- 图片功能 -->
	// 初始化图片显示
	$("#addOrModify_imgs").zImgslider_init('${contextPath}','${(obj.imgs)!}',true);
	
	laydate({
        elem: '#theTime',
        event: 'focus',
		format: 'YYYY-MM-DD hh:mm:ss',
		istime: true
    });
});
</script>
</body>
</html>