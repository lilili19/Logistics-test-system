    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    ad.listExtParam = 'priceType=1';
    ad.listParamBox = ".listParamBox";

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
                rows: []
            }
        }, 
        methods: {
            getData: function(rows){
                this.rows = rows;
            },
            detailData: function(id){
                var url = `priceInfo.aspx?id=`+id;
                APLDevel.dlgFull(url);
            }
        }
    });

    ad.doListEnd = function(data){
        if(data!=undefined && data!=null){
            apl.getData(data.rows);//显示表格数据
            page.show(data.rowCount);//显示页码
        }
    };
    ad.listUrl = "/exp5/price/doList";
    ad.doList(1,'','priceType=1');

    function dlgAdd() {
        APLDevel.dlgFull("priceInfo.aspx");
    }
     
    //删除
    function delRow(id) {
        if(id==undefined || id==null) id= APLDevel.getChecks("#tabList");
        ad.delRow("/exp5/price/doDel", id, "list", null, "#tabList");
    }