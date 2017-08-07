function APLDevel() {
    this.host = "http://192.168.1.115:85"; //host用于本地调试，上传到服务器后host要设为空,
    //this.host = "http://dt1.apl-sys.com:5603";
    //this.host = ""; 
    this.mapFile = null;//map文件
    this.controller = null; //控制器  
    this.success=null; //ajax返回事件
    this.dbId = 0;//数据库id
    this.ajaxType = "json";//ajax返回数据类型
    this.preloader = null;//ajax遮罩
    this.doListEnd = null; //查询后回调函数
    this.pageIndex=1; //当前页码
    this.pageSize=0;//单页显示条数
    this.rsIndex = 1;//记录序号
    this.listParamBox = null; //查询参数容器
    this.listExtParam = null;//查询扩展参数
    this.bindTabNames = null;
    this.page = null;   
    var _this=this;

    //查询
    this.doList = function(pIndex, pSize){
        if(pIndex!=undefined) 
            _this.pageIndex = pIndex;
        if(pSize!=undefined)
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
            postData +="&"+_this.bindTabNames;
            this.bindTabNames = null;
        }
        var url = _this.host + _this.controller +"/doList";
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
                alert('加载失败'); 
                if(_this.preloader!=null) $(_this.preloader).hide(); 
            }
        })
    }

    //详情
    this.doInfo = function(){
        var url = _this.host+_this.controller +"/doInfo";
        var postData = "mapFile="+_this.mapFile+"&id="+_this.dbId;
        if( _this.bindTabNames!=null && _this.bindTabNames!=undefined){ 
            postData +="&"+_this.bindTabNames;
            this.bindTabNames = null;
        }
        _this.ajax('post',url,postData);
    }

    //弹出框编辑页
    this.dlgEdit = function(boxObj, boxData,i){ 
        _this.rsIndex = (_this.pageIndex-1)*_this.pageSize+1;      
        //boxData=exp.rows[i]
        layui.use('layer', function(){
            var layer = layui.layer;
            layer.open({
                type: 1,
                title: '详细信息',                      
                content: boxObj,
                btn: ['保存'],
                yes: function(index){   
                    // alert(_this.pageIndex+'+'+_this.pageSize);
                     _this.success = function(data){       
                        if(data.success==true) {               
                            layer.close(index);                     
                            if(boxData!=undefined && boxData!=null && boxData!=null && boxData!=undefined)                           
                                APLDevel.setDataForBox(boxObj, boxData, i);                          
                            else{
                                ad.pageIndex=1;
                                _this.doList();          
                            }
                        }
                    }
                    _this.doSave(boxObj);
                }
            });
        });  
    }

    //保存
    this.doSave = function(boxObj, method, extData){
        _this.rsIndex = (_this.pageIndex-1)*_this.pageSize+1;   
        if (!APLDevel.Vertion(boxObj)) return;
        if(method==undefined || method==null || method=="") method="doSave";
        var url = _this.host+_this.controller +"/" + method;
        var postData = "mapFile="+_this.mapFile+"&id="+_this.dbId;
        var fData = APLDevel.getBoxData(boxObj); 
        if(fData!=undefined && fData!=null && fData.length>0) postData +="&"+fData;
        if(extData!=undefined && extData!=null && extData.length>0) postData +="&"+extData;
        //alert(_this.success);
        _this.ajax('post',url,postData);
    };

    //保存行
    this.doSaveRow = function(e, modelName, extData){
        if(_this.dbId==0)
        {
            //alert("请先保存基本信息");
            //return;
        }
        var rowData = APLDevel.getBoxData($(e).parent().parent());
        if(rowData=="" || rowData==null){
            alert("保存行数据不能为空");
            return;
        }
        var url = _this.host+_this.controller +"/doSave";
        var postData = "mapFile="+_this.mapFile+"&modelName="+modelName+"&mainTabId="+_this.dbId;
        if(rowData!=undefined && rowData!=null && rowData.length>0) postData +="&"+rowData;
        if(extData!=undefined && extData!=null && extData.length>0) postData +="&"+extData;

        _this.success = function (data) {
            if(data.Error!=undefined) { alert(data.Error);return; }
            if(data.dbId!=undefined) {
                $(e).parent().parent().find("[aplDataName=rowId]").val(data.dbId);
                $(e).parent().parent().find("input[aplDataName]").attr("disabled",true);
                $(e).parent().find("[name=btnEditRow]").show();
                $(e).parent().find("[name=btnSaveRow]").hide();
            }
            if(data.Message!=undefined) alert(data.Message);
        };
        _this.ajax('post',url,postData);
    };

    //添加行
    this.addRow = function(tabObj,n){
        // if(!n) n = 1;
        // let lastRowArr = [];
        // let lastRowObj = $(`#${tabObj} tbody tr:last-child`).html();
        // lastRowObj = `<tr>${String(lastRowObj)}</tr>`;
        // for(let i=0;i<parseInt(n);i++){
        //     lastRowArr.push(lastRowObj);
        // }
        // $(`#${tabObj} tbody`).append(String(lastRowArr));
    };

    //编辑行
    this.editRow = function(e){
        $(e).parent().find("[name=btnEditRow]").hide();
        $(e).parent().find("[name=btnSaveRow]").show();
        $(e).parent().parent().find(`input[aplDataName]`).attr('disabled',false);
    };

    //删除
    this.doDel = function(id, extData, boxObj){
        //re为选择器
        if (id == "" || id==undefined || id==null || id<=0) {
            alert("删除的数据不能为空");
            return;
        }
        var content="";
        if(APLDevel.checkCount>0){
            content='<div id="layuiContent">确定删除这'+APLDevel.checkCount+'条记录吗？</div>', 
            APLDevel.checkCount = 0;
        }
        else
            content='<div id="layuiContent">确定删除这条记录吗？</div>';

        layui.use('layer', function(){
            var layer = layui.layer;
            layer.open({
                type: 1,
                title: '警告',                     
                content: content, 
                btn: ['确认删除'],
                yes: function(index){                    
                    _this.success = function(data){
                        layer.close(index); 
                        if(boxObj != null && boxObj != undefined) $(boxObj+' input[type=checkbox]:checked').prop("checked", false);
                        _this.doList();
                    }
                    var url = _this.host+_this.controller +"/doDel";
                    var postData = "mapFile=" + _this.mapFile + "&id=" + id;
                    if(extData!=undefined && extData!=null && extData!="") postData += "&" + extData;
                    _this.ajax('post',url, postData);  
                }
            });
        }); 
    }

    //导出列表
    this.doExportList = function(extData){
        var postData = "mapFile="+_this.mapFile;        
        var params = null;
        if(_this.listParamBox !=null) params = APLDevel.getBoxData(_this.listParamBox);       
        if(params!=null && params!="") postData +="&"+params;       
        if(extData!=null && extData!=undefined) postData +="&"+extData;
        var url = _this.host + _this.controller +"/doExportList";
        APLDevel.creaForm("exportList", url, postData);
    }

    //打印
    this.doPrint = function(data){
        var postData = "mapFile="+_this.mapFile;  
        var url = _this.host + _this.controller +"/doPrint";
        APLDevel.creaForm("doPrint", url, postData);
    }
    
    this.ajax = function(type,url,data){
        if(_this.preloader!=null) $(_this.preloader).show(); 
        $.ajax({
            type:type,
            url:url,
            data:data,
            dataType:_this.ajaxType,
            success:function(data){
                if(data!=null && data.Message!=undefined)
                    alert(data.Message);
                //alert(_this.success);
                if(data!=null && data.Error!=undefined)
                    alert(data.Error);
                else if(_this.success!=null){
                    _this.success(data);
                    _this.success = null;//清除返回事件
                }
                if(_this.preloader!=null) $(_this.preloader).hide();                 
            },
            error:function(){
                alert('提交失败!'); 
                if(_this.preloader!=null) $(_this.preloader).hide(); 
            }
        })
    }
};

