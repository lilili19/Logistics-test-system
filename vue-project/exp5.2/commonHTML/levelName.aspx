<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>权限名称</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">levelName</div>
	
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
				    关键字 <input type="text" aplDataName="key"  style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
				    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
				    <input type="button" @click="modifyData(0)" value="添加" style="padding: 5px;display: none;" level="m">
	 			    <br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td><input type="checkbox" onclick="APLDevel.checkAll('.content', this)" ></td>	
							<td>一级编号</td>
							<td>一级名称</td>
							<td>次序</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 详情</td>
							<!-- <td level="m" style="display: none;">删除</td> -->
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>		
						<td>{{row.bigNo}}</td>
						<td>{{row.bigName}}</td>
						<td>{{row.keyOrder}}</td>
						<td level="m" style="display: none;">
							<a href="javascript:;" @click="modifyData(row.id)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 详情
							</a>
						</td>
						<!-- <td level="m" style="display: none;">
							<a href="javascript:;" @click="delData(row.id)">					
								删除
							</a>
						</td> -->
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
							    <span>一级编号：</span>
							    <input type="text" :value="infoData.bigNo" aplDataName="bigNo" placeholder="输入10位之内" Verification="0-10">
						    </p>
						    <p>
							    <span>一级名称：</span>
							    <input type="text" :value="infoData.bigName" aplDataName="bigName" placeholder="输入限制2-10位" Verification="2-10">
						    </p>
						    <p>
							    <span>次序：</span>
							    <input type="text" :value="infoData.keyOrder" aplDataName="keyOrder" placeholder="输入限制2-10位" Verification="2-10">
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