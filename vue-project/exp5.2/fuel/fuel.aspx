<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<META HTTP-EQUIV="Content-Type" Content="text/html; charset=utf-8">
	<title>燃油费</title>
	<link rel="stylesheet" href="../../layui/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
</head>
<body> 
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
			    <div class="listParamBox">
				    <input type="button" value="添加" style="padding: 5px;display: none;" onClick="dlgAdd()"  level="m">
				     &nbsp;&nbsp;&nbsp;&nbsp;
	 			    <br><br>
			    </div>
				<table cellspacing="0" cellpadding="0" width="100%">
					<thead>
						<tr>
							<td>ID</td>
							<td><input type="checkbox" onclick="APLDevel.checkAll('.content', this)" ></td>
							<td>渠道类型</td>
							<td>起始时间</td>
							<td>截止时间</td>
							<td>燃油费</td>
							<td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 修改</td>
							<td level="m" style="display: none;">删除</td>
						</tr>
					</thead>
					<tbody>
					<tr v-for="(row,index) in rows">
						<td>{{ad.rsIndex++}}</td>
						<td width="10%"><input type="checkbox" :value="row.id"></td>
						<td width="10%">{{row.transit}}</td>
						<td width="20%">{{row.dateStart}}</td>
						<td width="20%">{{row.dateEnd}}</td>
						<td width="20%">{{row.fuel}}</td>
						<td width="10%"  level="m" style="display: none;" >
							<a href="javascript:;" @click="dlgEdit(index)">					
								<i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
							</a>
						</td>
						<td width="10%"  level="m" style="display: none;">
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
										<option value="30">30</option>
										<option value="40">40</option>
										<option value="50">50</option>
									</select>
								</div>
								
							</td>
						</tr>
					</tfoot>
				</table>

				<div style="display: none;" id="boxInfo">
				    <div id="layuiContent">
					    <form>
						    <p>
							   <span>渠道类型：</span>
							   <select style="width: 200px;" aplDataName="transit" Verification="2-20" onblur="APLDevel.Vertion('#boxInfo',$(this),$(this).prev())" :value="infoData.transit">
							        <option></option>
									<option :value="item.transit" v-for="item in tabTransit">{{item.transit}}</option>
							   </select>
						    </p>
						    <p>
							    <span>起始时间：</span>
							    <!-- <input class="laydate-icon" id="start" placeholder="请选择" Verification="16" aplDataName="dateStart" :value="infoData.dateStart">	 -->
							    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input-text Wdate"  placeholder="请选择" Verification="16" aplDataName="dateStart" :value="infoData.dateStart">       
						    </p>
						    <p>
							    <span>截止时间：</span>
							    <!-- <input class="laydate-icon" id="end" placeholder="请选择" Verification="16" aplDataName="dateEnd" :value="infoData.dateEnd"> -->
							    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="input-text Wdate" placeholder="请选择" Verification="16" aplDataName="dateEnd" :value="infoData.dateEnd">
						    </p>
						    <p>
							    <span>燃油费：</span>
							    <input type="text" :value="infoData.fuel" aplDataName="fuel" placeholder="输入限制3-10位" Verification="3-10" onblur="APLDevel.Vertion('#boxInfo',$(this),$(this).prev())">
						    </p>						    
					    </form>
				    </div>
				</div>

			</div>
		</div>
	</section>
	<div id="searchBoxInfo">
		<div id="layuiContent">
			<div class="listParamBox" style="margin-bottom: 10px;position: relative;">
			    关键字 <input type="text" style="height: 28px;border-radius: 4px;outline: 0;border: 1px solid #ddd;" oninput="searchC($(this).val(),'yes')" onClick="stopBubble(event)" onfocus="searchC($(this).val(),'yes');">&nbsp;&nbsp;
 			    <button onclick="searchCountryList(2,$(this).prev().val())">查找</button>
 			    <ul class="searchCountryLocation" style="display: none;" onClick="stopBubble(event)">
 			    	<div style="padding: 5px 0px;text-indent: 20px;background-color: white;border: 1px solid #ccc;width: 100%;">若缩小范围，请输入更多条件</div>
					<li v-for="item in items"><a href="###" onClick="showData($(this))">{{item.c1}}{{item.c3}}</a></li>
 			    </ul>
 			    <!-- 小加载层 -->
				<div class="preloader" style="display: none;">
			      	<img src="../../images/load.gif" alt="">
			  	</div>
		    </div>
			<div class="searchCountry">
				<p class="p_" onclick="searchCountryList(1)">热门</p>
				<p onclick="searchCountryList(2)">国家</p>
			</div>
			<div class="searchCountryList">
				<table width="329" cellspacing="0" cellpadding="0" border="1">
					<tr>
						<td><a href="###" onClick="showData($(this))">123</a></td>
						<td><a href="###" onClick="showData($(this))">456</a></td>
					</tr>
					<tr>
						<td><a href="###" onClick="showData($(this))">789</a></td>
						<td><a href="###" onClick="showData($(this))">012</a></td>
					</tr>
					<tr>
						<td><a href="###" onClick="showData($(this))">189</a></td>
						<td><a href="###" onClick="showData($(this))">1232655</a></td>
					</tr>
				</table>
				<ul style="display: none;margin-bottom: 5px">
					<li v-for="item in items"><a href="###" onClick="showData($(this))">{{item.c1}}{{item.c3}}</a></li>
				</ul>
			</div>
			<div>
				<ul class="pagesSearchBox" style="display: none;" id="pagesSearchBox">

				</ul>
			</div>
		</div>
	</div>
	<input type="text" id="txtCountryNo"><input type="button" value="选择" onClick="dateDlgAdd()">

	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../layui/layui.min.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script> 	
	<script type="text/javascript" src="fuel.js"></script> 
</body>
</html>



	


