<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>出纳管理</title>
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
	<div id="pagingSorting" style="display: none;">cash</div>

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
	            APLDevel.dlgFull(dbTab+'Details.aspx?id='+this.props.data.cashId);
	        },
	        render: function () {
	            var index = this.props.index;
	            var user = this.props.data;
	            return (
	                <tr>
						<td>{user.bookTime}</td>
						<td>
							<a href="javascript:;" onClick={this.modify} style={{'color': 'red','font-weight': 'bold'}}>
		                        {user.cashNo}
		                    </a>
						</td>
						<td>{user.accountName}</td>
						<td>{user.summary}</td>
						<td>{user.inCharge}</td>
						<td>{user.inCurrency}</td>
						<td>{user.outCharge}</td>
						<td>{user.outCurrency}</td>
						<td>{user.clientName} {user.coagentName}  {user.remark}</td>
						<td>{user.oprBill}</td>		
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
	        	bindEvent(this);
	        },
	        searhClick: function() {
	        	doList(1,this);
	        },
	        handleClick: function () {
	            APLDevel.dlgFull(dbTab+'Details.aspx?id=0');
	        },
	        sboBankaccount:function(){
	        	sbo.go2('bankaccount','#accountId','id','#accountName','c2');
	        },
	        sboClient:function(){
	        	sbo.go2('client','#clientId','id','#clientName','c2');
	        },
	        sboCoagent:function(){
	        	sbo.go2('coagent','#coagentId','id','#coagentName','c2');
	        },
	        sboSummary:function(){
	        	sbo.go2('summary','#numCode','id','#summary','c2');
	        },
	        sboUser:function(){
	        	sbo.go2('user','#user','id','#oprBill','c2');
	        },
	        timerFocus:function(){
            	WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});
            },
	        render: function(){
	            return (
	                <div>
					    <div className="listParamBox">
					    	<table cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<button>结账</button>
								    	<button onClick={this.handleClick}>添加</button>
								    	<button>主营收入</button>
								    	<button>主营费用</button>
								    	<button>导出</button>
								    	账号：<input type="text" data-name="accountName" id="accountName" style={{'width': '100px'}} />
				                			  <input type="hidden" id="accountId" data-name="accountId" data-corre="accountName" />
				                			  <button type="button" onClick={this.sboBankaccount} title="搜索" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>	 			   
						 			    客户：<input type="text" data-name="clientName" id="clientName" style={{'width': '100px'}} />
				                			  <input type="hidden" id="clientId" data-name="clientId"  data-corre="clientName" />
				                			  <button type="button" onClick={this.sboClient} title="搜索" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
						 			    服务商：<input type="text" data-name="coagentName" id="coagentName"  style={{'width': '100px'}} />
				                			    <input type="hidden" id="coagentId" data-name="coagentId"  data-corre="coagentName" />
				                			    <button type="button" onClick={this.sboCoagent} title="搜索" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
									</td>
								</tr>
								<tr>
									<td>
										日期：<input onFocus={this.timerFocus} type="text" data-name="dateStart" className="input-text Wdate" style={{'width': '150px'}} /> &nbsp;至 &nbsp;
						 			    <input onFocus={this.timerFocus} type="text" data-name="dateEnd" className="input-text Wdate" style={{'width': '150px','margin-left':'5px'}} />
						 			    科目：<input type="text" data-name="summary" id="summary" style={{'width': '100px'}} />
				                			  <input type="hidden" id="numCode" data-name="numCode"  data-corre="summary" />
				                			  <button type="button" onClick={this.sboSummary} title="搜索" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
						 			    &nbsp;
						 			    出纳员：<input type="text" data-name="oprBill" id="oprBill" style={{'width': '100px'}} />
				                			  <input type="hidden" id="user" data-name="user" data-corre="oprBill" />
				                			  <button type="button" onClick={this.sboUser} title="搜索" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px'}}><i className="layui-icon"></i></button>
									</td>
								</tr>
								<tr>
									<td>
										方向：<select data-name="way" onChange={this.searhClick}>
												  <option value=""></option>
												  <option value="1">收入</option>   
												  <option value="2">支出</option>
												  <option value="3">收支</option>
						 			    	  </select> 
										结账：<select data-name="cashJz" onChange={this.searhClick}>
												  <option value=""></option>
												  <option value="1">已结</option>   
												  <option value="0">未结</option>
						 			    	  </select> 	
										销账：<select data-name="cashJz" onChange={this.searhClick}>
												  <option value=""></option>
												  <option value="1">已结</option>   
												  <option value="0">未结</option>
						 			    	  </select>
										关键字 <input type="text" data-name="key"  style={{'text-indent': '5px'}} />
									    <button onClick={this.searhClick}>搜索</button>
									</td>
								</tr>
					    	</table>
					    	<br/>
					    </div>
	                    <table cellspacing="0" cellpadding="0" width="100%">
	                        <thead>
	                            <tr>				
									<td>日期</td>
									<td>出纳编号</td>
									<td>账户</td>
									<td>科目</td>
									<td colSpan="2">收入</td>
									<td colSpan="2">支出</td>					
									<td>备注</td>
									<td>出纳员</td>
	                            </tr>
	                        </thead>
	                        <Tbody data={this.state.data}/>
	                        <tfoot>
								<tr>
									<td colSpan="11">
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