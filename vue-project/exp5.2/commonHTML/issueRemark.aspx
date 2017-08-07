<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>基本数据</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">issueRemark</div>
	
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
			    	类型：<select aplDataName="type" onChange="ad.doList(1)">
						<option value="0">-- 请选择 --</option>
						<option value="1">扣件备注</option>
						<option value="2">退件备注</option>
						<option value="3">问题件备注</option>
						<option value="4">理赔件备注</option>
						<option value="5">附加项目</option>
						<option value="6">问题件分类</option>
						<option value="7">仓库管理</option>
						<option value="8">账号属性</option>
						<option value="9">发件人管理</option>
						<option value="10">付款结算</option>
						<option value="11">收件人管理</option>
						<option value="12">起运地管理</option>
						<option value="13">运输状态</option>
						<option value="18">报关公司</option>
						<option value="19">报关方式</option>
						<option value="21">提货地址</option>
						<option value="22">常用转运地址</option>
						<option value="23">常用转运信息</option>
						<option value="26">货物性质</option>
						<option value="30">费用名称</option>
						<option value="50">区域管理</option>
			    	</select>
			    	&nbsp;&nbsp;
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
							<td>ID</td>
							<td>编码</td>
							<td>内容</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>			
						<td>{{row.id1}}</td>
						<td>{{row.coding}}</td>
						<td>{{row.content}}</td>						
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
							    <span>类型：</span>
							    <select :value="infoData.type" aplDataName="type" Verification="0-10">
									<option value="">--请选择--</option>
									<option value="1">扣件备注</option>
									<option value="2">退件备注</option>
									<option value="3">问题件备注</option>
									<option value="4">理赔件备注</option>
									<option value="5">附加项目</option>
									<option value="6">问题件分类</option>
									<option value="7">仓库管理</option>
									<option value="8">账号属性</option>
									<option value="9">发件人管理</option>
									<option value="10">付款结算</option>
									<option value="11">收件人管理</option>
									<option value="12">起运地管理</option>
									<option value="13">运输状态</option>
									<option value="18">报关公司</option>
									<option value="19">报关方式</option>
									<option value="21">提货地址</option>
									<option value="22">常用转运地址</option>
									<option value="23">常用转运信息</option>
									<option value="26">货物性质</option>
									<option value="30">费用名称</option>
									<option value="50">区域管理</option>
							    </select>
						    </p>				   
						    <p>
							    <span>ID：</span>
							    <input type="text" :value="infoData.id1" aplDataName="id1" placeholder="输入1-10位" Verification="1-10">
						    </p>
						    <p>
							    <span>编码：</span>
							    <input type="text" :value="infoData.coding" aplDataName="coding" placeholder="输入20位之内" Verification="0-20">
						    </p>
						    <p>
							    <span>内容：</span>
							    <input type="text" :value="infoData.content" aplDataName="content" placeholder="输入1-50位" Verification="1-50">
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