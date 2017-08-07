<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>出纳管理</title>
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
	<div id="pagingSorting" style="display: none;">cash</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<div id="exp">
	    <div class="listParamBox">
	    	<table cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<button>结账</button>
				    	<button @click="modifyData(0)" style="display: none;" level="m">添加</button>
				    	<button>主营收入</button>
				    	<button>主营费用</button>
				    	<button>导出</button>
				    	账号：<input type="text" aplDataName="accountName" id="accountName" style="width: 100px">
                			  <input type="hidden" id="accountId" aplDataName="accountId"  corre="accountName" >
                			  <button type="button" onclick="sbo.go2('bankaccount','#accountId','id','#accountName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>	 			   
		 			    客户：<input type="text" aplDataName="clientName" id="clientName" style="width: 100px">
                			  <input type="hidden" id="clientId" aplDataName="clientId"  corre="clientName" >
                			  <button type="button" onclick="sbo.go2('client','#clientId','id','#clientName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
		 			    服务商：<input type="text" aplDataName="coagentName" id="coagentName"  style="width: 100px">
                			    <input type="hidden" id="coagentId" aplDataName="coagentId"  corre="coagentName">
                			    <button type="button" onclick="sbo.go2('coagent','#coagentId','id','#coagentName','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
					</td>
				</tr>
				<tr>
					<td>
						日期：<input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="dateStart" class="input-text Wdate" style="width: 150px;"> &nbsp;至&nbsp;
		 			    <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="dateEnd" class="input-text Wdate" style="width: 150px;">
		 			    <!-- 科目：<input type="text" aplDataName="summary"> -->
		 			    科目：<input type="text" aplDataName="summary" id="summary" style="width: 100px">
                			  <input type="hidden" id="numCode" aplDataName="numCode"  corre="summary" >
                			  <button type="button" onclick="sbo.go2('summary','#numCode','id','#summary','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
		 			    &nbsp;
		 			    <!-- 出纳员：<input type="text" aplDataName="oprBill"> -->
		 			    出纳员：<input type="text" aplDataName="oprBill" id="oprBill" style="width: 100px">
                			  <input type="hidden" id="user" aplDataName="user"  corre="oprBill" >
                			  <button type="button" onclick="sbo.go2('user','#user','id','#oprBill','c2')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
					</td>
				</tr>
				<tr>
					<td>
						方向：<select aplDataName="way">
								  <option value=""></option>
								  <option value="1">收入</option>   
								  <option value="2">支出</option>
								  <option value="3">收支</option>
		 			    	  </select> 
		 			   	&nbsp;&nbsp;&nbsp;
						结账：<select aplDataName="cashJz">
								  <option value=""></option>
								  <option value="1">已结</option>   
								  <option value="0">未结</option>
		 			    	  </select> 					
						&nbsp;&nbsp;&nbsp;
						销账：<select aplDataName="cashJz">
								  <option value=""></option>
								  <option value="1">已结</option>   
								  <option value="0">未结</option>
		 			    	  </select> 					
						&nbsp;&nbsp;&nbsp;
						关键字 <input type="text" aplDataName="key"  style="text-indent: 5px;" />&nbsp;&nbsp;
					    <button onClick="ad.doList(1)">搜索</button>
					</td>
				</tr>
	    	</table>
	    </div>
		<table cellspacing="0" cellpadding="0" width="100%" style="margin-top: 20px;">
			<thead>
				<tr>					
					<td>日期</td>
					<td>出纳编号</td>
					<td>账户</td>
					<td>科目</td>
					<td colspan="2">收入</td>
					<td colspan="2">支出</td>					
					<td>备注</td>
					<td>出纳员</td>
				</tr>
			</thead>
			<tbody>
			<tr v-for="(row,index) in rows">					
				<td>{{row.bookTime}}</td>
				<td>
					<a href="javascript:;" @click="modifyData(row.cashId)" style="color: red;font-weight: bold;">        
                        {{row.cashNo}}
                    </a>
				</td>
				<td>{{row.accountName}}</td>
				<td>{{row.summary}}</td>
				<td>{{row.inCharge}}</td>
				<td>{{row.inCurrency}}</td>
				<td>{{row.outCharge}}</td>
				<td>{{row.outCurrency}}</td>
				<td>{{row.clientName}} {{row.coagentName}}  {{row.remark}}</td>
				<td>{{row.oprBill}}</td>			
			</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="18">
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
	<script src="cash.js"></script>	
	<script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
</body>
</html>