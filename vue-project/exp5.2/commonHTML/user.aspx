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
	<style>
		#boxInfo form{overflow: hidden;}
		#boxInfo form>p{float: left;width: 325px;}
	</style>
</head>
<body> 
	<div id="pagingSorting" style="display: none;">user</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 95%;">
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
							<td>用户</td>
							<td>姓名</td>
							<td>职位</td>
							<td>权限组</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 详细</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td><input type="checkbox" :value="row.id"></td>						
						<td>{{row.userId}}</td>
						<td>{{row.userName}}</td>
						<td>{{row.job}}</td>
						<td>{{row.groupName}}</td>
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
							<td colspan="20">
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
							    <span>用户：</span>
							    <input type="text" :value="infoData.userId" aplDataName="userId" placeholder="输入1-15位" Verification="1-15">
						    </p>
						    <p>
							    <span>密码：</span>
							    <input type="text" :value="infoData.pwd5" aplDataName="pwd5" placeholder="输入20位之内" Verification="0-20">
						    </p>
						    <p>
							    <span>姓名：</span>
							    <input type="text" :value="infoData.userName" aplDataName="userName" placeholder="输入1-15位" Verification="1-15">
						    </p>
						    <p>
							    <span>职位：</span>
							    <input type="text" :value="infoData.job" aplDataName="job" placeholder="输入15位之内" Verification="0-15">
						    </p>
						    <p>
							    <span>性别：</span>
							    <select v-model="infoData.sex" aplDataName="sex" Verification="1-10">
									<option value="1">男</option>
									<option value="0">女</option>
							    </select>
						    </p>		
						    <p>
							    <span>分公司：</span>				
							    <select v-model="infoData.filialeId" aplDataName="filialeId" Verification="1-10">
									<option :value="item.id" v-for="item in tabFiliale">{{item.name}}</option>
							    </select>
						    </p>
						    <p>
							    <span>权限组：</span>
							    <select v-model="infoData.groupName" aplDataName="groupName" Verification="1-10">
									<option :value="item.id" v-for="item in tabUserGroup">{{item.name}}</option>
							    </select>
						    </p>		
						    <p>
							    <span>部门：</span>
							    <select v-model="infoData.depId" aplDataName="depId" Verification="1-10">
									<option :value="item.id" v-for="item in tabDep">{{item.name}}</option>
							    </select>
						    </p>
						    <p>
							    <span>电话：</span>
							    <input type="text" :value="infoData.phone" aplDataName="phone" placeholder="输入100位之内" Verification="0-100">
						    </p>
						    <p>
							    <span>手机：</span>
			    				<input type="text" :value="infoData.mobile" aplDataName="mobile" placeholder="输入30位之内" Verification="0-30">
						    </p>
						    <p>
							    <span>qq：</span>
							    <input type="text" :value="infoData.qq" aplDataName="qq" placeholder="输入30位之内" Verification="0-30">
						    </p>
						    <p>
							    <span>邮箱：</span>
							    <input type="text" :value="infoData.email" aplDataName="email" placeholder="输入30位之内" Verification="0-30">
						    </p>
						    <p>
							    <span>状态：</span>
							    <select v-model="infoData.state" aplDataName="state" Verification="1-10">
									<option value="1">在职</option>
									<option value="0">离职</option>
							    </select>
						    </p>
						     <p>
							    <span>入职日期：</span>
							    <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" :value="infoData.joinCompanyTime" aplDataName="joinCompanyTime" placeholder="" verification="0-50" class="input-text Wdate">
						    </p>	
						     <p>
							    <span>身份证号：</span>
							    <input type="text" :value="infoData.idCard" aplDataName="idCard" placeholder="输入30位之内" Verification="0-30">
						    </p>	
						     <p>
							    <span>备注：</span>
							    <input type="text" :value="infoData.remark" aplDataName="remark" placeholder="输入300位之内" Verification="0-300">
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
	<script src="../../plugins/WdatePicker/WdatePicker.js"></script>
	<script src="../js/common.js"></script>	
</body>
</html>