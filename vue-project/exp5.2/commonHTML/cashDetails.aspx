<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>出纳管理详情</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../../css/apl-1.0.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<style>
		#app input{height: 30px;padding: 0px 5px;}
		#app form td{padding: 10px 5px;}
		#app form input{width: 150px;}
		#app form span{display: inline-block;width: 90px;}
		#app form select{height: 30px;}
		#app table{width: 1000px;}
        #app select{height: 30px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #tabCashact td input{width: 100px;}
        .newRow{display: none;}
	</style>	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">cash</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<div id="app">
		<div class="apl-tool" style="margin-bottom: 10px;">
            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" onclick="saveInfo()">保存</button>
            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="parent.l_popup.close(0);parent.ad.doList(1)">关闭</button>
        </div>
        <!-- 基本信息 -->
        <form>
        	<table>
        		<tr>	
					<td>	
						<span>客户：</span><input type="text" apldataname="clientName" v-model="info.clientName" id="clientName">
                    	<input type="hidden" aplDataName="clientId" id="clientId" corre="clientName">
                    	<button type="button" onclick="sbo.go2('client','#clientId','id', '#clientName', 'c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;margin-right: 10px;"><i class="layui-icon"></i></button>

				    	<span>日期：</span><input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" apldataname="bookTime" class="input-text Wdate" v-model="info.bookTime"> 
				    	<span>编号：</span><input type="text" apldataname="cashNo" v-model="info.cashNo"  disabled="true">		
					</td>
        		</tr>
        		<tr>	
					<td>	
						<span>服务商：</span><input type="text" apldataname="coagentName" v-model="info.coagentName" id="coagentName">
						<input type="hidden" aplDataName="coagentId" id="coagentId" corre="coagentName">
                    	<button type="button" onclick="sbo.go2('coagent','#coagentId','id', '#coagentName', 'c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;margin-right: 10px;"><i class="layui-icon"></i></button>

						<span>出纳员：</span><input type="text" apldataname="oprBill" v-model="info.oprBill"  disabled="true">
						<span>出纳结账：</span><input type="text" apldataname="oprJz" v-model="info.oprJz"  disabled="true">
					</td>
        		</tr>
        		<tr>	
					<td>	
						<span>备注：</span><input type="text" apldataname="remark" style="width: 696px;" v-model="info.remark">
					</td>
        		</tr>
        	</table>
        </form>
        <!-- 项目明细 -->
        <div id="tabCashact" style="display: none; margin-top: 15px;">
		    <table>
	            <thead>
		            <tr>
		                <td style="display: none;" level="m">编辑</td>
		                <td><span>科目</span></td>
		                <td><span>账户</span></td>
		                <td><span>收入</span></td>
		                <td><span>支出</span></td>
		                <td><span>汇率</span></td>		                
		                <td><span>备注</span></td>
		                <td><span>销账</span></td>
		                <td style="display: none;" level="m">删除</td>
		            </tr>
	            </thead>
	            <tbody>
		            <tr v-for="row in cashact">
		                <td align="cetner" style="display: none;" level="m">
		                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
		                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'cashact')" style="display: none;margin-left: 0px;" >保 存</button>
		                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
		                </td>
		                <td>
		                    <input type="hidden" name="numCode" aplDataName="numCode" v-model="row.numCode">
		                    <input type="text" name="summary" disabled="true" aplDataName="summary" v-model="row.summary" Verification="2-100" onblur="vertionCell(this)">
		                    <button type="button" onclick="sbo.go2('summary','numCode','c1', 'summary', 'c2')" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button>
		                </td>		              
		                <td>
		                    <input type="hidden" name="accountId" disabled="true" aplDataName="accountId" v-model="row.accountId">
		                    <input type="text" name="accountName" disabled="true" aplDataName="accountName" v-model="row.accountName" Verification="0-100" onblur="vertionCell(this)">
		                    <button type="button" onclick="sbo.go2('account','accountId','id', 'accountName', 'c2')" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button>
		                </td>		               
		                <td>
		                    <input type="text" name="inCharge" disabled="true" aplDataName="inCharge" v-model="row.inCharge" Verification="0-100" onblur="vertionCell(this)">
		                    <select disabled="true"  v-model="row.inCurrency"  aplDataName="inCurrency" >
								<option value=""></option>
								<option value="RMB">RMB</option>
								<option value="HKD">HKD</option>
								<option value="USD">USD</option>
		                    </select>
		                </td>
		                <td>
		                    <input type="text" name="outCharge" disabled="true" aplDataName="outCharge"  v-model="row.outCharge" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
		                    <select disabled="true"  v-model="row.outCurrency" aplDataName="outCurrency">
								<option value=""></option>
								<option value="RMB">RMB</option>
								<option value="HKD">HKD</option>
								<option value="USD">USD</option>
		                    </select>
		                </td>
		                <td>
		                    <input type="text" name="hl" disabled="true" aplDataName="hl"  v-model="row.hl" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
		                </td>
		                <td>
		                    <input type="text" name="remarkact" disabled="true" aplDataName="remarkact"  v-model="row.remarkact"  Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
		                </td>
		                <td>
							{{row.chargeAcc}}
		                </td>
		                <td style="display: none;" level="m">
		                    <a href="javascript:;" onclick="delRow(this,'cashact')" style="color: red;">删 除</a>
		                </td>
		            </tr>
		            <tr class="newRow">
		                <td align="cetner"  style="display: none;" level="m">
		                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
		                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'cashact')" style="display: inline-block;margin-left: 0px;">保 存</button>
		                    <input type="hidden" aplDataName="rowId"/>
		                </td>		              		    
		                <td>
		                    <input type="hidden" aplDataName="numCode" >
		                    <input type="text" aplDataName="summary" Verification="2-100" onblur="vertionCell(this)">
		                    <button type="button" onclick="sbo.go2('summary','numCode','c1', 'summary', 'c2')" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button>
		                </td>		             
		                <td>
		                    <input type="hidden" aplDataName="accountId" >
		                    <input type="text" aplDataName="accountName" Verification="0-100" onblur="vertionCell(this)">
		                    <button type="button" onclick="sbo.go2('account','accountId','id', 'accountName', 'c2')" level="m" class="layui-btn layui-btn-mini" style="line-height: 17px;"><i class="layui-icon"></i></button>
		                </td>		               
		                <td>
		                    <input type="text"  aplDataName="inCharge" Verification="0-100" onblur="vertionCell(this)">
		                    <select aplDataName="inCurrency">
								<option value=""></option>
								<option value="RMB">RMB</option>
								<option value="HKD">HKD</option>
								<option value="USD">USD</option>
							</select>
		                </td>
		                <td>
		                    <input type="text" aplDataName="outCharge" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
		                	<select  aplDataName="outCurrency">
								<option value=""></option>
								<option value="RMB">RMB</option>
								<option value="HKD">HKD</option>
								<option value="USD">USD</option>
		                    </select>
		                </td>
		                <td>
		                    <input type="text" aplDataName="hl" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
		                </td>		               
		                <td>
		                    <input type="text" aplDataName="remarkact" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
		                </td>
		                <td>

		                </td>
		                <td  style="display: none;" level="m">
		                    <a href="javascript:;" onclick="delRow(this,'cashact')" style="color: red;">删 除</a>
		                </td>
		            </tr>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="15">
	                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabCashact',1)"  style="display: none;" level="m">新 增</button>
	                    </td>
	                </tr>
	            </tfoot>
	        </table>
        </div>
	</div>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
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