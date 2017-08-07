function APLDevel() {
    this.host = "http://192.168.1.107:85"; //host用于本地调试，上传到服务器后host要设为空,
    // this.host = "http://192.168.1.126:2244";
    //this.host = "";
    this.mapFile = "";//map文件
    this.success=null; //ajax返回事件
    this.id = 0;//数据库id
    this.mainTabId=0;
    this.ajaxType = "json";//ajax返回数据类型
    this.preloader = null;//ajax遮罩    
    this.bindTabNames = null;  //绑定的公共表，可用逗号隔开多个 如transit,currency
    this.rsIndex = 1;//记录序号
    this.doListEnd = null; //查询后回调函数
    this.pageIndex=1; //当前页码
    this.pageSize=0;//单页显示条数   
    this.listParamBox = null; //查询参数容器
    this.listExtParam = null; //查询扩展参数
    this.listUrl = null;//查询的url
    var _this=this;

    //查询
    this.doList = function(pIndex, pSize){
        if(pIndex!=undefined && pIndex!=null)
            _this.pageIndex = pIndex;
        if(pSize!=undefined && pSize!=null)
            _this.pageSize = pSize;
        _this.rsIndex = (_this.pageIndex-1)*_this.pageSize+1;

        var postData = "mapFile="+_this.mapFile;
        var params = null;
        if(_this.listParamBox !=null) params = APLDevel.getBoxData(_this.listParamBox);       
        if(params!=null && params!="") postData +="&"+params;
        if(_this.pageIndex!=undefined && _this.pageIndex!=null && _this.pageIndex>0) postData += "&pageIndex=" + _this.pageIndex;
        if(_this.pageSize!=undefined && _this.pageSize!=null && _this.pageSize>0) postData += "&pageSize=" + _this.pageSize;
        if( _this.listExtParam!=null && _this.listExtParam!=undefined) postData +="&"+_this.listExtParam;
        if( _this.bindTabNames!=null && _this.bindTabNames!=undefined){
            postData +="&bindTabNames="+_this.bindTabNames;
            _this.bindTabNames = null;
        }
        var url = _this.host + _this.listUrl;
        if(_this.preloader!=null) $(_this.preloader).show();
        $.ajax({
            type:"post",
            url:url,
            data:postData,
            dataType: "json",
            success:function(data){
                if(_this.doListEnd!=null) _this.doListEnd(data);
                if(_this.preloader!=null) $(_this.preloader).hide();
            },
            error:function(){
                // alert('加载失败');
                l_status('error','加载失败');
                if(_this.preloader!=null) $(_this.preloader).hide();
            }
        })
    }; 

    //详情
    this.doInfo = function(url){  
        if (_this.mainTabId == null) _this.mainTabId = 0;      
        var postData = "mapFile="+_this.mapFile+"&id="+_this.mainTabId;
        if( _this.bindTabNames!=null && _this.bindTabNames!=undefined){
            postData +="&bindTabNames="+_this.bindTabNames;
            this.bindTabNames = null;
        }
        url = _this.host+url;
        _this.ajax('post',url,postData);
    };

    //弹出框编辑页
    this.dlgEdit = function(url, box, boxData, w, h,extData){
        _this.rsIndex = (_this.pageIndex-1)*_this.pageSize+1;
        var dlgArea = undefined;
        if(w!=undefined && h!=undefined)
            dlgArea = [w, h];
        l_popup({
            title: '详细信息',
            content: box,
            btn: '保存',
            width:w,
            yes: function(index){
                _this.success = function(data){
                    if(data.success==true) {
                        l_popup.close(index);
                        if(boxData!=undefined && boxData!=null && boxData.id>0)
                            APLDevel.boxFillData(box, boxData);
                        else{
                            ad.pageIndex=1;
                            _this.doList();
                        }
                    }
                }
                _this.doSave(url, box,extData);                 
            }
        })
    };

    //保存
    this.doSave = function(url, box, extData){
        _this.rsIndex = (_this.pageIndex-1)*_this.pageSize+1;
        if (!APLDevel.Vertion(box)) return;  
        var postData = "mapFile="+_this.mapFile;
        if(_this.id>0) postData+="&id="+_this.id;
        if(_this.mainTabId>0) postData+="&mainTabId="+_this.mainTabId;
        var fData = APLDevel.getBoxData(box, 1);
        if(fData!=undefined && fData!=null && fData.length>0) postData +="&"+fData;
        if(extData!=undefined && extData!=null && extData.length>0) postData +="&"+extData; 
        url = _this.host + url;
        return _this.ajax('post',url,postData, false);
    };

    //保存行
    this.doSaveRow = function(url, e, extData){
        if(_this.mainTabId==0)
        {
            //alert("请先保存基本信息");
            //return;
        }
        if(APLDevel.VerTips==null) APLDevel.VerTips = $(e).parent().parent().parent().children().eq(0).find("span");;
        if (!APLDevel.Vertion($(e).parent().parent())) return;

        var rowData = APLDevel.getBoxData($(e).parent().parent(), 1);
        if(rowData=="" || rowData==null){
            alert("保存行数据不能为空");
            return;
        }        
        var postData = "mapFile="+_this.mapFile+"&mainTabId="+_this.mainTabId;
        if(rowData!=undefined && rowData!=null && rowData.length>0) postData +="&"+rowData;
        if(extData!=undefined && extData!=null && extData.length>0) postData +="&"+extData;

        _this.success = function (data) {
            if(data.Error!=undefined) { alert(data.Error);return; }
            if(data.id!=undefined) {
                $(e).parent().parent().find("["+APLDevel.dataName+"=rowId]").val(data.id);
                $(e).parent().parent().find("["+APLDevel.dataName+"]").attr("disabled",true);
                $(e).parent().find("[name=btnEditRow]").show();
                $(e).parent().find("[name=btnSaveRow]").hide();
            }
        };
        url = _this.host + url;
        return _this.ajax('post',url,postData, false);
    };

    //删除
    this.doDel = function(url, id, extData){
        if (id == "" || id==undefined || id==null || id<=0) {
            alert("删除的数据不能为空");
            return;
        }
        var msg="";
        if(APLDevel.checkCount>0){
            msg="确定删除这"+APLDevel.checkCount+"条记录吗？";
            APLDevel.checkCount = 0;
        }
        else{
            msg="确定删除这条记录吗？";
        }
        if(confirm(msg)==false) return false;
        
        var postData = "mapFile=" + _this.mapFile + "&id=" + id;
        if(extData!=undefined && extData!=null && extData!="") postData += "&" + extData;
        url = _this.host + url;
        return _this.ajax('post',url, postData,false);
    };

    //删除行
    this.delRow = function (url, id, e, extData, box) {
        var tabObj=null,rowObj=null;        
        if(id=="rowId") {
            rowObj = e.parentNode.parentNode;
            tabObj = rowObj.parentNode;
            id = $(rowObj).find("["+APLDevel.dataName+"=rowId]").val();
            if(id!=undefined && id>0){
                if(_this.doDel(url, id, extData))
                    tabObj.removeChild(rowObj);
            }else
                tabObj.removeChild(rowObj);
        }
        else{

            if(_this.doDel(url, id, extData)){                
                _this.doList();
                if(box != null && box != undefined)
                    $(box+' input[type=checkbox]:checked').prop("checked", false);
            }
        }
    };

    //添加行
    this.addRow = function(tabObj,n){
        if(!n) n = 1;
        var arr = [];
        var row="";
        for(var i=0;i<parseInt(n);i++){
            row = $(tabObj + " .newRow").prop("outerHTML");  
            row = APLDevel.replaceAll(row, "class=\"newRow\"", "");
            arr.push(row);
        }        
        var strHtml = String(arr);
        $(tabObj+" tbody").append(strHtml);
    };

    //编辑行
    this.editRow = function(e){
        $(e).parent().find("[name=btnEditRow]").hide();
        $(e).parent().find("[name=btnSaveRow]").show();
        $(e).parent().parent().find("["+APLDevel.dataName+"]").attr('disabled',false);
    };

    //导出列表
    this.doExportList = function(url, extData){
        var postData = "mapFile="+_this.mapFile;
        var params = null;
        if(_this.listParamBox !=null) params = APLDevel.getBoxData(_this.listParamBox);
        if(params!=null && params!="") postData +="&"+params;
        if(extData!=null && extData!=undefined) postData +="&"+extData;
        url = _this.host + url;
        APLDevel.creaForm("doExportList", url, postData);
    };

    //打印
    this.doPrint = function(url, data){
        var postData = "mapFile="+_this.mapFile;
        url = _this.host + url;
        APLDevel.creaForm("doPrint", url, postData);
    };

    this.ajax = function(type,url,data,async){
        if(_this.preloader!=null) $(_this.preloader).show();
        if(async==undefined) async=true;//默认是异步
        var succ=false;
        if(async) succ=true;//异步，就返回true
        $.ajax({
            type:type,
            url:url,
            data:data,
            async:async,
            dataType:_this.ajaxType,
            success:function(data){
                if(data!=null && data.success!=undefined)
                    succ = data.success;

                if(data!=null && data.Message!=undefined)
                    // alert(data.Message);
                    l_status('success',data.Message);

                if(data!=null && data.Error!=undefined)
                    alert(data.Error);
                else if(_this.success!=null)
                    _this.success(data);
                _this.success = null;//清除返回事件
                if(_this.preloader!=null) $(_this.preloader).hide();
            },
            error:function(){
                // alert('提交失败!');
                l_status('error','提交失败');
                if(_this.preloader!=null) $(_this.preloader).hide();
            }
        });
        return succ;
    };
};

