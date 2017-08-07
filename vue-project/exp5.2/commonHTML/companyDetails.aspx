<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>公司管理详情</title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">

    <link rel="stylesheet" href="../../exp5.2/css5.2/common.css">  
    <link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">  
    <link rel="stylesheet" href="../../css/popup.css">

    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
    <style>
        #app table{margin-left: 10px;width: 1100px;}
        #app form table td{max-width: 1100px;padding: 10px;}
        #app form table input{width: 200px;margin-right: 10px;}
        #app form table span{display: inline-block;width: 90px;}
        #app form table select{height: 30px;margin-right: 10px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #app td input{width: 100%;height: 30px;padding: 0px 5px;}
        .newRow{display: none;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">company</div>

    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <div id="app">
        <div class="apl-tool">
            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" onclick="saveInfo()">保存</button>
            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="parent.l_popup.close(0);parent.ad.doList(1)">关闭</button>
        </div>
        <form>
            <table cellspacing="0" cellpadding="0">
                <tr>
                    <td>  
                        <span>总公司Id：</span>
                        <input type="text" v-model="info.companyId2" aplDataName="companyId2" placeholder="输入0-20位" Verification="0-20">                   
                        <span>公司代码：</span>
                        <input type="text" v-model="info.companyCode" aplDataName="companyCode" placeholder="输入1-20位" Verification="1-20">                 
                        <span>公司名称：</span>
                        <input type="text" v-model="info.companyName" aplDataName="companyName" placeholder="输入1-20位" Verification="1-20">
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>组号：</span>
                        <input type="text" v-model="info.companyRole" aplDataName="companyRole" placeholder="输入0-20位" Verification="0-20">     
                        <span>欠费：</span>
                        <input type="text" v-model="info.arrearage" aplDataName="arrearage" placeholder="输入0-20位" Verification="0-20">                       
                        <span>upload：</span>
                        <input type="text" v-model="info.upload" aplDataName="upload" placeholder="输入0-20位" Verification="0-20">
                    </td>
                </tr> 
                <tr>
                    <td colspan="5">
                        <span>ip：</span>
                        <input type="text" v-model="info.ip" aplDataName="ip" placeholder="输入0-200位" Verification="0-200" style="width: 815px;"> 
                    </td>
                </tr>             
            </table>                          
        </form> 
        <div id="tabCompany_branch" style="display: none;">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">更多信息：</p>
            <table class="apl-tableSpecial">
                <thead>
                <tr>
                    <td style="display: none;" level="m">编辑</td>
                    <td><span>总公司Id</span></td>
                    <td><span>分公司Id</span></td>
                    <td><span>分公司代码</span></td>
                    <td><span>分公司名称</span></td>
                    <td style="display: none;" level="m">删除</td>
                </tr>
                </thead>
                <tbody>
                <tr v-for="row in company_branch">
                    <td align="cetner" style="display: none;" level="m">
                        <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                        <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'company_branch')" style="display: none;" >保 存</button>
                        <input type="hidden" aplDataName="rowId" v-model="row.id" />
                    </td>
                    <td>
                        <input type="text" name="companyId2" disabled="true" aplDataName="companyId2" v-model="row.companyId2" Verification="0-20" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" name="filialeId" disabled="true" aplDataName="filialeId" v-model="row.filialeId" Verification="1-10" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" name="filialeCode" disabled="true" aplDataName="filialeCode" v-model="row.filialeCode" Verification="1-10" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" name="filialeName" disabled="true" aplDataName="filialeName" v-model="row.filialeName" Verification="1-20" onblur="vertionCell(this)">
                    </td>
                    <td style="display: none;" level="m">
                        <a href="javascript:;" onclick="delRow(this,'company_branch')" style="color: red;">删 除</a>
                    </td>
                </tr>
                <tr class="newRow">
                    <td align="cetner"  style="display: none;" level="m">
                        <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                        <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'company_branch')" style="display: inline-block;">保 存</button>
                        <input type="hidden" aplDataName="rowId"/>
                    </td>
                    <td>
                        <input type="text" aplDataName="companyId2" Verification="0-20" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" aplDataName="filialeId" Verification="1-10" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" aplDataName="filialeCode" Verification="1-10" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" aplDataName="filialeName" Verification="1-20" onblur="vertionCell(this)">
                    </td>
                    <td  style="display: none;" level="m">
                        <a href="javascript:;" onclick="delRow(this,'company_branch')" style="color: red;">删 除</a>
                    </td>
                </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="10">
                            <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabCompany_branch',3)"  style="display: none;" level="m">新增</button>
                        </td>
                    </tr>
                </tfoot>
            </table>  
        </div>
                    
    </div>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../plugins/layer/layer.min.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="commonDetails.js"></script>
</body>
</html>