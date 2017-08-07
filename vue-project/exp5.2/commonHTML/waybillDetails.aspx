<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>运件清单详情</title>
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
        #app th{padding: 5px;border: 1px solid #ddd;}  
        .tdCenter td{text-align: center;} 
        .tdCenter td a{color: red;}       
        #app td input{width: 100%;height: 30px;padding: 0px 5px;}
        .newRow{display: none;}
        #app .modify{
            background-color: #FF5722;
            height: 30px;
            line-height: 30px;
            padding: 0 10px;
            font-size: 14px;
            text-align: center;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            opacity: .9;
            color: white;
            font-weight: normal;
        }
        #tabServMsg ul{margin:0px 0px 10px 10px;width: 1098px;border: 1px solid #ddd;border-bottom: 0;}
        #tabServMsg ul li{width: 100%;margin-bottom: 10px;border-bottom: 1px solid #ddd;padding: 5px;}
        #tabServMsg ul li input{width: 14px;height: 14px;vertical-align: middle;margin: 0 0 0 15px;}
        #tabServMsg ul li textarea{vertical-align: text-top;resize:none;width: 800px;height: 100px;padding:5px;}
        #tabServMsg ul li button{padding: 5px;margin-left: 5px;}
        #chargeList{overflow: hidden;}
        #chargeList p{float: left;width: 325px;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">waybill</div>
    
    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <div id="app">
        <div class="apl-tool">
            <!-- <button type="button" class="layui-btn layui-btn-small layui-btn-danger" onclick="saveInfo()">保存</button> -->
            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="parent.l_popup.close(0);parent.ad.doList(1)">关闭</button>
        </div>
        <!-- 基本信息 -->
        <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">基本信息：<button class="modify" @click="modifyData('info')" level="m" style="display: none;">修改</button></p>
        <form>
            <table cellspacing="0" cellpadding="0">
                <tr>
                    <td>下单日期</td>
                    <td>
                        {{info.checkinTime}}
                    </td>
                    <td>订单类型</td>
                    <td>
                        <span v-if="info.type==1">快递</span>
                        <span v-if="info.type==2">空运</span>
                    </td>
                    <td>入库批号</td>
                    <td>
                        {{info.inNoAll}}
                    </td> 
                    <td>客户简称</td>
                    <td>
                        {{info.clientName}}
                    </td>                      
                </tr>
                <tr>
                    <td>客户单号</td>
                    <td>
                        {{info.inCorpNo}}
                    </td> 
                    <td>运单号</td>
                    <td>
                        {{info.inNo}}
                    </td>
                    <td>转单号</td>
                    <td>
                        {{info.webNo}}
                    </td>
                     <td>附加项目</td>
                    <td>
                        {{info.shipServ}}
                    </td>
                </tr> 
                <tr>
                    <td>起运地</td>
                    <td>
                        {{info.startShip}}
                    </td>
                    <td>国家简码</td>
                    <td>
                        {{info.countryNo}}
                    </td>
                    <td>国家名</td>
                    <td>
                        {{info.countryCn}}
                    </td> 
                    <td>件数</td>
                    <td>
                        {{info.piece}}
                    </td>
                </tr>  
                <tr>
                    <td>收渠道类型</td>
                    <td>
                        {{info.inTransit}}
                    </td>
                    <td>出渠道类型</td>
                    <td>
                        {{info.outtransit}}
                    </td>
                    <td>收裹类型</td>
                    <td>
                        {{info.inPackdoc}}
                    </td>                    
                    <td>出裹类型</td>
                    <td>
                        {{info.outPackDoc}}
                    </td>
                </tr>      
                <tr>
                    <td>总申报价值</td>
                    <td>
                        {{info.worth}}
                    </td>                    
                    <td>品名</td>
                    <td>
                        {{info.goods}}
                    </td>
                    <td>邮编</td>
                    <td>
                        {{info.postalCode}}
                    </td>
                    <td>核销单</td>
                    <td>
                        {{info.hxd}}
                    </td>
                </tr>      
                <tr>                   
                    <td>业务员</td>
                    <td>
                        {{info.ywyName}}
                    </td>
                    <td>出货状态</td>
                    <td>
                        {{info.outState}}
                    </td>                    
                    <td>状态</td>
                    <td>
                        {{info.state}}
                    </td>
                     <td>收货员</td>
                    <td>
                        {{info.inOpr}}
                    </td>
                </tr>
                <tr>
                    <td>上网状态</td>
                    <td>
                        {{info.trackState}}
                    </td>
                    <td>付款结算</td>
                    <td>
                        {{info.payment}}
                    </td>                    
                    <td>毛利</td>
                    <td>
                        {{info.gain}}
                    </td>   
                     <td>出货员</td>
                    <td>
                        {{info.outOpr}}
                    </td>                  
                </tr>                
                <tr>
                    <td>内部备注</td>
                    <td colspan="7">
                        {{info.remark}}
                    </td>                
                   
                </tr>
                <tr>
                    <td>收货备注</td>
                    <td colspan="7">
                        {{info.inRemark}}
                    </td> 
                </tr> 
                <tr>
                    <td>出货备注</td>
                    <td colspan="7">
                        {{info.outRemark}}
                    </td> 
                </tr>                                                
            </table>                          
        </form> 
        <!-- 基本信息2 -->
        <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">基本信息2：<button class="modify" @click="modifyData('info2')" level="m" style="display: none;">修改</button></p>
        <form>
            <table cellspacing="0" cellpadding="0">
                <tr>
                    <td>寄件国家</td>
                    <td>
                        {{info2.fromCountryNo}}
                    </td>
                    <td>寄件人公司</td>
                    <td>
                         {{info2.fromCompany}}
                    </td>
                    <td>寄件人名</td>
                    <td>
                        {{info2.fromMan}}
                    </td>                   
                </tr>
                <tr>
                    <td>寄个人电话</td>
                    <td>
                        {{info2.fromPhone}}
                    </td>                    
                    <td>寄件人地址</td>
                    <td>
                        {{info2.fromAddress}}
                    </td>
                    <td>收件人公司</td>
                    <td>
                        {{info2.recipCompany}}
                    </td>
                </tr> 
                <tr>
                    <td>收件人名</td>
                    <td>
                        {{info2.recipMan}}
                    </td>                    
                    <td>收件人手机</td>
                    <td>
                        {{info2.recipMobile}}
                    </td>
                    <td>收件人电话</td>
                    <td>
                        {{info2.recipPhone}}
                    </td>
                </tr>  
                <tr>
                    <td>收件人邮箱</td>
                    <td>
                        {{info2.recipEmail}}
                    </td>                    
                    <td>收件地址1行</td>
                    <td>
                        {{info2.recipAddress}}
                    </td>
                    <td>收件地址2行</td>
                    <td>
                        {{info2.recipAddress2}}
                    </td>
                </tr> 
                <tr>
                    <td>收件地址3行</td>
                    <td>
                        {{info2.recipAddress3}}
                    </td>                    
                    <td>州(省)</td>
                    <td>
                        {{info2.toState}}
                    </td>
                    <td>城市</td>
                    <td>
                        {{info2.toCity}}
                    </td>
                </tr>      
                <tr>
                    <td>数量</td>
                    <td>
                        {{info2.qty}}
                    </td>                    
                    <td>投保值</td>
                    <td>
                        {{info2.insureValue}}
                    </td>
                    <td>申报明细</td>
                    <td>
                        {{info2.goodsInfo}}
                    </td>
                </tr>                                     
            </table>                          
        </form> 
        <!-- 留言信息 -->
        <div id="tabServMsg">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">留言信息：</p>
            <ul>
                <li v-for="(row,index) in servMsg">
                    <button class="modify" @click="modifyData('servMsg',index)" level="m" style="display: none;">编辑</button> 
                    <span style="color: red;">操作时间：{{row.bookTime}}</span> 
                    <span>操作人：{{row.oprName}}</span>
                    <br>
                    <span style="padding: 10px 0 0 10px;display: inline-block;">备注：
                        <span v-if="row.way==1">From服务商</span>
                        <span v-if="row.way==2">To服务商</span>
                        <span v-if="row.way==3">From客户</span>
                        <span v-if="row.way==4">TO客户</span>
                        <span v-if="row.way==5">内部备注</span>
                        ：{{row.remark}}
                    </span>
                </li>
                <li>
                    <span class="xxlx">信息流向：</span>
                    <input type="radio" name="1" value="1"> From服务商
                    <input type="radio" name="1" value="2"> To服务商
                    <input type="radio" name="1" value="3"> From客户
                    <input type="radio" name="1" value="4"> TO客户
                    <input type="radio" name="1" value="5"> 内部备注
                    <br><br>
                    内容：<textarea></textarea>
                    <br><br>
                    <button onclick="servMsgSave()">提交</button>
                </li>
            </ul>
        </div>          
        <!-- 操作日志 -->
        <div id="tabOprLog" class="tdCenter">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">操作日志：</p>
            <table class="apl-tableSpecial">
                <tr>
                    <th>日期</th>
                    <th>内容1</th>
                    <th>内容2</th>
                    <th>操作人</th>
                </tr>
                <tr v-for="row in oprLog">
                   <td>{{row.oprTime}}</td>
                   <td>{{row.content1}}</td>
                   <td>{{row.content2}}</td>
                   <td>{{row.oprName}}</td>
                </tr>               
            </table> 
        </div>
        <!-- 重量及费用 -->
        <div id="tabChargeList" class="tdCenter">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">重量及费用：<button class="modify" @click="modifyData('chargeList')" level="m" style="display: none;">添加</button></p>
            <table class="apl-tableSpecial">
                <tr>
                    <th>方向</th>
                    <th>服务商</th>
                    <th>实重</th>
                    <th>体积重</th>
                    <th>计费重</th>
                    <th>体基</th>
                    <th>费用名</th>
                    <th>金额</th>
                    <th>币制</th>
                    <th>汇率</th>
                    <th>销账</th>
                    <th>公式</th>
                    <th>渠道</th>
                    <th>备注</th>
                    <th>审核</th>
                    <td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
                    <td level="m" style="display: none;">删除</td>
                </tr>
                <tr v-for="(row,index) in chargeList">
                   <td>
                        <span v-if="row.way==1">收入</span>
                        <span v-if="row.way==2">支出</span>
                   </td>
                   <td>{{row.dxId}}</td>
                   <td>{{row.GWT}}</td>
                   <td>{{row.VWT}}</td>
                   <td>{{row.CWT}}</td>
                   <td>{{row.vwtfm}}</td>
                   <td>{{row.chargeName}}</td>
                   <td>{{row.charge}}</td>
                   <td>{{row.currency}}</td>
                   <td>{{row.hl}}</td>
                   <td>{{row.chargeAcc}}</td>
                   <td>{{row.exp}}</td>
                   <td>{{row.priceName}}</td>
                   <td>{{row.remark}}</td>
                   <td>{{row.auditing}}</td>
                   <td level="m" style="display: none;">
                        <a href="javascript:;" @click="modifyData('chargeList',index)">
                            <i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
                        </a>
                    </td>
                    <td level="m" style="display: none;">
                        <a href="javascript:;" @click="delData(row.id,index,'chargeList')">                    
                            删除
                        </a>
                    </td>
                </tr>               
            </table>
        </div>
        <!-- 转运信息 -->
        <div id="tabTrack" class="tdCenter">
            <p style="margin: 10px;color:red;font-weight: bold;font-size: 16px;">转运信息：<button class="modify" @click="modifyData('track')" level="m" style="display: none;">添加</button></p>
            <table class="apl-tableSpecial">
                <tr>
                    <th>日期时间</th>
                    <th>转运地点</th>
                    <th>转运信息</th>
                    <td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
                    <td level="m" style="display: none;">删除</td>
                </tr>
                <tr v-for="(row,index) in track">
                   <td>{{row.datetime}}</td>
                   <td>{{row.location}}</td>
                   <td>{{row.activity}}</td>
                   <td level="m" style="display: none;">
                        <a href="javascript:;" @click="modifyData('track',index)">
                            <i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
                        </a>
                    </td>
                    <td level="m" style="display: none;">
                        <a href="javascript:;" @click="delData(row.id,index,'track')">             
                            删除
                        </a>
                    </td>
                </tr>               
            </table>
        </div>

        <!-- 基本信息修改 -->
        <table cellspacing="0" cellpadding="0" id="info" style="display: none;">
            <tr>
                <td>运件类型</td>
                <td>
                    <select :value="info.type" aplDataName="type" Verification="1-5">
                        <option value="1">快递</option>
                        <option value="2">空运</option>
                    </select>
                </td> 
                <td>客户单号</td>
                <td>
                    <input type="text" :value="info.inCorpNo" aplDataName="inCorpNo" placeholder="请输入0-30位" Verification="0-30">
                </td> 
                <td>运单号</td>
                <td>
                    <input type="text" :value="info.inNo" aplDataName="inNo" placeholder="请输入1-20位" Verification="1-20">
                </td>
                <td>转单号</td>
                <td>
                    <input type="text" :value="info.webNo" aplDataName="webNo">
                </td>                    
            </tr> 
            <tr>
                <td>起运地</td>
                <td>
                    <input type="text" :value="info.startShip" aplDataName="startShip">
                </td>
                <td>国家</td>
                <td>
                    <input type="text" :value="info.countryNo" aplDataName="countryNo"  placeholder="请输入1-6位" Verification="1-6">
                </td>
                <td>件数</td>
                <td>
                    <input type="text" :value="info.piece" aplDataName="piece">
                </td>
                <td></td>
                <td>

                </td>
            </tr>  
            <tr>
                <td>收渠道类型</td>
                <td>
                    <input type="text" :value="info.inTransit" aplDataName="inTransit">
                </td>
                <td>出渠道类型</td>
                <td>
                    <input type="text" :value="info.outtransit" aplDataName="outtransit">
                </td>
                <td>收包裹类型</td>
                <td>
                    <input type="text" :value="info.inPackdoc" aplDataName="inPackdoc">
                </td>                    
                <td>出包裹类型</td>
                <td>
                    <input type="text" :value="info.outPackDoc" aplDataName="outPackDoc">
                </td>
            </tr>                 
            <tr>
                <td>总申报价值</td>
                <td>
                    <input type="text" :value="info.worth" aplDataName="worth">
                </td>                    
                <td>品名</td>
                <td>
                    <input type="text" :value="info.goods" aplDataName="goods">
                </td>
                <td>邮编</td>
                <td>
                    <input type="text" :value="info.postalCode" aplDataName="postalCode">
                </td>
                <td>核销单</td>
                <td>
                    <input type="text" :value="info.hxd" aplDataName="hxd">
                </td>
            </tr> 
            <tr>
             <td>附加项目</td>
                <td colspan="7">
                    <input type="text" :value="info.shipServ" aplDataName="shipServ">
                </td>
            </tr>     
            <tr>
                <td>内部备注</td>            
                <td colspan="7">
                    <input type="text" :value="info.remark" aplDataName="remark">
                </td>                   
            </tr>
            <tr>
                <td>收货备注</td>
                <td colspan="7">
                   <input type="text" :value="info.inRemark" aplDataName="inRemark">
                </td>
            </tr>
            <tr>
                <td>出货备注</td>
                <td colspan="7">
                    <input type="text" :value="info.outRemark" aplDataName="outRemark">
                </td>
            </tr>                                          
        </table>
        <!-- 基本信息2修改 -->
        <table cellspacing="0" cellpadding="0" id="info2" style="display: none;">
                <tr>
                    <td>寄件国家</td>
                    <td>
                        <input type="text" :value="info2.fromCountryNo" aplDataName="fromCountryNo" placeholder="请输入0-30位" Verification="0-30">
                    </td>
                    <td>寄件人公司</td>
                    <td>
                         <input type="text" :value="info2.fromCompany" aplDataName="fromCompany">
                    </td>
                    <td>寄件人名</td>
                    <td>
                        <input type="text" :value="info2.fromMan" aplDataName="fromMan">
                    </td>                   
                </tr>
                <tr>
                    <td>寄个人电话</td>
                    <td>
                        <input type="text" :value="info2.fromPhone" aplDataName="fromPhone">
                    </td>                    
                    <td>寄件人地址</td>
                    <td>
                        <input type="text" :value="info2.fromAddress" aplDataName="fromAddress">
                    </td>
                    <td>收件人公司</td>
                    <td>
                        <input type="text" :value="info2.recipCompany" aplDataName="recipCompany">
                    </td>
                </tr> 
                <tr>
                    <td>收件人名</td>
                    <td>
                        <input type="text" :value="info2.recipMan" aplDataName="recipMan">
                    </td>                    
                    <td>收件人手机</td>
                    <td>
                        <input type="text" :value="info2.recipMobile" aplDataName="recipMobile">
                    </td>
                    <td>收件人电话</td>
                    <td>
                        <input type="text" :value="info2.recipPhone" aplDataName="recipPhone">
                    </td>
                </tr>  
                <tr>
                    <td>收件人邮箱</td>
                    <td>
                        <input type="text" :value="info2.recipEmail" aplDataName="recipEmail">
                    </td>                    
                    <td>收件地址1行</td>
                    <td>
                        <input type="text" :value="info2.recipAddress" aplDataName="recipAddress">
                    </td>
                    <td>收件地址2行</td>
                    <td>
                        <input type="text" :value="info2.recipAddress2" aplDataName="recipAddress2">
                    </td>
                </tr> 
                <tr>
                    <td>收件地址3行</td>
                    <td>
                        <input type="text" :value="info2.recipAddress3" aplDataName="recipAddress3">
                    </td>                    
                    <td>州(省)</td>
                    <td>
                        <input type="text" :value="info2.toState" aplDataName="toState">
                    </td>
                    <td>城市</td>
                    <td>
                        <input type="text" :value="info2.toCity" aplDataName="toCity">
                    </td>
                </tr>      
                <tr>
                    <td>数量</td>
                    <td>
                        <input type="text" :value="info2.qty" aplDataName="qty">
                    </td>                    
                    <td>投保值</td>
                    <td>
                        <input type="text" :value="info2.insureValue" aplDataName="insureValue">
                    </td>
                    <td>申报明细</td>
                    <td>
                        <input type="text" :value="info2.goodsInfo" aplDataName="goodsInfo">
                    </td>
                </tr>                                     
        </table>  
        <!-- 留言信息编辑 -->
        <div id="servMsg" style="display: none;">
            <p>
                <span>信息流向：</span>
                <select Verification="1-10" apldataname="way" :value="servMsgInfo.way">
                    <option value="1">From服务商</option>
                    <option value="2">To服务商</option>
                    <option value="3">From客户</option>
                    <option value="4">TO客户</option>
                    <option value="5">内部备注</option>  
                </select>
            </p>
            <p style="height: auto;overflow: hidden;">
                <span style="float: left;margin-right: 3px;">内容：</span>
                <textarea :value="servMsgInfo.remark" Verification="1-1000000" apldataname="remark" onblur="APLDevel.Vertion('',$(this),$(this).prev())"></textarea>
            </p>
        </div>
        <!-- 重量及费用编辑 -->
        <div id="chargeList" style="display: none;">
            <p>
                <span>方向：</span>
                <select Verification="1-10" apldataname="way" :value="chargeListInfo.way">
                    <option value="1">收入</option>
                    <option value="2">支出</option>
                </select>
            </p>
            <p>
                <span>服务商：</span>
                <input type="text" apldataname="dxId" :value="chargeListInfo.dxId" placeholder="请输入1-10位" Verification="1-10">
            </p>
            <p>
                <span>实重：</span>
                <input type="text" apldataname="GWT" :value="chargeListInfo.GWT">
            </p>
            <p>
                <span>体积重：</span>
                <input type="text" apldataname="VWT" :value="chargeListInfo.VWT">
            </p>
            <p>
                <span>计费重：</span>
                <input type="text" apldataname="CWT" :value="chargeListInfo.CWT">
            </p>
            <p>
                <span>体积：</span>
                <input type="text" apldataname="vwtfm" :value="chargeListInfo.vwtfm">
            </p>
            <p>
                <span>费用名：</span>
                <input type="text" apldataname="chargeName" :value="chargeListInfo.chargeName" placeholder="请输入1-10位" Verification="1-10">
            </p>
             <p>
                <span>金额：</span>
                <input type="text" apldataname="charge" :value="chargeListInfo.charge">
            </p>
            <p>
                <span>币制：</span>
                <input type="text" apldataname="currency" :value="chargeListInfo.currency">
            </p>
            <p>
                <span>汇率：</span>
                <input type="text" apldataname="hl" :value="chargeListInfo.hl">
            </p>
            <p>
                <span>销账：</span>
                <input type="text" apldataname="chargeAcc" :value="chargeListInfo.chargeAcc">
            </p>
            <p>
                <span>公式：</span>
                <input type="text" apldataname="exp" :value="chargeListInfo.exp">
            </p>
            <p>
                <span>渠道：</span>
                <input type="text" apldataname="priceName" :value="chargeListInfo.priceName">
            </p>
            <p>
                <span>备注：</span>
                <input type="text" apldataname="remark" :value="chargeListInfo.remark" placeholder="请输入1-50位" Verification="1-50">
            </p>
            <p>
                <span>审核：</span>
                <input type="text" apldataname="auditing" :value="chargeListInfo.auditing">
            </p>
        </div>
         <!-- 转运信息编辑 -->
        <div id="track" style="display: none;">
            <p>
                <span>转运地点：</span>
                <input type="text" apldataname="location" :value="trackInfo.location">
            </p>
            <p>
                <span>转运信息：</span>
                <input type="text" apldataname="activity" :value="trackInfo.activity">
            </p>
        </div>
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

        //运件清单详情修改
        function waybillModify(attr,index) {
            var url = '/general5/doSave';
            ad.id = 0;
            switch(attr){
                case 'info':
                    ad.id = app.info.id;
                    ad.dlgEdit(url, $('#'+attr), app.info, 'auto', null,'modelName=checkin');
                break;
                case 'info2':
                    ad.id = app.info2.id;
                    ad.dlgEdit(url, $('#'+attr), app.info2, 'auto', null,'modelName=checkinInfo');
                break;
                case 'servMsg':   
                    ad.id = app.servMsg[index].id;
                    app.servMsgInfo = app.servMsg[index];
                    ad.dlgEdit(url, $('#'+attr), app.servMsg[index], 'auto', null,'modelName=servMsg');
                break;
                case 'chargeList':                       
                    if (index == undefined) {
                        app.chargeListInfo = {};
                        APLDevel.dlg(null,$('#'+attr), '详细信息', '720px', null,'保存',chargeListSave);
                    }
                    else {
                        ad.id = app.chargeList[index].id;
                        app.chargeListInfo = app.chargeList[index];
                        ad.dlgEdit(url, $('#'+attr), app.chargeList[index], '720px', null,'modelName=chargeList');
                    }
                break;
                case 'track':                       
                    if (index == undefined) {
                        app.trackInfo = {};
                        APLDevel.dlg(null,$('#'+attr), '详细信息', null, null,'保存',trackSave);
                    }
                    else {
                        ad.id = app.track[index].id;
                        app.trackInfo = app.track[index];
                        ad.dlgEdit(url, $('#'+attr), app.track[index], null, null,'modelName=track');
                    }
                break;
            }
        }
        //运件清单详情留言信息保存
        function servMsgSave() {
            var xxlx = $('#tabServMsg input:radio:checked').val();
            if(!xxlx){
                l_tips('请选择信息流向',$('.xxlx'),{backgroundColor:'blue'});
                return;
            }
            if ($('#tabServMsg textarea').val() == '') {
                l_tips('内容不能为空',$('#tabServMsg textarea'),{backgroundColor:'blue'});
                return;
            }   
            var data = 'mapFile='+dbTab+'.xml&modelName=servMsg&way='+xxlx+'&remark='+$('#tabServMsg textarea').val()+"&mainTabId="+ad.mainTabId;
            var url = ad.host + '/general5/doSave';
            $.ajax({
                data:data,
                type:'post',
                dataType:'json',
                url:url,
                success:function(data) {
                    $('#tabServMsg input:radio:checked').attr('checked',false);
                    $('#tabServMsg textarea').val('');
                    if (data.Message != undefined) alert(data.Message); 
                    if (data.Error != undefined) alert(data.Error); 
                    detailsInfo();
                },
                error:function() {
                    alert('保存失败');
                }
            })
        } 
        //运件清单详情重量及费用保存 
        function chargeListSave(box,index) {
            if (!APLDevel.Vertion(box)) return;
            var data = 'mapFile='+dbTab+'.xml&modelName=chargeList&'+APLDevel.getBoxData(box)+"&mainTabId="+ad.mainTabId;
            var url = ad.host + '/general5/doSave';
            $.ajax({
                data:data,
                type:'post',
                dataType:'json',
                url:url,
                success:function(data) {
                    if (data.Message != undefined) alert(data.Message); 
                    if (data.Error != undefined) alert(data.Error); 
                    detailsInfo();
                    l_popup.close(index);
                },
                error:function() {
                    alert('保存失败');
                }
            })
        } 
        //运件清单详情转运信息保存 
        function trackSave(box,index) {
            if (!APLDevel.Vertion(box)) return;
            var data = 'mapFile='+dbTab+'.xml&modelName=track&'+APLDevel.getBoxData(box)+"&mainTabId="+ad.mainTabId;
            var url = ad.host + '/general5/doSave';
            $.ajax({
                data:data,
                type:'post',
                dataType:'json',
                url:url,
                success:function(data) {
                    alert(data.Message);
                    detailsInfo();
                    l_popup.close(index);
                },
                error:function() {
                    alert('保存失败');
                }
            })
        } 
        //删除
        function del(id,index,attr) {
            var url = '/general5/doDel';
            ad.success=function() {
                if (attr == 'chargeList') app.chargeList.splice(index, 1);
                if (attr == 'track') app.track.splice(index, 1);    
            }
            ad.doDel(url,id,'mainTabId='+ad.mainTabId+'&dbTab='+attr);
        }
    </script>
</body>
</html>