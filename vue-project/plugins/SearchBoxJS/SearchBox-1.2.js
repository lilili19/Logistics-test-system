/*
*   更新升级Time：2017-03-01
*
* */
function SearchBox(){
    this.TabData = "";
    this.myMethod = null;
    this.rsCount = 0;
    this.PageSize = 7;
    this.PageIndex = 1;
    this.PageLength = 5;
    this.IsPageTotal = 0;
    this.url = "";
    this.pageStr = "";
    this.method = "";
    this.methodName = "";   // 新增methodName，请求提交method时，method的前缀可灵活改变，对于函数this.gogo
    this.key = "";
    this.data = "";
    this.setObj = null;
    this.setObj1 = null;
    this.defKey = "";
    this.defKey1 = "";
    this.defVal = "";
    this.valName = "";
    this.valName1 = "";
    this.cols = "";
    this.loca = null;
    this.ItemTabs = new Object(); //哈希表  tabFiliale 分公司    tabDep 部门  tabTransit  运转方式 SearchBox.my.
    this.KeyVals = new Array("", "", "", "");
    this.first = 1;
    this.layerIndex = 0;
    this.IsShow = 0;

    this.BoxSearch = function(){
        this.PageIndex = 1;
        this.key = null;
        this.gogo();
    };

    this.go = function(method,id,valName,key,data,myMethod){
        this.go2(method,id,valName,"","",key,data,myMethod);
    };

    //loca位置控件 method-方法   obj1-容器1   v1选字段1   obj2-容器2    v2选字段2 data-参数  key-关键字
    this.go2 = function(method,id,valName,id1,valName1,key,data,myMethod){
        //alert("go2 key = " + key);

        if (id == "") return;
        var obj = null, obj1 = null;

        if (typeof (id) == "object")
            obj = $(id);
        else
            obj = $("#" + id);

        if (id1 != "") obj1 = $("#" + id1);

        if (key != undefined && key == "") return; //key=null 一定弹出窗口  key=="" change为空（调过）  key!="" change不为空（执行搜索）

        this.key = null;

        if(key != undefined && key != null) this.key = key;

        this.data = "";

        if(data != undefined) this.data = data;

        this.myMethod = null;

        if(myMethod != undefined) this.myMethod = myMethod;

        this.setObj = obj;
        this.setObj1 = obj1;
        this.valName = valName;
        this.valName1 = valName1;
        this.method = method;
        this.loca = obj;

        //默认隐藏selKey
        //$("#selKey1").hide(); $("#selKey2").hide(); $("#selKey3").hide();
        //$("#divKey").hide(); $("#divSearchPage").hide();
        this.cols = ""; this.PageIndex = 1; this.IsShow = 0;
        SearchBox.my = this;
        this.gogo();
    };

    this.gogo = function(){
        SearchBox.my = this;

        var key = "",url = "";
        var postData = "PageSize=" + this.PageSize + "&PageIndex=" + this.PageIndex + "&first=" + this.first;

        if(this.url != null){
            url = this.url;
            //postData += "&method=" + this.method; // 请求method名字修改
            //alert("this.methodName = " + this.methodName);
            postData += "&" + this.methodName + "=" + this.method; // 请求method名字修改
        }else{
            url = "/Search/" + this.method
        }

        if(this.key){
            postData += "&" + this.data + "key=" + this.key;
        }

        if(this.key != null){
            if(this.setObj != null)
                $(this.setObj).val("");

            if(this.setObj1 != null)
                $(this.setObj1).val("");
        }

        $.ajax({
            type : "post",
            url : url,
            data : postData,
            dataType : "json",
            error : function(errData){
                SearchBox.my.key = null;
                alert("Error loading " + errData);
            },
            success : function(resData){
                //alert("$.ajax resDate = " + resData);
                SearchBox.my.first = 0;
                resData = {"success":true,"rowCount":2,"rows": [
                    {
                        "name": "双头锯1号",
                        "machInte": "aaaaaa"
                    },
                    {
                        "name": "双头锯3号",
                        "machInte": "ccccc"
                    }
                ]};
                SearchBox.my.show(resData); //弹出框
            }
        });
    };

    this.show = function(resData){
        //alert("resData = " + resData);

        // resData没有数据时：
            //注意：resData.rows(数据的表名) 根据项目的不同而改变，如：resData.Tab
            //resData.rows[0].rsCount(表格子数据个数)
        if(resData == undefined || resData == "null" || resData.rows == undefined || resData.rows == "") {
            layer.open({
                type : 1,
                shift : 2,
                skin : 'layui-layer-demo', //样式类名
                shadeClose : true, //开启遮罩关闭
                scrollbar : false,
                title : "选择",
                area : ['800px', '400px'],
                content : "无此相关数据"
            });
            if(SearchBox.my.key != null)
                $("#txtSearchKey").val(SearchBox.my.key);
            SearchBox.my.key = null;
            return;
        }

        // resData有数据时：
        var rsCount = 0;

        resData.rows[0].rsCount = resData.rows.length;
        //alert("resData.rows.length = " + resData.rows.length);

        SearchBox.my.TabData = resData;

        if(resData != undefined && resData != null && resData.rows[0].rsCount != undefined)
            rsCount = resData.rows[0].rsCount - 0;
        //alert("resData.rows[0].rsCount = " + resData.rows[0].rsCount);

        SearchBox.my.rsCount = rsCount;
        SearchBox.my.first = 0;
        if(rsCount == 1 && SearchBox.my.key != null){
        //当只有一条数据及key不为空,则显示到对应文本框中.
            SearchBox.showData(0);
            SearchBox.my.key = null;
            return;
        }

        var objTab = $("#tabSearchBox");
        //alert("objTab = " + objTab);
        if(objTab != undefined || objTab != ""){
            objTab.find("tr").each(function(i){
                //alert("i = " + i);
                if(i > 0)
                    $(this).remove();
            });
        }

        if(SearchBox.my.IsShow == 0){
            var strHtml = "";
            strHtml += '<div id="divSearch" style=""> <div style="margin-left:10px;margin-right:10px;margin-top:10px;"> ';
            strHtml += '  <div class="top10 bottom10" id="divKey">&nbsp;&nbsp;<select id="selKey1" onchange="SearchBox.my.PageChange(1)" style="display:none"><option value=""></option></select>&nbsp;&nbsp;<select id="selKey2" onchange="SearchBox.my.PageChange(1)" style="display:none"><option value=""></option></select>&nbsp;&nbsp;<select id="selKey3" onchange="SearchBox.my.PageChange(1)" style="display:none"><option value=""></option></select>&nbsp;&nbsp;关键字&nbsp;<input id="txtSearchKey" type="text" onchange="SearchBox.my.PageChange(1)">&nbsp;&nbsp;<input type="button" id="btnKeySearch" value="查找" class="button" onclick="SearchBox.my.PageChange(1)"></div>';
            strHtml += '    <table id="tabSearchBox"  class="table table-border table-bordered table-bg table-hover table-sort"  data-side-pagination="server" data-pagination="true" data-search="true" >';
            strHtml += '    <tbody><tr><td></td></tr></tbody> </table> ';
            strHtml += '<div id="divSearchPage"> </div></div> </div>';

            //弹出框设置
            SearchBox.my.layerIndex = layer.open({
                type : 1,
                shift : 2,
                //skin : 'layui-layer-demo', //样式类名
                shadeClose : true, //开启遮罩关闭
                scrollbar : true,
                title : "选择",
                area : ['800px','456px'],
                yes : function(i){
                    SearchBox.my.layerIndex = index;
                    alert(i);
                },
                content : strHtml
            });
            SearchBox.my.IsShow = 1;
        }

        var mothod = SearchBox.my.method;
        if(mothod == "users")
            SearchBox.my.cols = "c1,用户ID,70|c2,姓名,100";
        else if (mothod == "oper")
            SearchBox.my.cols = "name,岗位名称,80|machInte,设备接口,200";
        else if (mothod == "storeHouse")
            SearchBox.my.cols = "c1,编号,80|c2,库区,200";
        else if (mothod == "operPost")
            SearchBox.my.cols = "c1,编号,80|c2,岗位,200";
        else if (mothod == "profili")
            SearchBox.my.cols = "c1,型材编码,80|c2,型材描述,200";
        else if (mothod == "accessori")
            SearchBox.my.cols = "c1,玻璃编码,80|c2,玻璃描述,200";
        else if (mothod == "vetri")
            SearchBox.my.cols =  "c1,配件编码,80|c2,配件描述,200";
        else if (mothod == "trattamenti")
            SearchBox.my.cols = "c2,处理描述,200";
        else if (mothod == "colori")
            SearchBox.my.cols = "c1,颜色编码,80|c2,颜色描述,200";

        $("#divKey").show();
        //$("#selKey1").show();
        $("#BoxPage").show();

        if(SearchBox.my.key != undefined && SearchBox.my.key != null)
            $("#txtSearchKey").val(SearchBox.my.key);

        SearchBox.my.key = null;

        var trBody = "";
        var myCol;
        var myCols = SearchBox.my.cols.split('|');
        for(var colIndex in myCols){
            myCol = myCols[colIndex].split(',');
            if (myCol[1] != "") trBody += "<th style=\"width:" + myCol[2] + "px\">" + myCol[1] + "</th>";
        }
        //trBody += "</tr>";
        //alert("trBody = " + trBody);
        var firstTr = $("#tabSearchBox tr:first");

        if(firstTr != undefined)
            $(firstTr).html(trBody);

        SearchBox.showTab(resData);
        SearchBox.my.ShowPage();
    };

    this.AddSelItems = function(obj, title, items, val){
        var setVal = "", firstVal = "";
        if(val != undefined) setVal = val;
        var itemCount = 0;
        $(obj).empty();
        if(title != "0"){
            $(obj).append("<option value=''>" + title + "</option>"); itemCount++;
        }
        $(items).each(function (i){
            if(this.t == "default"){
                if(setVal == "")
                    setVal = this.v;
            }
            else{
                if (i == 0) firstVal = this.v;
                $(obj).append("<option value='" + this.v + "'>" + this.t + "</option>");
                itemCount++;
            }
        });
        if(setVal == "" && title == "0") setVal = firstVal;
        $(obj).val(setVal);
        if(itemCount > 1)
            $(obj).show();
        else
            $(obj).hide();
    };

    //显示分页
    this.ShowPage = function(){
        var pageObj = $("#divSearchPage");

        if(pageObj == undefined)
            return;
        if(SearchBox.my.rsCount <= 0){
            $(pageObj).html("null");
            return;
        }

        var strPageHtml = "";
        if(SearchBox.my.rsCount > SearchBox.my.PageSize){
            strPageHtml = "<div class=\"pagination\" style=\"letter-spacing: 10px;\">";
            //strPageHtml = "<div class=\"pagination\">";
            var PageCount = 1;

            if(SearchBox.my.rsCount > SearchBox.my.PageSize)
                PageCount = parseInt(SearchBox.my.rsCount / SearchBox.my.PageSize);
            if(SearchBox.my.rsCount % SearchBox.my.PageSize) PageCount++;

            var PageStart = 1;

            if(SearchBox.my.PageIndex > SearchBox.my.PageLength)
                PageStart = SearchBox.my.PageIndex - SearchBox.my.PageIndex % SearchBox.my.PageLength + 1;

            var PageEnd = PageStart + SearchBox.my.PageLength;

            if(PageEnd > PageCount)
                PageEnd = PageCount;

            var PageIndex0 = SearchBox.my.PageIndex - 1;
            var PageIndex1 = SearchBox.my.PageIndex + 1;

            if(PageIndex0 <= 0)
                PageIndex0 = 1;
            if(PageIndex1 >= PageCount)
                PageIndex1 = PageCount;

            if(SearchBox.my.IsPageTotal == 1){
                strPageHtml += "<span class=\"f_left\">记录总数:" + SearchBox.my.rsCount + " 总页数:" + PageCount + " 每页:" + SearchBox.my.PageSize + " 当前页:" + SearchBox.my.PageIndex + "</span> ";
            }
            else{
                strPageHtml += "<span class=\"f_left\">记录总数:" + SearchBox.my.rsCount + "</span> ";
            }

            strPageHtml += "<a href=\"javascript:void(0);\" class=\"number\"  onclick=\"SearchBox.my.PageChange(1)\">首页</a><a href=\"javascript:void(0);\" class=\"number\"  onclick=\"SearchBox.my.PageChange(" + PageIndex0 + ")\" title=\"Previous Page\">&laquo; </a>";

            for(var i = PageStart; i <= PageEnd; i++){
                if (i == SearchBox.my.PageIndex)
                    strPageHtml += "<a href=\"javascript:void(0);\" class=\"number current\">" + i + "</a>";
                else
                    strPageHtml += "<a href=\"javascript:void(0);\" class=\"number\" onclick=\"SearchBox.my.PageChange(" + i + ")\">" + i + "</a>";
            }

            if(PageCount != PageIndex1)
                strPageHtml += "<a href=\"javascript:void(0);\" class=\"number\" title=\"Next Page\" onclick=\"SearchBox.my.PageChange(" + PageIndex1 + ")\">...</a>";
            strPageHtml += "<a href=\"javascript:void(0);\" class=\"number\" title=\"Next Page\" onclick=\"SearchBox.my.PageChange(" + PageIndex1 + ")\"> &raquo;</a><a href=\"javascript:void(0);\" class=\"number\"  title=\"Last Page\" onclick=\"SearchBox.my.PageChange(" + PageCount + ")\">尾页</a>";
            strPageHtml += "</div>";
        }
        else{
            strPageHtml += "<div class=\"pagination\"><span class=\"f_left\">记录总数:" + SearchBox.my.rsCount + "</span></div>";
        }
        //alert(strPageHtml);
        //alert($(pageObj).id);
        $(pageObj).html(strPageHtml);
        //$(pageObj).show();
    };

    //翻页
    this.PageChange = function(theIndex){
        //alert(PageIndex);
        SearchBox.my.PageIndex = theIndex;
        SearchBox.my.gogo();
    };
}