//验证1
APLDevel.Verification = function (arr1,arr2,arr3){
    for (var i = 0; i < arr1.length; i++) {
        if (arr1[i].val() == '' || arr1[i].val() == null) {
            layer.tips(arr2[i]+'不能为空',arr1[i], {tips: [2,'red']});
            return false;
        };
        var arr = arr3[i].split('=');
        if (arr[0] == 'string') {
            if (arr[1].indexOf('-') == -1) {
                if (arr1[i].val().length > arr[1]) {
                    layer.tips(arr2[i]+'不能超过'+arr[1]+'位',arr1[i], {tips: [2,'red']});
                    return false;
                }
            }else{
                var arr_ = arr[1].split('-');
                if (arr1[i].val().length > arr_[1] || arr1[i].val().length < arr_[0]) {
                    layer.tips('请输入'+arr_[0]+'-'+arr_[1]+'位',arr1[i], {tips: [2,'red']});
                    return false;
                }
            }            
        };
    }

    return true;
}

//验证2
// APLDevel.VerSpan = "span";//选取名称标签
APLDevel.VerName = "Verification";//添加的验证属性
APLDevel.Vertion = function(boxObj,one){
    //boxObj='#id';
    //one=$(this);
    var Verification = $(boxObj).find('['+APLDevel.VerName+']');
    // var span = $(boxObj).find(APLDevel.VerSpan);
    var span = Verification.prev();
    var arr1=[],arr2=[],arr3=[]; 
    if (one == null) {
        for (var i = 0; i < Verification.length; i++) {
            arr2[i] = span.eq(i).html().split('：')[0].split(':')[0];
            arr1[i] = Verification.eq(i);
            arr3[i] = 'string='+Verification.eq(i).attr(APLDevel.VerName);
        }
    }else{
        arr2[0] = one.prev().html().split('：')[0].split(':')[0];
        arr1[0] = one;
        arr3[0] = 'string='+one.attr(APLDevel.VerName);
    }   
    return APLDevel.Verification(arr1,arr2,arr3);
}

