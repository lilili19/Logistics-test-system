<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>运件清单</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../../css/apl-1.0.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<style>
		.listParamBox table input{height: 30px;}
		.listParamBox table select{height: 30px;}
		.listParamBox table button{padding: 5px;margin-right: 20px;}
		#exp .listParamBox table td{padding: 10px;}
		.apl-tool{margin-bottom: 10px;}
	</style>	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">waybill</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<div id="exp">
	    <div class="listParamBox">
	    	<table cellspacing="0" cellpadding="0" style="width: 1120px;">
				<tr>
					<td>
						日期：<input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="dateStart" class="input-text Wdate" style="width: 150px;"> &nbsp;至&nbsp;
		 			    <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="dateEnd" class="input-text Wdate" style="width: 150px;">
						&nbsp;
						客户：<input type="text" aplDataName="clientName" id="clientName" style="width: 100px">
                			  <input type="hidden" id="clientId" aplDataName="clientId"  corre="clientName" >
                			  <button type="button" onclick="sbo.go2('client','#clientId','id','#clientName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
                		服务商：<input type="text" aplDataName="coagentName" id="coagentName"  style="width: 100px">
                			    <input type="hidden" id="coagentId" aplDataName="coagentId"  corre="coagentName">
                			    <button type="button" onclick="sbo.go2('coagent','#coagentId','id','#coagentName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
                		业务员：<input type="text" aplDataName="ywyName" id="ywyName" style="width: 100px">
                			    <input type="hidden" type="text" id="ywy" aplDataName="ywy" corre="ywyName">
                			    <button type="button" onclick="sbo.go2('user','#ywy','id','#ywyName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
                		<button @click="modifyData(0)">添加</button>
					</td>
				</tr>
				<tr>
					<td>						
                		<select aplDataName="type" onchange="ad.doList(1)">
							<option value="">业务类型</option>
							<option value="1">快递</option>   
							<option value="2">空运</option>
							<option value="3">海运</option>
							<option value="4">小包</option>
							<option value="5">其他</option>
		 			    </select>       
                		<select aplDataName="state" onchange="ad.doList(1)">
							<option value="">状态</option>
							<option value="1">未出货</option>   
							<option value="2">超12小时未出货</option>
							<option value="3">已出货</option>
		 			    </select> 	
		 			    <select aplDataName="trackState" onchange="ad.doList(1)">
							<option value="">上网状态</option>
							<option value="1">已签收的</option>
							<option value="2">未签收的</option>
							<option value="3">未上网的</option>
		 			    </select>  
		 			    <select aplDataName="transit" onchange="ad.doList(1)">
							<option value="">渠道类型</option>
							<option :value="item.transit" v-for="item in tabTransit">{{item.transit}}</option>  
		 			    </select>
		 			    <select aplDataName="shipServ" onchange="ad.doList(1)">
							<option value="">附加项目</option>
							<option :value="item.shipServ" v-for="item in tabShipServ">{{item.shipServ}}</option>
		 			    </select> 	
		 			    <select aplDataName="holdState" onchange="ad.doList(1)">
							<option value="">问题件</option>
							<option value="1">扣件</option>   
							<option value="2">退件</option>
							<option value="3">等待问题件</option>
							<option value="3">已处理问题件</option>
							<option value="3">所有问题件</option>
		 			    </select>
						关键字 <input type="text" aplDataName="key"  style="text-indent: 5px; width: 70px; margin-right: 5px;" />
						单号 <input type="text" aplDataName="AWB"  style="text-indent: 5px; width: 100px; margin-right: 5px;" />
					    <button onClick="ad.doList(1)"  style="margin-right: 10px">搜索</button>
					    重量：<input type="text" aplDataName="wtStart" style="width: 50px"> 至 <input type="text" aplDataName="wtEnd"  style="width: 50px"> kg
					</td>
				</tr>			
				
	    	</table>
	    </div>
		<table cellspacing="0" cellpadding="0" width="100%" style="margin-top: 20px;width: 1500px;">
			<thead>
				<tr>
					<td>日期</td>					
					<td>入库批号</td>
					<td>客户</td>					
					<td>客户单</td>
					<td>运单号</td>
					<td>转单号</td>
					<td>国家</td>
					<td>件数</td>
					<td>包裹</td>
					<td>品名</td>
					<td>入重</td>
					<td>出重</td>
					<td>渠道</td>
					<td>应收款</td>
					<td>应付款</td>
					<td>毛利</td>
					<td>服务商</td>
					<td>备注</td>
					<td>状态</td>
					<td>上网状态</td>
					<td>业务员</td>
					<td>分公司</td>
					<td>类型</td>
				</tr>
			</thead>
			<tbody>
				<tr v-for="(row,index) in rows">
					<td>{{row.checkinTime}}</td>			
					<td>{{row.inNOAll}}</td>
					<td>{{row.clientName}}</td>
					<td>
						<a href="javascript:;" @click="modifyData(row.id)" style="color: red;font-weight: bold;">
						   {{row.inCorpNo}}
	                    </a>
					</td>
					<td>
						<a href="javascript:;" @click="modifyData(row.id)" style="color: red;font-weight: bold;">
						   {{row.inNo}}
	                    </a>
	                </td>
					<td>
						<a href="javascript:;" @click="modifyData(row.id)" style="color: red;font-weight: bold;">
						   {{row.webNo}}
	                    </a>					
					</td>
					<td>{{row.countryCn}}</td>					
					<td>{{row.piece}}</td>
					<td>{{row.inPackDoc}}</td>
					<td>{{row.goods}}</td>
					<td>{{row.inCWT}}</td>
					<td>{{row.outCWT}}</td>
					<td>{{row.inTransit}} {{row.priceName}}</td>
					<td>{{row.inChargeAll}}</td>
					<td>{{row.outChargeAll}}</td>
					<td>{{row.gain}}</td>
					<td>{{row.coagentNo}}</td>
					<td>{{row.remark}}</td>						
					<td>{{row.state}}</td>
					<td>{{row.trackLast}}</td>
					<td>{{row.ywyName}}</td>
					<td>{{row.companycode}}</td>
					<td>{{row.type}}</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="40">
						<div id="pager">
							<ul class="pages">
								<!-- <div>首页</div>
								<p>上一页</p>										
								<li>1</li>
								<li>2</li>
								<li>3</li>
								<li>4</li>
								<p>下一页</p>
								<div>尾页</div>
								<span>总共5条数据</span> -->
							</ul>
						</div>
						<div>
							<select id="selPageSize">
								<option value="20" selected>20</option>
								<option value="40">40</option>
								<option value="60">60</option>
								<option value="80">80</option>
							</select>
						</div>
						
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../plugins/WdatePicker/WdatePicker.js"></script>
	<script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	<script src="../js/common.js"></script>	
	<script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
</body>
</html>