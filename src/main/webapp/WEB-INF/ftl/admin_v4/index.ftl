<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>14205</title>
	<link rel="stylesheet" href="${contextPath}/admin4/stylesheets/common.css?v=${sversion}" />
	<link rel="stylesheet" href="${contextPath}/admin4/stylesheets/index.css?v=${sversion}" />
</head>
<body>
    <iframe class="top" src="${contextPath}/index4/top.do" height="88" frameborder="0" name="topFrame"></iframe>
    <!-- 有top页加class top-iframe-margin -->
    <div id="container" class="container top-iframe-margin">
        <iframe class="container-iframe" id="container-iframe" name="contentFrame" src="${contextPath}/index4/container.do" scrolling="yes" noresize="noresize" frameborder="0"></iframe>
    </div>
    <!-- 顶部折叠按钮 不需要请删除 -->
    <a class="top-collapse" id="top-collapse" href="javascript:void(0);" title="折叠"></a>
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/admin4/javascripts/tool.js?v=${sversion}"></script>
    <script>
        var height = 0;
        var leftHeight = 0;

        $(function(){
            /*顶部折叠按钮*/
            $('#top-collapse').toggle(toggleCollapse, toggleExpanding);
        });
        /*折叠顶部*/
        function toggleCollapse (argument) {
            height = $('#container').height();
            $('#container').height($(document).height() - 35).removeClass('top-iframe-margin').css('top', '35px');
            $(this).attr('title', '展开').css({
                top: '35px',
                backgroundPosition: '-7px -29px'
            });
            window.frames['topFrame'].Header.switchingMode();
        }
        /*展开顶部*/
        function toggleExpanding (argument) {
            $('#container').height(height).addClass('top-iframe-margin').attr('style', '');
            $(this).attr('title', '折叠').css({
                top: '88px',
                backgroundPosition: '-7px -2px'
            });
            window.frames['topFrame'].Header.switchingMode();
        }
    </script>
</body>
</html>