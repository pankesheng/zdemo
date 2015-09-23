<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_mobile/jquery.mobile.icons-1.4.5.min.css" media="screen" />
<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_mobile/theme-classic.css" media="screen" />
<link rel="stylesheet" type="text/css" href="${contextPath}/ext/jquery_mobile/jquery.mobile.structure-1.4.5.min.css" media="screen" />
<script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/ext/jquery_mobile/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
	<div data-role="page" data-title="瓯海教育网 - ${(obj.title)!}" data-theme="c">
		<div data-role="header" data-theme="b">
			<a data-role="button" data-icon="back" data-iconpos="notext" data-rel="back">返回</a>
			<h1>瓯海教育网</h1>
		</div>
		<div data-role="content">
			<div class="ui-body ui-body-c ui-corner-all">
				<h3>${(obj.title)!}</h3>
				<p style="color: #666666">${((obj.showtime)?string("yyyy-MM-dd"))!} ${(obj.userName)!}</p>
				<font size="4">${(obj.context)!}</font>
			</div>
		</div>
		<div data-role="footer" data-theme="b">
			<h4>主办单位：温州市瓯海区教育局</br>浙ICP备05082032号</h4>
		</div>
	</div>
</body>
</html>