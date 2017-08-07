    var ad = new APLDevel();
    ad.preloader = "#preloader";//ajax遮罩
    ad.host = "http://192.168.1.135:9441";
    // ad.listExtParam = "mapName=list";

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
            updateOrder:function(index) {
                update(index);
            },
            addOrder:function(index) {
                add(index);
            }            
        }
    });

    ad.doListEnd = function(data){
        if(data!=undefined && data!=null){
            exp.getData(data.rows);//显示表格数据            
        }
    };
    // ad.listUrl = "/exp5/general5/doList";
    ad.listUrl = "/updateOrder/doListAccount";
    ad.doList(1);

    //更新
    function update(index){
        var postData = 'appId=' + exp.rows[index].apiId 
        + '&appName=' + exp.rows[index].apiName;
        var url = ad.host + "/updateOrder/GetOrder";
        $.ajax({
            type:'post',
            url:url,
            data:postData,
            dataType:'json',
            success:function(data) {
                alert(data.Message);
            },
            error:function() {
                alert('查询失败');
            }
        })
    }
    //添加转单号
    function add(index) {
        exp.infoData = exp.rows[index];
        $('#boxInfo [aplDataName="sVal"]').val('');
        APLDevel.dlg(1,$('#boxInfo'),'添加转单号','520px','auto','保存',save);
    }
    //保存
    function save(box) {
        APLDevel.VerTips = box.find('span').eq(box.find('span').length-1);
        if(!APLDevel.Vertion(box)) return;
        var postData = APLDevel.getBoxData(box);
        var url = ad.host + '/updateOrder/Sender';
        $.ajax({
            type:'post',
            url:url,
            data:postData,
            dataType:'json',
            success:function(data) {
                alert(data.Message);
            },
            error:function() {
                alert('添加失败');
            }
        })
    }
    
