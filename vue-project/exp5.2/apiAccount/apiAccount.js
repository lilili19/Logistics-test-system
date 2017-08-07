       
    $(function(){        
        $('id tr').each(function(index){
            $('id tr').eq(index).find('[apl]').blur(function(){
                var i = $('id tr').eq(index).find('[apl]').index(this);
                APLDevel.Vertion($('id tr').eq(index),$(this),$('id tr').eq(0).eq())
            })
        })       
    })

    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    ad.mapFile = "apiAccount.xml";//mapFile

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
        }
    };
    ad.listUrl = "/exp5/general5/doList";
    ad.doList(1);

    //修改
    function dlgEdit(i){
        exp.infoData = exp.rows[i];
        ad.dbId = exp.infoData.id;
        $('#boxInfo [aplDataName="isDef"]').val(exp.infoData.isDef);
        $('#boxInfo [aplDataName="useState"]').val(exp.infoData.useState);
        var url = "/exp5/general5/doSave";
        ad.dlgEdit(url, $('#boxInfo'), exp.rows[i]);
    }

    function dlgAdd() {
        $('#boxInfo [aplDataName="isDef"]').val('0');
        $('#boxInfo [aplDataName="useState"]').val('1');
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

    function openParam(e){
        var url = 'apiconfig.aspx?apiId='+$(e).attr('apiId')+'&apiName='+$(e).attr('apiName');
        // window.open(url);
        APLDevel.dlgFull(url);
    }
