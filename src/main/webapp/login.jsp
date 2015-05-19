<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/admin/styles/reset.css" media="screen" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/admin/styles/login.css" media="screen" />
<script type="text/javascript" src="<%=request.getContextPath() %>/ext/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/ext/zcommon.js?v=1" basepath="<%=request.getContextPath() %>" baseinit="iframeCheckLogin"></script>
<!--[if lt IE 8]>
<script type="text/javascript" src="<%=request.getContextPath() %>/ext/DD_belatedPNG/DD_belatedPNG.js"></script>        
<script type="text/javascript">
	DD_belatedPNG.fix('.login');
</script>
<![endif]-->
<script type="text/javascript">
function login() {
	var a = $("input[name='username']").val() || "";
	var b = $("input[name='password']").val() || "";
	if ($.trim(a) == "" || $.trim(b) == "") {
		alert("账号或密码不能为空！");
	} else {
		$.ajax({url:"<%=request.getContextPath() %>/user/login.ajax",data:{username:a,password:b},type:"post",dataType:"json", success: function(data){
	        if(data.s!=1){
	          alert(data.d);
	          return;
	        }
	        window.location.href="<%=request.getContextPath() %>/index/index.do";
		}});
	}
}
function login2() {
	var a = $("input[name='username']").val() || "";
	var b = $("input[name='password']").val() || "";
	if ($.trim(a) == "" || $.trim(b) == "") {
		alert("账号或密码不能为空！");
	} else {
		$.ajax({url:"<%=request.getContextPath() %>/user/login.ajax",data:{username:a,password:b},type:"post",dataType:"json", success: function(data){
	        if(data.s!=1){
	          alert(data.d);
	          return;
	        }
	        window.location.href="<%=request.getContextPath() %>/index2/index.do";
		}});
	}
}
function login4() {
	var a = $("input[name='username']").val() || "";
	var b = $("input[name='password']").val() || "";
	if ($.trim(a) == "" || $.trim(b) == "") {
		alert("账号或密码不能为空！");
	} else {
		$.ajax({url:"<%=request.getContextPath() %>/user/login.ajax",data:{username:a,password:b},type:"post",dataType:"json", success: function(data){
	        if(data.s!=1){
	          alert(data.d);
	          return;
	        }
	        window.location.href="<%=request.getContextPath() %>/index4/index.do";
		}});
	}
}
$(document).ready(function(){
	$("input[name='password']").keydown(function(e){
		if(e.which==13){login();return false;}
	});
	$("input[name='username']").keydown(function(e){
        if (e.which == 13) {
        	$("input[name='password']").focus();
            return true;
        }
	});
	$("input[name='username']").focus();
});
</script>
</head>
<body>
<div class="login-box">
    	<div class="login">
        	<p class="login-title">合成作战线索管理平台</p>
        	<div class="login-form">
        	<form>
            	<p><label class="login-label">账号：</label><input type="text" class="login-txt" name="username"/></p>
            	<p><label class="login-label">密码：</label><input type="password" class="login-txt" name="password"/></p>
                <p>
                    <input type="button" onclick="login();" class="login-btn" value="" />
                    <input type="button" onclick="login2();" class="login-btn" value="" />
                    <input type="button" onclick="login4();" class="login-btn" value="" />
                    <!-- <input type="button" class="digital-btn" value="" /> -->
                </p>
            </form>
            </div>
            <div class="copy">V1.0 苍南县公安局</div>
        </div>
    </div>
</body>
</html>