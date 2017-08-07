<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>银行账号</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">bankAccout</div>
	
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
							<td>次序</td>
							<td>编号</td>
							<td>简称</td>							
							<td>所属银行</td>
							<td>开户行</td>
							<td>户名</td>
							<td>卡号</td>
							<td>状态</td>
							<td>在网站显示</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>						
						<td>{{row.myIndex}}</td>
						<td>{{row.coding}}</td>
						<td>{{row.name}}</td>						
						<td>{{row.bank}}</td>
						<td>{{row.bankName2}}</td>
						<td>{{row.accountName}}</td>
						<td>{{row.cardNo}}</td>
						<td>{{row.stat==1?'有效':row.stat==0?'无效':''}}</td>
						<td>{{row.web==1?'显示':row.web==0?'不显示':''}}</td>
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
					    <form>						   
						    <p>
							    <span>次序：</span>
							    <input type="text" :value="infoData.myIndex" aplDataName="myIndex" placeholder="输入10位之内" Verification="0-10">
						    </p>
						    <p>
							    <span>编号：</span>
							    <input type="text" :value="infoData.coding" aplDataName="coding" placeholder="输入限制2-10位" Verification="2-10">
						    </p>
						    <p>
							    <span>简称：</span>
							    <input type="text" :value="infoData.name" aplDataName="name" placeholder="输入限制2-10位" Verification="2-10">
						    </p>	
						    <p>
							    <span>所属银行：</span>
							    <input type="text" :value="infoData.bank" aplDataName="bank" placeholder="输入限制20位之内" Verification="0-20">
						    </p>
						    <p>
							    <span>开户行：</span>
							    <input type="text" :value="infoData.bankName2" aplDataName="bankName2" placeholder="输入限制50位之内" Verification="0-50">
						    </p>
						    <p>
							    <span>户名：</span>
							    <input type="text" :value="infoData.accountName" aplDataName="accountName" placeholder="输入限制20位之内" Verification="0-20">
						    </p>
						    <p>
							    <span>卡号：</span>
							    <input type="text" :value="infoData.cardNo" aplDataName="cardNo" placeholder="输入限制30位之内" Verification="0-30">
						    </p>
						     <p>
							    <span>状态：</span>
							    <select :value="infoData.stat==undefined?1:infoData.stat" aplDataName="stat" Verification="1-5">
									<option value="0">无效</option>
									<option value="1" selected>有效</option>
							    </select>
						    </p>
						    <p>
							    <span>在网站显示：</span>
							    <select :value="infoData.web==undefined?1:infoData.web" aplDataName="web" Verification="1-5">
									<option value="0">不显示</option>
									<option value="1" selected>显示</option>
							    </select>
						    </p>					   
					    </form>
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