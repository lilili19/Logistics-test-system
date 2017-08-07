<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>服务商详情</title>
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
    <div id="pagingSorting" style="display: none;">coagent</div>

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
                        <span>服务商编号：</span>
                        <input type="text" v-model="info.coagentNo" aplDataName="coagentNo" placeholder="输入1-20位" Verification="1-20">                 
                        <span>服务商简称：</span>
                        <input type="text" v-model="info.coagentName" aplDataName="coagentName" placeholder="输入1-20位" Verification="1-20">                     
                        <span>服务商全称：</span>
                        <input type="text" v-model="info.fullName" aplDataName="fullName" placeholder="输入1-20位" Verification="1-20">  
                    </td>
                </tr>
                <tr>
                    <td>                   
                        <span>状态：</span>
                        <select v-model="info.state" aplDataName="state" Verification="1-20">
                            <option value="1">有效</option>
                            <option value="0">无效</option>
                        </select>                                              
                        <span>备注：</span>
                        <input type="text" v-model="info.remark" aplDataName="remark" placeholder="输入1-20位" Verification="1-20" style="width: 600px;">
                    </td>                    
                </tr>
            </table>                          
        </form> 
        <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">更多信息：</p>
        <table class="apl-tableSpecial" id="tabCoagent" style="display: none;">
            <thead>
            <tr>
                <td style="display: none;" level="m">编辑</td>
                <td><span>联系人</span></td>
                <td><span>部门</span></td>
                <td><span>电话</span></td>
                <td><span>手机</span></td>
                <td><span>邮箱</span></td>
                <td><span>备注</span></td>
                <td style="display: none;" level="m">删除</td>
            </tr>
            </thead>
            <tbody>
            <tr v-for="row in coagentext">
                <td align="cetner" style="display: none;" level="m">
                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'coagentext')" style="display: none;" >保 存</button>
                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                </td>
                <td>
                    <input type="text" name="linkman" disabled="true" aplDataName="linkman" v-model="row.linkman" placeholder="请输入2-100位" Verification="2-100" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" name="depName" disabled="true" aplDataName="depName" v-model="row.depName" placeholder="0-100位内" Verification="0-100" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" name="phone" disabled="true" aplDataName="phone" v-model="row.phone" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" name="mobile" disabled="true" aplDataName="mobile"  v-model="row.mobile" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                </td>
                <td>
                    <input type="text" name="email" disabled="true" aplDataName="email"  v-model="row.email" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                </td>
                <td>
                    <input type="text" name="remark" disabled="true" aplDataName="remark"  v-model="row.remark" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                </td>
                <td style="display: none;" level="m">
                    <a href="javascript:;" onclick="delRow(this,'coagentext')" style="color: red;">删 除</a>
                </td>
            </tr>
            <tr class="newRow">
                <td align="cetner"  style="display: none;" level="m">
                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'coagentext')" style="display: inline-block;">保 存</button>
                    <input type="hidden" aplDataName="rowId"/>
                </td>
                <td>
                    <input type="text" aplDataName="linkman" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" aplDataName="depName" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text"  aplDataName="phone" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                </td>
                <td>
                    <input type="text" aplDataName="mobile" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                </td>
                <td>
                    <input type="text" aplDataName="email" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                </td>
                <td>
                    <input type="text" aplDataName="remark" placeholder="200位内" Verification="0-200" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                </td>
                <td  style="display: none;" level="m">
                    <a href="javascript:;" onclick="delRow(this,'coagentext')" style="color: red;">删 除</a>
                </td>
            </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="10">
                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabCoagent',3)"  style="display: none;" level="m">新增</button>
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