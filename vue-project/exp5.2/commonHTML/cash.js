	APLDevel.level();

    var dbTab = $('#pagingSorting').text();

    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    ad.mapFile = dbTab + ".xml";//mapFile
    ad.listParamBox = ".listParamBox";//查询参数

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
            modifyData: function(id) {
                modify(id);
            },
        }
    });
    ad.doListEnd = function(data){
        if(data!=undefined && data!=null){
            if (dbTab == 'remote') {
                if (data.rows.length > 0 && $('.listParamBox [apldataname="city"]').val()!='' || $('.listParamBox [apldataname="postCode"]').val()!='') 
                    $('#isRemote').show();
                else
                    $('#isRemote').hide();
            }
            exp.getData(data.rows);//显示表格数据
            page.pageIndex = ad.pageIndex;
            page.show(data.rowCount);//显示页码
        }
    };
    ad.listUrl = "/general5/doList";
    ad.doList(1);

    page.bindSelPageSize(); //绑定页大小下拉框

   function modify(id) {
        var url = dbTab + 'Details.aspx?id=' + id;
        APLDevel.dlgFull(url);
    }


    


    


