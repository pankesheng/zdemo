<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="${contextPath}/admin2/stylesheets/common.css" />
    <link rel="stylesheet" href="${contextPath}/admin2/stylesheets/index.css" />
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
</head>
<body>
    <iframe class="left" src="${contextPath}/index/left.do" scrolling="yes" noresize="noresize" frameborder="0"></iframe>
    <div class="main">
        <div class="place">
            <span class="label-span">位置：</span>
            <ul id="place-list" class="place-ul">
                <li>
                    <a href="#" target="rightFrame">首页</a>
                </li>
            </ul>
        </div>
        <div class="content-wrap">
            <iframe class="content" src="${contextPath}/index/main.do" name="rightFrame" id="rightFrame" frameborder="0" title="rightFrame" ></iframe>
        </div>
    </div>
    <div class="left-collapse" id="left-collapse" title="折叠"></div>
    <!--[if lt IE 8]>
    <script type="text/javascript" src="${contextPath}/ext/DD_belatedPNG/DD_belatedPNG.js"></script>
    <script>
    	DD_belatedPNG.fix('.left-collapse, background');
    </script>
    <![endif]-->
    <script>
        /*路径设置*/
        window.indexObj = {
            setPlaceHistory: function(html){
                $('#place-list').html(html);
            }
        };
        /*向左折叠*/
        $(function(){
            $('#left-collapse').toggle(function() {
                $('.left').width(0);
                $('.main').css({
                    left: '0',
                    width: '100%'
                });
                $(this).attr('title', '展开').css({
                    left: '0',
                    top: '50%',
                    backgroundPosition: '0 -56px'
                });
            }, function() {
                $('.left').width(187);
                $('.main').attr('style', '').css({
                    left: '187px'
                });
                $(this).attr('title', '折叠').css({
                    left: '187px',
                    top: '50%',
                    backgroundPosition: '0 0'
                });
            });
        });
    </script>
</body>
</html>