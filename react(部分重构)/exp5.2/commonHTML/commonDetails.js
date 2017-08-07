var host = "http://192.168.1.107:85";
var dbTab = $('#pagingSorting').text();
var getId = APLDevel.getUrlParam("id");//获取id
var setThis = null;

//Info查询
function detailsInfo() {
    var url = host + '/general5/doInfo';
    var data = 'mapFile='+dbTab+'.xml&id='+getId;
    $('#preloader').show();
    $.ajax({
        data:data,
        type:'post',
        dataType:'json',
        url:url,
        success:function(resData) {
            $('#preloader').hide();
            var data = setThis.state.data;           
            if(resData.info != undefined) data.info = resData.info;//基本信息
            if(resData.info2 != undefined) data.info2 = resData.info2;//基本信息
            if(resData.coagentext != undefined) data.coagentext = resData.coagentext;
            if(resData.cashact != undefined) data.cashact = resData.cashact;
            if(resData.user != undefined) data.user = resData.user;
            if(resData.chargeList != undefined) data.chargeList = resData.chargeList;
            if(resData.oprLog != undefined) data.oprLog = resData.oprLog;
            if(resData.servMsg != undefined) data.servMsg = resData.servMsg;
            if(resData.track != undefined) data.track = resData.track;
            setThis.setState({
                data:data
            })           
        },
        error:function() {
            alert('数据加载失败，请重新操作');            
            parent.l_popup.close(0);
        }
    })
}
// detailsInfo();

//验证行
function vertionCell(e) {
    var span = $(e).parent().parent().parent().parent().find('tr').eq(0).find('span');  
    var c = span.eq($(e).parent().index());
    APLDevel.Vertion('',$(e),c); 
}

//保存行
function saveRow(e,db){
    APLDevel.VerTips = $(e).parent().parent().parent().parent().find('tr').eq(0).find("span");
    if (!APLDevel.Vertion($(e).parent().parent())) return;
    var url = host + "/general5/doSave";
    var data = "mapFile="+dbTab+".xml&mainTabId="+getId+"&modelName="+db+'&'
            +APLDevel.getBoxData($(e).parent().parent());
    $('#preloader').show();
    $.ajax({
        data:data,
        type:'post',
        dataType:'json',
        url:url,
        success:function(data) {
            $('#preloader').hide();
            if(data.Error!=undefined) {
                alert(data.Error);
                return; 
            }
            if(data.id!=undefined) {
                $(e).parent().parent().find("["+APLDevel.dataName+"=rowId]").val(data.id);
                $(e).parent().parent().find("["+APLDevel.dataName+"]").attr("disabled",true);
                $(e).parent().find("[name=btnEditRow]").show();
                $(e).parent().find("[name=btnSaveRow]").hide();
            }
            l_status('success','保存成功');
        },
        error:function() {
            $('#preloader').hide();
            l_status('error','保存失败');
        }
    })
}

//删除行
function delRow(e,db) {
    var elemId = $(e).parent().parent().find("["+APLDevel.dataName+"=rowId]");
    if (elemId.val() == "" || elemId.val() == undefined) {
        $(e).parent().parent().remove();
        return;
    }
    if(!confirm('确定删除这条记录吗？')) return;
    var url = host + "/general5/doDel";
    var data = "mapFile="+dbTab+".xml&mainTabId="+getId+"&dbTab="+db+'&id='
            +elemId.val();
    $('#preloader').show();
    $.ajax({
        data:data,
        type:'post',
        dataType:'json',
        url:url,
        success:function(data) {
            $('#preloader').hide();
            if(data.Error!=undefined) {
                alert(data.Error);
                return; 
            }
            $(e).parent().parent().remove();
            l_status('success','删除成功');
        },
        error:function() {
            $('#preloader').hide();
            l_status('error','删除失败');
        }
    })
}

//保存主表
function saveInfo(_this) {
    APLDevel.dataName = "data-name";
    APLDevel.VerName = "data-ver";
    if (dbTab == 'orderInfo' || dbTab == 'client' || dbTab == 'ywdd') {
        APLDevel.VerTips = $('#app form [data-ver]').parent().prev();  
    }
    if (!APLDevel.Vertion('#app form')) return;
    var data = 'mapFile='+dbTab+'.xml&modelName='+dbTab+'&id='+getId;
    $('#app form [data-name]').each(function() {
        var name = $(this).attr('data-name');
        var value = $(this).val();
        if (value != "") {
            data += "&" + name + "=" +value;
        }
    })
    var url = host + '/general5/doSave';
    $.ajax({
        url:url,
        data:data,
        type:'post',
        dataType:'json',
        success:function(resData) {
            if(resData.Message) {
                l_status('success',resData.Message);
            }
            if(resData.Error) {
                alert(resData.Error);
                return;
            }
            getId = resData.id;
            var data = _this.state.data;
            data.info.rows[0].id = getId;
            _this.setState({
                data: data
            })            
        },
        error:function() {
            l_status('error','保存失败');
        }
    })       
}

//编辑行
function editRow(e) {
    $(e).parent().find("[name='btnEditRow']").hide();
    $(e).parent().find("[name='btnSaveRow']").show();
    $(e).parent().parent().find("["+APLDevel.dataName+"]").attr('disabled',false);
}