    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    // ad.mapFile = "apiAccount.xml";//mapFile
    ad.host = "http://192.168.1.135:9441";

    var page = new APLPage();      
    page.pageBox=".pages";//分页容器
    page.selPageSize='#selPageSize';//页大小选择器
    page.pageSize=$('#selPageSize').val();//页大小   
    page.onChange=ad.doList;
    ad.pageSize=page.pageSize; 

    var exp = new Vue({
        el: '#exp',
        data: function(){
            return {
                rows: [],
                infoData:{},
            }
        }, 
        methods: {
            getData: function(rows){
                this.rows = rows;
            },           
            detailsOrders:function(index) {
                openParam(index);
            }
        }
    });

    ad.doListEnd = function(data){
        if(data!=undefined && data!=null){
            for (var i = 0; i < data.rows.length; i++) {
                if (data.rows[i].shipNo == '' || data.rows[i].shipNo == null || data.rows[i].shipNo == undefined) {
                    data.rows[i].shipNo = '未发货';
                }
            }
            exp.getData(data.rows);//显示表格数据 
            page.pageIndex = ad.pageIndex;
            page.show(data.rowCount);//显示页码           
        }
    };
    ad.listUrl = "/updateOrder/order";
    ad.doList(1);

    page.bindSelPageSize(); //绑定页大小下拉框

    function openParam(index){
        var url = 'ordersInfo.aspx?id=' + exp.rows[index].id;
        APLDevel.dlgFull(url);
    }
    //搜索查询
    function search(e) {
        ad.listExtParam = 'key=' + $(e).prev().val();
        ad.doList(1);
    }
    //下拉框查询
    function doList(){
        ad.listExtParam = APLDevel.getBoxData('#exp form');
        ad.doList(1);
    }