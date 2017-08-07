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
	<div id="pagingSorting" style="display: none;">currency</div>
	
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
		 var xiugai = {
	        'font-size': '22px',
	        'color': '#E4393C'
	    }
		var UserItem = React.createClass({
	        dlgEdit: function () {
	            dlgEdit(this.props.data,this);
	        },
	        delData: function () {
	            delData(this.props.data.id,this.refs.del,'one');
	        },
	        render: function () {
	            var index = this.props.index;
	            var user = this.props.data;
	            return (
	                <tr>
	                    <td><input type="checkbox" value={user.id} /></td>
						<td>{user.currencyName}</td>
						<td>{user.hl}</td>
						<td>
							<a href="javascript:;" onClick={this.dlgEdit}>		
								<i className="layui-icon" style={xiugai}>&#xe642;</i> 修改
							</a>
						</td>
						<td>
							<a href="javascript:;" onClick={this.delData} ref="del">				
								删除
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
	        dlgEdit: function () {
	            dlgEdit({},this);
	        },
	        delClick: function (){
	        	var id = APLDevel.getChecks('#exp table tbody');
				delData(id,this,'all');
	        },
	        componentDidMount: function() {
	        	setThis = this;
	        	bindEvent(this);
	        },
	        searhClick: function() {
	        	doList(1,this);
	        },
	        checkboxClick :function (){
				APLDevel.checkAll('.content', this.refs.checkbox);
	        },
	        render: function() {
	            return (
	                <div>
	                    <div className="listParamBox">
						    关键字 <input type="text" data-name="key" className="key" />
						    <button onClick={this.searhClick} className="pd5">搜索</button>
						    <button onClick={this.dlgEdit} className="pd5">添加</button>
			 			    <button onClick={this.delClick} className="pd5">删除</button>
			 			    <br/><br/>
					    </div>
	                    <table cellspacing="0" cellpadding="0" width="100%">
	                        <thead>
	                            <tr>
	                                <td><input type="checkbox" onClick={this.checkboxClick} ref="checkbox" /></td>
									<td>币制</td>
									<td>汇率</td>
									<td><i className="layui-icon">&#xe642;</i> 修改</td>
									<td>删除</td>
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

	    function dlgEdit(user,_this) {
	        var string = '<div style="display: none;" id="boxInfo">'
	                        +'<p>'
	                            +'<span>币制：</span>'
	                            +'<input type="text" value="'+(user.currencyName==undefined?'':user.currencyName)+'" data-name="currencyName" placeholder="输入限制1-20位" data-ver="1-20">'
	                        +'</p>'
	                        +'<p>'
	                            +'<span>汇率：</span>'
	                            +'<input type="text" value="'+(user.hl==undefined?'':user.hl)+'" data-name="hl" placeholder="输入限制1-20位" data-ver="1-20">'
	                        +'</p>'
	                    +'</div>';   
	        addModify(user,_this,string);
	    }
    </script>
</body>
</html>