<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>API账号</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css/common.css">
	<link rel="stylesheet" href="../css/index.min.css">

	<link rel="stylesheet" href="../../exp5.2/css5.2/common.css">
	<link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">

	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	
	<style>
		#exp form{margin-bottom: 10px;}
		#exp form input{height: 30px;text-indent: 5px;}
		#exp form select{height: 30px;}
	</style>	
</head>
<body>
    <div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section style="width: 100%;">
		<div id="exp">
			<form action="">
				发货状态：<select name="" id="" onChange="doList()" aplDataName="shipState">
					<option value="">是否发货</option>
					<option value="1">是</option>
					<option value="0">否</option>
				</select>&nbsp;&nbsp;
				日期： <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input-text Wdate"  placeholder="请选择" aplDataName="dateStart" onblur="doList()">
			    至 <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input-text Wdate"  placeholder="请选择" aplDataName="DateEnd" onblur="doList()">&nbsp;&nbsp;&nbsp;
			    <select name="" id="" onChange="doList()" aplDataName="platform">
							<option value="">平台</option>
							<option value="ebay">ebay</option>
							<option value="Dhgate">Dhgate</option>
							<option value="Amazon">Amazon</option>
							<option value="Wish">Wish</option>
							<option value="AliExpress">AliExpress</option>
							<option value="lazada">lazada</option>
			    		</select>
			  <!-- 订单状态：<select name="" id="" onChange="doList()">
							<option value=""></option>
							<option value="">是</option>
							<option value="">否</option>
			    		</select> -->
			  <select name="" id="" onChange="doList()" aplDataName="payStatus">
							<option value="">付款状态</option>
							<option value="Complete">已付款</option>
							<option value="None">未付款</option>
			    		</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    关键字：<input type="text"><input type="button" onClick="search(this);" value="搜索" style="padding: 0px 5px;text-indent: 0px;line-height: 30px;">
			</form>
		   

			<table cellspacing="0" cellpadding="0" width="100%">
				<thead>
					<tr>
						<td><input type="checkbox" onclick="APLDevel.checkAll('#exp table', this)"></td>
						<td>日期</td>
						<td>平台</td>
						<td>订单编号</td>							
						<td>订单状态</td>
						<td>国家</td>
						<td>收件人</td>	
						<td>品名</td>
						<td>件数</td>
						<td>费用</td>							
						<td>付款状态</td>							
						<td>运单号</td>
						<td>appId</td>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox"></td>					    
						<td>{{row.createDate}}</td>
						<td>{{row.platform}}</td>						
						<td>
							<a href="javascript:;" @click="detailsOrders(index)" style="font-weight: bold;">					
								{{row.orderNo}}
							</a>
						</td>
						<td>{{row.orderStatus}}</td>
						<td>{{row.countryNo}}</td>					
						<td>{{row.contact}}</td>
						<td>{{row.productName}}</td>
						<td>{{row.qty}}</td>
						<td>{{row.amount}}</td>
						<td>{{row.payStatus}}</td>
						<td>{{row.shipNo}}</td>						
						<td>{{row.appId}}</td>						
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="13">
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
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="40">40</option>
								</select>
							</div>
							
						</td>
					</tr>
				</tfoot>
			</table>			
		</div>		
	</section>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 	
	<script src="../../js/APLDevel.js"></script>
	<script src="../js/ordersList.js"></script>
</body>
</html>