APLDevel.level();

layui.use('element',function(){
    var element = layui.element();
});

var sbo = new SearchBox();
sbo.url = "/search/doSearch";

var ad = new APLDevel();
ad.preloader = "#preloader";//ajax遮罩

var app = new Vue({
    el: '#app',
    data: function(){
        return {
            info: {}, //基本信息
            exp: [], //公式
            saleCoeffi: [], //销售系数
            priceWTSection: [], //重量段
            priceClient: [], //客户
            extCharge: [], //附加费
            tabTransit: [], //渠道类型
            tabCurrency: [], //币制
            tabNature: [], //货物性质
            tabClientGroup: [], //客户组
            lable: [], //打印标签
            dlgExtChargeData: [], //弹出附加费  dlgExtCharge
        }
    },
    methods: {
        setData: function(data){
            if(data.info && data.info.rows && data.info.rows.length>0) {
                var info2 = data.info.rows[0];
                if(info2.remark) {
                    info2.remark = APLDevel.replaceAll(info2.remark, "<br>", "\r\n");
                    info2.remark = APLDevel.replaceAll(info2.remark, "＜br＞", "\r\n");
                    $("#remark").val(info2.remark);
                }
                if(info2.remarkImp){ 
                    info2.remarkImp = APLDevel.replaceAll(info2.remarkImp, "<br>", "\r\n");
                    info2.remarkImp = APLDevel.replaceAll(info2.remarkImp, "＜br＞", "\r\n");
                    $("#remarkImp").val(info2.remarkImp);
                }
                this.info = info2;
            }

            if(data.exp)
                this.exp = data.exp.rows;

            if(data.saleCoeffi)
                this.saleCoeffi = data.saleCoeffi.rows;

            if(data.extCharge)
                this.extCharge = data.extCharge.rows;

            if(data.priceWTSection)
                this.priceWTSection = data.priceWTSection.rows;

            if(data.priceClient)
                this.priceClient = data.priceClient.rows;

            if(data.tabTransit)
                this.tabTransit = data.tabTransit.rows;

            if(data.tabCurrency)
                this.tabCurrency = data.tabCurrency.rows;

            if(data.tabNature)
                this.tabNature = data.tabNature.rows;

            if(data.tabClientGroup)
                this.tabClientGroup = data.tabClientGroup.rows;

            if(data.lable)
                this.lable = data.lable.rows;
        }
    }
});

ad.dbId = APLDevel.getUrlParam("id");
ad.bindTabNames = "transit,currency,clientGroup";
ad.success = function(data) {
    if (data != undefined) {
        app.setData(data);
         if (data.tabClientGroup && data.tabClientGroup.rows)
             APLDevel.creaChecks("#clientGroupBox", data.tabClientGroup.rows, "clientGroup", "id");
           
         if (data.tabNatureGoods && data.tabNatureGoods.rows)
             APLDevel.creaChecks("#natureGoodsBox", data.tabNatureGoods.rows, "myName", "id1");
             
        /*var arr = data.info.rows[0].cgs.split(',');
        setTimeout(function() {
            for (var i = 0; i < arr.length; i++) {
                $("#clientGroupBox input").eq(arr[i]-1).prop("checked", true);
            }
        }, 0); */

        if (data.info && data.info.rows && data.info.rows.length > 0){        
            APLDevel.setChecks("#clientGroupBox input:checkbox", data.info.rows[0].cgs);
            APLDevel.setChecks("#natureGoodsBox input:checkbox", data.info.rows[0].natureGoods);

            if(data.info.rows[0].isWeb==1)
                $("#isWeb").prop("checked", true);

            if(data.info.rows[0].isGuest==1)
                $("#isGuest").prop("checked", true);
        }
    }
};
ad.doInfo("/exp5/price/doInfo");
APLDevel.bindVertion("#infoBox", 1);
APLDevel.nextFocus("#infoBox");

