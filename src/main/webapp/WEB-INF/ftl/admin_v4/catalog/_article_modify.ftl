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
	<link rel="stylesheet" type="text/css" href="${contextPath}/admin4/ext/uploadify/uploadify.css" media="screen" />
	<script type="text/javascript" src="${contextPath}/admin4/ext/uploadify/jquery.uploadify.min.js?t=<@z.z_now />"></script>
	<link rel="stylesheet" href="${contextPath}/ext/jquery_zcj/jquery.zimgslider.css?v=${sversion}" />
	<script type="text/javascript" src="${contextPath}/ext/jquery_zcj/jquery.zimgslider.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin4/ext/jquery/selectbox.js"></script>
	<script type="text/javascript" src="${contextPath}/admin4/ext/zw/check.js?v=${sversion}"></script>
	<script type="text/javascript" src="${contextPath}/admin4/javascripts/zcommon.js?v=${sversion}" basepath="${contextPath}" baseinit="ajaxCheckLogin"></script>
	<script type="text/javascript" src="${contextPath}/ext/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" src="${contextPath}/ext/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
	<div class="place">
        <span class="label-span">位置：</span>
        <ul id="place-list" class="place-ul">
            <li>基本功能 - 发布资讯</li>
        </ul>
    </div>
    <div class="body-warp">
        <div class="panel">
            <div class="panel-title">
                <i class="form-icon"></i>
                <span class="title-text">发布资讯</span>
            </div>
            <div class="panel-body">
                <form id="saveform" method="post">
                	<input type="hidden" name="id" value="${(obj.id)!}"/>
			        <table class="form-table">
			            <tr>
			                <td><label class="form-label" for="catalogId">所属栏目<b class="red">*</b></label></td>
			                <td>
			                	<select id="catalogId" name="catalogId" class="form-select" data-check="must">
			                        <option value="">--请选择栏目--</option>
			                        <#list catalogList as cat>
					    			<option value="${cat.id}" <#if (obj?? && obj.catalogId==cat.id)>selected</#if> >${(cat.name)!}</option>
									</#list>
			                    </select>
			                </td>
			            </tr>
			            <tr>
			                <td><label class="form-label" for="title">标题<b class="red">*</b></label></td>
			                <td>
			                	<input class="form-control" name="title" id="title" type="text" data-check="must|min-len: 4" maxlength="100" value="${(obj.title)!}"/>
			                </td>
			            </tr>
			            <tr>
			                <td><label class="form-label" for="titleType">标题显示方式<b class="red">*</b></label></td>
			                <td>
			                	<select id="titleType" name="titleType" class="form-select" data-check="must">
					    			<option value="3" <#if (obj?? && obj.titleType==3)>selected</#if> >纯文字</option>
					    			<option value="1" <#if (obj?? && obj.titleType==1)>selected</#if> >大图+文字</option>
					    			<option value="2" <#if (obj?? && obj.titleType==2)>selected</#if> >小图+文字</option>
			                    </select>
			                </td>
			            </tr>
			            <tr>
			                <td><label class="form-label">标题图片</label></td>
			                <td>
			                	<input type="hidden" name="titleImg">
								<div id="addOrModify_imgs"></div>
								<input id="upload1" type="file"/>
			                </td>
			            </tr>
			            <tr>
			                <td><label class="form-label">内容<b class="red">*</b></label></td>
			                <td>
			                	<script id="editor" name="content" type="text/plain" style="width:800px;height:400px;"><#noescape>${(obj.content)!}</#noescape></script>
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
$(document).ready(function(){

	// 初始化上传控件
	z_initImgUpload("upload1", "addOrModify_imgs", "${contextPath}", "upload-${.now?string("yyyyMM")}", 1);
	
	// 初始化图片显示
	$("#addOrModify_imgs").zImgslider_init('${contextPath}','${(obj.titleImg)!}',true);
});
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
	wordCount : false
});

// 提交前设置图片地址
function _initImgPath() {
	var logo = $("#addOrModify_imgs").zImgslider_getImgUrls("${contextPath}");
	if (logo && logo != '') {
		$("input[name='titleImg']").val(logo);
	}
}
		
function _save() {

	_initImgPath();
	
	$("#saveform").ajaxSubmit({
		url : '${contextPath}/web/article/modify.ajax',
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
	window.location.href = '${contextPath}/web/article/tolist.do';
}
</script>
</body>
</html>