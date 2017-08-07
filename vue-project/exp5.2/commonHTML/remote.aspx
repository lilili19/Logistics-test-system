<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>部门管理</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">remote</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
			    	<select aplDataName="transit" style="height: 30px;" onChange="ad.doList(1)">
						<option value="">渠道类型</option>
						<option value="DHL">DHL</option>
						<option value="UPS">UPS</option>
						<option value="FEDEX">FEDEX</option>
			    	</select>
			    	国家：<input type="text" aplDataName="countryNo" style="height: 30px;text-indent: 5px;">&nbsp;&nbsp;
			    	城市：<input type="text" aplDataName="city" style="height: 30px;text-indent: 5px;">&nbsp;&nbsp;
			    	邮编：<input type="text" aplDataName="postCode" style="height: 30px;text-indent: 5px;">&nbsp;&nbsp;
				    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;  
				    <span style="color: red;display: none;font-weight: bold;font-size: 16px;" id="isRemote">这是偏远地区</span>
				    <br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td>渠道类型</td>
							<td>国家</td>
							<td>城市</td>
							<td>邮编1</td>
							<td>邮编2</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">						
						<td>{{row.transit}}</td>
						<td>{{row.countryNo}}</td>
						<td>{{row.city}}</td>
						<td>{{row.postCode1}}</td>
						<td>{{row.postCode2}}</td>
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