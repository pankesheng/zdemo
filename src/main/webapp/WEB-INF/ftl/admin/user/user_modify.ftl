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
	<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_uploadify/uploadify.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_uploadify/jquery.uploadify.js?t=<@z.z_now />"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_validform/style.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_validform/Validform_v5.3.2.js"></script>
	<link rel="stylesheet" href="${contextPath}/ext/jquery_zcj/jquery.zimgslider.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_zcj/jquery.zimgslider.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/ext/laydate/laydate.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/layer/layer.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
</head>
<body>
<div class="space">
	<form id="form" action="${contextPath}/user/modify.ajax" method="post">
		<input type="hidden" name="id" value="${(obj.id)!}"/>
		<table class="form">
			<tr>
				<td class="label"><label><b>*</b>真实姓名：</label></td>
				<td><input datatype="*" type="text" name="realname" size="20" value="${(obj.realname)!}">&nbsp;<input type="checkbox" name="state" value="1" <#if !(obj??) || ((obj.state)!0)==1>checked</#if>>启用</td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>角色：</label></td>
				<td>
					<select size="1" name="role">
						<option value="2" <#if (obj.role)?? && obj.role=="2">selected</#if>>普通用户</option>
						<option value="1" <#if (obj.role)?? && obj.role=="1">selected</#if>>超级管理员</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>账号：</label></td>
				<td><input datatype="*4-20" type="text" name="username" size="20" value="${(obj.username)!}"></td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>密码：</label></td>
				<td><input datatype="*4-20" type="text" name="password" size="20" value="${(obj.password)!'888888'}"></td>
			</tr>
			<#-- 
			<tr>
				<td class="label"><label><b>*</b>排序号：</label></td>
				<td><input datatype="*,n" type="text" name="orders" size="20" value="${(obj.orders)!}"></td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>链接地址：</label></td>
				<td><input datatype="*" type="text" name="url" size="20" value="${(obj.url)!}"></td>
			</tr>
			<tr>
				<td class="label"><label>信息内容：</label></td>
				<td>
				    <input type="hidden" id="context" name="context" value="${((obj.context)!)?html}">
				    <IFRAME ID="eWebEditor1" SRC="${contextPath}/ewebeditor/ewebeditor.htm?id=context&style=standard600" FRAMEBORDER="0" SCROLLING="no" WIDTH="600" HEIGHT="350"></IFRAME>
				</td>
			</tr>
			<tr>
				<td class="label"><label>外部链接地址：</label></td>
				<td>
					<input type="text" size="50" value="${(obj.linkUrl)!}" id="linkUrl" name="linkUrl">
					<input id="upload2" type="file"/>
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>文件：</label></td>
				<td>
					<input type="hidden" name="logo">
					<div id="addOrModify_imgs"></div>
					<input id="upload1" type="file"/>
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="label"><label><b>*</b>发表时间：</label></td>
				<td><input id="showtime" datatype="*" type="text" name="showtime" size="20" value="${((obj.showtime)?string("yyyy-MM-dd HH:mm:ss"))!'${.now}'}"></td>
			</tr>
			 -->
		</table>
	    <div style="overflow:hidden; height:10px;"></div>
	    <table id="buttons" class="form">
	        <tr>
	            <td class="label"><label class="label">&nbsp;</label></td>
	            <td>
	                <input type="submit" class="c-btn primary-label" value="保存">
	                <input type="reset" class="c-btn primary-label" value="重置">
	                <#-- <input type="button" onclick="location.href='${contextPath}/user/tolist.do'" class="c-btn primary-label" value="返回"> -->
	            </td>
	        </tr>
	    </table>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function(){
	
		<#-- // 初始化上传控件
		z_initImgUpload("upload1", "addOrModify_imgs", "${contextPath}", "Downloads-AD", 1);
			
		z_initFlieUpload("upload2", "${contextPath}", "Downloads-zt", "linkUrl");
			
		// 初始化图片显示
		$("#addOrModify_imgs").zImgslider_init('${contextPath}','${(obj.logo)!}',true); -->

		$("#form").Validform({
			tiptype: '4',
			ajaxPost:true,
			beforeSubmit:function(curform){
				<#-- var logo = $("#addOrModify_imgs").zImgslider_getImgUrls("${contextPath}");
				if (logo && logo != '') {
					$("input[name='logo']").val(logo);
				} else {
					alert("请上传图片！");
					return false;
				}
				try {
					$("#context").val(eWebEditor1.getHTML());
				} catch (e) {
					alert("获取编辑器内容失败");
				} -->
			},
			callback:function(data){
				if(data.s){
					window.parent.grid.reload();
					// 解决IE6下关闭弹窗时焦点丢失的问题
					$("#searchKey", window.parent.document).focus();
					window.parent.layer.closeAll();
					
					// window.location.href = '${contextPath}/ztTopicArticle/tolist.do';
				}else{
					alert(data.d);
				}
			}
		});
		
		<#-- //时间控件
		laydate({
		    elem: '#showtime', //目标元素。
		    event: 'focus', //响应事件。
		    format: 'YYYY-MM-DD hh:mm:ss',
		    festival: false
		}); -->
		
		// 解决IE6下第二次打开弹窗时焦点丢失的问题
		$('#form :input:not(:hidden):not(:button):first').focus();
	});
</script>
</body>
</html>