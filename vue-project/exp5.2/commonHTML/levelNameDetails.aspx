<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>权限名称详情</title>
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
        #app form table select{height: 30px;margin-right: 10px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #app td input{width: 100%;height: 30px;padding: 0px 5px;}
        .newRow{display: none;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">levelName</div>

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
                        <span>一级编号：</span>
                        <input type="text" v-model="info.bigNo" aplDataName="bigNo" placeholder="输入1-20位" Verification="1-20">                 
                        <span>一级名称：</span>
                        <input type="text" v-model="info.bigName" aplDataName="bigName" placeholder="输入1-20位" Verification="1-20">                     
                        <span>次序：</span>
                        <input type="text" v-model="info.keyOrder" aplDataName="keyOrder" placeholder="输入1-10位" Verification="1-10">  
                    </td>
                </tr>                
            </table>                          
        </form> 
        <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">更多信息：</p>
        <table class="apl-tableSpecial" id="tabLevelSmall" style="display: none;">
            <thead>
            <tr>
                <td style="display: none;" level="m">编辑</td>
                <td><span>二级编号</span></td>
                <td><span>二级名称</span></td>
                <td><span>次序</span></td>
                <td style="display: none;" level="m">删除</td>
            </tr>
            </thead>
            <tbody>
            <tr v-for="row in levelSmall">
                <td align="cetner" style="display: none;" level="m">
                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'levelSmall')" style="display: none;" >保 存</button>
                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                </td>
                <td>
                    <input type="text" name="smallNo" disabled="true" aplDataName="smallNo" v-model="row.smallNo" placeholder="1-20位" Verification="1-20" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" name="smallName" disabled="true" aplDataName="smallName" v-model="row.smallName" placeholder="1-20位" Verification="1-20" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" name="keyOrder" disabled="true" aplDataName="keyOrder" v-model="row.keyOrder"  placeholder="1-20位" Verification="1-10" onblur="vertionCell(this)">
                </td>
                <td style="display: none;" level="m">
                    <a href="javascript:;" onclick="delRow(this,'levelSmall')" style="color: red;">删 除</a>
                </td>
            </tr>
            <tr class="newRow">
                <td align="cetner"  style="display: none;" level="m">
                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'levelSmall')" style="display: inline-block;">保 存</button>
                    <input type="hidden" aplDataName="rowId"/>
                </td>
                <td>
                    <input type="text" aplDataName="smallNo" placeholder="1-20位" Verification="1-20" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" aplDataName="smallName" placeholder="1-20位" Verification="1-20" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text"  aplDataName="keyOrder" placeholder="1-10位" Verification="1-10" onblur="vertionCell(this)">
                </td>
                <td  style="display: none;" level="m">
                    <a href="javascript:;" onclick="delRow(this,'levelSmall')" style="color: red;">删 除</a>
                </td>
            </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="10">
                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabLevelSmall',3)"  style="display: none;" level="m">新增</button>
                    </td>
                </tr>
            </tfoot>
        </table>              
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