//验证权限
APLDevel.level = function(){
    if(levelData!=undefined){
        $("[level]").each(function () {
            var levelName = $(this).attr("level");
            if(levelData["ok"]==2 || levelData[levelName]==1)                
                $(this).show();
        });
    }
}

//验证1
APLDevel.Verification = function (arr1,arr2,arr3){
    for (var i = 0; i < arr1.length; i++) {
        var arr = arr3[i].split('=');
        if (arr[0] == 'input') {
            if (arr[1].indexOf('-') == -1) {
                if (arr1[i].val() == '' || arr1[i].val() == null) {
                    l_tips(arr2[i]+'不能为空',arr1[i]);
                    return false;
                }
                if (arr1[i].val().length != arr[1]) {
                    l_tips('只能输入'+arr[1]+'位',arr1[i]);
                    return false;
                }              
            }else{
                var arr_ = arr[1].split('-');                
                if (arr1[i].attr("type") == 'number') {
                    if (arr_[0] != null && arr_[0] != '') {
                        if (arr1[i].val() == '' || arr1[i].val() == null) {
                            l_tips(arr2[i]+'不能为空',arr1[i]);
                            return false;
                        }                                 
                        if (arr1[i].val() >= (arr_[1]+1) || arr1[i].val() < arr_[0]) {
                            l_tips('大小限定'+arr[1],arr1[i]);
                            return false; 
                        }                                             
                    }else{                      
                        if (arr1[i].val() < 0) {
                            l_tips(arr2[i]+'不能小于0',arr1[i]);
                            return false;
                        }
                        if (arr1[i].val() - arr_[1] > 1) {
                            l_tips(arr2[i]+'不能超过'+(arr_[1]+1),arr1[i]);
                            return false;
                        }                        
                    }
                }else if (arr1[i].attr("type") == 'text' || !arr1[i].attr("type")) {
                    if (arr_[0] == 0) {
                        if (arr1[i].val().length > arr_[1]) {
                            l_tips(arr2[i]+'不能超过'+arr_[1]+'位',arr1[i]);
                            return false;
                        }
                    }else{
                        if (arr1[i].val() == '' || arr1[i].val() == null) {                         
                            l_tips(arr2[i]+'不能为空',arr1[i]);
                            return false;
                        }
                         if (arr1[i].val().length > arr_[1] || arr1[i].val().length < arr_[0]) {
                            l_tips('请输入'+arr[1]+'位',arr1[i]);
                            return false;
                        }
                    }
                }                
            }
        };  
    }
    return true;
};

