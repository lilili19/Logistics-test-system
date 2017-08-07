<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>API参数</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
</head>
<body>	
	<button type="button" onclick="parent.l_popup.close(0);if(isSaveInfo==1) parent.ad.doList(1)" class="layui-btn layui-btn-small layui-btn-normal" style="margin:10px 0 10px 20px;">关闭</button>


    <div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
    <section id="main" style="width: 1200px;margin: 0 auto;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <h2 style="font-size: 20px;margin: 15px 0px;color: red;font-weight: bold;"></h2><br>
			    <input type="button" onClick="dlgAdd()" value="添加" style="padding: 5px;margin-bottom: 10px;">
			     &nbsp;&nbsp;&nbsp;&nbsp;
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>						   
							<td>参数名称</td>
							<td>参数说明</td>
							<td>参数文本值</td>
							<td><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td>删除</td>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(row,index) in rows">
							<td width="10%">{{row.paramName}}</td>
							<td width="10%">{{row.paramDesc}}</td>
							<td style="word-wrap:break-word;word-break:break-all;" width="width:80%;">
								{{row.sVal}}				
							</td>
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
				</table>
				<div style="display: none;" id="boxInfo">
						<input type="hidden" aplDataName="apiId">
						<input type="hidden" aplDataName="apiName">
						<form>
						    <!--<p>
								<span>创建日期：</span>
								<input type="text" id="dataTime" placeholder="请选择" Verification="16" aplDataName="dataTime">
							</p>-->
							<p>
								<span>参数名称：</span>
								<input type="text" aplDataName="paramName" :value="infoData.paramName" placeholder="输入限制50位之内" Verification="0-50">
							</p>
							<p>
								<span>参数说明：</span>
								<input type="text" aplDataName="paramDesc" :value="infoData.paramDesc" placeholder="输入限制50位之内" Verification="0-50">
							</p>
							<p style="height:auto;overflow: hidden;">
								<span style="display: block;float: left;margin-right: 5px;">参数文本值：</span>
								<textarea aplDataName="sVal" placeholder="输入限制3000位之内" Verification="0-3000">{{infoData.sVal}}</textarea> 
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
	<script src="apiConfig.js"></script>
</body>
</html>