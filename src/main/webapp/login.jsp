<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath() %>/ext/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
	
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
	
	//当前页面的最顶层页面转到登录页面
	z_iframeCheckLogin("<%=request.getContextPath() %>/login.jsp");
</script>
</head>
<body>
<button onclick="location.href='<%=request.getContextPath() %>/index/index.do'">第一套样式入口</button>
<button onclick="location.href='<%=request.getContextPath() %>/index2/index.do'">第二套样式入口</button>
</body>
</html>