APLDevel.dataName = "aplDataName";//本框架的元素数据名称
//验证2
APLDevel.customVertion = null;//用于最后自定义验证
APLDevel.VerTips = null;//选取名称标签  
APLDevel.VerName = "Verification";//添加的验证属性
APLDevel.Vertion = function(box,e,eTitle){ 
    //box = '#id'所需验证此行的容器
    //e = $(this) 所需验证的单个节点（若传则验证单个）
    //eTitle = $(this).prev() 所需验证单个名称的节点 
    var arr1=[],arr2=[],arr3=[];
    if (e == null) {
        var Verification = $(box).find('['+APLDevel.VerName+']');
        var span = null;
        if(APLDevel.VerTips!=null){
            span = APLDevel.VerTips;
            APLDevel.VerTips = null;
        }
        else{
            //span = $(box).find("[verifyName]"); 
            span = $(box).find("span");
        }
        for (var i = 0; i < Verification.length; i++) {                    
            arr2[i] = span.eq(i).text().replace(":","").replace("：","");
            arr1[i] = Verification.eq(i);
            arr3[i] = 'input='+arr1[i].attr(APLDevel.VerName);
        }
    }else{
        arr2[0] = eTitle.text().replace(":","").replace("：","");
        arr1[0] = e;
        arr3[0] = 'input='+arr1[0].attr(APLDevel.VerName);
    } 
    var rVal = APLDevel.Verification(arr1,arr2,arr3);
    if(rVal && box!=null && APLDevel.customVertion!=null)
        rVal = APLDevel.customVertion(box);
    APLDevel.customVertion=null;

    return rVal;
};

