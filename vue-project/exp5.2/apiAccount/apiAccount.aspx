<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>API账号</title>
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
			    <!-- 关键字 <input type="text" paramName="key"  style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
			     <input type="button" onClick="ad.doList(0)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp; -->
			    <input type="button" onClick="dlgAdd()" value="添加" style="padding: 5px;margin-bottom: 10px;">
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td>参数</td>
							<td>apiId</td>
							<td>API名称</td>
							<td>API说明</td>
							<td>默认</td>
							<td>使用状态</td>
							<td><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td>删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td width="10%">
						<button :apiId="row.apiId" :apiName="row.apiName" onclick="openParam(this)">详情</button>
						</td>
						<td width="10%">{{row.apiId}}</td>
						<td width="10%">{{row.apiName}}</td>
						<td width="10%">{{row.apiDesc}}</td>
						<td width="20%">{{row.isDef==1?'默认':'不默认'}}</td>
						<td width="20%">{{row.useState==1?'使用':'停用'}}</td>
						<td width="10%">
							<a href="javascript:;" @click="editData(index)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
							</a>
						</td>
						<td width="10%">
							<a href="javascript:;" @click="delData(row.id)" >					
								删除
							</a>
						</td>
					</tr>
					</tbody>
					<tfoot>
						
					</tfoot>
				</table>
				<div style="display: none;" id="boxInfo"> 
						<form>
							<p>
								<span>apiId：</span>
								<input type="text" :value="infoData.apiId" aplDataName="apiId" placeholder="输入限制20位之内" Verification="0-20">
							</p>
							<p>
								<span>API名称：</span>
								<input type="text" :value="infoData.apiName" aplDataName="apiName" placeholder="输入限制20位之内" Verification="0-20">
							</p>
							<p>
								<span>API说明：</span>
								<input type="text" :value="infoData.apiDesc" aplDataName="apiDesc" placeholder="输入限制50位之内" Verification="0-50">
							</p>
							<p>
								<span>是否默认：</span>
						        <select aplDataName="isDef">
							        <option value="1">是</option>
							        <option value="0">否</option>
						        </select>
					        </p>
					        <p>
						        <span>使用状态：</span>
						        <select aplDataName="useState" >
							        <option value="1">是</option>
							        <option value="0">否</option>							        
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
	<script src="apiAccount.js"></script>
</body>
</html>