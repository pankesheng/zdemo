<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin4/stylesheets/common.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin4/stylesheets/table.css?v=${sversion}" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/jquery_form/jquery.form.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/laydate/laydate.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_uploadify/uploadify.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_uploadify/jquery.uploadify.js?t=<@z.z_now />"></script>
	<link rel="stylesheet" href="${contextPath}/ext/jquery_zcj/jquery.zimgslider.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_zcj/jquery.zimgslider.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin4/ext/jquery/selectbox.js"></script>
	<script type="text/javascript" src="${contextPath}/admin4/ext/zw/check.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin4/javascripts/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
</head>
<body>
	<div class="place">
        <span class="label-span">位置：</span>
        <ul id="place-list" class="place-ul">
            <li>首页</li>
        </ul>
    </div>
    <div class="body-warp">
        <div class="panel">
            <div class="panel-title">
                <i class="form-icon"></i>
                <span class="title-text">修改密码</span>
            </div>
            <div class="panel-body">
                <form id="saveform" method="post">
			        <table class="form-table">
			            <tr>
			                <td><label class="form-label" for="oldpassword">原密码<b class="red">*</b></label></td>
			                <td>
			                	<input class="form-control" name="oldpassword" id="oldpassword" type="text" data-check="must" maxlength="20"/>
			                </td>
			            </tr>
			            <tr>
			                <td><label class="form-label" for="newpassword">新密码<b class="red">*</b></label></td>
			                <td>
			                	<input class="form-control" name="newpassword" id="newpassword" type="password" data-check="must|min-len: 4" maxlength="20"/>
			                </td>
			            </tr>
			            <tr>
			                <td><label class="form-label" for="newpassword2">确认密码<b class="red">*</b></label></td>
			                <td>
			                	<input class="form-control" name="newpassword2" id="newpassword2" type="password" data-check="must|min-len: 4|fit: newpassword" maxlength="20"/>
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
function _save() {
	$("#saveform").ajaxSubmit({
		url : '${contextPath}/user/updatepassword.ajax',
		dataType : 'json',
		beforeSubmit : function(formData, jqForm, options) {
			if(!$("#saveform").check())return false;
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
	window.location.href = '${contextPath}/index4/container.do';
}
</script>
</body>
</html>