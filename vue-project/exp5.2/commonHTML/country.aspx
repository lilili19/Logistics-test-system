<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>国家</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">country</div>
	
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
							<td>国家简码</td>
							<td>英文名</td>
							<td>中文名</td>
							<td>别名</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>
						<td>{{row.countryNo}}</td>
						<td>{{row.countryEn}}</td>
						<td>{{row.countryCn}}</td>
						<td>{{row.countryCn1}}</td>
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
							<td colspan="11">
								<div id="pager">
									<ul class="pages">									
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
							    <span>国家简码：</span>
							    <input type="text" :value="infoData.countryNo" aplDataName="countryNo" placeholder="输入限制1-8位" Verification="1-8">
						    </p>
						    <p>
							    <span>英文名：</span>
							    <input type="text" :value="infoData.countryEn" aplDataName="countryEn" placeholder="输入限制1-20位" Verification="1-20">
						    </p>
						    <p>
							    <span>中文名：</span>
							    <input type="text" :value="infoData.countryCn" aplDataName="countryCn" placeholder="输入限制1-10位" Verification="1-10">
						    </p>
						    <p style="overflow: hidden;height: auto;">
							    <span style="float: left;margin-right: 5px;">别名：</span>
							    <textarea :value="infoData.countryCn1" aplDataName="countryCn1" placeholder="输入限制0-200位" Verification="0-200"></textarea>
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