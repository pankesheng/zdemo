<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/reset.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/common.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/form.css?v=${sversion}" media="screen" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin/styles/button.css?v=${sversion}" media="screen" />
	
	<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/json/json2.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_validform/style.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_validform/Validform_v5.3.2.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/laydate/laydate.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
</head>
<body>
<div class="space">
	<form id="form" action="${contextPath}/user/updatepassword.ajax" method="post">
		<table class="form">
			<tr>
				<td class="label"><label><b>*</b>原密码：</label></td>
				<td><input datatype="*" type="text" name="oldpassword" maxlength="20" size="20"></td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>新密码：</label></td>
				<td><input datatype="*4-20" type="password" id="newpassword" name="newpassword" maxlength="20" size="20"></td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>确认密码：</label></td>
				<td><input datatype="*4-20" recheck="newpassword" type="password" id="newpassword2" name="newpassword2" maxlength="20" size="20"></td>
			</tr>
		</table>
	    <div style="overflow:hidden; height:10px;"></div>
	    <table id="buttons" class="form">
	        <tr>
	            <td class="label"><label class="label">&nbsp;</label></td>
	            <td>
	                <input type="submit" class="c-btn primary-label" value="修改">
	            </td>
	        </tr>
	    </table>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$("#form").Validform({
			tiptype: '4',
			tipSweep:true,// 默认为false，为true时提示信息将只会在表单提交时触发显示，各表单元素blur时不会触发信息提示。
			showAllError:true,// 默认为false，true：提交表单时所有错误提示信息都会显示；false：一碰到验证不通过的对象就会停止检测后面的元素，只显示该元素的错误信息。
			postonce:true,// 默认为false，指定是否开启二次提交防御，true开启，不指定则默认关闭；为true时，在数据成功提交后，表单将不能再继续提交。
			ajaxPost:true,
			beforeSubmit:function(curform){
			},
			callback:function(data){
				if(data.s){
					alert(data.d||"操作成功！");
				}else{
					alert(data.d);
				}
			}
		});
		
		$('#form :input:not(:hidden):not(:button):first').focus();
	});
</script>
</body>
</html>