//限制小数点位数
APLDevel.clearVal = null;
APLDevel.clearNoNum = function (e,n){
    //只能输入两个小数
    var num = "";
    for (var i = 0; i < n+1; i++) {
        num += "\\d";
    }
    var str = "/\^(\\-)*(\\d+)\\.(" + num + ").*$/";
    var patt1=new RegExp(eval(str));

    result=patt1.test($(e).val());
    if (result) {
        $(e).val(APLDevel.clearVal);
    }else{
       APLDevel.clearVal = $(e).val();
    }
};

//元素绑定验证
APLDevel.bindVertion = function(box, p){
    if(p==undefined) p=0;
    $(box).find("input[Verification],textarea[Verification]").blur(function(){
        if(p==0)
            APLDevel.Vertion(null,$(this),$(this).prev());
        else if(p==1)
            APLDevel.Vertion(null,$(this),$(this).parent().prev());       
    }) 
};

//获取容器的数据
APLDevel.getBoxData = function(box, isNull){
    var data="",name = null, val = null, correName = null, correVal = null;
    $(box).find("["+APLDevel.dataName+"]").each(function () {
        name = $(this).attr(APLDevel.dataName);     
        val = $(this).val();
        if(val!="******" && ((val!=undefined && val!=null && val!="") || (isNull!=undefined && isNull!=null))) {            
            correVal = null; correName = $(this).attr("corre");
            if (correName != undefined && correName != null) correVal = $(box).find("["+APLDevel.dataName+"="+correName+"]").val();
            if (correVal != null && correVal != undefined && correVal.length==0) val=""; 

            if((val==undefined || val.length==0) && $(this).attr("nullVal")) 
                val = $(this).attr("nullVal"); 

            if((val==undefined || val.length==0) && $(this).attr("type")=="number")
                val = "0"; 

            if(val!="" || (isNull!=undefined && isNull!=null)){
                val = APLDevel.replaceAll(val, "+","%2B");
                val = APLDevel.replaceAll(val, "&","%26");
                if(data!="") data += "&";
                data += name + "=" + val;
            }
        }
    });
    return data;
};

//容器数据填充到json数据 
APLDevel.boxFillData = function(box, data){
    $(box).find("["+APLDevel.dataName+"]").each(function () {
        var name = $(this).attr(APLDevel.dataName);
        data[name] = $(this).val();
    });
};

//JSON数据填充到容器
APLDevel.dataFillBox = function(box, data){
    $(box).find("["+APLDevel.dataName+"]").each(function () {
        var name = $(this).attr(APLDevel.dataName);
        $(this).val(data[name]);
    });
};


