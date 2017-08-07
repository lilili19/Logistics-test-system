
var ajaxData = "";
function doAjax(url, postData, dataType, call) {
    if (dataType == "") dataType = "text";
    $.ajax({
        type: "post",
        url: url,
        data: postData,
        dataType: dataType,
        async:false,
        error: function (errData) { //返回失败后
            alert("Error loading " + errData);
        },
        success: function (resData) {
            if (call != null)
                call(resData);
            else if (resData.Error != undefined)
                alert(resData.Error);
            else if (resData.Message != undefined)
                alert(resData.Message);
        }
    });
}

function doGetMap() {
    var mapFile = document.getElementById("txtMapFile").value;
    if (mapFile == "") { alert("mapFile不能为空"); return; }
    var data = "mapFile=" + mapFile;
    doAjax("/Build/getMap", data, "json", doGetMapEnd);
}

function doGetMapEnd(resData) {
    if (resData == undefined) {
        alert("返回undefined");
        return;
    }
    if (resData.Error != undefined) { alert(resData.Error); return; }
    if (resData.listSQL != undefined) $("#txtListSQL").val(resData.listSQL);
    if (resData.infoSQL != undefined) $("#txtInfoSQL").val(resData.infoSQL);
    if (resData.exportSQL != undefined) $("#txtExportSQL").val(resData.exportSQL);

    if (resData.rows == undefined) {
        alert("返回resData.rows=undefined");
        return;
    }

    var mHtml = "";
    var data = resData.rows;
    var dbTab0 = "", dbTab = "", fieldName = "", textVal = "", dbName = "", title = "", val = "", dataType = "", minVal = "", maxVal = "", accNull = "";
    for (var i in data) {
        dbTab = data[i]["dbTab"];
        fieldName = data[i]["name"];
        dbName = data[i]["dbName"];
        if (dbName == "") dbName = fieldName;
        title = data[i]["title"];
        dataType = data[i]["type"];
        minVal = data[i]["min"];
        maxVal = data[i]["max"];
        accNull = data[i]["accNull"];

        textVal = fieldName + " " + title
        val = dbTab + "," + fieldName + "," + dbName + "," + title + "," + dataType + "," + minVal + "," + maxVal + "," + accNull;
        if (dbTab0 != dbTab) {
            if (mHtml != "") mHtml += "<br>";
            mHtml += '<input type="button"  class="btn btn-success" value="' + dbTab + '" onclick="doBuildDbTab(\'' + dbTab + '\')"  style="" /> <br>';
        }
        mHtml += '<input style="" type="checkbox" name="chkM" value="' + val + '"> ' + textVal + "<br>";

        dbTab0 = dbTab;
    }

    $("#divModel").html(mHtml);
    if (resData.Message != undefined && resData.Message != "") alert(resData.Message);
}

function doBuildDbTab(dbTab) {
    var mapFile = document.getElementById("txtMapFile").value;
    if (mapFile == "") { alert("mapFile不能为空"); return; }
    var company = document.getElementById("txtCompany").value;
    if (company == "") { alert("company不能为空"); return; }   
    if (confirm("确认要创建或修改DB." + dbTab + "表吗？") == false) return;
    if (dbTab == "") { alert("dbTab不能为空"); return }
    
    var arr = null;
    var dbName = "", fields = "", rowVal = "";
    $("input:checked[name=chkM]").each(function () {
        rowVal = $(this).val();
        arr = rowVal.split(',');
        if (fields != "") fields += ",";
        fields += arr[0] + "." + arr[2];
    })

    var data = "dbTab=" + dbTab + "&company=" + company + "&mapFile=" + mapFile;
    //alert(data);
    doAjax("/Build/buildDbTab", data, "json");
}

function doBuildSQL(sqlName) {
    var dbTab = "", dbTab0 = "", dbTabFirst = "", title = "", fieldName = "", fieldTab = "", dbName = "", rowVal = "";
    var sql = "", sqlTab = "";
    var arr = null;

    $("input:checked[name=chkM]").each(function () {
        rowVal = $(this).val();
        //alert(rowVal);
        arr = rowVal.split(',');
        dbTab = arr[0];
        if (dbTabFirst == "") dbTabFirst = dbTab;

        fieldName = arr[1];
        dbName = arr[2];
        if (dbName == "") dbName = fieldName;
        //alert(dbName);
        if (dbName != "companyId") {
            if (sql != "") sql += ",";
            if (dbTab != dbTab0 && dbTab0 != "") fieldTab = dbTab;
            if (fieldTab != "") sql += fieldTab + ".";
            sql += dbName;
            if (dbName != fieldName) sql += " AS " + fieldName;

            if (dbTab != dbTab0) {
                if (sqlTab != "") sqlTab += " INNER JOIN ";
                sqlTab += " " + dbTab;
            }
            
            dbTab0 = dbTab;
        }
    });
    
    sql = "SELECT " + sql + " FROM " + sqlTab;
    if (sqlName == "list") {
        $("#txtListSQL").val(sql);
    }
    else if (sqlName == "info") {
        $("#txtInfoSQL").val(sql);
    }
    else if (sqlName == "export") {
        $("#txtExportSQL").val(sql);
    }
    else {
        $("#txtOtherSQL").val(sql);
    }
}

function doSaveSQL() {
    if (confirm("确认要保存SQL？") == false) return;
    var mapFile = document.getElementById("txtMapFile").value;
    if (mapFile == "") { alert("mapFile不能为空"); return; }
   
    var listSQL = $("#txtListSQL").val();
    var infoSQL = $("#txtInfoSQL").val();
    var exportSQL = $("#txtExportSQL").val();
    var otherSQLName = $("#txtOtherSQLName").val();
    var otherSQL = $("#txtOtherSQL").val();

    var data = "mapFile=" + mapFile + "&listSQL=" + listSQL + "&infoSQL=" + infoSQL + "&exportSQL=" + exportSQL + "&otherSQLName=" + otherSQLName + "&otherSQL=" + otherSQL;
    doAjax("/Build/saveSQL", data, "json");
}

function doBuildModelCode() {
    var mapFile = document.getElementById("txtMapFile").value;
    if (mapFile == "") { alert("mapFile不能为空"); return; }
    var data = "mapFile=" + mapFile;
    doAjax("/Build/buildModelCode", data, "text", doBuildModelCodeEnd);
}

function doBuildModelCodeEnd(resData) {
    document.getElementById("txtModelCode").value = resData;
}