<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>科目管理</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">summary</div>
	
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
				    关键字 <input type="text" aplDataName="key"  style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
				    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
				    <input type="button" onClick="dlgAdd()" value="添加" style="padding: 5px;display: none;" level="m">
				     &nbsp;&nbsp;&nbsp;
	 			    <input type="button" onClick="delRow()" value="删除" style="padding: 5px;display: none;" level="m"><br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td><input type="checkbox" onclick="APLDevel.checkAll('.content', this)" ></td>	
							<td>科目编码</td>
							<td>助记码</td>
							<td>科目名称</td>
							<td>关联账户</td>							
							<td>方向</td>
							<td>是否销账</td>
							<td>客户对账</td>							
							<td>是否统计</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>		
						<td>{{row.numCode}}</td>
						<td>{{row.coding}}</td>
						<td>{{row.myName}}</td>
						<td>{{row.account}}</td>						
						<td>{{row.way==1?'收入':row.way==2?'支付':row.way==3?'收支':'其他'}}</td>
						<td>{{row.reckoning==1?'销账':row.reckoning==0?'不销账':''}}</td>
						<td>{{row.wl==1?'结账':row.wl==0?'不结账':''}}</td>						
						<td>{{row.stat==1?'统计':row.stat==0?'不统计':''}}</td>
						<td level="m" style="display: none;">
							<a href="javascript:;" @click="editData(index)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
							</a>
						</td>
						<td level="m" style="display: none;">
							<a href="javascript:;" @click="delData(row.id)">					
								删除
							</a>
						</td>
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
				<div style="display: none;" id="boxInfo">
				    <!-- <div id="layuiContent"> -->
					    <form>						   
						    <p>
							    <span>科目编码：</span>
							    <input type="text" :value="infoData.numCode" aplDataName="numCode" placeholder="输入10位之内" Verification="0-10">
						    </p>
						    <p>
							    <span>助记码：</span>
							    <input type="text" :value="infoData.coding" aplDataName="coding" placeholder="输入10位之内" Verification="0-10">
						    </p>
						    <p>
							    <span>科目名称：</span>
							    <input type="text" :value="infoData.myName" aplDataName="myName" placeholder="输入30位之内" Verification="0-30">
						    </p>	
						    <p>
							    <span>关联账户：</span>
							    <input type="text" :value="infoData.account" aplDataName="account" placeholder="输入限制30位之内" Verification="0-30">
						    </p>
						    <p>
							    <span>方向：</span>
							    <select :value="infoData.way==undefined?1:infoData.way" aplDataName="way" Verification="1-5">
									<option value="1">收入</option>
									<option value="2">支付</option>
									<option value="3">收支</option>
									<option value="4">其他</option>
							    </select>
						    </p>
						    <p>
							    <span>是否销账：</span>
							    <select :value="infoData.reckoning==undefined?1:infoData.reckoning" aplDataName="reckoning" Verification="1-5">
									<option value="0">不销账</option>
									<option value="1">销账</option>
							    </select>
						    </p>
						    <p>
							    <span>客户对账：</span>
							     <select :value="infoData.wl==undefined?1:infoData.wl" aplDataName="wl" Verification="1-5">
									<option value="0">不结账</option>
									<option value="1">结账</option>
							    </select>
						    </p>						   
						     <p>
							    <span>是否统计：</span>
							    <select :value="infoData.stat==undefined?1:infoData.stat" aplDataName="stat" Verification="1-5">
									<option value="0">不统计</option>
									<option value="1" selected>统计</option>
							    </select>
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
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	<script src="../js/common.js"></script>	
</body>
</html>