layui.use('element',function(){
    let element = layui.element();
});

sbo = new SearchBox();
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
            tabTransit: [], //渠道类型
            tabCurrency: [], //币制
            tabNature: [], //货物性质
            tabClientGroup: [], //客户组
            lable: [], //打印标签
        }
    },
    methods: {
        setData: function(data){
            if(data.info && data.info.rows && data.info.rows.length>0) {
                this.info = data.info.rows[0];
            }

            if(data.exp)
                this.exp = data.exp.rows;

            if(data.saleCoeffi)
                this.saleCoeffi = data.saleCoeffi.rows;

            if(data.priceWTSection)
                this.priceWTSection = data.priceWTSection.rows;

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
ad.bindTabNames = `transit,currency,clientGroup,extCharge`;
ad.success = function(data) {
    if (data != undefined) {
        app.setData(data);
        if (data.tabClientGroup && data.tabClientGroup.rows)
            APLDevel.creaChecks("#clientGroupBox", data.tabClientGroup.rows, "clientGroup", "id");

        if (data.info && data.info.rows && data.info.rows.length > 0)
            APLDevel.setChecks("#clientGroupBox input:checkbox", data.info.rows[0].cgs);
    }
};
ad.doInfo("/exp5/price/doInfo");

//保存基本信息
function saveInfo() {
    var cgs = APLDevel.getChecks("#clientGroupBox");
    ad.doSave("/exp5/price/doSaveInfo", '.infoBox', 'cgs='+cgs)
}

//验证行
function  vertionRow(e) {
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