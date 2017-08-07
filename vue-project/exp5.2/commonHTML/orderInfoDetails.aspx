<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>预报记录详情</title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">

    <link rel="stylesheet" href="../../exp5.2/css5.2/common.css">  
    <link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">  
    <link rel="stylesheet" href="../../css/popup.css">

    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
    <style>
        #app table{margin-left: 10px;width: 1200px;}
        #app form table td{max-width: 1100px;padding: 10px 5px;border: 1px solid #ddd;}
        #app form table td:nth-child(2n-1){font-weight: bold;}
        #app form table select{height: 30px;margin-right: 10px;}
        #app td input{height: 30px;padding: 0px 5px;}
        .newRow{display: none;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">orderInfo</div>

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
                    <td>客户</td>
                    <td>
                        <input type="text" v-model="info.clientName" id="clientName" Verification="1-20" disabled="disabled">
                        <input type="hidden" id="clientId" aplDataName="clientId"  corre="clientName" >
                        <button type="button" onclick="sbo.go2('client','#clientId','id','#clientName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button>
                    </td> 
                    <td>日期</td>
                    <td>
                        {{info.bookTime}}
                    </td>
                    <td>状态</td>
                    <td>
                        {{info.state}}
                    </td>  
                    <td>
                    </td>  
                     <td>
                    </td>  
                </tr>
                <tr>
                    <td>寄件人姓名</td>
                    <td>
                        <input type="text" v-model="info.Fromcontract" aplDataName="Fromcontract" placeholder="输入50位之内" Verification="0-50">
                        <!-- <input type="hidden" id="user" aplDataName="user"  corre="oprBill" >
                        <button type="button" onclick="sbo.go2('user','#user','id','#oprBill','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button> -->
                    </td>
                    <td>寄件人电话</td>
                    <td>
                        <input type="text" v-model="info.fromPhone" aplDataName="fromPhone" placeholder="输入50位之内" Verification="0-50">
                    </td> 
                    <td>寄件人公司</td>
                    <td>
                        <input type="text" v-model="info.fromCompany" aplDataName="fromCompany" placeholder="输入50位之内" Verification="0-50">
                    </td> 
                    <td>寄件国家</td>
                    <td>
                        <input type="text" v-model="info.fromCountryNo" aplDataName="fromCountryNo" placeholder="输入5位之内" Verification="0-5" >
                        <!-- <input type="hidden" id="user" aplDataName="user"  corre="oprBill" >
                        <button type="button" onclick="sbo.go2('user','#user','id','#oprBill','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button> -->
                    </td>
                </tr>
                <tr>
                    <td>寄件人地址</td>
                    <td colspan="7">
                        <input type="text" v-model="info.fromAddress" aplDataName="fromAddress" placeholder="输入100位之内" Verification="0-100" style="width: 800px;">
                    </td>
                </tr>  
                <tr>
                    <!-- <td>分区</td>
                    <td>
                        <input type="text" v-model="info.zone" aplDataName="zone" placeholder="输入5位之内" Verification="0-5">
                    </td>    -->               
                    <td>收件人名</td>
                    <td>
                        <input type="text" v-model="info.contract" aplDataName="contract" placeholder="输入2-20位" Verification="2-20">
                    </td> 
                    <td>收件人电话</td>
                    <td>
                        <input type="text" v-model="info.Phone" aplDataName="Phone" placeholder="输入50位之内" Verification="0-50">
                    </td>
                    <td>收件人公司</td>
                    <td>
                        <input type="text" v-model="info.companyName" aplDataName="companyName" placeholder="输入50位之内" Verification="0-50">
                    </td> 
                    <td>收件人证件号</td>
                    <td>
                        <input type="text" v-model="info.ConsigneIDentity" aplDataName="ConsigneIDentity" placeholder="输入50位之内" Verification="0-50">
                    </td>                 
                </tr> 
                <tr>
                    <td>收件地址</td>
                    <td colspan="7">
                        <input type="text" v-model="info.address" aplDataName="address" placeholder="输入5-200位" Verification="5-200" style="width: 800px;">
                    </td>                                                         
                </tr>
                <tr>
                    <td>收件第二行</td>
                    <td colspan="7">
                        <input type="text" v-model="info.address2" aplDataName="address2" placeholder="输入50位之内" Verification="0-50" style="width: 800px;">
                    </td>
                </tr>
                <tr>
                    <td>收件第三行</td>
                    <td colspan="7">
                        <input type="text" v-model="info.address3" aplDataName="address3" placeholder="输入50位之内" Verification="0-50" style="width: 800px;">
                    </td> 
                </tr>
                <tr>
                    <td>国家</td>
                    <td>
                        <input type="text" v-model="info.countryNo" aplDataName="countryNo" Verification="2-5" style="width:60px">
                        <input type="text" v-model="info.countryCn" id="countryCn" aplDataName="countryCn"  style="width:120px" >
                        <button type="button" onclick="sbo.go2('country','#countryNo','c1','#countryCn','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button>
                    </td>
                    <!-- <td>国家中文名</td>
                    <td>
                        <input type="text" v-model="info.countryCn" aplDataName="countryCn" placeholder="输入1-20位" Verification="1-20">
                    </td> -->
                    <td>州(省)</td>
                    <td>
                        <input type="text" v-model="info.toState" aplDataName="toState" placeholder="输入50位之内" Verification="0-50">
                    </td> 
                    <td>城市</td>
                    <td>
                        <input type="text" v-model="info.toCity" aplDataName="toCity" placeholder="输入50位之内" Verification="0-50">
                    </td>
                    <td>邮编</td>
                    <td>
                        <input type="text" v-model="info.zip" aplDataName="zip"  placeholder="输入15位之内" Verification="0-15">
                    </td>                
                </tr>  
                <tr>
                    <td>运件类型</td>
                    <td>
                        <select  v-model="info.ywType" aplDataName="ywType"  Verification="1-20">
                            <option value=""></option>
                            <option value="1">国际快递</option>
                            <option value="2">国际空运</option>
                            <option value="3">国际海运</option>
                            <option value="4">国际小包</option>
                            <option value="5">国际进口</option>                            
                        </select>
                    </td>
                    <td>参考号</td>
                    <td>
                        <input type="text" v-model="info.refNo" aplDataName="refNo"  placeholder="输入20位之内" Verification="0-20">
                    </td>
                    <td>跟踪号</td>
                    <td>
                        <input type="text" v-model="info.trackNo" aplDataName="trackNo" placeholder="输入20位之内" Verification="0-20">
                    </td>
                    <td>包裹类型</td>
                    <td>
                        <select  v-model="info.packDoc" aplDataName="packDoc"  Verification="1-20">
                            <option value=""></option>
                            <option value="WPX">WPX</option>
                            <option value="DOC">DOC</option>                        
                        </select>
                    </td>
                </tr> 
                <tr>  
                    <td>渠道类型</td>
                    <td>
                        <input type="text" v-model="info.transit" aplDataName="transit" placeholder="输入1-20位" Verification="1-20">
                    </td>
                    <td>渠道名称</td>
                    <td>
                        <input type="text" v-model="info.priceName" aplDataName="priceName" placeholder="输入2-30位" Verification="2-30">
                    </td>
                    <td>件数</td>
                    <td>
                        <input type="number" v-model="info.piece" aplDataName="piece" placeholder="100000内" Verification="1-100000">
                    </td>
                    <td>数量</td>
                    <td>
                        <input type="number" v-model="info.qty" aplDataName="qty"  placeholder="100000内" Verification="1-100000">
                    </td>
                </tr> 
                <tr> 
                    <td>实重</td>
                    <td>
                        <input type="number" v-model="info.GWT" aplDataName="GWT" placeholder="10000内" Verification="1-10000" onkeydown="APLDevel.clearNoNum(this,3)">KG
                    </td>
                    <td>体积重</td>
                    <td>
                        <input type="number" v-model="info.VWT" aplDataName="VWT" placeholder="10000内" Verification="1-10000" onkeydown="APLDevel.clearNoNum(this,3)">KG
                    </td>                              
                     <td>计费重</td>
                    <td>
                        <input type="number" v-model="info.CWT" aplDataName="CWT" placeholder="10000内" Verification="1-10000" onkeydown="APLDevel.clearNoNum(this,3)">
                    </td> 
                    <td>货物编码</td>
                    <td>
                        <input type="text" v-model="info.productCode" aplDataName="productCode" placeholder="输入50位之内" Verification="0-50">
                    </td>      
                </tr>
                <tr>
                    <td>中文品名</td>
                    <td>
                        <input type="text" v-model="info.goods" aplDataName="goods" placeholder="输入200位之内" Verification="0-200">
                    </td>
                    <td>申报品名</td>
                    <td>
                        <input type="text" v-model="info.goodsEn" aplDataName="goodsEn" placeholder="输入2-200位" Verification="2-200">
                    </td>     
                    <td>申报价值</td>
                    <td>
                        <input type="number" v-model="info.worth" aplDataName="worth" placeholder="1000000内" Verification="0-1000000" onkeydown="APLDevel.clearNoNum(this,2)">
                    </td>
                    <td>投保值</td>
                    <td>
                        <input type="number" v-model="info.insureValue" aplDataName="insureValue" placeholder="1000000内" Verification="0-1000000" onkeydown="APLDevel.clearNoNum(this,3)">
                    </td>                                  
                </tr>
                <tr>
                    <td>备注</td>
                    <td colspan="7">
                        <input type="text" v-model="info.remark" aplDataName="remark" placeholder="输入200位之内" Verification="0-200" style="width: 800px;">
                    </td>
                </tr>                                         
            </table>                          
        </form>                     
    </div>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../plugins/layer/layer.min.js"></script>
    <script src="../../plugins/WdatePicker/WdatePicker.js"></script>
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