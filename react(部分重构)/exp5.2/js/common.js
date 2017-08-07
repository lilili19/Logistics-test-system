    var host = "http://192.168.1.107:85";
    var dbTab = $('#pagingSorting').text();

    var page = new APLPage();
    //查询
    var setThis = null;
    function doList(pageIndex) {
        var url = host + '/exp5/general5/doList';
        var data = 'mapFile='+dbTab+'.xml&pageIndex='+pageIndex+'&pageSize='+page.pageSize;
        $('.listParamBox [data-name]').each(function () {
            name = $(this).attr("data-name");
            val = $(this).val();
            if(val!=""){
                val = APLDevel.replaceAll(val, "+","%2B");
                val = APLDevel.replaceAll(val, "&","%26");
                if(data!="") data += "&";
                data += name + "=" + val;
            }
        });
        $('#preloader').show();
        $.ajax({
            data:data,
            url:url,
            type:'post',
            dataType:'json',
            success:function(data) {
                if (data.rowCount == undefined) data.rowCount = 0;
                if (data.rows == undefined) data.rows = [];
                page.show(data.rowCount);
                $('#preloader').hide();
                setThis.setState({
                    data:data.rows
                });
            },
            error:function() {
                $('#preloader').hide();
                l_status('error','加载失败');
            }
        })
    }

    //绑定用户操作事件
    function bindEvent(_this) {
        page.pageBox = '.pages';
        page.pageSize = $('#selPageSize').val();
        page.onChange = doList;
        page.selPageSize = '#selPageSize';
        page.outher = _this;
        $('#selPageSize').change(function() {
            page.pageSize = $('#selPageSize').val();
            doList(1,_this);
        })
        doList(1,_this);
    }
    
    //删除
    function delData(id,_this,one) {
        //_this值删除一条时传当前节点，多条时传初始组件this
        var msg="";
        if(one != 'one') {
            if (id == "" || id == undefined || id == null) {
                alert("请选择删除数据");
                return;
            }
            msg="确定删除这"+APLDevel.checkCount+"条记录吗？";
        }
        else msg="确定删除这条记录吗？";
        if(confirm(msg)){
            var url = host + "/general5/doDel";
            var data ="mapFile="+dbTab+".xml&id="+id
                    +"&dbTab="+(dbTab=='bankAccout'?'Accout':dbTab);
            $('#preloader').show();
            $.ajax({
                type:'post',
                data:data,
                url:url,
                dataType:'json',
                success:function(data) {
                    $('#preloader').hide();
                    l_status('success','删除成功');
                    if (one != 'one') {
                        $('#exp').find('input[type=checkbox][value]:checked').attr('checked',false);
                        doList(1,_this);
                    }else{
                        _this.parentNode.parentNode.parentNode.removeChild(_this.parentNode.parentNode);
                        $('.pages span').eq(0).text(
                            '共'+($('.pages span').eq(0).text().charAt(1)-1)+'条'
                        );
                    }
                },
                error:function() {
                    $('#preloader').hide();
                    l_status('error','删除失败');
                }
            })           
        }
    }

    //修改或添加数据
    function addModify(user,_this,string){
        l_popup({
            title: '详细信息',
            content: string,
            btn: '保存',
            width: dbTab=='user'?'720px':'360px',
            yes: function(index){   
                if(!APLDevel.Vertion('#boxInfo')) return;
                if (user.id == undefined) user.id = 0;

                var data = 'mapFile='+dbTab+'.xml&id='+user.id;
                data += '&' + APLDevel.getBoxData('#boxInfo');
                var url = host + '/general5/doSave';
                $('#preloader').show();
                $.ajax({
                    url:url,
                    data:data,
                    type:'post',
                    dataType:'json',
                    success:function(data) { 
                        $('#preloader').hide();   
                        if(data.success==true) {
                            l_status('success','保存成功');
                            l_popup.close(index);
                            if (user.id != 0) {
                                $('#boxInfo').find("["+APLDevel.dataName+"]").each(function () {
                                    var name = $(this).attr(APLDevel.dataName);
                                    user[name] = $(this).val();
                                }); 
                                _this.setState({
                                    data:user
                                });     
                            }else{
                                doList(1,_this);
                            }          
                        }                       
                    },
                    error:function() {
                        $('#preloader').hide();
                        l_status('error','保存失败');
                    }
                })                      
            }
        });        
    }




    


    

