<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>验证计算机</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
	<style>
		.ktzt_{background-color: white;padding: 5px;border: 1px solid #ccc;cursor: pointer;border-radius: 3px;}
		.ktzt{background-color: red;color: white;border: 1px solid red;}
	</style>
</head>
<body> 
	<div id="pagingSorting" style="display: none;">hostLis</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
				    关键字 <input type="text" aplDataName="key"  style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
				    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;

				    <input type="button" onClick="delRow()" value="删除" style="padding: 5px;display: none;" level="m">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    
				    <button class="ktzt_ ktzt" onclick="ktzt(this,1)">已开通的</button>
				    &nbsp;&nbsp;&nbsp;&nbsp;
				    <button class="ktzt_" onclick="ktzt(this,0)">未开通的</button>

				    <input type="hidden" aplDataName="ktzt" value="1">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <button id="kaitong" style="padding: 5px;">取消开通所选</button>

				    <br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td><input type="checkbox" onclick="APLDevel.checkAll('.content', this)" ></td>
							<td>用户</td>
							<td>计算机类型</td>
							<td>计算机名</td>
							<td>硬盘Id</td>
							<td>主板Id</td>
							<td>登记日期</td>
							<td>开通状态</td>
							<td>开通人</td>
							<td>开通日期</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>						
						<td>{{row.userId}}</td>
						<td>{{row.pcType}}</td>
						<td>{{row.pcName}}</td>
						<td>{{row.hdId}}</td>
						<td>{{row.biosId}}</td>
						<td>{{row.sqDate}}</td>
						<td>{{row.ktzt}}</td>
						<td>{{row.ktrName}}</td>
						<td>{{row.ktDate}}</td>
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