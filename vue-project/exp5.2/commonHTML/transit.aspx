<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>渠道类型</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">transit</div>
	
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
			    	<select aplDataName="type" onchange="ad.doList(1)" style="height: 30px;">
						<option value="1">有效</option>
						<option value="3">无效</option>
			    	</select>
				    关键字 <input type="text" aplDataName="key"  style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
				    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
				    <input type="button" onClick="dlgAdd()" value="添加" style="padding: 5px;display: none;" level="m">
				     &nbsp;&nbsp;&nbsp;
	 			    <input type="button" onClick="delRow()" value="删除" style="padding: 5px;display: none;" level="m"><br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td>渠道类型</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 详细</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">						
						<td>{{row.transit}}</td>
						<td level="m" style="display: none;">
							<a href="javascript:;" @click="editData(index)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 详细
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
							    <input type="text" :value="infoData.transit" aplDataName="transit" placeholder="输入1-20位之内" Verification="1-20">
						    </p>
						    <p>
							    <span>业务类型：</span>
							    <select v-model="infoData.ywType" aplDataName="ywType" Verification="1-5">
									<option value="1">国际快递</option>
									<option value="2">国际空运</option>
									<option value="3">国际海运</option>
									<option value="4">国际小包</option>
									<option value="5">国内物流 </option>
									<option value="6">国际进口</option>									
							    </select>
						    </p>
						    <p>
							    <span>查件官网：</span>
							    <select v-model="infoData.track" aplDataName="track" Verification="1-5">
									<option :value="item.name" v-for="item in tabTrack">{{item.name}}</option>		
							    </select>		
						    </p>	
						    <p>
							    <span>计泡方式：</span>
							    <select v-model="infoData.defEval" aplDataName="defEval" Verification="1-5">
									<option :value="item.name" v-for="item in tabWtEval">{{item.name}}</option>		
							    </select>
						    </p>
						    <p>
							    <span>体积系数：</span>
							    <select v-model="infoData.vwtfm==undefined?5000:infoData.vwtfm" aplDataName="vwtfm" Verification="1-5">
									<option value="5000">5000</option>		
									<option value="5500">5500</option>		
									<option value="6000">6000</option>		
									<option value="6500">6500</option>		
									<option value="7000">7000</option>		
									<option value="7500">7500</option>		
									<option value="8000">8000</option>		
									<option value="8500">8500</option>		
									<option value="9000">9000</option>	
									<option value="9500">9500</option>		
							    </select>
						    </p>
						    <p>
							    <span>计重方式：</span>
							    <select v-model="infoData.packCwt" aplDataName="packCwt" Verification="1-5">
									<option value="1">多件一起</option>
									<option value="2">单件计重</option>
							    </select>
						    </p>
						    <p>
							    <span>重量进位：</span>
							    <select v-model="infoData.wtCeiling" aplDataName="wtCeiling" Verification="1-5">
									<option value="1">多件一起</option>
									<option value="2">单件计重</option>
							    </select>
						    </p>
						    <p>
							    <span>燃油费：</span>
							    <input type="text" :value="infoData.remoteExp" aplDataName="remoteExp" placeholder="输入20位之内" Verification="0-20">
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