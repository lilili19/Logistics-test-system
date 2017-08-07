<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>API账号</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css/common.css">
	<link rel="stylesheet" href="../css/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
</head>
<body>
    <div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>							
							<td>平台</td>
							<td>appId</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
					    <td>{{row.apiName}}</td>
						<td>{{row.apiId}}</td>						
						<td>
							<a href="javascript:;" @click="updateOrder(index)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 抓取订单
							</a>
						</td>
						<td>
							<a href="javascript:;" @click="addOrder(index)">				
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 上传运单号
							</a>
						</td>
					</tr>
					</tbody>
					<tfoot>
						
					</tfoot>
				</table>
				
				<div style="display: none;" id="boxInfo">
					<!-- <div id="layuiContent"> -->
						<form>
							<p>
								<span>平台：</span>
								<input type="text" aplDataName="paramName" :value="infoData.apiName" disabled>
							</p>
							<p>
								<span>appId：</span>
								<input type="text" aplDataName="paramDesc" :value="infoData.apiId" disabled>
							</p>
							<p style="height:auto;overflow: hidden;">
								<span style="display: block;float: left;margin-right: 5px;">添加订单：</span>
								<textarea aplDataName="sVal" placeholder="请输入需要添加的订单" Verification="1-100000" onblur="APLDevel.Vertion('',$(this),$(this).prev())" style="width: 360px;line-height: 25px;"></textarea> 
							</p>
						</form>
					<!-- </div> -->
				</div>
	
			</div>
		</div>
		
	</section>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../js/updateOrders.js"></script>
</body>
</html>