/**
 * @author Ezios
 * @extends jquery-1.8.3
 * @version 0.0.1
 * @date 2015-1-9
 * @describe
 *     后台管理模块通用库
 *     1.后台AJAX状态码统一管理
 *     2.菜单生成器
 */
(function($) {
    //AJAX状态码
    var _ajaxStatusCode = {
        success: 1,
        error: 0,
        succesProperty: 's',
        dataProperty: 'd',
        namespace: ''
    };
    //方法集
    var _methods = {
        //初始化
        init: function() {
            console.log('call init()');
        },
        //设置AJAX返回状态码
        setOptions: function(options) {
            if (typeof options === 'object') {
                $.extend(_ajaxStatusCode, options);
            }
        },
        //菜单生成器
        initMenu: function(option) {
            //目标dom
            var $doms = $(this);
            //生成器
            var maker = function(item){
                //一级dom
                var $firstNodeDom = $('<div class="left-menu-first-node"><div class="first-title"><i class="first-icon"></i><div class="text">' + item.name + '</div></div><div class="first-children"></div></div>');
                //二级菜单dom
                var $secondNodeDom = $('<div class="left-menu-second-node"><div class="second-title default-second-icon"><i class="second-icon"></i></div></div>');
                //三级菜单dom
                var $thirdNodeDom = $('<ul class="menu-son"></ul>');

                if(! $.isEmptyObject(item.childs)){
                    var secondNode = item.childs;

                    for (var i = 0; i < secondNode.length; i++) {
                        var $secondNodeDomClone = $secondNodeDom.clone();

                         //图标
                        if(secondNode[i].icon){
                            $secondNodeDomClone.find('.second-title').removeClass('default-second-icon').find('.second-icon').append('<img src="' + secondNode[i].icon + '" width="16" height="16" />');
                        }
                        //链接地址
                        if(secondNode[i].url !== '#'){
                            $secondNodeDomClone.find('.second-title').append('<a href="' + secondNode[i].url + '" class="text navigation" target="rightFrame">' + secondNode[i].name + '</a>');
                        }else{
                            $secondNodeDomClone.find('.second-title').append('<span class="text">' + secondNode[i].name + '</span>');
                        }
                        //三级菜单
                        if(! $.isEmptyObject(secondNode[i].childs)){
                            var thirdNode = secondNode[i].childs;
                            var $thirdNodeDomClone = $thirdNodeDom.clone();

                            for (var j = 0; j < thirdNode.length; j++) {
                                var $liclone = $('<li><i class="li-icon"></i><a href="' + thirdNode[j].url + '" class="navigation" target="rightFrame">' + thirdNode[j].name + '</a><span class="right-arrow"></span></li>');

                                //存储数据
                                $liclone.attr('data-path', '<li><span>' + item.name + ' - </span><span>' + secondNode[i].name + ' - </span><a href="' + thirdNode[j].url + '" target="rightFrame">' + thirdNode[j].name + '</a></li>');
                                $thirdNodeDomClone.append($liclone);
                            };

                            $secondNodeDomClone.append($thirdNodeDomClone);
                        }

                        $firstNodeDom.find('.first-children').append($secondNodeDomClone);
                    };
                }

                $doms.append($firstNodeDom);
            };
            //注册器
            var register = function($aim){
                // TO DO 完善路径
                $('.navigation').bind('click', function(event) {
                    if($(this).attr('data-path')){
                        window.parent.indexObj.setPlaceHistory($(this).attr('data-path'));
                    }else{
                        window.parent.indexObj.setPlaceHistory($(this).parent('li').attr('data-path'));
                    }
                });
                //切换菜单显示
                $aim.find('.second-title').bind('click', function(event) {
                    var $children = $(this).parent().find('.menu-son');

                    $aim.find('.menu-son:visible').slideUp();
                    if ($children.is(':visible')) {
                        $children.slideUp();
                    }else{
                        $children.slideDown();
                    }
                    
                });
                //选择
                $aim.find('.menu-son li').bind('click', function(event) {
                    $aim.find('.menu-son li').removeClass('active');
                    $(this).addClass('active');
                });
                //快捷菜单
                $('.left-menu-top .navigation').bind('click', function(event) {
                    $('.left-menu-top .active').removeClass('active');
                    $aim.find('.menu-son:visible').slideUp();
                    $(this).addClass('active');
                    $aim.find('.menu-son .active').removeClass('active');
                });
            };
            var init = function(json){
                if(json.d && ! $.isEmptyObject(json.d)){
                    $doms.html('');

                    for (var i = 0; i < json.d.length; i++) {
                        maker(json.d[i]);
                    };

                    register($doms);
                }else{
                    alert('菜单数据为空');
                }
            };

            if(typeof option === 'string'){
                $.getJSON(option, function(json, textStatus) {
                    if (! $.isEmptyObject(json)) {
                        init(json);
                    }else{
                        alert('获取菜单数据失败');
                    }
                });
            }else if(typeof option === 'object'){
                if (! $.isEmptyObject(option)) {
                    init(option);
                }else{
                    alert('请检查菜单配置项');
                }
            }
        }
    };

    $.fn.zwbam = function(method) {
        if (_methods[method]) { //调用_methods中的方法
            return _methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) { //当参数是对象时 初始化
            return _methods.init.apply(this, arguments);
        } else { //未找到参数指明的方法
            $.error('错误' + method + ' 该方法并未在zwbam中定义');
        }
    };
})(jQuery);