//保存基本信息
var isSaveInfo=0;
function saveInfo() {
    var url = '/exp5/price/doSaveInfo';
    APLDevel.VerTips = $("#infoBox").find("[aplName1st]");//选取名称标签
    var cgs = APLDevel.getChecks("#clientGroupBox");
    var coagentName = $("#coagentName").val();
    if(cgs=="" && coagentName==""){
        //alert("客户组和服务商不能同时为空");
        layer.tips("客户组和服务商不能同时为空", "#clientGroupBox", {tips: [1,'red']});
        return;
    }

    var natureGoods = APLDevel.getChecks("#natureGoodsBox");
    var extData = 'cgs='+cgs+'&natureGoods='+natureGoods;
    if($("#isWeb").prop('checked'))
        extData += "&isWeb=1";
    else
        extData += "&isWeb=0";
    if($("#isGuest").prop('checked'))
        extData += "&isGuest=1";
    else
        extData += "&isGuest=0";
    var remark = APLDevel.replaceAll($("#remark").val(), "\r\n", "＜br＞");
    var remarkImp = APLDevel.replaceAll($("#remarkImp").val(), "\r\n", "＜br＞");
    extData += "&remark="+remark+ "&remarkImp="+remarkImp;
    ad.doSave(url, '.infoBox', extData);
    isSaveInfo=1;
}


//删除客户
function delClient() {    
    var checkbox = $('#addClient').parent().find('[type="checkbox"]');
    var id = "";
    checkbox.each(function() {
        if ($(this).prop('checked')) {
            if (id != "") id += ',';
            id += $(this).val();
        }
    })
    if(id==""){
        alert("请选择要删除的客户");
        return;
    }
    if(!confirm("确认要删除所选客户吗？")) return;
    var postData ="dbTab=priceClient&id="+id;
    var url = ad.host + "/exp5/price/doDel";
    $.ajax({
        type:'post',
        url:url,
        data:postData,
        success:function() {
            alert('删除成功');
            checkbox.each(function() {
                if ($(this).prop('checked')) {
                    $(this).parent().remove();
                }
            })                 
        }

    })
}  
//添加客户
function clientAdd() {
    sbo.myMethod = saveClient;
    sbo.go2('client','#clientId','id','#clientName','c2');
}
//添加客户回调
function saveClient(data) {
    var checkbox = $('#addClient').parent().find('[type="checkbox"]');
    for (var i = 0; i < checkbox.length; i++) {
        if (checkbox.eq(i).val() == data.id) {
            alert(data.c2 + '已存在');
            return false;
        }
    }   
    var postData = "modelName=priceClient&mainTabId="+ad.dbId+"&clientId="+data.id;
    var url = url = ad.host + "/exp5/price/doSave";
    $.ajax({
        type:'post',
        url:url,
        data:postData,
        success:function() {
            alert('保存成功');
            var crear = '<span style="margin-right: 5px;">'
                        +'<input type="checkbox" value="'+data.id+'">'
                        +'<span>'+data.c2+'</span></span>';

            $(crear).insertBefore($('#addClient'));
                                        
        }

    })
}

//验证行
function vertionCell(e) {
    var tab = $(e).parent().parent().parent().parent();
    var c = $(e).parent().index();
    APLDevel.Vertion($(e).parent(),$(e),tab.find("tr").eq(0).children().eq(c));
}

//保存行
function saveRow(e, dbTab) {
    APLDevel.VerTips = $(e).parent().parent().parent().parent().find('tr').eq(0).find("span");
    ad.doSaveRow("/exp5/price/doSave", e, "modelName="+dbTab);
}

//删除行
function delRow(e, extData) {
    ad.delRow("/exp5/price/doDel", "rowId", e, extData);
}

var extChargeRowId = null;
//附加费选择弹出框
function dlgExtCharge(e,select,num) { 
    var url = "";
    var postData = ""; 
    if (select == 'saleCoeffi') {
        url = ad.host + '/exp5/price/doListCommSaleCoeffi';  
        postData = 'mapFile=&key=&pageIndex=1&pageSize=100000';
    }else if (select == 'extCharge') {
        url = ad.host + '/exp5/general5/doList';  
        postData = 'mapFile=extCharge.xml&key=&pageIndex=1&pageSize=100000';
    }    
    $.ajax({
        url:url,
        data:postData,
        dataType:'json',
        type:'post',
        success:function(data){
            extChargeRowId = $(e).parent().parent().find('[aplDataName="rowId"]');
            $('#dlgExtChargeBox input[type="radio"]').attr('checked',false);
            app.dlgExtChargeData = data.rows;
        },
        error:function(){

        }
    });
    APLDevel.dlg(1, $('#dlgExtChargeBox'), '选择附加费', '900px', '500px');
}

//附加费选择后填充行
function dlgExtChargeFill(e){
    var i = e.index();
    APLDevel.dataFillBox(extChargeRowId.parent().parent(), app.dlgExtChargeData[i]);
    APLDevel.closeDlg();
}

ad.addRow('#tabExp',1);
// ad.addRow('#tabSaleCoeffi',1);
ad.addRow('#tabPriceWTSection',1);
ad.addRow('#tabExtCharge',1);