//获取所有行(或选择行)
APLDevel.getRows = function(re, check, names){
    //re 选择器
    //check =“check”是否选择行，=null所有行
    //names 指定字段  =null =undefined 全部字段
    var xmlDatas = "";
    if(names!=null && names!=undefined && names!="") names=","+names+",";
    var n =  $(re).length;
    for (var i = 1; i < n; i++) {
        if(check==undefined || check==null || (check=="check" && $(re).eq(i).find('[type="checkbox"]').is(':checked'))){
            var dr = "";
            $(re).eq(i).find('['+APLDevel.dataName+']').each(function(){
                var name =  $(this).attr(APLDevel.dataName);
                var val = $(this).val();
                if(val!="" && (names==undefined || names==undefined || names.indexOf(","+ name+",")>-1))
                    dr += '<'+name+'>'+val+'</'+name+'>';
            });
            if(dr!="")
                xmlDatas += '<row>' +dr+ '</row>';
        }
    }
    if(xmlDatas!="")
        xmlDatas = '<root>'+xmlDatas+'</root>';

    return xmlDatas; //返回xml
};

//选择checkbox的值
APLDevel.checkCount = 0;
APLDevel.getChecks = function(box){
    APLDevel.checkCount = 0;
    var ids ="";
    $(box).find('input[type=checkbox][value]:checked').each(function(){
        if (APLDevel.checkCount== 0)
            ids += $(this).val();
        else
            ids +="," + $(this).val();
        APLDevel.checkCount++;
    });
    return ids;
}

APLDevel.creaChecks = function(box, datas, textName, valName) {
    var n = datas.length;
    var str="";
    for (var i = 0; i < n; i++){
        str += '<input type="checkbox" value="'+datas[i][valName]+'"><label style="margin-right: 10px">'+datas[i][textName]+'</label>';
    }
    $(box).html(str);
};

APLDevel.setChecks = function(re, vals) {
    if(vals==undefined || vals==null || vals=="") return;
    vals = ","+vals+",";
    $(re).each(function(){
        var val = ","+ $(this).val()+",";
        if(vals.indexOf(val)>-1)  $(this).prop("checked", true);
    });
};

//全选
APLDevel.checkAll = function(box, e){
    $(box).find('input[type="checkbox"]').prop("checked", $(e).is(':checked'));
};

//弹出框
APLDevel.dlgIndex=0;
APLDevel.dlg = function(type, box, title, w, h, btn, method){
    /*if (box == "dayRange") {
        var toDay = new Date();
        var strDay = APLDevel.dayFormat(toDay);
        box = "<div style=\"padding: 10px 20px\"> <div class='row'>起始日期:<input id='dlg_Time1' type='text' onfocus=\"WdatePicker({maxDate:'#F{$dp.$D(\\'dlg_Time1\\')||\\'%y-%M-%d\\'}'})\"  class='input-text Wdate' style=\"width:120px\" value=\"" + strDay + "\"  /></div><br>";
        box += "<div class='row'>截止日期:<input id='dlg_Time2'  type='text' onfocus=\"WdatePicker({maxDate:'#F{$dp.$D(\\'dlg_Time2\\')||\\'%y-%M-%d\\'}'})\"  class='input-text Wdate'  style=\"width:120px\"  value=\"" + strDay + "\"  /></div><br>";
        //w = 280; h = 220;
    }*/
    if(box==null || box=="") { alert("弹出框内容不能为空"); return;}
    var dlgArea = undefined;
    if(w!=undefined && w!=null && h!=undefined && h!=null)
        dlgArea = [w, h];
    l_popup({
        title: title,
        content: box,
        btn: btn,
        width:w,
        yes: function(index){
            if(method!=undefined && method!=null) method(box,index);          
        }
    })
};

APLDevel.dlgFull = function(url, titleV) {
    if(titleV==undefined) titleV=false;
    l_popup({
        url:url,
    })
}

//关闭当前弹出框
APLDevel.closeDlg = function(){
    if(APLDevel.dlgIndex > 0){
        layer.close(APLDevel.dlgIndex);
        APLDevel.dlgIndex=0;
    }
};


//替换
APLDevel.replaceAll = function (s1, sp, sn) {
    if (s1 == null || s1 == undefined) return "";
    var r = new RegExp(sp.replace(/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g, "\\$1"), "ig");
    return s1.replace(r, sn);
};