//获取容器的数据
APLDevel.getBoxData = function(boxObj){ 
    var data="",name = null, val = null, correId = null, correVal = null;
    $(boxObj).find("[aplDataName]").each(function () {
        name = $(this).attr("aplDataName");
        val = $(this).val(); //alert(val);
        if (name != undefined && name != "" && val != "") {
            correVal = null; correId = $(this).attr("corre");
            if (correVal != null && correId != undefined) correVal = $("#" + correId).val();
            if (correVal == null || correVal == undefined || correVal != "") {
                if(data!="") data += "&";
                data += name + "=" + val;
            }
        }
    });
    return data;
}

//设置数据来自容器
APLDevel.setDataForBox = function(boxObj, boxData,index){ 
    //alert("APLDevel.setDataForBox");
    var dataTemp = {};
    dataTemp["id"] = boxData["id"];
    $(boxObj).find("[aplDataName]").each(function () {
        var name = $(this).attr("aplDataName");
        dataTemp[name] = $(this).val();
    });
    //alert("exp.rows[index]");
    //exp.rows[index] = dataTemp;
    exp.rows.splice(index, 1,dataTemp); 
}

//获取所有行(或选择行)
APLDevel.getRows = function(re, check, names){
    //re 选择器
    //check =“check”是否选择行，=null所有行
    //names 指定字段  =null =undefined 全部字段
    var xmlDatas = "";
    if(names!=null && names!=undefined && names!="") names=","+names+",";
    var n =  $(re).length;//alert(n);
    for (var i = 1; i < n; i++) {
        if(check==undefined || check==null || (check=="check" && $(re).eq(i).find('[type="checkbox"]').is(':checked'))){
            var dr = "";        
            $(re).eq(i).find('[aplDataName]').each(function(){                 
                var name =  $(this).attr('aplDataName'); 
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
}

//选择checkbox的值
APLDevel.checkCount = 0;
APLDevel.getChecks = function(boxObj){
    APLDevel.checkCount = 0;
    var ids ="";
    $(boxObj).find('input[type=checkbox][value]:checked').each(function(){ 
    //$(boxObj+' input[type=checkbox][value]:checked').each(function(){ 
         if (APLDevel.checkCount== 0) 
            ids += $(this).val();                
        else
            ids +="," + $(this).val();
        APLDevel.checkCount++;
    });

    return ids;
}

//全选
APLDevel.checkAll = function(boxObj, e){
    $(boxObj).find('input[type=checkbox][value]').prop("checked", $(e).is(':checked'));   
}

//替换
APLDevel.replaceAll = function (s1, sp, sn) {
    var r = new RegExp(sp.replace(/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g, "\\$1"), "ig");
    return s1.replace(r, sn);
};

//编码
APLDevel.escape = function (val) {
    if (val != undefined && val != null) {
        val = val.replace(/\+/g, '%2B');
        val = escape(val);
    }

    return val;
};

//获取地址栏参数
APLDevel.getUrlParam = function(name){
    var reg = new RegExp("(^|&)"+name+"=([^&]*)(&|$)");
    var result = window.location.search.substr(1).match(reg);
    return result?decodeURIComponent(result[2]):null;
}

//弹出框
APLDevel.dlg = function(boxObj, title, btn, method){
    if (boxObj == "dayRange") {
        var toDay = new Date();
        var strDay = APLDevel.dayFormat(toDay);
        boxObj = "<div style=\"padding: 10px 20px\"> <div class='row'>起始日期:<input id='dlg_Time1' type='text' onfocus=\"WdatePicker({maxDate:'#F{$dp.$D(\\'dlg_Time1\\')||\\'%y-%M-%d\\'}'})\"  class='input-text Wdate' style=\"width:120px\" value=\"" + strDay + "\"  /></div><br>";
        boxObj += "<div class='row'>截止日期:<input id='dlg_Time2'  type='text' onfocus=\"WdatePicker({maxDate:'#F{$dp.$D(\\'dlg_Time2\\')||\\'%y-%M-%d\\'}'})\"  class='input-text Wdate'  style=\"width:120px\"  value=\"" + strDay + "\"  /></div><br>";
        //w = 280; h = 220;
    }
    if(boxObj==null || boxObj=="") { alert("弹出框内容不能为空"); return;}

    layui.use('layer', function(){
        var layer = layui.layer;
        layer.open({
            type: 1,
            title: title,                      
            content: boxObj,
            btn: btn,
            yes: function(index){
                if(method!=null) method(boxObj); 
            }
        });
    });  
}

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
}

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
}

//按回车，跳光标
APLDevel.nextFocus = function (boxObj) {
    if (boxObj == undefined || boxObj == "") boxObj = "#body";
    $(boxObj + " input:not(:hidden),select").bind('keydown', function (evt) {
        var key = evt.keyCode ? evt.keyCode : evt.which;
        if (key == 13) {
            var inputs = $(boxObj + " input:not(:hidden):enabled,select:enabled");
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
    var j=1;//初始化页面
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
    }

    //绑定页码
    this.bindPageNumber = function () {      
        $(_this.pageBox+' li').click(function() {
            if ($(this).html() == _this.pageIndex) return;
            // var i = $(_this.pageBox+' li').index(this);             
            _this.pageIndex = $(this).html();
            redNumber = (_this.pageIndex-1)%_this.pageShowCount;
            if(_this.onChange!=null) _this.onChange(_this.pageIndex);     
        });
        if(_this.selPageSize!=undefined && _this.selPageSize!=null){ 
            $(_this.selPageSize).change(function(){
                _this.pageSize=$(_this.selPageSize).val();
                _this.pageIndex = 1;
                redNumber = 0;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex, _this.pageSize);  
            });
        }
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
                if (_this.pageIndex == pageCount) {
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
                if (_this.pageIndex == 1) {
                    return;
                }
                _this.pageIndex--;
                redNumber = (_this.pageIndex-1)%_this.pageShowCount;
                if(_this.onChange!=null) _this.onChange(_this.pageIndex);  
            }else if(i == 1){
                if (_this.pageIndex == pageCount) {
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