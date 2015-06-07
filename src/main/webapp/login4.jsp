<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title></title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/admin4/stylesheets/common.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/admin4/stylesheets/login.css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/ext/jquery/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/admin4/javascripts/zcommon.js?v=1" basepath="<%=request.getContextPath() %>" baseinit="iframeCheckLogin"></script>
	<script>
		<% if (session.getAttribute("login_info") != null) {%>
		window.location.href="<%=request.getContextPath() %>/index4/index.do";
		<% }%>
	</script>
</head>
<body>
    <table width="100%" height="100%">
        <tbody>
            <tr>
                <td align="center" valign="middle">
                    <div class="login-block">
                        <h1 class="website-title">后台管理系统示例</h1>
                        <div class="login-panel">
                            <h2 class="login-title">用户登录</h2>
                            <div class="login-content">
                                <!-- <div class="login-tip">您输入的账号或密码有误！</div> -->
                                <form>
                                    <div class="form-group">
                                        <input class="form-control" id="account" name="account" type="text" />
                                        <i class="iconfont">&#xe62c;</i>
                                        <div class="placeholder">请输入账号</div>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" id="password" name="password" type="password" />
                                        <i class="iconfont">&#xe62d;</i>
                                        <div class="placeholder">请输入密码</div>
                                    </div>
                                    <div class="form-group clearfix">
                                        <span class="left">
                                            <input class="form-checkbox" id="remember-password" type="checkbox" autocomplete="off" />
                                            <label for="remember-password">记住密码</label>
                                        </span>
                                        <!-- <a class="right" href="##">忘记密码？</a> -->
                                    </div>
                                    <div class="form-group">
                                        <a class="login-submit" href="javascript:void(0);" id="login-submit">登&nbsp;&nbsp;录</a>
                                    </div>
                                    <input class="hide" type="password" />
                                </form>
                            </div>
                        </div>
                        <div class="copyright">
                            <a href="http://www.thanone.com" target="_blank">© 掌网科技 Thanone Inc.</a>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    <script>
        var docCookies = {
            getItem: function(sKey) {
                return decodeURIComponent(document.cookie.replace(new RegExp("(?:(?:^|.*;)\\s*" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=\\s*([^;]*).*$)|^.*$"), "$1")) || null;
            },
            setItem: function(sKey, sValue, vEnd, sPath, sDomain, bSecure) {
                if (!sKey || /^(?:expires|max\-age|path|domain|secure)$/i.test(sKey)) {
                    return false;
                }
                var sExpires = "";
                if (vEnd) {
                    switch (vEnd.constructor) {
                        case Number:
                            sExpires = vEnd === Infinity ? "; expires=Fri, 31 Dec 9999 23:59:59 GMT" : "; max-age=" + vEnd;
                            break;
                        case String:
                            sExpires = "; expires=" + vEnd;
                            break;
                        case Date:
                            sExpires = "; expires=" + vEnd.toUTCString();
                            break;
                    }
                }
                document.cookie = encodeURIComponent(sKey) + "=" + encodeURIComponent(sValue) + sExpires + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "") + (bSecure ? "; secure" : "");
                return true;
            },
            removeItem: function(sKey, sPath, sDomain) {
                if (!sKey || !this.hasItem(sKey)) {
                    return false;
                }
                document.cookie = encodeURIComponent(sKey) + "=; expires=Thu, 01 Jan 1970 00:00:00 GMT" + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "");
                return true;
            },
            hasItem: function(sKey) {
                return (new RegExp("(?:^|;\\s*)" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=")).test(document.cookie);
            },
            keys: /* optional method: you can safely remove it! */ function() {
                var aKeys = document.cookie.replace(/((?:^|\s*;)[^\=]+)(?=;|$)|^\s*|\s*(?:\=[^;]*)?(?:\1|$)/g, "").split(/\s*(?:\=[^;]*)?;\s*/);
                for (var nIdx = 0; nIdx
                < aKeys.length; nIdx++) {
                    aKeys[nIdx] = decodeURIComponent(aKeys[nIdx]);
                }
                return aKeys;
            }
        };
        
        $(function() {
            loadCookies();
            removePlaceholder();
            addListeners();
        });

        /*移除输入框提示*/
        function removePlaceholder () {
            if (navigator.userAgent.toLowerCase().indexOf("chrome") >= 0) {
                $('input:-webkit-autofill').each(function(){
                    var text = $(this).val();
                    var name = $(this).attr('name');
                    $(this).after(this.outerHTML).remove();
                    $('input[name=' + name + ']').val(text);
                });
            }
            $('.form-control').each(function(index, el) {
                if($(this).val().length !== 0){
                    $(this).siblings('.placeholder').hide();
                }
            });
        }
        /*侦听器*/
        function addListeners () {
            /*placeholder相关*/
            $('.form-control').focus(function(event) {
                $(this).siblings('.placeholder').hide();
            });
            $('.placeholder').click(function(event) {
                $(this).siblings('.form-control').focus();
            });
            $('.form-control').blur(function(event) {
                if($(this).val().length === 0){
                    $(this).siblings('.placeholder').show();
                }
            });
            /*表单提交*/
            $('#login-submit').bind('click', function(){
                //cookies
                if($('#remember-password').is(':checked')){
                    docCookies.setItem('account', $('#account').val(), Infinity);
                    docCookies.setItem('password', $('#password').val(), Infinity);
                }else{
                    docCookies.removeItem('account');
                    docCookies.removeItem('password');
                }

                login();
            });
        }

        function loadCookies (argument) {
            var account = docCookies.getItem('account');
            var password = docCookies.getItem('password');

            if(account && password){
                $('#account').val(account);
                $('#password').val(password);
                $('#remember-password').prop('checked', true);
            }
        }
        
        function login() {
        	var a = $("#account").val() || "";
        	var b = $("#password").val() || "";
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
    </script>
</body>
</html>