//获取地址栏参数
APLDevel.getUrlParam = function(name){
    var reg = new RegExp("(^|&)"+name+"=([^&]*)(&|$)");
    var result = window.location.search.substr(1).match(reg);
    return result?decodeURIComponent(result[2]):null;
};

//创建表单
APLDevel.creaForm = function(name, url, data, target) {
    var formObj = null;
    if ($("form") != null && $("form") != undefined) {
        $("form").each(function () {
            if ($(this).attr("name") == name) {
                formObj = $(this);
            }
        });
    }

    var isNewForm = 0;
    if (formObj != null) {
        $(formObj).find("input").remove();
    }
    else {
        formObj = $("<form></form>");
        $(formObj).attr("name", name);
        $(formObj).css("display", "none");
        if (target == undefined) target ="_blank";
        $(formObj).attr("target", target);
        $(formObj).attr("method", "post");
        isNewForm = 1;
    }

    var vals, inputObj;
    var datas = data.split("&");
    $(datas).each(function (i) {
        vals = datas[i].split("=");
        inputObj = $("<input type='hidden' name='" + vals[0] + "' />");
        //inputObj.attr('value', vals[1]);
        inputObj.val(vals[1]);
        $(formObj).append(inputObj);
    });

    if (isNewForm == 1)
        $(formObj).appendTo("body");

    $(formObj).attr('action', url);
    $(formObj).submit();
};

//格式化日期
APLDevel.dayFormat = function (dayVal) {
    var y = dayVal.getFullYear();
    var m = dayVal.getMonth() + 1;
    var myStrM = "" + m
    if (m < 10) myStrM = "0" + myStrM;
    var d = dayVal.getDate();
    var myStrD = "" + d;
    if (d < 10) myStrD = "0" + d;
    var rVal = y + '-' + myStrM + '-' + myStrD;
    return rVal;
};

//按回车，跳光标
APLDevel.nextFocus = function (box) {
    if (box == undefined || box == "") box = "#body";
    $(box + " input:not(:hidden),select").bind('keydown', function (evt) {
        var key = evt.keyCode ? evt.keyCode : evt.which;
        if (key == 13) {
            var inputs = $(box + " input:not(:hidden):enabled,select:enabled");
            var idx = inputs.index(this);
            var type = inputs[idx + 1].type;
            if (idx < inputs.length - 1) {
                if (type == "button") {
                    $(inputs[idx + 1]).click();
                }
                else {
                    $(inputs[idx + 1]).focus();
                }
                if (type == "text") $(inputs[idx + 1]).select();
            }
            return false;
        }
    });
};

