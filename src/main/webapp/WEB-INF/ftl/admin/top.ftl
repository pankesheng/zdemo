<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="${contextPath}/admin/stylesheets/common.css?v=${sversion}" />
    <link rel="stylesheet" href="${contextPath}/admin/stylesheets/index.css?v=${sversion}" />
</head>
<body>
    <div class="header clearfix">
        <div class="function-block">
            <p class="function-list">
                <i class="icon"></i>
                <a class="help" href="#">帮助</a>
                <a class="split" href="${contextPath}/user/password.do" target="contentFrame">修改密码</a>
                <a class="split" href="${contextPath}/index/container.do" target="contentFrame">首页</a>
                <a class="split" href="${contextPath}/user/logout.do" target="_parent">退出</a>
            </p>
            <p class="user">
                <i class="icon"></i>
                <span class="user-name">测试管理</span>
            </p>
        </div>
        <h1 class="web-title">后台管理系统示例</h1>
        <div class="icon-bar clearfix" id="iconBar">
            <div class="icon-list">
                <ul class="icon-ul"></ul>
            </div>
            <div class="next-list">
                <a href="javascript:void(0);" class="next-btn" id="next-btn"></a>
                <ul class="dots-list clearfix"></ul>
                <div class="nums-list">
                    <span class="cur-page">1</span>
                    <span>/</span>
                    <span class="total-page">4</span>
                </div>
            </div>
        </div>
        <div class="mini-list" id="mini-list"></div>
    </div>
    <script type="text/javascript" src="${contextPath}/ext/jquery/jquery-1.8.1.min.js"></script>
    <!--[if lt IE 8]>
    <script type="text/javascript" src="${contextPath}/admin/ext/jquery/jquery.pngFix.js"></script>
    <script>
        //修复IE6 PNG
        var fixpng = function(){
            $(document).pngFix();
        };
    </script>
    <![endif]-->
    <script type="text/javascript" src="${contextPath}/admin/javascripts/jquery-zwbam.js?v=${sversion}"></script>
    <script>
        /*顶部框架暴露对象*/
        var Header = {
            //当前模式
            mode: 'normal',
            /*顶部迷你模式*/
            switchingMode: function(){
                if(this.mode === 'normal'){
                    switchingMiniMode.call(this);
                }else if(this.mode === 'mini'){
                    switchingNormalMode.call(this);
                }
            },
            /*根据标题设置图标*/
            setTopMenu:function(title){
                 $.fn.zwbam('setTopMenu',title);
            },
            /*获取当前选择的右框架链接*/
            getSelectedUrl:function(){
                return $.fn.zwbam('getCurrentSelectedTopMenuUrl');
            }
        };
        $(function(){
            if(window.parent.$('.top').height() === 35){
                Header.switchingMode();
            }
            $('#iconBar').zwbam('initTopMenu', '${contextPath}/index/menutop.ajax?t=<@z.z_now />');
        });
        function switchingMiniMode(){
            this.mode = 'mini';
            $('.function-block').addClass('mini');
            $('.web-title').addClass('mini-title');
            $('.mini-list').show();
            $('.logo').add('.icon-bar').hide();
            window.parent.$('.top').height(35);
        }
        function switchingNormalMode(){
            this.mode = 'normal';
            $('.function-block').removeClass('mini');
            $('.web-title').removeClass('mini-title');
            $('.mini-list').hide();
            $('.logo').add('.icon-bar').show();
            window.parent.$('.top').height(88);
        }
    </script>
</body>
</html>