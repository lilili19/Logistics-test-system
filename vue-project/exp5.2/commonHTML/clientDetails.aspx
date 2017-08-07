<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>客户管理详情</title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">

    <link rel="stylesheet" href="../../exp5.2/css5.2/common.css">  
    <link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">  
    <link rel="stylesheet" href="../../css/popup.css">

    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
    <style>
        #app table{margin:0px 0px 10px 10px;width: 1100px;}
        #app form table td{max-width: 1100px;padding: 10px;}
        #app form table td:nth-child(2n-1){font-weight: bold;}
        #app input{width: 200px;margin-right: 10px;}
        #app select{height: 30px;margin-right: 10px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #app td input{width: 100%;height: 30px;padding: 0px 5px;}
        .newRow{display: none;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">client</div>

    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <div id="app">
        <div class="apl-tool">
            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" onclick="saveInfo()">保存</button>
            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="parent.l_popup.close(0);parent.ad.doList(1)">关闭</button>
        </div>
        <!-- 基本信息 -->
        <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">基本信息：</p>
        <form>
            <table cellspacing="0" cellpadding="0">
                <tr>
                    <td>客户编号</td>
                    <td>
                        <input type="text" v-model="info.clientNo" aplDataName="clientNo" placeholder="输入2-20位" Verification="2-20">
                    </td>
                    <td>客户简称</td>
                    <td>
                        <input type="text" v-model="info.clientName" aplDataName="clientName" placeholder="输入2-20位" Verification="2-20">
                    </td>
                    <td>客户中文全称</td>
                    <td>
                        <input type="text" v-model="info.fullName" aplDataName="fullName" placeholder="输入100位之内" Verification="0-100">
                    </td>                   
                </tr>
                <tr>
                    <td>客户英文简称</td>
                    <td>
                        <input type="text" v-model="info.enName" aplDataName="enName" placeholder="输入100位之内" Verification="0-100">
                    </td>
                    <td>审核</td>
                    <td>
                        <span v-if="info.auditing==1">已审</span>
                        <span v-if="info.auditing==0">未审</span>
                    </td>  
                    <td></td>
                    <td></td>
                </tr>                
                <tr>
                    <td>地址</td>
                    <td colspan="5">
                        <input type="text" v-model="info.province" style="width: auto;" aplDataName="province" placeholder="输入2-50位">省 
                        <input type="text" v-model="info.city" style="width: auto;" aplDataName="city" placeholder="输入2-50位">市
                        <input type="text" v-model="info.county" style="width: auto;" aplDataName="county" placeholder="输入2-50位">县(区)
                        <br>详细地址：<input type="text" v-model="info.address" style="margin-top: 5px;width: 100%;" aplDataName="address" placeholder="输入2-200位" Verification="2-200">
                    </td>
                </tr>
                <tr>
                    <td>业务员</td>
                    <td>
                        <input type="text" style="height: 30px;text-indent: 5px;width: auto;" id="ywyName" aplDataName="ywyName"  placeholder="请选择" Verification="1-200">
                        <input type="hidden" aplDataName="ywy" id="ywy" corre="ywyName">
                        <button type="button" onclick="sbo.go2('user','#ywyName','c2', '#ywy', 'id')" title="搜索" level="m" class="layui-btn layui-btn-mini"><i class="layui-icon"></i></button>
                    </td>
                    <td>信用额度</td>
                    <td>
                        <input type="text" v-model="info.accountCyc" aplDataName="accountCyc">
                    </td>
                    <td>添加人</td>
                    <td>
                        {{info.oprname}}
                    </td>
                </tr>
                <tr>
                    <td>付款协议</td>
                    <td>
                        <input type="text" v-model="info.payType" aplDataName="payType">
                    </td>
                    <td>状态</td>
                    <td>
                        <select v-model="info.state" aplDataName="state" Verification="1-5">
                            <option value="1">有效</option>
                            <option value="0">无效</option>
                        </select>
                    </td>                                     
                    <td>添加日期</td>
                    <td>
                        {{info.bookTime}}
                    </td>
                </tr>
                <tr>
                    <td>付款协议</td>
                    <td>
                        <select>
                            <option :value="row.name" v-for="row in tabPay">{{row.name}}</option>
                        </select>
                    </td>
                    <td>分公司</td>
                    <td>
                        <select>
                            <option :value="row.id" v-for="row in tabFiliale">{{row.name}}</option>
                        </select>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>备注</td>
                     <td colspan="5">
                        <input type="text" v-model="info.remark" style="width: 100%;" aplDataName="remark" placeholder="输入200位之内" Verification="0-200">
                    </td>
                </tr>
            </table>                          
        </form> 
        <!-- 联系人 -->
        <div id="tabClient" style="display: none;">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">联系人：</p>
            <table class="apl-tableSpecial">
                <thead>
                    <tr>
                        <td style="display: none;" level="m">编辑</td>
                        <td><span>联系人</span></td>
                        <td><span>部门</span></td>
                        <td><span>电话</span></td>
                        <td><span>手机</span></td>
                        <td><span>传真</span></td>
                        <td><span>邮箱</span></td>
                        <td><span>qq</span></td>
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
                            <input type="text" name="linkman" disabled="true" aplDataName="linkman" v-model="row.linkman" placeholder="2-50位" Verification="2-50" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <input type="text" name="depName" disabled="true" aplDataName="depName" v-model="row.depName" placeholder="30位内" Verification="0-30" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <input type="text" name="phone" disabled="true" aplDataName="phone" v-model="row.phone" placeholder="20位内" Verification="0-20" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <input type="text" name="mobile" disabled="true" aplDataName="mobile" v-model="row.mobile" placeholder="20位内" Verification="0-20" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                        </td>
                        <td>
                            <input type="text" name="fax" disabled="true" aplDataName="fax" v-model="row.fax" placeholder="20位内" Verification="0-20" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                        </td>
                        <td>
                            <input type="text" name="email" disabled="true" aplDataName="email" v-model="row.email" placeholder="30位内" Verification="0-30" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                        </td>
                        <td>
                            <input type="text" name="qq" disabled="true" aplDataName="qq" v-model="row.qq" placeholder="50位内" Verification="0-50" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                        </td>
                        <td>
                            <input type="text" name="remark" disabled="true" aplDataName="remark"  v-model="row.remark" placeholder="200位内" Verification="0-200" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
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
                        <input type="text" aplDataName="linkman" placeholder="2-50位内" Verification="2-50" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" aplDataName="depName" placeholder="30位内" Verification="0-30" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text"  aplDataName="phone" placeholder="20位内" Verification="0-20" onblur="vertionCell(this)">
                    </td>
                    <td>
                        <input type="text" aplDataName="mobile" placeholder="20位内" Verification="0-20" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                    </td>
                    <td>
                        <input type="text" aplDataName="fax" placeholder="20位内" Verification="0-20" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                    </td>
                    <td>
                        <input type="text" aplDataName="email" placeholder="30位内" Verification="0-30" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                    </td>
                    <td>
                        <input type="text" aplDataName="qq" placeholder="50位内" Verification="0-50" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
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
                            <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabClient',1)"  style="display: none;" level="m">新增</button>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>          
        <!-- 账号 -->
        <div id="tabUser" style="display: none;">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">账号：</p>
            <table class="apl-tableSpecial">
                <thead>
                    <tr>
                        <td style="display: none;" level="m">编辑</td>
                        <td><span>账号</span></td>
                        <td><span>密码</span></td>
                        <td><span>状态</span></td>
                        <td style="display: none;" level="m">删除</td>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="row in user">
                        <td align="cetner" style="display: none;" level="m">
                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'regUser')" style="display: none;" >保 存</button>
                            <input type="hidden" aplDataName="rowId" v-model="row.id" />
                        </td>
                        <td>
                            <input type="text" name="userId" disabled="true" aplDataName="userId" v-model="row.userId" placeholder="请输入2-20位" Verification="2-20" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <input type="text" name="userPwd" disabled="true" aplDataName="userPwd" v-model="row.userPwd" placeholder="2-20位内" Verification="2-20" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <select v-model="row.state" aplDataName="state" disabled="true" Verification="1-10">
                                <option value="1">有效</option>
                                <option value="0">无效</option>
                            </select>
                        </td>
                        <td style="display: none;" level="m">
                            <a href="javascript:;" onclick="delRow(this,'regUser')" style="color: red;">删 除</a>
                        </td>
                    </tr>
                    <tr class="newRow">
                        <td align="cetner"  style="display: none;" level="m">
                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'regUser')" style="display: inline-block;">保 存</button>
                            <input type="hidden" aplDataName="rowId"/>
                        </td>
                        <td>
                            <input type="text" aplDataName="userId" placeholder="2-20位内" Verification="2-20" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <input type="text" aplDataName="userPwd" placeholder="2-20位内" Verification="2-20" onblur="vertionCell(this)">
                        </td>
                        <td>
                            <select aplDataName="state" Verification="1-10">
                                <option value="1">有效</option>
                                <option value="0">无效</option>
                            </select>
                        </td>
                        <td  style="display: none;" level="m">
                            <a href="javascript:;" onclick="delRow(this,'regUser')" style="color: red;">删 除</a>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="10">
                            <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabUser',1)"  style="display: none;" level="m">新增</button>
                        </td>
                    </tr>
                </tfoot>
            </table> 
        </div>
        <!-- 上传附件upFile -->
        <!-- <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">上传附件：</p> -->
    </div>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../plugins/layer/layer.min.js"></script>
    <script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="commonDetails.js"></script>
    <script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
</body>
</html>