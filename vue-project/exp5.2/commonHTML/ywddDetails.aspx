<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
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
    <div id="pagingSorting" style="display: none;">ywdd</div>
    
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
                    <td>下单日期</td>
                    <td>
                        <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="createTime" class="input-text Wdate" style="width: 150px;" Verification="1-20">
                    </td>
                    <td>订单类型</td>
                    <td>
                        <select v-model="info.type" aplDataName="type" Verification="1-10">
                            <option value="1">快递</option>
                            <option value="2">空运</option>
                        </select>
                    </td>
                    <td>订单号</td>
                    <td>
                        <input type="text" v-model="info.ddNo" aplDataName="ddNo">
                    </td>                   
                </tr>
                <tr>
                    <td>客户</td>
                    <td>
                        <input type="hidden" v-model="info.clientId" aplDataName="clientId" id="clientId">
                        <input type="text" v-model="info.clientName" aplDataName="clientName" id="clientName" style="width: auto;" disabled="true">
                        <button type="button" onclick="sbo.go2('client','#clientName','c2', '#clientId', 'id')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
                    </td>                    
                    <td>业务员</td>
                    <td>
                        <input type="text" v-model="info.ywyName" aplDataName="ywyName" disabled="true">
                    </td>
                    <td></td>
                    <td></td>
                </tr>                
                <tr>
                    <td>是否扣件</td>
                    <td>
                        <select v-model="info.outState" aplDataName="outState" Verification="1-10">
                            <option value="0">未扣件</option>
                            <option value="1">已扣件</option>
                        </select>
                    </td> 
                    <td>是否锁定</td>
                    <td>
                        <select v-model="info.isLock" aplDataName="isLock" Verification="1-10">
                            <option value="0">未锁定</option>
                            <option value="1">已锁定</option>
                        </select>
                    </td> 
                    <td>是否入库</td>
                    <td colspan="5">
                        <select v-model="info.inDep" aplDataName="inDep" Verification="1-10">
                            <option value="0">未入库</option>
                            <option value="1">已入库</option>
                        </select>
                    </td>                   
                </tr>
                  <tr>
                    <td>备注</td>
                    <td colspan="5">
                        <input type="text" v-model="info.remark" aplDataName="remark">
                    </td>                  
                </tr>
            </table>                          
        </form> 
        <!-- 提货地址 -->
        <div id="tabAddr" style="display: none;">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">提货地址：</p>
            <table class="apl-tableSpecial">
                <thead>
                    <tr>
                        <td style="display: none;" level="m">编辑</td>
                        <td><span>联系人</span></td>
                        <td><span>手机</span></td>                      
                        <td><span>电话</span></td>                        
                        <td><span>预约时间</span></td>
                        <td><span>区域</span></td>
                        <td><span>总件数</span></td>
                        <td><span>地址</span></td>
                        <td><span>备注</span></td>
                        <td style="display: none;" level="m">删除</td>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="row in addr">
                        <td align="cetner" style="display: none;" level="m">
                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'orderAddress')" style="display: none;" >保 存</button>
                            <input type="hidden" aplDataName="rowId" v-model="row.id" />
                        </td>
                        <td>
                            <input type="text" name="linkman" disabled="true" aplDataName="linkman" v-model="row.linkman" placeholder="1-20位内" Verification="1-20">
                        </td>
                        <td>
                            <input type="text" name="mobile" disabled="true" aplDataName="mobile" v-model="row.mobile" placeholder="1-20位内" Verification="1-20">
                        </td>
                        <td>
                            <input type="text" name="phone" disabled="true" aplDataName="phone" v-model="row.phone">
                        </td>
                        <td>
                            <input type="text" name="proceedTime" disabled="true" aplDataName="proceedTime" v-model="row.proceedTime">
                        </td>
                        <td>
                            <input type="text" name="area" disabled="true" aplDataName="area" v-model="row.area">
                        </td>
                        <td>
                            <input type="text" name="wt" disabled="true" aplDataName="wt" v-model="row.wt">
                        </td>
                        <td>
                            <input type="text" name="address" disabled="true" aplDataName="address" v-model="row.address">
                        </td>
                        <td>
                            <input type="text" name="remark" disabled="true" aplDataName="remark"  v-model="row.remark">
                        </td>                       
                        <td style="display: none;" level="m">
                            <a href="javascript:;" onclick="delRow(this,'orderAddress')" style="color: red;">删 除</a>
                        </td>
                    </tr>
                    <tr class="newRow">
                        <td align="cetner"  style="display: none;" level="m">
                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'orderAddress')" style="display: inline-block;">保 存</button>
                            <input type="hidden" aplDataName="rowId"/>
                        </td>
                        <td>
                            <input type="text" aplDataName="linkman" placeholder="1-20位内" Verification="1-20">
                        </td>
                        <td>
                            <input type="text" aplDataName="mobile" placeholder="1-20位内" Verification="1-20">
                        </td>
                        <td>
                            <input type="text"  aplDataName="phone">
                        </td>
                        <td>
                            <input type="text" aplDataName="proceedTime">
                        </td>
                         <td>
                            <input type="text" aplDataName="area">
                        </td>
                        <td>
                            <input type="text" aplDataName="wt">
                        </td>
                        <td>
                            <input type="text" aplDataName="address">
                        </td>
                        <td>
                            <input type="text" aplDataName="remark">
                        </td>
                        <td  style="display: none;" level="m">
                            <a href="javascript:;" onclick="delRow(this,'orderAddress')" style="color: red;">删 除</a>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="12">
                            <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabAddr',1)"  style="display: none;" level="m">新增</button>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>          
        <!-- 货物明细 -->
        <div id="tabOrderInfo" style="display: none;">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">货物明细：</p>
            <table class="apl-tableSpecial">
                <thead>
                    <tr>
                        <td style="display: none;" level="m">编辑</td>
                        <td><span>单号</span></td>
                        <td><span>方式</span></td>
                        <td><span>国家</span></td>
                        <td><span>重量</span></td>
                        <td><span>渠道名称</span></td>
                        <td><span>包裹类型</span></td>
                        <td><span>件数</span></td>
                        <td><span>品名</span></td>
                        <td><span>邮编</span></td>
                        <td><span>申报价值</span></td>
                        <td><span>备注</span></td>
                        <td style="display: none;" level="m">删除</td>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="row in orderInfo">
                        <td align="cetner" style="display: none;" level="m">
                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'orderInfo')" style="display: none;" >保 存</button>
                            <input type="hidden" aplDataName="rowId" v-model="row.id" />
                        </td>
                        <td>
                            <input type="text" name="AWB" disabled="true" aplDataName="AWB" v-model="row.AWB">
                        </td>
                        <td>
                            <input type="text" name="transit" disabled="true" aplDataName="transit" v-model="row.transit">
                        </td>
                        <td>
                            <input type="text" name="cityNo" disabled="true" aplDataName="cityNo" v-model="row.cityNo">
                        </td>
                        <td>
                            <input type="text" name="cwt" disabled="true" aplDataName="cwt" v-model="row.cwt">
                        </td>
                        <td>
                            <input type="text" name="priceName" disabled="true" aplDataName="priceName" v-model="row.priceName">
                        </td>
                        <td>
                            <input type="text" name="packDoc" disabled="true" aplDataName="packDoc" v-model="row.packDoc">
                        </td>
                        <td>
                            <input type="text" name="piece" disabled="true" aplDataName="piece" v-model="row.piece">
                        </td>
                        <td>
                            <input type="text" name="goods" disabled="true" aplDataName="goods" v-model="row.goods">
                        </td>
                        <td>
                            <input type="text" name="postalCode" disabled="true" aplDataName="postalCode" v-model="row.postalCode" placeholder="1-20位内" Verification="1-20">
                        </td>
                        <td>
                            <input type="text" name="worth" disabled="true" aplDataName="worth" v-model="row.worth">
                        </td>
                        <td>
                            <input type="text" name="remark" disabled="true" aplDataName="remark" v-model="row.remark">
                        </td>
                        <td style="display: none;" level="m">
                            <a href="javascript:;" onclick="delRow(this,'orderInfo')" style="color: red;">删 除</a>
                        </td>
                    </tr>
                    <tr class="newRow">
                        <td align="cetner"  style="display: none;" level="m">
                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'orderInfo')" style="display: inline-block;">保 存</button>
                            <input type="hidden" aplDataName="rowId"/>
                        </td>
                        <td>
                            <input type="text" aplDataName="AWB">
                        </td>
                        <td>
                            <input type="text" aplDataName="transit">
                        </td>
                        <td>
                            <input type="text"  aplDataName="cityNo">
                        </td>
                        <td>
                            <input type="text"  aplDataName="cwt">
                        </td>
                        <td>
                            <input type="text"  aplDataName="priceName">
                        </td>
                        <td>
                            <input type="text"  aplDataName="packDoc">
                        </td>
                        <td>
                            <input type="text"  aplDataName="piece">
                        </td>
                        <td>
                            <input type="text"  aplDataName="goods">
                        </td>
                        <td>
                            <input type="text"  aplDataName="postalCode" placeholder="1-20位内" Verification="1-20">
                        </td>
                        <td>
                            <input type="text"  aplDataName="worth">
                        </td>
                        <td>
                            <input type="text"  aplDataName="remark">
                        </td>
                        <td  style="display: none;" level="m">
                            <a href="javascript:;" onclick="delRow(this,'orderInfo')" style="color: red;">删 除</a>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="15">
                            <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabOrderInfo',1)"  style="display: none;" level="m">新增</button>
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
    <script src="../../plugins/WdatePicker/WdatePicker.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="commonDetails.js"></script>
    <script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
</body>
</html>