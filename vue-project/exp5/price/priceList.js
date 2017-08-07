    APLDevel.level();
    
    var sbo = new SearchBox();
    sbo.url = "/search/doSearch";

    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    ad.listParamBox = ".listParamBox";//获取容器数据

    var page = new APLPage();   
    page.selPageSize = '#selPageSize';//页大小选择器
    page.pageSize=$(page.selPageSize).val();//页大小
    page.pageBox=".pages";//分页容器
    page.onChange = ad.doList;
    ad.pageSize = page.pageSize;

    var apl = new Vue({
        el: '#apl',
        data: function(){
            return {
                tabTransit:[], //渠道类型
                tabClientGroup:[], //客户组
                priceListData:[], //价格列表数据
                regionListData:[],//分区列表数据
                regionInfoData:{}, //分区详细数据            
                salesListData:[]//销售系数                
            }
        }, 
        methods: {
            setData: function(data){
                this.priceListData = data.rows;
                if(data.tabTransit)
                    this.tabTransit = data.tabTransit.rows;

                if(data.tabClientGroup)
                    this.tabClientGroup = data.tabClientGroup.rows;
            },
            priceInfo: function(id){
                var url = "priceInfo.aspx?id="+id;
                APLDevel.dlgFull(url);
                //APLDevel.dlg(2, url, '报价表详细', '1300px', '700px');
            },
            editData: function(name, index){
                dlgEdit(name, index);
            },
            delRowVue: function(name, id){
                delRow(name,id);
            },
            priceIdUrl: function(index) {
                window.open('/aspx/exp2/Priceact2.aspx?id='+this.priceListData[index].id);
            }
        }
    });

    ad.doListEnd = function(data){
        if(data!=undefined && data!=null){
            apl.setData(data);//显示表格数据
            page.show(data.rowCount);//显示页码
            doBeoverdue2(); 
        }
    };
    ad.listUrl = "/exp5/price/doList";

    function dlgAdd(name) {
        if(name=="region"){
            apl.regionInfoData = {};
            ad.dbId = 0;
            ad.dlgEdit('/exp5/general5/doSave',$('#regionInfoBox'));
        }
    }

    //修改
    function dlgEdit(name, i){
        if(name=="region"){
            apl.regionInfoData = apl.regionListData[i];
            ad.dbId = apl.regionInfoData.id;
            var url = "/exp5/general5/doSave";
            ad.dlgEdit(url, $('#regionInfoBox'), apl.regionListData[i]);
        }
    }

     //保存行
    function saveRow(name, e) {
        if(name=="saleCoeffi"){
            APLDevel.VerTips = $(e).parent().parent().parent().parent().find('tr').eq(0).find("span");
            ad.doSaveRow("/exp5/price/doSave", e, "modelName=saleCoeffi");
        }
    }

     
    //删除
    function delRow(name,id, e) {
        //alert(name);
        var tabList = "";
        var tabUrl = "";
        var extData = null;
        if (name == "price") {
            tabList = "#tabList";
            tabUrl = "/exp5/price/doDel";
            extData = "dbTab=map";
        }else if (name == "region") {
            tabList = "#tabList2";
            tabUrl = "/exp5/general5/doDel";
            extData = "dbTab=map";
        }else if (name == "saleCoeffi") {
            tabList = "#tabList3";
            tabUrl = "/exp5/price/doDel";
            extData = "dbTab=SaleCoeffi";
        }
        if(id!="rowId" && (id==undefined || id==null)) id= APLDevel.getChecks(tabList);
        ad.delRow(tabUrl, id, e, extData, tabList);
    }

   

    //验证行
    function  vertionCell(e) {
        var tab = $(e).parent().parent().parent().parent();
        var c = $(e).parent().index();
        APLDevel.Vertion('',$(e),tab.find("tr").eq(0).children().eq(c));
    }

    function doList(priceType){   
        $('.section [aplName]').hide().val('').find('input').val('');
        $('.section [aplName="'+priceType+'"]').show();

        ad.bindTabNames= "transit,clientGroup"; 
        ad.listExtParam = "priceType="+priceType;
        ad.doList(1); 
    }
    doList(1);
    page.bindSelPageSize();

    var arrPrice=['','客户组','','客户','服务商'];
    function aplTab(e,priceType){
        if ($(e).attr('class') == 'layui-this') return;
        var i = $(e).index();
        $(e).attr('class','layui-this').siblings().attr('class','');
        $('#dxTitle').text(arrPrice[priceType]);
        if (typeof(priceType) == 'number'){
            page.selPageSize = '#selPageSize';//页大小选择器
            page.pageSize=$(page.selPageSize).val();//页大小
            page.pageBox=".pages";//分页容器
            ad.listParamBox = ".listParamBox";//获取容器数据
            ad.listUrl = "/exp5/price/doList";
            ad.listExtParam = "priceType="+priceType;
            ad.mapFile = "";
            $('section').eq(0).show().siblings().hide();
            ad.doListEnd = function(data){
                if(data!=undefined && data!=null){
                    apl.setData(data);//显示表格数据
                    page.show(data.rowCount);//显示页码
                    doBeoverdue2();
                }
            };           
            doList(priceType);
        }           
        else{
            aplTabResopn(priceType);
        }
    }
    function aplTabResopn(priceType) {
        if (priceType == 'region') {
            $('section').eq(1).show().siblings().hide();
            ad.listUrl = "/exp5/general5/doList";            
            ad.mapFile = "region.xml";
            page.selPageSize = '#selPageSize2';//页大小选择器
            page.pageSize=$(page.selPageSize).val();//页大小
            page.pageBox=".pages2";//分页容器
            ad.listParamBox = ".section2";//获取容器数据 
            ad.doListEnd = function(data){
                if(data!=undefined && data!=null){
                    apl.regionListData = data.rows;
                    page.show(data.rowCount);//显示页码
                }
            };
            ad.doList(1);           
        }else if (priceType == 'saleCoeffi') {
            $('section').eq(2).show().siblings().hide();
            ad.listUrl = "/exp5/price/doListCommSaleCoeffi";            
            ad.mapFile = "";            
            page.selPageSize = '#selPageSize3';//页大小选择器
            page.pageSize=$(page.selPageSize).val();//页大小
            page.pageBox=".pages3";//分页容器
            ad.listParamBox = ".section3";//获取容器数据  
            ad.doListEnd = function(data){
                if(data!=undefined && data!=null){
                    apl.salesListData = data.rows;
                    page.show(data.rowCount);//显示页码
                }
            };
            ad.doList(1);           
        }
        page.bindSelPageSize();             
    }

    // ad.addRow('#tabSaleCoeffi',1);
    
    //时间是否过期 
    function doBeoverdue(Day,number) {
        if (number == undefined) number = 0;
        var myDate  = new Date();
        var year = myDate.getFullYear();
        var month = (myDate.getMonth()+1);
        var data = myDate.getDate();
        var hours = myDate.getHours();
        var minutes = myDate.getMinutes();
        var seconds = myDate.getSeconds();
        if (month < 10) {
            month = '0' + month;
        }
        if (data < 10) {
            data = '0' + data;
        }
        if (hours < 10) {
            hours = '0' + hours;
        }
        if (minutes < 10) {
            minutes = '0' + minutes;
        }
        if (seconds < 10) {
            seconds = '0' + seconds;
        }
        data = year + '-' + month + '-' + data + ' ' + hours + ':' + minutes + ':' + seconds;
        if (Date.parse(Day)>Date.parse(data)) {
            return true;
        }else{
            var s = Date.parse(data) - Date.parse(Day);
            s = parseInt(s/60/60/24/1000);
            if (s < number) {
                return true;
            }
            return false;
        }
    }
    //根据是否过期改变样式
    function doBeoverdue2() {
        setTimeout(function() {
            $('[doData]').each(function() {
                // $(this).parent().css('opacity','');//改变之前先置空，否则影响下一次操作
                $(this).parent().children().css('color','');
                $(this).parent().find('a').eq(1).css('color','balck');
                if (!doBeoverdue($(this).text(),0)) {
                    // $(this).parent().css('opacity','0.5');
                    $(this).parent().children().css('color','#75878a');
                    $(this).parent().find('a').eq(1).css('color','#75878a');                      
                }      
                if (!doBeoverdue($(this).text(),10)){
                    // $(this).parent().css('opacity','0.2');
                    $(this).parent().children().css('color','#bacac6');
                    $(this).parent().find('a').eq(1).css('color','#bacac6');
                }
            })
        },0);      
    }
    