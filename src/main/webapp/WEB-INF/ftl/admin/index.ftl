<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <title>首页</title>
    <link rel="stylesheet" href="${contextPath}/admin2/stylesheets/common.css" />
    <link rel="stylesheet" href="${contextPath}/admin2/stylesheets/index.css" />
</head>
<body>
    <iframe class="top" src="${contextPath}/admin2/top.html" height="88" frameborder="0" scrolling="no"></iframe>
    <!-- 有top页加class top-iframe-margin -->
    <div id="container" class="container top-iframe-margin">
        <iframe class="container-iframe" src="${contextPath}/index/container.do" scrolling="yes" noresize="noresize" frameborder="0"></iframe>
    </div>
    <div class="top-collapse" id="top-collapse" title="折叠"></div>
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <script>
        $(function(){
            $('#top-collapse').toggle(function() {
                $('#container').css('height', '100%').removeClass('top-iframe-margin');
                $(this).attr('title', '展开').css({
                    top: '0',
                    backgroundPosition: '0 0'
                });
            }, function() {
                $('#container').attr('style', '').addClass('top-iframe-margin');
                $(this).attr('title', '折叠').css({
                    top: '88px',
                    backgroundPosition: '-56px 0'
                });
            });
        });
    </script>
</body>
</html>