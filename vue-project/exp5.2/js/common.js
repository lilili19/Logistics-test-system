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
                tabTransit: [],
                tabShipServ: [],
                infoData:{},
                tabTrack:{},//查件官网
                tabWtEval:{},//计泡方式
                tabDep:{},//部门
                tabFiliale:{},//分公司
                tabUserGroup:{}//权限组
            }
        }, 
        methods: {
            getData: function(rows){
                this.rows = rows;
            },
            editData: function(index){
                dlgEdit(index);
            },
            modifyData: function(id,expData) {
                modify(id,expData);
            },
            delData: function(id){
                delRow(id);
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
            if (data.tabTransit != undefined) exp.tabTransit = data.tabTransit.rows;
            if (data.tabShipServ != undefined) exp.tabShipServ = data.tabShipServ.rows;
            exp.getData(data.rows);//显示表格数据
            page.pageIndex = ad.pageIndex;
            page.show(data.rowCount);//显示页码
        }
    };
    ad.listUrl = "/general5/doList";
    if (dbTab == 'company') ad.listUrl = "/company/doList";

    function get_data(day) {
        var year = day.getFullYear();
        var month = day.getMonth()+1;
        var date = day.getDate();
        if (month<10) month = '0' + month;
        if (date<10) date = '0' + date;
        return  year + '-' + month + '-' + date;
    }
    if (dbTab == 'ywdd') {
        var day = new Date();
        var nowData = get_data(day);
        day.setDate(day.getDate() - 7);
        var nowData7 = get_data(day);
        $('.listParamBox [aplDataName="dateStart"]').val(nowData7+' 00:00');
        $('.listParamBox [aplDataName="dateEnd"]').val(nowData+' 23:59');
    }
    if (dbTab == 'waybill') {
        ad.bindTabNames = "transit,shipServ";
    }
    ad.doList(1);

    page.bindSelPageSize(); //绑定页大小下拉框
    APLDevel.bindVertion("#boxInfo");

    //修改
    function dlgEdit(i){    
        if (dbTab == 'transit' || dbTab == 'user' || dbTab == 'coagent') {
            addModify(dbTab,i);   
        }else{
            exp.infoData = exp.rows[i]; 
            ad.id = exp.infoData.id;
            var url = "/general5/doSave";
            ad.dlgEdit(url, $('#boxInfo'), exp.rows[i]);
        }
    }
    //添加
    function dlgAdd() {
        exp.infoData = {};       
        ad.mainTabId=0;
        var url = "/general5/doSave";
        if (dbTab == 'user') 
            ad.dlgEdit(url, $('#boxInfo'),null,'720px');
        else
            ad.dlgEdit(url, $('#boxInfo'));
        switch(dbTab){
            case 'transit':
                addModify('transit','add');  
                break;
            case 'user':
                addModify('user','add');
                break;
        }    
    }
     
    //删除行
    function delRow(id) {
        if(id==undefined || id==null) id = APLDevel.getChecks(".content");
        var url = "/general5/doDel";

        if (dbTab == 'bankAccout') {
            dbTab = 'Accout';
        }
        ad.delRow(url, id, null, "dbTab=" + dbTab, ".content");
    }

    //修改添加数据
    function addModify(page,i) {
        var data = '';
        if (i == 'add') data = 'mapFile='+page+'.xml&id=0';
        else data = 'mapFile='+page+'.xml&id='+exp.rows[i].id;
        var url = ad.host + '/general5/doInfo';
        $.ajax({
            url:url,
            data:data,
            type:'post',
            dataType:'json',
            success:function(data) {
                if (data.tabTrack != undefined) exp.tabTrack = data.tabTrack.rows;//查件官网
                if (data.tabWtEval != undefined) exp.tabWtEval = data.tabWtEval.rows;//计泡方式
                if (data.tabDep != undefined) exp.tabDep = data.tabDep.rows;//部门
                if (data.tabFiliale != undefined) exp.tabFiliale = data.tabFiliale.rows;//分公司
                if (data.tabUserGroup != undefined) exp.tabUserGroup = data.tabUserGroup.rows;//权限组
                if(data.info != undefined) exp.infoData = data.info.rows[0];
                if(i != 'add') {
                    ad.mainTabId = exp.infoData.id;
                    var url = "/general5/doSave";
                    if (page == 'user') 
                        ad.dlgEdit(url, $('#boxInfo'), exp.rows[i],'720px');                   
                    else
                        ad.dlgEdit(url, $('#boxInfo'), exp.rows[i]);                  
                }
            },
            error:function() {
                // alert('响应失败，请重新操作');
                l_status('error','保存失败');
            }
        })       
    }
    
    function modify(id,expData) {
        var url = dbTab + 'Details.aspx?id=' + id;
        if (dbTab == 'company') url = dbTab + 'Details.aspx?id='+id+'&companyId2='+expData;
        APLDevel.dlgFull(url);
    }

    //验证计算机是否开通
    function ktzt(e,num) {
        if (num == 1) {
            $('#kaitong').text('取消开通所选');
            $(e).attr('class','ktzt_ ktzt');
            $(e).next().attr('class','ktzt_');
        }else{
            $('#kaitong').text('开通所选');
            $(e).attr('class','ktzt_ ktzt');
            $(e).prev().attr('class','ktzt_');
        }      
        $('.listParamBox [type="hidden"]').val(num);
        ad.doList(1);
    }

    


    

