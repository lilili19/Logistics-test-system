<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>API账号</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css/common.css">
	<link rel="stylesheet" href="../css/index.min.css">

	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<script src="../../l_popup_tips/l_popup_tips.js"></script>

	<style>
		#exp table{}
		#exp table td{padding: 10px;width: 12.5%;}
		#exp table tr td:nth-child(2n-1){font-weight: bold;}
	</style>
</head>
<body>
	<button type="button" onclick="parent.l_popup.close(0);if(isSaveInfo==1) parent.ad.doList(1)" class="layui-btn layui-btn-small layui-btn-normal" style="margin:0px 0 0 15px;">关闭</button>

    <div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section>
		<div id="exp">
			<table cellspacing="0" cellpadding="0" width="100%" v-for="item in items">
				<tr>
					<td colspan="8" style="font-weight: bold;text-align: left;padding: 10px;">电商平台名称:{{item.platform}}</td>
				</tr>
				<tr>
					<td colspan="8" style="font-weight: bold;text-align: center;color: red;">订单信息</td>
				</tr>
				<tr>
					<td>下单日期</td>
					<td>{{item.createDate}}</td>
					<td>订单编号</td>
					<td>{{item.orderNo}}</td>
					<td>当前订单状态</td>
					<td>{{item.orderStatus}}</td>
					<td>订单配送方式</td>
					<td>{{item.shipCarrier}}</td>
				</tr>
				<tr>
					<td>订单商品的售价</td>
					<td>{{item.itemPrice}}</td>
					<td>订单总费用</td>
					<td>{{item.amount}}</td>
					<td>物品名</td>
					<td>{{item.productName}}</td>
					<td>物件数</td>
					<td>{{item.qty}}</td>
				</tr>
				<tr>
					<td>付款状态</td>
					<td>{{item.payStatus}}</td>
					<td>是否保单</td>
					<td>{{item.isPremium}}</td>
					<td>运单号</td>
					<td>{{item.shipNo}}</td>
					<td>付款时间</td>
					<td>{{item.payDate}}</td>
				</tr>
				<tr>
					<td colspan="8" style="font-weight: bold;text-align: center;color: red;">收件人信息</td>
				</tr>
				<tr>
					<td>国家简码</td>
					<td>{{item.countryNo}}</td>
					<td>国家名字</td>
					<td>{{item.countryEn}}</td>
					<td>邮编</td>
					<td>{{item.postalCode}}</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>州(省)</td>
					<td>{{item.state}}</td>
					<td>区(县)</td>
					<td>{{item.county}}</td>
					<td>区</td>
					<td>{{item.district}}</td>
					<td>城市</td>
					<td>{{item.city}}</td>
				</tr>
				<tr>
					<td>地址1</td>
					<td>{{item.address}}</td>
					<td>地址2</td>
					<td>{{item.address2}}</td>
					<td>地址3</td>
					<td>{{item.address3}}</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>收件公司</td>
					<td>{{item.companyName}}</td>
					<td>收件人1</td>
					<td>{{item.contact}}</td>
					<td>收件人2</td>
					<td>{{item.contact2}}</td>
					<td>收件人电子邮件</td>
					<td>{{item.email}}</td>
				</tr>
				<tr>
					<td>收件人电话</td>
					<td>{{item.phone}}</td>
					<td>收件人手机</td>
					<td>{{item.mobile}}</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>					
				</tr>
				<tr>
					<td colspan="8" style="font-weight: bold;text-align: center;color: red;">买家信息</td>
				</tr>
				<tr>
					<td>买家名字1</td>
					<td>{{item.buyerName}}</td>
					<td>买家名字2</td>
					<td>{{item.buyerContact2}}</td>
					<td>买家邮件</td>
					<td>{{item.buyerEmail}}</td>
					<td>买家Id</td>
					<td>{{item.buyerId}}</td>
				</tr>
				<tr>
					<td colspan="8" style="font-weight: bold;text-align: center;color: red;">发件人信息</td>
				</tr>
				<tr>
					<td>国家简码</td>
					<td>{{item.fromCountryNo}}</td>
					<td>国家名字</td>
					<td>{{item.fromCountryEn}}</td>
					<td>发件公司</td>
					<td>{{item.fromCompanyName}}</td>
					<td></td>
					<td></td>					
				</tr>
				<tr>
					<td>地址1</td>
					<td>{{item.fromAddress}}</td>
					<td>地址2</td>
					<td>{{item.fromAddress2}}</td>
					<td>地址3</td>
					<td>{{item.fromAddress3}}</td>
					<td></td>
					<td></td>					
				</tr>
				<tr>
					<td>州(省)</td>
					<td>{{item.fromState}}</td>
					<td>城市</td>
					<td>{{item.fromCity}}</td>
					<td>发件人电话</td>
					<td>{{item.fromPhone}}</td>
					<td>发件人手机</td>
					<td>{{item.fromMobile}}</td>
				</tr>
				<tr>
					<td colspan="8" style="font-weight: bold;text-align: center;color: red;">其他</td>
				</tr>
				<tr>
					<td>卖家SKU</td>
					<td>{{item.sku}}</td>
					<td>身份标识</td>
					<td>{{item.appId}}</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>			
		</div>		
	</section>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../js/vue.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../js/ordersInfo.js"></script>
</body>
</html>