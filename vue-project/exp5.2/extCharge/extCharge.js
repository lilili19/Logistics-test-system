
    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    ad.mapFile = "extCharge.xml";//mapFile
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
            editData: function(index){
                dlgEdit(index);
            },
            delData: function(id){                          
                delRow(id);
            }
        }
    });
    ad.doListEnd = function(data){
        if(data!=undefined && data!=null){
            exp.getData(data.rows);//显示表格数据
            page.pageIndex = ad.pageIndex;
            page.show(data.rowCount);//显示页码
        }
    };
    ad.host = 'http://dt1.apl-sys.com:5604';
    ad.listUrl = "/exp5/general5/doList";
    ad.doList(1);

    page.bindSelPageSize(); //绑定页大小下拉框
    APLDevel.bindVertion("#boxInfo");

    //修改
    function dlgEdit(i){
        exp.infoData = exp.rows[i];
        ad.dbId = exp.infoData.id;
        var url = "/exp5/general5/doSave";
        ad.dlgEdit(url, $('#boxInfo'), exp.rows[i]);  
    }

    function dlgAdd() {           
        exp.infoData = {};       
        ad.dbId=0;
        var url = "/exp5/general5/doSave";
        ad.dlgEdit(url, $('#boxInfo')); 
    }
     
    //删除行
    function delRow(id) {
        if(id==undefined || id==null) id = APLDevel.getChecks(".content");
        var url = "/exp5/general5/doDel";
        ad.delRow(url, id, null, "dbTab=map", ".content");
    }


    

