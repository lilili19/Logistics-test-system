	 // APLDevel.level();

	var ad = new APLDevel();
	ad.preloader = "#preloader";//ajax遮罩
	ad.mapFile = "fuel.xml";//mapFile	    
	//ad.listParamBox = ".listParamBox";//查询参数

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
	            tabTransit:[],
	        }
	    }, 
	    methods: {
	        setData: function(data){
	            this.rows = data.rows;
	            if(data.tabTransit!=undefined && data.tabTransit!=null)
	            	exp.tabTransit = data.tabTransit.rows;
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
	        exp.setData(data);//显示表格数据
	        page.pageIndex = ad.pageIndex;
	        page.show(data.rowCount);//显示页码
	    }
	};
	ad.bindTabNames = "transit";
	ad.listUrl = "/exp5/general5/doList";
	ad.doList(1);

	//修改
	function dlgEdit(i){
	    //exp.rows[i]["chargeCode"]="123";return;
	    exp.infoData = exp.rows[i];
	    ad.dbId = exp.infoData.id;
	    var url = "/exp5/general5/doSave";
	    ad.dlgEdit(url,$('#boxInfo'), exp.rows[i]);	        
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
		ad.delRow(url, id, null, null, ".content");
	}

	var adCountry = new APLDevel();
	adCountry.preloader = ".preloader";//ajax遮罩
	// adCountry.mapFile = "fuel.xml";//mapFile	

	var country = new APLPage();   
	country.pageBox=".pagesSearchBox";//分页容器
	country.pageSize=7;//页大小   
	country.onChange=adCountry.doList;
	adCountry.pageSize=country.pageSize;

	var Vm = new Vue({
		el:'#searchBoxInfo',
		data:{
			items:[],
		} 
	})

	adCountry.doListEnd = function(data){
	    if(data!=undefined && data!=null){	    	
	        Vm.items = data.rows;//显示表格数据
	        country.appIndex = adCountry.pageIndex;
	        country.show(data.rowCount);//显示页码	       
	    }
	};
	//选择国家弹出框
	function dateDlgAdd() { 			    	        
	    APLDevel.dlg(1,$('#searchBoxInfo'), "选择", "", "");
	    searchCountryList(1);
	}
	//默认（热门）
	function searchCountryList(_id,key) {
		$('#searchBoxInfo .searchCountryLocation').hide();
		if (_id == 1) {
			$('.searchCountry p').eq(0).attr('class','p_');
			$('.searchCountry p').eq(1).attr('class','');
			$('.searchCountryList').children().eq(0).show();
			$('.searchCountryList').children().eq(1).hide();
			$('.pagesSearchBox').hide();
		}else{
			$('.searchCountry p').eq(1).attr('class','p_');
			$('.searchCountry p').eq(0).attr('class','');
			$('.searchCountryList').children().eq(1).show();
			$('.searchCountryList').children().eq(0).hide();
			$('.pagesSearchBox').show();
			searchC(key);
		}
	}
	//选择（国家或筛选条件）发送请求
	function searchC(key,Whether) {
		countryOperation();
		if (key == null || key == undefined) key = "";
		adCountry.listExtParam = "method=country&key="+key+"&module=Search&Company=fw";
		adCountry.listUrl = "/search/doSearch";
		// var url = adCountry.host + "/search/doSearch";		
		var url = "http://plat.fw856.com:5903/ashx/Search.ashx";		
        var postData ="PageSize="+country.pageSize+"&PageIndex=1&first=1&"+adCountry.listExtParam;
        $('.preloader').show();
        if (Whether == "yes")
        	$('#searchBoxInfo .searchCountryLocation').show();
        else 
        	$('#searchBoxInfo .searchCountryLocation').hide();
        $.ajax({
            type : "post",
            url : url,
            data : postData,
            dataType : "json",
            error : function(errData){
                // SearchBox.my.key = null;
                // alert("Error loading " + errData);
            },
            success : function(data){
                Vm.items = data.Tab[0].Data;
                $('.preloader').hide();
                country.show(data.Tab[0].rsCount);
            }
        });       
	}
	//选定后填值并关闭弹框
	function showData(e) {
		$('#txtCountryNo').val(e.text());
		layer.closeAll();
	}

	$(function() {
		document.onclick=function() {
			$('#searchBoxInfo .searchCountryLocation').hide();			
			keydownNum = null;
		}	
	})

	//阻止事件冒泡
	function stopBubble(event) {
	 	event.stopPropagation(); 	
	}

	var keydownNum = null;
	function countryOperation() {
		keydownNum = null;
		$('.searchCountryLocation li').css('background-color','')
		$(window).off('keypress');
		window.onkeydown=function(ev) {
			if (ev.keyCode == 40) {
				if (keydownNum == null) {
					keydownNum = 0;
				}else if(keydownNum == $('.searchCountryLocation li').length-1){
					keydownNum = $('.searchCountryLocation li').length-1;
				}else{
					keydownNum++;
				}				
			}else if (ev.keyCode == 38) {
				if(keydownNum <= 0){
					keydownNum = 0;
				}else if(keydownNum != null){				
					keydownNum--;
				} 
			}
			if(keydownNum != null){
				$('.searchCountryLocation li').eq(keydownNum).css('background-color','red').siblings().css('background-color','');
				$('.searchCountryLocation div').css('background-color','white');
				$(window).one('keypress',function(ev){
					if (keydownNum == null) return;
					if (ev.keyCode == 13) {
						showData($('.searchCountryLocation li').eq(keydownNum));
					}
				});

			}			
		}
	}