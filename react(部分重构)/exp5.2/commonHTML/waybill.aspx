<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>运件清单</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../../css/apl-1.0.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<script src="../../react/react.min.js"></script>
    <script src="../../react/react-dom.min.js"></script>
    <script src="../../react/browser.min.js"></script>
	<style>
		.listParamBox table input{height: 30px;margin-right: 5px;}
		.listParamBox table select{height: 30px;margin-right: 5px;}
		.listParamBox table button{padding: 5px;margin-right: 20px;}
		#exp .listParamBox table td{padding: 10px;}
		.apl-tool{margin-bottom: 10px;}
	</style>	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">waybill</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<div id="exp">

	</div>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../plugins/WdatePicker/WdatePicker.js"></script>
	<script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	<script src="../js/common.js"></script>	
	<script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
    <script type="text/babel">
        var UserItem = React.createClass({
            modify: function () {
                APLDevel.dlgFull(dbTab+'Details.aspx?id='+this.props.data.id);
            },
            render: function () {
                var index = this.props.index;
                var user = this.props.data;
                return (
                    <tr>
	                    <td>{user.checkinTime}</td>			
						<td>{user.inNOAll}</td>
						<td>{user.clientName}</td>
						<td>
							<a href="javascript:;" style={{'color': 'red','font-weight': 'bold'}} onClick={this.modify}>
							   {user.inCorpNo}
		                    </a>
						</td>
						<td>
							<a href="javascript:;" style={{'color': 'red','font-weight': 'bold'}} onClick={this.modify}>
							   {user.inNo}
		                    </a>
		                </td>
						<td>
							<a href="javascript:;" style={{'color': 'red','font-weight': 'bold'}} onClick={this.modify}>
							   {user.webNo}
		                    </a>					
						</td>
						<td>{user.countryCn}</td>					
						<td>{user.piece}</td>
						<td>{user.inPackDoc}</td>
						<td>{user.goods}</td>
						<td>{user.inCWT}</td>
						<td>{user.outCWT}</td>
						<td>{user.inTransit} {user.priceName}</td>
						<td>{user.inChargeAll}</td>
						<td>{user.outChargeAll}</td>
						<td>{user.gain}</td>
						<td>{user.coagentNo}</td>
						<td>{user.remark}</td>						
						<td>{user.state}</td>
						<td>{user.trackLast}</td>
						<td>{user.ywyName}</td>
						<td>{user.companycode}</td>
						<td>{user.type}</td>  
                    </tr>
                )
            }
        });
        var Tbody = React.createClass({
            render: function() {
                return (
                    <tbody>
                        {this.props.data.map(function (user, index) {
                            return <UserItem data={user} index={index} />
                        })}
                    </tbody>
                )
            }
        });
        
        var Table = React.createClass({
            getInitialState: function () {
                return {
                    data: [
                        
                    ]
                }
            },          
            componentDidMount: function() {
                setThis = this;
                APLDevel.level();
                bindEvent(this);
            },
            searhClick: function() {
                doList(1);
            },
            handleClick: function () {
                APLDevel.dlgFull(dbTab+'Details.aspx?id=0');
            },
            sboUser:function(){
                sbo.go2('user','#user','id','#oprBill','c2');
            },
            render: function(){
                return (
                    <div>
                        <div className="listParamBox">
					    	<table cellspacing="0" cellpadding="0" style={{'width': '1120px'}}>
								<tr>
									<td>
										日期：<input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" data-name="dateStart" className="input-text Wdate" style={{'width': '150px'}} /> 至
						 			    <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" data-name="dateEnd" className="input-text Wdate" style={{'width': '150px','margin-left':'5px'}} />
										客户：<input type="text" data-name="clientName" id="clientName" style={{'width': '100px'}} />
				                			  <input type="hidden" id="clientId" data-name="clientId"  corre="clientName" />
				                			  <button type="button" onclick="sbo.go2('client','#clientId','id','#clientName','c2')" title="搜索" level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
				                		服务商：<input type="text" data-name="coagentName" id="coagentName"  style={{'width': '100px'}} />
				                			    <input type="hidden" id="coagentId" data-name="coagentId"  corre="coagentName" />
				                			    <button type="button" onclick="sbo.go2('coagent','#coagentId','id','#coagentName','c2')" title="搜索" level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
				                		业务员：<input type="text" data-name="ywyName" id="ywyName" style={{'width': '100px'}} />
				                			    <input type="hidden" id="ywy" data-name="ywy" data-corre="ywyName" />
				                			    <button type="button" onclick="sbo.go2('user','#ywy','id','#ywyName','c2')" title="搜索" level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
				                		<button onClick={this.handleClick}>添加</button>
									</td>
								</tr>
								<tr>
									<td>
				                		<select data-name="type" onChange={this.searhClick}>
											<option value="">业务类型</option>
											<option value="1">快递</option>   
											<option value="2">空运</option>
											<option value="3">海运</option>
											<option value="4">小包</option>
											<option value="5">其他</option>
						 			    </select>       
				                		<select data-name="state" onChange={this.searhClick}>
											<option value="">状态</option>
											<option value="1">未出货</option>   
											<option value="2">超12小时未出货</option>
											<option value="3">已出货</option>
						 			    </select> 	
						 			    <select data-name="trackState" onChange={this.searhClick}>
											<option value="">上网状态</option>
											<option value="1">已签收的</option>
											<option value="2">未签收的</option>
											<option value="3">未上网的</option>
						 			    </select>  
						 			    <select data-name="transit" onChange={this.searhClick}>
											<option value="">渠道类型</option>
											<option value="item.transit" for="item in tabTransit"></option>  
						 			    </select>
						 			    <select data-name="shipServ" onChange={this.searhClick}>
											<option value="">附加项目</option>
											<option value="item.shipServ" for="item in tabShipServ"></option>
						 			    </select> 	
						 			    <select data-name="holdState" onChange={this.searhClick}>
											<option value="">问题件</option>
											<option value="1">扣件</option>   
											<option value="2">退件</option>
											<option value="3">等待问题件</option>
											<option value="4">已处理问题件</option>
											<option value="5">所有问题件</option>
						 			    </select>
										关键字 <input type="text" data-name="key"  style={{'text-indent': '5px', 'width': '70px', 'margin-right': '5px'}} />
										单号 <input type="text" data-name="AWB"  style={{'text-indent': '5px', 'width': '100px', 'margin-right': '5px'}} />
									    <button onClick={this.searhClick} style={{'margin-right': '10px'}}>搜索</button>
									    重量：<input type="text" data-name="wtStart" style={{'width': '50px'}} /> 至 <input type="text" data-name="wtEnd"  style={{'width': '50px'}} /> kg
									</td>
								</tr>
					    	</table>
					    </div>
                        <table cellspacing="0" cellpadding="0" width="100%" style={{'margin-top': '20px','width': '1500px'}}>
                            <thead>
                                <tr>                
                                    <td>日期</td>					
									<td>入库批号</td>
									<td>客户</td>					
									<td>客户单</td>
									<td>运单号</td>
									<td>转单号</td>
									<td>国家</td>
									<td>件数</td>
									<td>包裹</td>
									<td>品名</td>
									<td>入重</td>
									<td>出重</td>
									<td>渠道</td>
									<td>应收款</td>
									<td>应付款</td>
									<td>毛利</td>
									<td>服务商</td>
									<td>备注</td>
									<td>状态</td>
									<td>上网状态</td>
									<td>业务员</td>
									<td>分公司</td>
									<td>类型</td>
                                </tr>
                            </thead>
                            <Tbody data={this.state.data}/>
                            <tfoot>
                                <tr>
                                    <td colSpan="31">
                                        <div id="pager">
                                            <ul className="pages">
                            
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
                )
            }
        });
        ReactDOM.render(
          <Table />,
          document.getElementById('exp')
        );
    </script>
</body>
</html>