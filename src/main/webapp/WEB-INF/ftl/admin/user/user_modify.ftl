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
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/ext/uploadify/uploadify.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/admin/ext/uploadify/jquery.uploadify.min.js?t=<@z.z_now />"></script>
	<link rel="stylesheet" href="${contextPath}/ext/jquery_zcj/jquery.zimgslider.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_zcj/jquery.zimgslider.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin/ext/jquery/selectbox.js"></script>
	<script type="text/javascript" src="${contextPath}/admin/ext/zw/check.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin/javascripts/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
</head>
<body>
<div class="form-wrap">
    <form id="saveform" method="post">
    	<input type="hidden" name="id" value="${(obj.id)!}"/>
        <table class="form-table">
            <tr>
                <td><label class="form-label" for="realname">真实姓名<b class="red">*</b></label></td>
                <td>
                	<input class="form-control" name="realname" id="realname" type="text" data-check="must|min-len: 2" maxlength="10" value="${(obj.realname)!}"/>
                </td>
            </tr>
            <tr>
                <td><label class="form-label" for="role">角色<b class="red">*</b></label></td>
                <td>
                    <select class="form-select" name="role" id="role">
                        <option value="2" <#if (obj.role)?? && obj.role=="2">selected</#if>>普通用户</option>
						<option value="1" <#if (obj.role)?? && obj.role=="1">selected</#if>>超级管理员</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label class="form-label" for="username">账号<b class="red">*</b></label></td>
                <td>
                	<input class="form-control" name="username" id="username" type="text" data-check="must|min-len: 4" maxlength="20" value="${(obj.username)!}"/>
                </td>
            </tr>
            <tr>
                <td><label class="form-label" for="password">密码<b class="red">*</b></label></td>
                <td>
                	<input class="form-control" name="password" id="password" type="text" data-check="must|min-len: 4" maxlength="20" value="${(obj.password)!'888888'}"/>
                </td>
            </tr>
            <tr>
                <td><label class="form-label" for="state">状态<b class="red">*</b></label></td>
                <td>
                    <select class="form-select" name="state" id="state">
                        <option value="1" <#if (obj.state)?? && obj.state=="1">selected</#if>>启用</option>
						<option value="0" <#if (obj.state)?? && obj.state=="0">selected</#if>>冻结</option>
                    </select>
                </td>
            </tr>
            
            <#--
            
            <tr>
                <td><label class="form-label">广告图片</label></td>
                <td>
                	<input type="hidden" name="pictureUrl">
					<div id="addOrModify_imgs"></div>
					<input id="upload1" type="file"/>
                </td>
            </tr>
            
            <tr>
                <td><label class="form-label">有效开始时间</label></td>
                <td>
                    <input class="form-control date" id="beginTime" name="beginTime" type="text" value="${((obj.beginTime)?string("yyyy-MM-dd HH:mm:ss"))!'${.now}'}"/>
                </td>
            </tr>
            
             -->
            
            <tr>
                <td><label class="form-label">&nbsp;</label></td>
                <td>
                    <input class="btn btn-success btn-large" type="button" onclick="_save()" value="提交">
                    <input class="btn btn-danger btn-large" type="reset" value="重置">
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">

<#--

// 提交前设置图片地址
function _initImgPath() {
	var logo = $("#addOrModify_imgs").zImgslider_getImgUrls("${contextPath}");
	if (logo && logo != '') {
		$("input[name='pictureUrl']").val(logo);
	}
}

 -->

function _save() {

	<#--
	
	_initImgPath();
	
	 -->

	$("#saveform").ajaxSubmit({
		url : '${contextPath}/user/modify.ajax',
		dataType : 'json',
		beforeSubmit : function(formData, jqForm, options) {
			if(!$("#saveform").check())return false;
			
			<#--
			
			if($("input[name='pictureUrl']").val()=="") {
				alert("请上传图片");
				return false;
			}
			
			 -->
			
			if(!window.confirm("确定提交?"))return false;
		    return true;
		},
		success : function(data, statusText, xhr) {
			if(data.s){
				window.parent.grid.refresh();
				// 解决IE6下关闭弹窗时焦点丢失的问题
				$("#searchKey", window.parent.document).focus();
				window.parent.layer.closeAll();
			}else{
				z_alert_error(data.d);
			}
		    return true;
		}
	});
}
$(document).ready(function(){

	<#--
	
	// 初始化上传控件
	z_initImgUpload("upload1", "addOrModify_imgs", "${contextPath}", "upload-${.now?string("yyyyMM")}", 1);
	
	// 初始化图片显示
	$("#addOrModify_imgs").zImgslider_init('${contextPath}','${(obj.pictureUrl)!}',true);
	
	laydate({
        elem: '#beginTime',
        event: 'focus',
		format: 'YYYY-MM-DD hh:mm:ss',
		istime: true
    });
	
	 -->

	// 解决IE6下第二次打开弹窗时焦点丢失的问题
	$('#form :input:not(:hidden):not(:button):first').focus();
});
</script>
</body>
</html>