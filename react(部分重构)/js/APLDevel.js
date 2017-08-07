function APLDevel() {
    
}

APLDevel.time = function () {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    var strHours = date.getHours();
    var strMinutes = date.getMinutes();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    if (strHours >= 0 && strHours <= 9) {
        strHours = "0" + strHours;
    }
    if (strMinutes >= 0 && strMinutes <= 9) {
        strMinutes = "0" + strMinutes;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + strHours + seperator2 + strMinutes;
    return currentdate;
}

//验证权限
APLDevel.level = function(){
    if(levelData!=undefined){
        $("[data-level]").each(function () {
            var levelName = $(this).attr("data-level");
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

APLDevel.dataName = "data-name";//本框架的元素数据名称
//验证2
APLDevel.customVertion = null;//用于最后自定义验证
APLDevel.VerTips = null;//选取名称标签  
APLDevel.VerName = "data-ver";//添加的验证属性
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

//全选
APLDevel.checkAll = function(box, e){
    $(box).find('input[type="checkbox"]').prop("checked", $(e).is(':checked'));
};

APLDevel.dlgFull = function(url, titleV) {
    if(titleV==undefined) titleV=false;
    l_popup({
        url:url,
    })
}

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

//------------分页类-------------------
function APLPage() {
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

    //绑定页码
    this.bindPageNumber = function () {
        $(_this.pageBox+' li').click(function() {
            if ($(this).html() == _this.pageIndex) return;            
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
            if(_this.onChange!=null) _this.onChange(_this.pageIndex);
        });
        if(_this.pageIndex<=1) redNumber = 0;
        $(_this.pageBox+' li').eq(redNumber).attr('class','show').siblings().attr('class','');
    };
};