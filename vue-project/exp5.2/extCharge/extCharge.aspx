<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>附加费</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
				    关键字 <input type="text" aplDataName="key"  style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
				    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
				    <input type="button" onClick="dlgAdd()" value="添加" style="padding: 5px;">
				     &nbsp;&nbsp;&nbsp;&nbsp;
	 			    <input type="button" onClick="delRow()" value="删除" style="padding: 5px;"><br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td>ID</td>
							<td><input type="checkbox" onclick="APLDevel.checkAll('.content', this)" ></td>
							<td>费用编码</td>
							<td>费用名称</td>
							<td>费用</td>
							<td>币制</td>
							<td>单位</td>
							<td>描述</td>
							<td>计算公式</td>
							<td><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td>删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td>{{ad.rsIndex++}}</td>
						<td width=""><input type="checkbox" :value="row.id"></td>
						<td width="10%">{{row.chargeCode}}</td>
						<td width="10%">{{row.chargeName}}</td>
						<td width="10%">{{row.charge}}</td>
						<td width="10%">{{row.curr}}</td>
						<td width="10%">{{row.unit}}</td>
						<td width="20%">{{row.chargeDesc}}</td>
						<td width="15%">{{row.calcForm}}</td>
						<td width="10%">
							<a href="javascript:;" @click="editData(index)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
							</a>
						</td>
						<td width="10%">
							<a href="javascript:;" @click="delData(row.id)">					
								删除
							</a>
						</td>
					</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="11">
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
										<option value="20">20</option>
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
							    <span>费用编码：</span>
							    <input type="text" :value="infoData.chargeCode" aplDataName="chargeCode" placeholder="输入限制0-20位" Verification="0-20">
						    </p>
						    <p>
							    <span>费用名称：</span>
							    <input type="text" :value="infoData.chargeName" aplDataName="chargeName" placeholder="输入限制2-20位" Verification="2-20">
						    </p>
						    <p>
							    <span>费用：</span>
							    <input type="number" :value="infoData.charge" aplDataName="charge" placeholder="输入限制小于99999" Verification="0-99999" onkeyup="APLDevel.clearNoNum(this,3)">
						    </p>
						    <p>
							    <span>币制：</span>
							    <input type="text" :value="infoData.curr" aplDataName="curr" placeholder="输入限制3-5位" Verification="3-5">
						    </p>
						    <p>
							    <span>单位：</span>
							    <input type="text" :value="infoData.unit" aplDataName="unit" placeholder="输入限制1-10位" Verification="1-10">
						    </p>
						    <p>
							    <span>描述：</span>
							    <input type="text" :value="infoData.chargeDesc" aplDataName="chargeDesc" placeholder="输入限制0-50位" Verification="0-50">
						    </p>
						    <p>
							    <span>计算公式：</span>
							    <input type="text" :value="infoData.calcForm" aplDataName="calcForm" placeholder="输入限制2-10位" Verification="2-10">
						    </p>
					    </form>
				    <!-- </div> -->
				</div>
				

			</div>
		</div>
		<div style="display: none;">
			<table id="tabUser">
				<tr>					
				 	<td>userId</td>
				 	<td>userName</td>
				</tr>
				<tr>
				 	<td><input type="text" aplDataName="userId" /></td>
				 	<td><input type="text" aplDataName="userName" /></td>
				</tr>
				<tr>
				 	<td><input type="text" aplDataName="userId" /></td>
				 	<td><input type="text" aplDataName="userName" /></td>
				</tr>
				<tr>
				 	<td><input type="text" aplDataName="userId" /></td>
				 	<td><input type="text" aplDataName="userName" /></td>
				</tr>			
			</table>
			<input type="button" value="test" onClick="doTest()">
		</div>

	</section>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	<script src="extCharge.js"></script>	
</body>
</html>