SearchBox.my = null;
SearchBox.chooseImg = "/images/Choose.gif";

SearchBox.showTab = function(resData){
    var myCol;
    var myCols = SearchBox.my.cols.split('|');

    var objTab = $("#tabSearchBox");
    objTab.find("tr").each(function(i){
        if(i > 0)
            $(this).remove();
    });

    var colName = "", trBody = "";

    //resData.rows[0].Data = resData.rows[0];

    //alert("rowIndex = " + rowIndex);
    $(resData.rows).each(function(rowIndex,dr){
        //alert("rowIndex = " + rowIndex); // 0
        trBody = "";
        for(var colIndex in myCols){
            myCol = myCols[colIndex].split(',');
            colName = myCol[0];
            //alert("colName="+colName);

            trBody += "<td style=\"text-align:center;width:" + myCol[2] + "px\"><a onclick=\"SearchBox.showData(" + rowIndex + ")\">" + dr[colName] + "</a></td>"; //href=\"javascript:void(0);\"
        }

        if(trBody != ""){
            trBody = "<tr>" + trBody + "</tr>";
            //alert(trBody);
            objTab.append(trBody);
        }
    });
};

SearchBox.showData = function(i){
    var v = SearchBox.my.TabData.rows[i];

    if(SearchBox.my.myMethod != undefined && SearchBox.my.myMethod != null){
        SearchBox.my.myMethod(v);
    }
    else{
        if(SearchBox.my.setObj != undefined && SearchBox.my.setObj != null && SearchBox.my.valName != "")
            $(SearchBox.my.setObj).val(v[SearchBox.my.valName]);

        if(SearchBox.my.setObj1 != undefined && SearchBox.my.setObj1 != null && SearchBox.my.valName1 != "")
            $(SearchBox.my.setObj1).val(v[SearchBox.my.valName1]);
    }
    //alert(SearchBox.my.layerIndex);
    layer.close(SearchBox.my.layerIndex);
    //layer.closeAll();
    SearchBox.my.IsShow = 0;
};

SearchBox.NextFocus = function(formid){
    var container = "body";

    if (formid != undefined && formid != "")
        container = "#" + formid;

    $(container + " :input:not(:hidden),input[type='text'],input[type='button'],select").bind('keydown',function(evt){
        var key = evt.keyCode ? evt.keyCode : evt.which;
        if(key == 13){
            var inputs = $(container + " :input:not(:hidden),input[type='text'],input[type='button'],select");
            var idx = inputs.index(this);
            var type = inputs[idx + 1].type;
            if(idx < inputs.length - 1){
                if(type == "button"){
                    $(inputs[idx + 1]).click();
                }
                else{
                    $(inputs[idx + 1]).focus();
                }

                if(type == "text")
                    $(inputs[idx + 1]).select();
            }
            return false;
        }
    });
};