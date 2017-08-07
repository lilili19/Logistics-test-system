APLDevel.level();

var dbTab = $('#pagingSorting').text();

var ad = new APLDevel();
ad.preloader = "#preloader";//ajax遮罩
ad.mapFile = dbTab + '.xml';

var app = new Vue({
    el: '#app',
    data:{
        info:{},//基本信息
        info2:{},//基本信息2
        coagentext:[],//联系人
        user:[],//账号
        upFile:[],//上传附件
        tabPay:[],//付款协议
        tabFiliale:[],//分公司
        coagent:[],//服务商更多信息
        addr:[],//提货地址
        orderInfo:[],//货物明细
        cashact:[],//项目明细
        tabCurrency:[],//币制ServMsg
        oprLog:[],//操作日志
        servMsg:[],//留言信息
        servMsgInfo:{},//留言信息编辑
        chargeList:[],//重量及费用
        chargeListInfo:{},//重量及费用编辑
        track:[],//转运信息
        trackInfo:{},//转运信息编辑
        levelSmall:[],//权限名称更多信息
        company_branch:[],//公司管理更多信息
    },
    methods:{
        modifyData:function(attr,index) {
            waybillModify(attr,index);
        },
        delData:function(id,index,attr) {
            del(id,index,attr);
        }
    }
});

ad.mainTabId = APLDevel.getUrlParam("id");//获取id

function detailsInfo() {
    var url = ad.host + '/general5/doInfo';
    var data = 'mapFile='+dbTab+'.xml&id='+ad.mainTabId;
    if (dbTab == 'company') {
        url = ad.host + '/company/doInfo';
        data = 'mapFile='+dbTab+'.xml&id='+ad.mainTabId+'&companyId2='+APLDevel.getUrlParam("companyId2");
    }
    $.ajax({
        data:data,
        type:'post',
        dataType:'json',
        url:url,
        success:function(data) {
            if (data.coagentext != undefined) app.coagentext = data.coagentext.rows;//联系人
            if (data.upFile != undefined) app.upFile = data.upFile.rows;//上传附件
            if (data.tabFiliale != undefined) app.tabFiliale = data.tabFiliale.rows;//分公司
            if (data.tabPay != undefined) app.tabPay = data.tabPay.rows;//付款协议
            if (data.user != undefined) app.user = data.user.rows;//账号
            if (data.coagent != undefined) app.coagent = data.coagent.rows;//服务商更多信息
            if (data.addr != undefined) app.addr = data.addr.rows;//提货地址
            if (data.orderInfo != undefined) app.orderInfo = data.orderInfo.rows;//货物明细
            if (data.cashact != undefined) app.cashact = data.cashact.rows;//项目明细
            if (data.tabCurrency != undefined) app.tabCurrency = data.tabCurrency.rows;//币制
            if (data.oprLog != undefined) app.oprLog = data.oprLog.rows;//操作日志
            if (data.servMsg != undefined) app.servMsg = data.servMsg.rows;//留言信息
            if (data.chargeList != undefined) app.chargeList = data.chargeList.rows;//重量及费用
            if (data.track != undefined) app.track = data.track.rows;//转运信息
            if (data.levelSmall != undefined) app.levelSmall = data.levelSmall.rows;//权限名称更多信息
            if (data.company_branch != undefined) app.company_branch = data.company_branch.rows;//公司管理更多信息
            if (data.info2 != undefined) app.info2 = data.info2.rows[0];//基本信息2
            if(data.info != undefined) {//基本信息
                app.info = data.info.rows[0];
                switch(dbTab){
                    case 'client':
                        $('#tabClient').show();
                        $('#tabUser').show();  
                        break;
                    case 'coagent':
                        $('#tabCoagent').show();
                        break;
                    case 'ywdd':
                        $('#tabAddr').show();
                        $('#tabOrderInfo').show();
                        break;
                    case 'cash':
                        $('#tabCashact').show();
                        $('#tabCurrency').show();
                        break;
                    case 'levelName':
                        $('#tabLevelSmall').show();
                        break;
                    case 'company':
                        $('#tabCompany_branch').show();
                        break;
                }
            }
            else{
                if (dbTab == 'coagent') {
                    setTimeout(function() {
                        $('[aplDataName="state"]').val('1');
                    },0)
                }           
            }
        },
        error:function() {
            alert('数据加载失败，请重新操作');            
            parent.l_popup.close(0);
        }
    })
}
detailsInfo();

