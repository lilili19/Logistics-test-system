
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

	var ad = new APLDevel();
	ad.preloader = "#preloader";//ajax遮罩
	ad.mapFile = "apiconfig.xml";//mapFile

	ad.doListEnd = function(data){
		if(data!=undefined && data!=null)
	    	exp.getData(data.rows);//显示表格数据
	};

	var apiId=APLDevel.getUrlParam("apiId");
	var apiName=APLDevel.getUrlParam("apiName");
	ad.listExtParam = "apiId="+apiId+"&apiName="+apiName;
	$('#exp h2').html("apiId:"+apiId+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;apiName:"+apiName);
	$('#boxInfo input[aplDataName="apiId"]').val(apiId);
	$('#boxInfo input[aplDataName="apiName"]').val(apiName);
	ad.listUrl = "/exp5/general5/doList";
	ad.doList(1);

	//修改
	function dlgEdit(i) {	   	 	 
	    exp.infoData = exp.rows[i];
	    ad.dbId = exp.infoData.id;
	    var url = "/exp5/general5/doSave";
        ad.dlgEdit(url, $('#boxInfo'), exp.rows[i]);
	}
	function dlgAdd(){	    
		exp.infoData={};
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