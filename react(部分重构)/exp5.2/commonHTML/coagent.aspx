<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>币制</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">	
	<script src="../../react/react.min.js"></script>
	<script src="../../react/react-dom.min.js"></script>
	<script src="../../react/browser.min.js"></script>
	<style>
		.hide{display: none;}
		.pd5{padding: 5px;margin-right: 10px;}
		.key{height: 30px;padding: 0 5px;margin-right: 10px;}
	</style>
</head>
<body> 
	<div id="pagingSorting" style="display: none;">coagent</div>
	
	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<section id="main" style="width: 1200px;">
		<div class="content" style="width: 100%;">
			<div id="exp">
				
			</div>
		</div>
	</section>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	<script src="../js/common.js"></script>	
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
						<td>{user.coagentNo}</td>
						<td>{user.coagentName}</td>
						<td>
							<a href="javascript:;" onClick={this.modify}>		
								<i className="layui-icon" style={{'font-size': '22px','color': '#E4393C'}}>&#xe642;</i> 详细
							</a>
						</td>
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
	        render: function() {
	            return (
	                <div>
	                    <div className="listParamBox">
				 			<select data-name="state" style={{'height': '30px','margin-right':'10px'}} onChange={this.searhClick}>
			                    <option value="1">有效的</option>
			                    <option value="0">无效的</option>
			                </select>&nbsp;
						    关键字 <input type="text" data-name="key" className="key" />&nbsp;&nbsp;
						    <button onClick={this.searhClick} className="pd5">搜索</button>
						    <button onClick={this.handleClick} className="pd5">添加</button>
			 			    <br/><br/>
					    </div>
	                    <table cellspacing="0" cellpadding="0" width="100%">
	                        <thead>
	                            <tr>
									<td>服务商编号</td>
									<td>服务商简称</td>
									<td><i className="layui-icon">&#xe642;</i> 详细</td>
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