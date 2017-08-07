<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>联系当地</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">localPhone</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 90%;">
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
							<td>渠道类型</td>
							<td>国家</td>
							<td>城市</td>
							<td>电话</td>
							<td>传真</td>
							<td>联系人</td>
							<td>网站</td>
							<td>备注</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>						
						<td>{{row.transit}}</td>
						<td>{{row.countryCn}}</td>
						<td>{{row.city}}</td>
						<td>{{row.phone}}</td>
						<td>{{row.fax}}</td>
						<td>{{row.linkman}}</td>
						<td>{{row.webSite}}</td>
						<td>{{row.remark}}</td>
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
							    <span>渠道类型：</span>
							    <input type="text" :value="infoData.transit" aplDataName="transit" placeholder="输入1-10位" Verification="1-10">
						    </p>
						    <p>
							    <span>国家：</span>
							    <input type="text" :value="infoData.countryCn" aplDataName="countryCn" placeholder="输入0-50位" Verification="0-50">
						    </p>
						     <p>
							    <span>城市：</span>
							    <input type="text" :value="infoData.city" aplDataName="city" placeholder="输入0-50位" Verification="0-50">
						    </p>	
						     <p>
							    <span>电话：</span>
							    <input type="text" :value="infoData.phone" aplDataName="phone" placeholder="输入0-100位" Verification="0-100">
						    </p>	
						     <p>
							    <span>传真：</span>
							    <input type="text" :value="infoData.fax" aplDataName="fax" placeholder="输入0-30位" Verification="0-30">
						    </p>	
						     <p>
							    <span>联系人：</span>
							    <input type="text" :value="infoData.linkman" aplDataName="linkman" placeholder="输入0-30位" Verification="0-30">
						    </p>	
						    <p>
							    <span>网站：</span>
							    <input type="text" :value="infoData.webSite" aplDataName="webSite" placeholder="输入0-50位" Verification="0-50">
						    </p>	
						    <p>
							    <span>备注：</span>
							    <input type="text" :value="infoData.remark" aplDataName="remark" placeholder="输入0-200位" Verification="0-200">
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