//------------分页类-------------------
function APLPage() {
    // var j=1;//初始化页面
    this.pageBox=null;//分页容器（选择器） 
    this.pageShowCount=5;//显示页码数，默认为5页
    this.pageSize=20;//单页显示条数，默认为20条
    this.pageIndex=1; //当前页码，初始为1
    this.onChange = null;//翻页
    this.selPageSize = null;//页大小选择器
    var pageCount=0;//总页数
    var redNumber = 0;//当前页码，红色

    var _this = this;
    //显示页码
    this.show = function(rowCount){
        if(rowCount==null || rowCount==undefined) rowCount=0;
        pageCount = Math.ceil(rowCount/_this.pageSize);//页面长度
        var string="";

        if (pageCount >= _this.pageShowCount) {
            for (var i = 0; i < _this.pageShowCount; i++) {
                if (_this.pageIndex%_this.pageShowCount == 0) {
                    if (i+1+_this.pageShowCount*(Math.floor(_this.pageIndex/_this.pageShowCount)-1)>pageCount) continue;
                    string += "<li>"+(i+1+_this.pageShowCount*(Math.floor(_this.pageIndex/_this.pageShowCount)-1))+"</li>";
                }else if(_this.pageIndex%_this.pageShowCount != 0){
                    if ((i+1+_this.pageShowCount*Math.floor(_this.pageIndex/_this.pageShowCount))>pageCount) continue;
                    string += "<li>"+(i+1+_this.pageShowCount*Math.floor(_this.pageIndex/_this.pageShowCount))+"</li>";
                }
            }
        }else{
            for (var i = 0; i < pageCount; i++) {
                string += "<li>"+(i+1)+"</li>";
            }
        }

        $(_this.pageBox+'').html('<div>首页</div><p>上一页</p>'+string+'<p>下一页</p><div>尾页</div><span>共'+rowCount+'条</span><span>共'+pageCount+'页</span><input type="text"><button>跳 转</button>');
        _this.bindPageNumber();
        if (pageCount != 0) {
            if (_this.pageIndex == 1) {
                $(_this.pageBox+' div').eq(0).attr("class","not");
                $(_this.pageBox+' p').eq(0).attr('class','not');
            }else{
                $(_this.pageBox+' div').eq(0).attr('class','yes');
                $(_this.pageBox+' p').eq(0).attr('class','yes');
            }
            if (_this.pageIndex == pageCount) {
                $(_this.pageBox+' div').eq(1).attr('class','not');
                $(_this.pageBox+' p').eq(1).attr('class','not');
            }else{
                $(_this.pageBox+' div').eq(1).attr('class','yes');
                $(_this.pageBox+' p').eq(1).attr('class','yes');
            }
        }else{
            $(_this.pageBox+' div').eq(0).attr("class","not");
            $(_this.pageBox+' div').eq(1).attr("class","not");
            $(_this.pageBox+' p').eq(0).attr('class','not');
            $(_this.pageBox+' p').eq(1).attr('class','not');
        }       
    };

    //绑定页大小下拉框
    this.bindSelPageSize  = function () {
        if(_this.selPageSize!=undefined && _this.selPageSize!=null){
            $(_this.selPageSize).change(function(){
                _this.pageSize=$(_this.selPageSize).val();
                _this.pageIndex = 1;
                redNumber = 0;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex, _this.pageSize);
            });
        }
    };

    //绑定页码
    this.bindPageNumber = function () {
        $(_this.pageBox+' li').click(function() {
            if ($(this).html() == _this.pageIndex) return;
            // var i = $(_this.pageBox+' li').index(this);             
            _this.pageIndex = $(this).html();
            redNumber = (_this.pageIndex-1)%_this.pageShowCount;
            if(_this.onChange!=null) _this.onChange(_this.pageIndex);
        });        
        $(_this.pageBox+' div').click(function(){
            var i = $(_this.pageBox+' div').index(this);
            if (i == 0) {
                if (_this.pageIndex <= 1) {
                    return;
                }
                _this.pageIndex = 1;
                redNumber = 0;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex);
            }else if(i == 1){
                if (_this.pageIndex == pageCount || pageCount == 0) {
                    return;
                }
                _this.pageIndex = pageCount;
                redNumber = (_this.pageIndex-1)%_this.pageShowCount;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex);
            }
        });
        $(_this.pageBox+' p').click(function(){
            var i = $(_this.pageBox+' p').index(this);
            if (i == 0) {
                if (_this.pageIndex <= 1) {
                    return;
                }
                _this.pageIndex--;
                redNumber = (_this.pageIndex-1)%_this.pageShowCount;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex);
            }else if(i == 1){
                if (_this.pageIndex == pageCount || pageCount == 0) {
                    return;
                }
                _this.pageIndex++;
                redNumber = (_this.pageIndex-1)%_this.pageShowCount;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex);
            }
        });
        $(_this.pageBox+' button').click(function(){
            if (isNaN($(_this.pageBox+' input').val())) {
                alert('输入不规范');
                return;
            }
            if ($(_this.pageBox+' input').val() == '' || $(_this.pageBox+' input').val() == null) {
                alert('跳转页不能为空');
                return;
            }
            if ($(_this.pageBox+' input').val() < 1) {
                alert('页面必须不小于1');
                return;
            }
            if ($(_this.pageBox+' input').val() >= pageCount+1) {
                alert('页面超出范围');
                return;
            }
            _this.pageIndex = Math.floor($(_this.pageBox+' input').val());
            redNumber = (_this.pageIndex-1)%_this.pageShowCount;
            // alert(redNumber)
            if(_this.onChange!=null) _this.onChange(_this.pageIndex);
        });
        if(_this.pageIndex<=1) redNumber = 0;
        $(_this.pageBox+' li').eq(redNumber).attr('class','show').siblings().attr('class','');
    };
};