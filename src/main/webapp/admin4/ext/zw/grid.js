/**
 * @author Ezios
 * @class grid
 * @extends jquery-1.8.3
 * @markdown
 * #表格插件
 * 版本 1.5.4 日期 2015-4-3
 * 配置项详见Config options
 *
 * 示例：
 *
 *     @example
 *     var grid = $('dom').grid({
 *         store: {
 *             url: ''
 *         },
 *         columns: []
 *     });
 *
 *     grid.getSelected();
 *     grid.refresh();
 *
 * <p>ajax模式数据示例:</p>
 * 
 *      @example
 *     {
 *         s: 1,
 *         d: [],
 *         total: 0
 *     }
 *
 * 字段可以自定义 
 * s 成功标志
 * d 数据
 * total 总数
 *      
 */
;!(function($) {
    "use strict";

    var MyGrid = function($dom, config) {
        var me = this;

        this.$me = $dom;
        //当前页数
        this.curPage = 0;
        //缓存参数
        this.ajaxParams = '';
        //默认配置项
        this.defaults = {
            /**
             * @cfg {Object} [store] (required) 数据配置
             * @cfg {Boolean} [store.autoLoad] 是否自动加载
             * @cfg {Object} [store.params] 额外参数 固定的额外参数 不会被清除
             * @cfg {Object} [store.data] 本地数据 url和data都存在时取url
             * @cfg {String} [store.type] 请求方式 'GET'或'POST' 默认'POST'
             * @cfg {String} [store.url] 请求地址
             * @cfg {Number} [store.pagesize] 每页记录数
             * @cfg {String} [store.totalProperty] 总页数字段名 默认： total
             * @cfg {String} [store.dataProperty] 数据数组字段名 默认： d
             * @cfg {String} [store.successProperty] 请求成功标志字段名 默认： s 1代表成功 其他值代表失败 失败时返回的d值将作为提示信息
             * @cfg {Boolean} [store.sortable] 该列是否允许排序 点击该表头将依次发送 降序、升序、默认等参数
             *
             *     降序:/users?sort=account&asc=true&offset=0&limit=10
             * 
             *     升序:/users?sort=account&asc=false&offset=0&limit=10
             * 
             *     默认:/users?sort=account&asc=false&offset=0&limit=10
             */
            store: {
                //自动加载
                autoLoad: true,
                //请求地址
                url: '',
                //额外参数
                extraParams: {},
                //本地数据
                data: {},
                //请求方式
                type: 'POST',
                //每页多少记录
                pagesize: 10,
                //总页数字段名
                totalProperty: 'total',
                //数组字段名
                dataProperty: 'd',
                //成功标志字段
                successProperty: 's',
                //排序
                sortable: false
            },
            /**
             * @cfg {Object} [columns] (required) 表格模型
             * @cfg {String} [columns.title] (required) 表头标题
             * @cfg {Object} [columns.dataIndex] 数据字段 级联对象请使用 .操作符
             *
             *      $('dom').grid({
             *          columns: [{
             *              dataIndex: 'user.info.sex'
             *          }]
             *      });
             * @cfg {Number} [columns.width] 宽度
             * @cfg {String} [columns.align] 对齐方式 'center','left','right'，默认：'center'
             * @cfg {Boolean} [columns.nowrap] 值为true时强制不换行 默认： false
             * @cfg {String} [columns.totalProperty] 总页数字段名 默认： total
             * @cfg {Function} [columns.renderer] 渲染函数
             *      <p>-cellData 单元格数据 当dataIndex属性存在时才有值</p>
             *      <p>-rowData 行数据</p>
             *      <p>-grid grid对象</p>
             *      <p>-cellIndex 列序号</p>
             *      <p>-rowIndex 行序号</p>
             *
             *      renderer: function(cellData, rowData, grid, cellIndex, rowIndex){
             *          console.log('dataIndex对应的数据 ', cellData);
             *          console.log('本行对应的数据 ', rowData);
             *          console.log('当前页 ', grid.getCurPage());
             *          console.log('列序号 ', cellIndex);
             *          console.log('行序号', rowIndex);
             *      }
             * @cfg {Object} [columns.formatter] 格式化
             *
             *      columns: [{
             *          formatter: {
             *              //长度限制
             *              length: 10
             *          }
             *      }]
             */
            columns: [{
                //标题
                title: '表头',
                //字段
                dataIndex: '',
                //宽度
                width: '',
                //对齐方式
                align: 'center',
                //换行
                nowrap: false
                //格式化函数
                // renderer: function() {}
            }],
            /**
             * @cfg {Object} tool 工具
             * @cfg {Boolean} [tool.checkboxSelect] 值为true时启用单选框
             * @cfg {Boolean} [tool.tableTip] 值为true时启用提示
             * @cfg {Boolean} [tool.pagingBar] 值为true时启用分页 排序参数为 偏移值offset 条数limit
             * @cfg {Number} [tool.pagingBtnNum] 显示的按钮数
             * @cfg {String} [tool.pagingCls] 插入分页按钮的DOM元素的class
             * @cfg {String} [tool.pagingInfoCls] 显示分页信息的DOM元素的class
             * @cfg {String} [tool.pagingSizeCls] 分页条数设置的DOM元素的class
             * @cfg {String} [tool.pagingJumpCls] 分页跳转的DOM元素的class
             */
            tool: {
                //启用选框
                checkboxSelect: true,
                //提示
                tableTip: true,
                //分页
                pagingBar: false,
                //分页按钮数
                pagingBtnNum: 5,
                //分页样式
                pagingCls: 'pagination',
                //分页信息样式
                pagingInfoCls: 'page-info',
                //分页条数设置样式
                pagingSizeCls: 'pagesize-value',
                //分页跳转
                pagingJumpCls: 'jump-select'
            },
            event: {}
        };
        //数据仓库
        this.store = new Array();
        //操作对象
        this.gridObj = {
            /**
             * @property {Object} 配置项
             *
             *
             *     alert(grid.config);
             */
            config: config,
            /**
             * 添加记录
             * @param  {Object} data 数据对象
             *
             *     @example
             *     grid.addRecord({
             *         "_id": "5518b89dbc547f6c18c98dff",
             *         "account": "123123",
             *         "password": "7c4a8d09ca3762af61e59520943dc26494f8941b",
             *         "__v": 0,
             *         "phone": "123",
             *         "role": 2,
             *         "sex": "123",
             *         "name": "123123"
             *     });
             */
            addRecord: function(data){
                me.$me.append(me.generateTableRow(data, me.$me.find('tr:not(.table-head)').length));
                //数据为空时添加数据移除提示信息
                if(me.store.length === 0){
                    //渲染表头
                    me.renderTableHead();

                    //初始化工具
                    me.initTool();
                }

                me.store.push({
                    rowIndex: me.store.length,
                    data: data
                });
                //移除空提示
                me.tableTip('hideTip');
            },
            /**
             * 以原有参数刷新表格。
             */
            refresh: function() {
                //载入当前页
                me.loadPage(me.curPage);
            },
            /**
             * 根据参数重新加载表格，之前的参数将被清除，并重新渲染表头，并返回第一页。
             * @param  {Object} params 参数对象
             *
             *     @example
             *     grid.load({
             *         filter: 'name'
             *     });
             */
            load: function(params) {
                me.loadPage(1, params);
            },
            /**
             * 载入第一页。
             */
            firstPage: function(){
                me.loadPage(1);
            },
            /**
             * 载入最后一页。
             */
            lastPage: function(){
                me.loadPage(me.totalPage);
            },
            /**
             * 上一页
             */
            prevPage: function(){
                if(me.curPage !== 1){
                    me.loadPage(me.curPage - 1);
                }
            },
            /**
             * 下一页
             */
            nextPage: function(){
                if(me.curPage !== me.totalPage){
                    me.loadPage(me.curPage + 1);
                }
            },
            /**
             * 跳转指定页
             * @param  {Number} pageNum 页码
             */
            gotoPage: function(pageNum){
                if(typeof pageNum === 'number'){
                    me.loadPage(pageNum);
                }
            },
            /**
             * 获取当前页数
             * @return {Number} 页数
             */
            getCurPage: function() {
                return me.curPage;
            },
            /**
             * 获取总页数
             * @return {Number} 页数
             */
            getTotalPage: function() {
                return me.totalPage;
            },
            /**
             * 获取数据原型
             * @return {Object} [description]
             */
            getData: function(){
                return me.data;
            },
            /**
             * 获取当前表格的数据对象
             * @return {Object} 数据对象
             */
            getDataStore: function(){
                var array = new Array();

                for(var i = 0; i < me.store.length;i++){
                    array.push(me.store[i].data);
                }

                return array;
            },
            /**
             * 获取选中行的数据对象。
             * @param {String} type 返回类型 默认返回原数据 参数为'data'时返回插件内部数据
             * @return {Object} 数据对象
             */
            getSelectedData: function(type) {
                var selections = me.$me.find(':checked:not(.selectAll)');
                var len = selections.length;
                var values = new Array();

                switch(type){
                    case 'data':
                        for (var i = 0; i < len; i++) {
                            var $tr = $(selections[i]).parents('tr');

                            values.push($tr.data());
                        }
                        break;
                    default:
                        for (var i = 0; i < len; i++){
                            var $tr = $(selections[i]).parents('tr');

                            values.push($tr.data('data'));
                        }
                }

                selections.prop('checked', false);
                me.$me.find('.selectAll').prop('checked', false);

                return values;
            },
            /**
             * 获取行数据根据行元素
             * @param  {Dom} dom 该行下的html元素
             * @return {Object}         数据对象
             */
            getRowDataByDom: function(dom) {
                return $(dom).parents('tr').data();
            },
            /**
             * 获取行数据根据行序号
             * @param  {Number} index 序号
             * @return {Object} 数据对象
             */
            getRowDataByIndex: function(index){
                if(typeof index === 'number'){
                    return me.$me.find('tr:not(.table-head)').eq(index).data();
                }else{
                    $.error('arguments must be number');
                }
            },
            /**
             * 更新行
             * @param  {Object} rowData  行数据
             * @param  {Number} rowIndex 行序号
             */
            updateRecord: function(rowData, rowIndex){
                var $trs = me.$me.find('tr:not(.table-head)');

                for (var i = 0, len = $trs.length; i < len; i++) {
                    if($($trs[i]).data('rowIndex') === rowIndex){
                        $($trs[i]).after(me.generateTableRow(rowData, rowIndex));
                        $($trs[i]).remove();
                        break;
                    }
                }

                for (var i = 0, len = me.store.length; i < len; i++) {
                    if(me.store[i].rowIndex === rowIndex){
                        me.store[i].data = rowData;
                        break;
                    }
                }
            },
            /**
             * 选中或取消选中
             * @param  {Array Number} rowIndex [description]
             */
            selectRecord: function(rowIndex){
                if(me.opts.tool.checkboxSelect){
                    var $trs = me.$me.find('tr:not(.table-head)');

                    if(typeof rowIndex === 'object'){
                        for (var i = rowIndex.length - 1; i >= 0; i--) {
                            $trs.eq(rowIndex[i]).find(':checkbox').trigger('click');
                        };
                    }else{
                        $trs.eq(rowIndex).find(':checkbox').trigger('click');
                    }
                }
            },
            /**
             * 删除行
             * @param {Array} dataObject 调用get方法返回的数据对象数组 包含rowIndex属性
             *
             *     @example
             *     grid.removeRecord(grid.getSelectedData());
             */
            removeRecord: function(dataObject){
                for(var i = 0, len = dataObject.length; i < len; i++){
                    if(typeof dataObject[i].rowIndex !== 'undefined'){
                        me.gridObj.removeRecordByRowIndex(dataObject[i].rowIndex);
                    }
                }
            },
            /**
             * 删除行根据行序号
             * @param {Number} rowIndex 行序号
             *
             *     @example
             *     grid.removeRecordByRowIndex(0);
             */
            removeRecordByRowIndex: function(rowIndex){
                if(typeof rowIndex === 'number'){
                    var $trs = me.$me.find('tr:not(.table-head)');
                    //删除dom
                    for(var i = 0, len = $trs.length; i < len; i++){
                        if($($trs[i]).data('rowIndex') === rowIndex){
                            $($trs[i]).remove();
                            break;
                        }
                    }
                    //删除store里的对象
                    for(var i = 0, len = me.store.length; i < len; i++){
                        if(me.store[i].rowIndex === rowIndex){
                            me.store.splice(i, 1);
                            break;
                        }
                    }
                }else{
                    $.error('arguments must be number');
                }
            }
        };
        //配置项
        this.opts = $.extend(true, this.defaults, config || {});

        /*事件注册*/
        //基本
        this.addListeners('basic');
        //分页
        if(this.opts.tool.pagingBar){
            this.generateDom('tableBottomBar');
            this.addListeners('pagingBar');
        }

        if(this.opts.store.autoLoad){
            this.loadPage(1);
        }
    };

    /**
     * 载入数据
     * @private
     * @param  {Number} page   页数
     * @param  {Object} params 参数
     */
    MyGrid.prototype.loadPage = function(page, params) {
        var me = this;

        //清除
        this.clean();
        //移除空提示
        this.tableTip('hideTip');
        //载入提示
        this.tableTip('showLoadingTip');
        /* 生成参数 */
        if(params){
            this.ajaxParams = {};
        }
        this.ajaxParams = $.extend(true, this.ajaxParams, this.opts.store.extraParams || {}, params || {}, {
            offset: (page - 1) * this.opts.store.pagesize,
            limit: this.opts.store.pagesize
        });
        //更新当前页数
        this.curPage = page;
        //获取数据
        this.getData(function(json) {
            if (json === 'error') {
                /*错误提示*/
                if (typeof me.opts.event.onGetDataError === 'function') {
                    me.opts.event.onGetDataError(json);
                }
                me.tableTip('showNoneTip');
            } else if (json === 'timeout') {
                /*超时提示*/
                me.tableTip('showTimeoutTip');
            } else if (typeof json === 'object') {
                if(json[me.opts.store.dataProperty].length){
                    /*有数据*/
                    //数据
                    me.data = json[me.opts.store.dataProperty];
                    //总数
                    me.total = json[me.opts.store.totalProperty];
                    //渲染
                    me.renderGrid(true);
                }else{
                    /*空数据提示*/
                    me.tableTip('showNoneTip');
                }
            }

            //移除载入动画
            me.tableTip('hideLoadingTip');
        });
    };

    //渲染表格
    MyGrid.prototype.renderGrid = function() {
        //渲染表头
        this.renderTableHead();

        //渲染行
        this.rendererTableRow();        

        //初始化工具
        this.initTool();
    };

    /**
     * 渲染表头
     * @private
     */
    MyGrid.prototype.renderTableHead = function() {
        if (this.$me.find('thead').length === 0) {
            var $thead = this.$me.find('thead');
            var $tr = '';
            //已存在表头不再生成
            if($thead.length){

            }else{
                $thead = $('<thead><tr class="table-head"></tr></thead>');
            }
            var $tr = $thead.children('.table-head');

            //移除之前的表头内容
            $tr.children().remove();
            //渲染表头单选框
            if (this.opts.tool.checkboxSelect === true) {
                $tr.append('<th class="checkbox-th"><input class="checkbox selectAll" type="checkbox" /></th>');
            }
            //渲染表头
            for (var i = 0, len = this.opts.columns.length; i < len; i++) {
                if (this.opts.columns[i].sortable === true) {
                    //排序表头
                    var $th = $('<th class="sortable">' + this.opts.columns[i].title + '</th>');

                    //渲染图标
                    $th.append('<span class="iconfont normal">&#xe61e;</span><span class="iconfont sort-icon asc">&#xe621;</span><span class="iconfont sort-icon desc">&#xe622;</span>');

                    //存储数据
                    $th.data(this.opts.columns[i]).data({
                        state: 1
                    });

                    //侦听筛选事件
                    this.addListeners('sort', $th);

                    $tr.append($th);
                } else {
                    //普通表头
                    $tr.append('<th>' + this.opts.columns[i].title + '</th>');
                }
            }

            this.$me.prepend($thead);

            //选框事件
            if (this.opts.tool.checkboxSelect === true) {
                this.addListeners('checkbox');
            }
        }
    };

    /**
     * 渲染表格行
     * @private
     */
    MyGrid.prototype.rendererTableRow = function() {
        for (var i = 0, len = this.data.length; i < len; i++) {
            this.$me.append(this.generateTableRow(this.data[i], i));
            this.store.push({
                rowIndex: i,
                data: this.data[i]
            });
        }
    };

    /**
     * 生成表格行
     * @private
     */
    MyGrid.prototype.generateTableRow = function(rowData, rowIndex) {
        var $tr = $('<tr></tr>');
        var columns = this.opts.columns;

        //渲染单选框
        if (this.opts.tool.checkboxSelect) {
            $tr.append('<td><input class="checkbox" type="checkbox" /></td>');
        }

        for (var j = 0, columnLen = columns.length; j < columnLen; j++) {
            var $td = $('<td></td>');

            /*内容*/
            if (columns[j].renderer) {
                //渲染回调函数 cellData rowData grid rowIndex cellIndex
                var renderContent =  columns[j].renderer(this.getDataByDataIndex(columns[j].dataIndex, rowData), rowData, this.gridObj, j, rowIndex);

                $td.append(renderContent);
            } else {
                var renderContent = this.getDataByDataIndex(columns[j].dataIndex, rowData);
                //格式化
                if (columns[j].formatter) {
                    //长度限制
                    if(columns[j].formatter.length && typeof columns[j].formatter.length === 'number'){
                        if(renderContent && renderContent.length > columns[j].formatter.length){
                            $td.attr('title', renderContent);
                            renderContent = renderContent.substring(0, columns[j].formatter.length) + '...';
                        }
                    }
                }

                $td.append(renderContent);
            }

            //对齐
            if (columns[j].align && (columns[j].align === 'left' || columns[j].align === 'right')) {
                $td.css('align', columns[j].align);
            }
            //宽度
            if (columns[j].width && typeof columns[j].width === 'number') {
                $td.width(columns[j].width);
            }
            //换行
            if (columns[j].nowrap) {
                $td.css('white-space', 'nowrap');
            }

            //存储数据
            $.data($td.get(0), {
                cellIndex: j,
                data: rowData[columns[j].dataIndex]
            });

            $tr.append($td);
        };

        //存储数据
        $.data($tr.get(0), {
            rowIndex: rowIndex,
            data: rowData
        });

        return $tr;
    };

    //初始化工具
    MyGrid.prototype.initTool = function() {
        /*分页*/
        if (this.opts.tool.pagingBar && this.total !== 0) {
            //作用域
            var $aims = $('.' + this.opts.tool.pagingCls, this.$tableBottomBar);
            //引用对象
            var me = this;
            //计算总页数
            this.totalPage = function(pagesize, total) {
                var rem = total % pagesize;

                if (rem > 0) {
                    return parseInt(total / pagesize) + 1;
                } else {
                    return parseInt(total / pagesize);
                }
            }(this.opts.store.pagesize, this.total);

            if (!$.isNumeric(this.totalPage)) {
                return false;
            }

            $aims.each(function(index, el) {
                var $that = $(this);
                //按钮数
                var len = me.opts.tool.pagingBtnNum;
                //起始页
                var startPage = 0;
                //清空
                $that.html('');

                //起始页超过一半
                if(me.curPage > (len / 2)){
                    startPage = me.curPage - parseInt(len / 2);
                }else{
                    startPage = 1;
                }

                for (var i = 1; i <= len && startPage <= me.totalPage; i++) {
                    if (startPage == me.curPage) {
                        //当前页
                        $that.append('<a class="num-page on" href="javascript:void(0);">' + startPage + '</a>\n');
                    } else {
                        $that.append('<a class="num-page" href="javascript:void(0);">' + startPage + '</a>\n');
                    }
                    startPage++;
                }

                //加入首页 上一页
                if (me.curPage !== 1) {
                    $that.prepend('<a class="prev-page" href="javascript:void(0);">&nbsp;前页&nbsp;</a>\n');
                }else{
                    $that.prepend('<a class="prev-page disabled" href="javascript:void(0);">&nbsp;前页&nbsp;</a>\n');
                }

                //加入下一页 尾页
                if (me.curPage !== me.totalPage) {
                    $that.append('<a class="next-page" href="javascript:void(0);">&nbsp;后页&nbsp;</a>\n');
                }else{
                    $that.append('<a class="next-page disabled" href="javascript:void(0);">&nbsp;后页&nbsp;</a>\n');
                }

                //点击事件
                me.addListeners('pageBtn', $that.find('a:not(.disabled):not(.on)'));
            });

            if(this.$tableBottomBar){
                //分页信息显示
                $('.' + this.opts.tool.pagingInfoCls, this.$tableBottomBar).html('当前第 <b>' + this.curPage + '</b> / <b>' + me.totalPage + '</b> 页， 共有 <b>' + this.total + '</b> 条记录');
                //每页显示条数
                $('.' + this.opts.tool.pagingSizeCls, this.$tableBottomBar).val(this.opts.store.pagesize);

                this.$tableBottomBar.show();
            }
        } else {
            if(this.$tableBottomBar){
                $('.' + this.opts.tool.pagingCls, this.$tableBottomBar).html('');
                $('.' + this.opts.tool.pagingSizeCls, this.$tableBottomBar).hide();
            }
        }

        /*其他工具*/
    };

    //获取数据
    MyGrid.prototype.getData = function(callback) {
        if (this.opts.store.data && !this.opts.store.url) {
            /*返回本地数据*/
            callback(this.opts.store.data);
        } else {
            /*返回ajax数据*/
            var me = this;
            var params = this.ajaxParams;
            var opts = this.opts;
            var method = 'GET';

            if(opts.store.type === 'GET' || opts.store.type === 'POST'){
                method = opts.store.type;
            }

            //加随机数防止缓存
            if(method === 'GET'){
                params._t = new Date().getTime();
            }

            //同步获取数据
            $.ajax({
                url: opts.store.url,
                type: method,
                dataType: 'json',
                data: params,
                success: function(json){
                    if (json[opts.store.successProperty] == 1) {
                        //获取成功
                        callback(json);
                    } else {
                        callback('none');
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    if(textStatus === 'timeout'){
                        callback('timeout');
                    }else{
                        callback('error');
                    }
                }
            });
        }
    };

    /**
     * 事件侦听器
     * @private
     */
    MyGrid.prototype.addListeners = function(type) {
        var me = this;
        var listeners = {
            //基本事件
            basic: function(){
                //经过效果
                me.$me.on('mouseover', 'tr', function() {
                    $(this).addClass('hover');
                }).on('mouseleave', 'tr', function() {
                    $(this).removeClass('hover');
                });
            },
            //选择框
            checkbox: function(){
                //全选选择框
                me.$me.find('.selectAll').bind('change', function() {
                    //全选 反选
                    me.$me.find(':checkbox:not(.selectAll)').prop('checked', this.checked);
                    //更新选中信息
                    $('.selected-info').text('当前选中 ' + me.$me.find(':checkbox:not(.selectAll):checked').length + ' 条');
                    //tr选中效果
                    this.checked ? me.$me.find('tr').addClass('selected') : me.$me.find('tr').removeClass('selected');
                });
                me.$me.on('change', ':checkbox:not(.selectAll)', function() {
                    //触发全选
                    if ($(':checkbox:not(.selectAll)', me.$me).not(':checked').length == 0) {
                        me.$me.find('.selectAll').prop('checked', true);
                    } else {
                        me.$me.find('.selectAll').prop('checked', false);
                    }
                    //更新选中信息
                    $('.selected-info').text('当前选中 ' + me.$me.find(':checkbox:not(.selectAll):checked').length + ' 条');
                    //选中效果
                    this.checked ? $(this).parents('tr').addClass('selected') : $(this).parents('tr').removeClass('selected');
                });
            },
            //分页
            pagingBar: function(){
                //更改每页显示
                $('.' + me.opts.tool.pagingSizeCls, me.$tableBottomBar).bind('change', function(event) {
                    var val = parseInt($(this).val());

                    me.opts.store.pagesize = val;

                    me.loadPage(1);
                });
                //跳转页面
                $('.btn-go', this.$tableBottomBar).bind('click', function() {
                    var pageNum = parseInt($('.' + me.opts.tool.pagingJumpCls, me.$tableBottomBar).val());

                    if($.isNumeric(pageNum) && pageNum <= me.totalPage && pageNum >= 1){
                        me.loadPage(pageNum);
                    }else{
                        if(window.parent.parent.tip){
                            window.parent.parent.tip('请输入正确的数字', 'danger');
                        }else{
                            alert('请输入正确的数字');
                        }
                    }

                    $('.' + me.opts.tool.pagingJumpCls, me.$tableBottomBar).val('');
                });
                //回车跳转
                $('.' + me.opts.tool.pagingJumpCls, me.$tableBottomBar).bind('keydown', function(event){
                    if(event.keyCode === 13){
                        $('.btn-go', this.$tableBottomBar).trigger('click');
                    }
                });
            },
            //页码
            pageBtn: function($dom){
                $dom.bind('click', function() {
                    var type = $(this).attr('class');
                    var limit = me.opts.store.pagesize;

                    switch (type) {
                        //首页
                        case 'index-page':
                            me.gridObj.firstPage();
                            break;
                            //尾页
                        case 'last-page':
                            me.gridObj.lastPage();
                            break;
                            //前一页
                        case 'prev-page':
                            me.gridObj.prevPage();
                            break;
                            //后一页
                        case 'next-page':
                            me.gridObj.nextPage();
                            break;
                            //页码页
                        case 'num-page':
                            me.gridObj.gotoPage(parseInt($(this).text()));
                            break;
                    }
                });
            },
            //排序
            sort: function($th){
                $th.bind('click', function() {
                    var data = $(this).data();
                    var dataIndex = data.dataIndex;

                    me.ajaxParams = '';

                    $('.sortable', me.$me).not(this).data({
                        state: 1
                    });
                    $('.sortable', me.$me).find('.sort-icon').hide()
                        .end().find('.normal').not(this).show();
                    $(this).find('.normal').hide();

                    switch (data.state) {
                        //默认 -- 升序
                        case 1:
                            $(this).data({
                                state: 2
                            }).find('.asc').show();

                            me.loadPage(1, {
                                sort: dataIndex,
                                asc: true
                            });

                            break;
                            //升序 -- 降序
                        case 2:
                            $(this).data({
                                state: 3
                            }).find('.desc').show();

                            me.loadPage(1, {
                                sort: dataIndex,
                                asc: false
                            });

                            break;
                            //降序 -- 默认
                        case 3:
                            $(this).data({
                                state: 1
                            }).find('.normal').show();

                            me.loadPage(1);

                            break;
                    }
                });
            }
        };

        if(listeners[type]){
            listeners[type].apply(this, Array.prototype.slice.call(arguments, 1));
        }
    };

    //获取数据项
    MyGrid.prototype.getDataByDataIndex = function(dataIndex, rowData) {
        if(!dataIndex || typeof dataIndex === 'undefined'){
            return '';
        }
        var indexArray = dataIndex.split('.');
        var data = '';

        for (var i = 0, len = indexArray.length; i < len; i++) {
            if(data){
                data = data[indexArray[i]];
            }else{
                data = rowData[indexArray[i]];
            }
        };

        return data;
    };

    //清除数据
    MyGrid.prototype.clean = function() {
        this.$me.find('tr').not('.table-head').remove();
        this.$me.find('.selectAll:checked').prop('checked', false);
        //TO 清除右上角信息
        $('.selected-info').text('');
        if(this.$tableBottomBar){
            this.$tableBottomBar.hide();
        }
    };

    //html生成
    MyGrid.prototype.generateDom = function(type) {
        var me = this;
        var methods = {
            tableBottomBar: function(){
                if(!this.$tableBottomBar){
                    var $tableBottomBar = $('<div class="table-bottom-bar clearfix"></div>');
                    
                    if(this.opts.tool.pagingBar){
                        $tableBottomBar
                            .append('<div class="table-bottom-left">'+
                                '<span class="page-size mr-10">'+
                                    '<select class="normal-select ' + this.opts.tool.pagingSizeCls + '">'+
                                        '<option value="5">5</option>'+
                                        '<option value="10">10</option>'+
                                        '<option value="15">15</option>'+
                                        '<option value="20">20</option>'+
                                        '<option value="25">25</option>'+
                                    '</select>'+
                                '</span>'+
                                '<span class="' + this.opts.tool.pagingCls + ' mr-10"></span>'+
                                '<span class="page-jump">'+
                                    '<input class="form-control mr-10 ' + this.opts.tool.pagingJumpCls + '" type="text">'+
                                    '<a class="btn btn-primary btn-go" href="javascript:void(0);">GO</a>'+
                                '</span>'+
                            '</div>')
                            .append(
                                '<div class="page-function table-bottom-right">'+
                                    '<span class="' + this.opts.tool.pagingInfoCls + '"></span>'+ 
                                '</div>'
                            );
                        
                        me.$me.after($tableBottomBar);
                        me.$tableBottomBar = $tableBottomBar;
                    }
                }
            }
        };

        if(methods[type]){
            methods[type].apply(this, Array.prototype.slice.call(arguments, 1));
        }
    };

    //表格提示
    MyGrid.prototype.tableTip = function(type) {
        if(!this.opts.tool.tableTip){
            return false;
        }
        switch(type){
            case 'showLoadingTip':
                this.$me.after('<div class="table-tip table-loading"></div>');
                break;
            case 'showNoneTip':
                this.$me.after('<div class="table-tip table-none"></div>');
                break;
            case 'showTimeoutTip':
                this.$me.after('<div class="table-tip table-timeout"></div>');
                break;
            case 'hideLoadingTip':
                this.$me.nextAll('.table-loading').remove();
                break;
            case 'hideTip':
                this.$me.nextAll('.table-tip').remove();
                break;
        }
    };

    /**
     * @constructor grid初始化方法
     * @param  {Object} config 配置项
     * @return {Object} grid 返回的grid对象
     */
    $.fn.grid = function(config) {
        if (!this) {
            return false;
        }

        var myGrid = new MyGrid(this, config);

        return myGrid.gridObj;
    };
})(jQuery);