//验证行
function vertionCell(e) {
    var tab = $(e).parent().parent().parent().parent();
    var c = $(e).parent().index();
    APLDevel.Vertion($(e).parent(),$(e),tab.find("tr").eq(0).children().eq(c));
}

//保存行
function saveRow(e,dbTab) {
    APLDevel.VerTips = $(e).parent().parent().parent().parent().find('tr').eq(0).find("span");
    var urlSave = "/general5/doSave";
    if (dbTab == 'company_branch') urlSave = "/company/doSave";
    ad.doSaveRow(urlSave, e, "modelName="+dbTab);
}

//删除行
function delRow(e,dbTab) {
    var urlDel = "/general5/doDel";
    if (dbTab == 'company_branch') urlDel = "/company/doDel";
    ad.delRow(urlDel, 'rowId', e, "dbTab="+dbTab);
}

//保存主表
function saveInfo() {
    if (dbTab == 'orderInfo' || dbTab == 'client' || dbTab == 'ywdd') {
        APLDevel.VerTips = $('#app form [Verification]').parent().prev();
        if (dbTab == 'client') {
            if ($('[aplDataName="province"]').val().length == "") {
                l_tips('省不能为空',$('[aplDataName="province"]'));
                return;
            }
            if ($('[aplDataName="province"]').val().length<2||$('[aplDataName="province"]').val()>50) {
                l_tips('请输入2-50位',$('[aplDataName="province"]'));
                return;
            }
            if ($('[aplDataName="city"]').val().length == "") {
                l_tips('市不能为空',$('[aplDataName="city"]'));
                return;
            }
            if ($('[aplDataName="city"]').val().length<2||$('[aplDataName="city"]').val()>50) {
                l_tips('请输入2-50位',$('[aplDataName="city"]'));
                return;
            }
            if ($('[aplDataName="county"]').val().length == "") {
                l_tips('县(区)不能为空',$('[aplDataName="county"]'));
                return;
            }
            if ($('[aplDataName="county"]').val().length<2||$('[aplDataName="county"]').val()>50) {
                l_tips('请输入2-50位',$('[aplDataName="county"]'));
                return;
            }
        }     
    }
    if (!APLDevel.Vertion('#app form')) return;
    var data = "";
    if (dbTab == 'levelName'){
        data = 'mapFile='+dbTab+'.xml&modelName=levelBig&id='+ad.mainTabId+"&"+APLDevel.getBoxData('form');
    }
    else{
        data = 'mapFile='+dbTab+'.xml&modelName='+dbTab+'&id='+ad.mainTabId+"&"+APLDevel.getBoxData('form');
    }
    var url = ad.host + '/general5/doSave';
    if (dbTab == 'company') url = ad.host + '/company/doSave';
    $.ajax({
        url:url,
        data:data,
        type:'post',
        dataType:'json',
        success:function(data) {
            if(data.Message) 
                l_status('success',data.Message);
            if(data.Error) {
                alert(data.Error);
                return;
            }
            switch(dbTab){
                case 'client':
                    $('#tabClient').show();
                    $('#tabUser').show();
                    break;
                case 'coagent':
                    $('#tabCoagent').show();
                    break;
                case 'ywdd':
                    $('#tabAddr').show();
                    $('#tabOrderInfo').show();  
                    break;
                case 'cash':
                    $('#tabCashact').show();
                    $('#tabCurrency').show();
                    break;
                case 'levelName':
                    $('#tabLevelSmall').show();
                    break;
                case 'company':
                    $('#tabCompany_branch').show();
                    break;
            }
            ad.mainTabId = data.id;
        },
        error:function() {
            l_status('error','保存失败');
        }
    })       
}

ad.addRow('#tabCoagent',1);