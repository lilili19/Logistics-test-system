<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
	<meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
	<title>出纳管理详情</title>
	<link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
	<link rel="stylesheet" href="../../css/apl-1.0.css">
	<link rel="stylesheet" href="../css5.2/common.css">
	<link rel="stylesheet" href="../css5.2/index.min.css">
	<link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
	<script src="../../react/react.min.js"></script>
	<script src="../../react/react-dom.min.js"></script>
	<script src="../../react/browser.min.js"></script>
	<style>
		#app input{height: 30px;padding: 0px 5px;margin-right: 5px;}
		#app form td{padding: 10px 5px;}
		#app form input{width: 150px;}
		#app form span{display: inline-block;width: 90px;}
		#app form select{height: 30px;}
		#app table{width: 1000px;}
        #app select{height: 30px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #tabCashact td input{width: 100px;}
		.morexx{margin: 10px;color:red;font-weight: bold;font-size: 16px;}
	</style>	
</head>
<body> 
	<div id="pagingSorting" style="display: none;">cash</div>

	<div id="preloader">
      	<img src="../../images/load.gif" alt="">
  	</div>
	<div id="app">
        
	</div>
	<script src="../../js/jquery-2.1.1.min.js"></script>
	<script src="../../plugins/layui2/layui.min.js"></script>
	<script src="../../plugins/WdatePicker/WdatePicker.js"></script>
	<script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
	<script src="../../js/APLDevel.js"></script>
	<script src="../../l_popup_tips/l_popup_tips.js"></script>
	<script src="commonDetails.js"></script>	
	<script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
    <script type="text/babel">
        var UserItem = React.createClass({
            hankChange:function(event){
                vertionCell(event.target);
            },
            componentDidMount: function() {
                APLDevel.level();
            },
            editRow:function(event){
                editRow(event.target);
            },
            saveRow:function(event){
                saveRow(event.target,'cashact');
            },
            delRow:function(event){
                delRow(event.target,'cashact');
            },
            change:function(event){
            	var name = $(event.target).attr('data-name');
                var data = setThis.state.data;
                data.cashact.rows[this.props.index][name] = event.target.value;
                setThis.setState({
                    data:data
                })
            },
            render:function(){
                var index = this.props.index;
                var user = this.props.data;
                return (
                    <tr>
                        <td align="cetner" style={{'display': 'none'}} data-level="m">
                            <button type="button" className="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow"  onClick={this.editRow} style={{'display': 'inline-block'}}>编 辑</button>
                            <button type="button" className="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onClick={this.saveRow} style={{'display': 'none'}} >保 存</button>
                            <input type="hidden" data-name="rowId" value={user.id} />
                        </td>
                        <td>
		                    <input type="hidden" data-name="numCode" />
		                    <input type="text" disabled="true" data-name="summary" value={user.summary} placeholder="请输入2-100位" data-ver="2-100" onBlur={this.hankChange} onChange={this.change} />
		                    <button type="button" onclick="sbo.go2('summary','numCode','c1', 'summary', 'c2')" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '17px','width':'24px'}}><i className="layui-icon"></i></button>
                        	</td>
                        <td>                            
                            <input type="hidden" data-name="accountId" />
		                    <input type="text" disabled="true" data-name="accountName" value={user.accountName} data-ver="0-100" onBlur={this.hankChange} onChange={this.change} />
		                    <button type="button" onclick="sbo.go2('account','accountId','id', 'accountName', 'c2')" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '17px','width':'24px'}}><i className="layui-icon"></i></button>
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="inCharge" value={user.inCharge} data-ver="0-100" onBlur={this.hankChange} onKeyup={this.handKeyup} onChange={this.change} />
		                    <select data-name="inCurrency" disabled="true">
								<option value=""></option>
								<option value="RMB">RMB</option>
								<option value="HKD">HKD</option>
								<option value="USD">USD</option>
							</select>
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="outCharge"  value={user.outCharge} placeholder="999999内" data-ver="-999999" onBlur={this.hankChange} onKeyup={this.handKeyup} onChange={this.change} />
		                	<select  data-name="outCurrency" disabled="true">
								<option value=""></option>
								<option value="RMB">RMB</option>
								<option value="HKD">HKD</option>
								<option value="USD">USD</option>
		                    </select>
                        </td>
                        <td>
                            <input type="number" disabled="true" data-name="hl"  value={user.hl} data-ver="-999999" onBlur={this.hankChange} onKeyup={this.handKeyup} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="remarkact"  value={user.remarkact} data-ver="0-100" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>

                        </td>
                        <td style={{'display': 'none'}} data-level="m" width="5%">
                            <a href="javascript:;" onClick={this.delRow} style={{'color': 'red'}}>删 除</a>
                        </td>
                    </tr>
                )
            }
        });
        var Tbody = React.createClass({
            hankChange:function(event){
                vertionCell(event.target);
            },
            editRow:function(event){
                editRow(event.target);
            },
            saveRow:function(event){
                saveRow(event.target,'cashact');
            }, 
            delRow:function(event){
                delRow(event.target,'cashact');
            },    
            handKeyup:function(event){
				APLDevel.clearNoNum(event.target,3)
            },
            render:function(){
                var _this = this;
                return (
                    <tbody>                            
                        {this.props.data.map(function(user,index){
                            return <UserItem data={user} index={index} />
                        })}
                        {this.props.addList.map(function(user,index){
                            return (
                                <tr>
                                    <td align="cetner" style={{'display': 'none'}} data-level="m">
                                        <button type="button" className="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onClick={_this.editRow} style={{'display': 'none'}}>编 辑</button>
                                        <button type="button" className="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onClick={_this.saveRow} style={{'display': 'inline-block'}}>保 存</button>
                                        <input type="hidden" data-name="rowId" value="" id={index} />
                                    </td>
                                    <td>
                                        <input type="hidden" data-name="numCode" />
					                    <input type="text" data-name="summary" data-ver="2-100" onBlur={_this.hankChange} />
					                    <button type="button" onclick="sbo.go2('summary','numCode','c1', 'summary', 'c2')" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '17px','width':'24px'}}><i className="layui-icon"></i></button>
                                    </td>
                                    <td>
                                        <input type="hidden" data-name="accountId" />
					                    <input type="text" data-name="accountName" data-ver="0-100" onBlur={_this.hankChange} />
					                    <button type="button" onclick="sbo.go2('account','accountId','id', 'accountName', 'c2')" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '17px','width':'24px'}}><i className="layui-icon"></i></button>
                                    </td>
                                    <td>
                                        <input type="number"  data-name="inCharge" data-ver="-999999" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
					                    <select data-name="inCurrency">
											<option value=""></option>
											<option value="RMB">RMB</option>
											<option value="HKD">HKD</option>
											<option value="USD">USD</option>
										</select>
                                    </td>
                                    <td>
                                        <input type="number" data-name="outCharge" data-ver="-999999" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
					                	<select  data-name="outCurrency">
											<option value=""></option>
											<option value="RMB">RMB</option>
											<option value="HKD">HKD</option>
											<option value="USD">USD</option>
					                    </select>
                                    </td>
                                    <td>
                                        <input type="number" data-name="hl" data-ver="-999999" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="remarkact" placeholder="200位内" data-ver="0-200" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        
                                    </td>
                                    <td style={{'display': 'none'}} data-level="m">
                                        <a href="javascript:;" onClick={_this.delRow} style={{'color': 'red'}}>删 除</a>
                                    </td>
                                </tr>						            
                            )
                        })}                                  
                    </tbody>
                )
            }              
        });
        var Table = React.createClass({
            getInitialState: function () {
                return {
                    data: {
                        info:{
                            rows:[
                                {
                                    clientName:"",
                                    bookTime:"",
                                    cashNo:"",
                                    id:getId,
                                    coagentName:"",
                                    oprBill:"",
                                    oprJz:"",
                                    remark:""
                                }
                            ]
                        },  
                        cashact:{
							rows:[]
                        },              
                        addList:[{}]
                    }
                }
            },  
            componentDidMount: function() {
            	setThis = this;
                APLDevel.level();
                detailsInfo(this);
            }, 
            Return: function(){
                parent.doList(1);
                parent.l_popup.close(0);
            },
            saveInfo:function(){
                saveInfo(this);
            },
            handleChange:function(event){
            	var name = $(event.target).attr('data-name');
                var data = this.state.data;
                data.info.rows[0][name] = event.target.value;
                this.setState({
                    data: data
                })
            },
            addRow:function(){
                var data = this.state.data;
                data.addList.push({},{},{});
                this.setState({
                    data:data
                },function(){
                    APLDevel.level();
                }) 
            },   
            sboClient:function(){
				sbo.go2('client','#clientId','id', '#clientName', 'c2')
            },
            sboCoagent:function(){
				sbo.go2('coagent','#coagentId','id', '#coagentName', 'c2')
            },
            timerFocus:function(){
            	WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});
            },
            render:function(){
                var data = this.state.data.info.rows[0];
                return (
                    <div>
                    	<div className="apl-tool" style={{'margin-bottom': '10px'}}>
				            <button type="button" className="layui-btn layui-btn-small layui-btn-danger" onClick={this.saveInfo}>保存</button>
				            <button type="button" className="layui-btn layui-btn-small layui-btn-normal" onClick={this.Return}>关闭</button>
				        </div>
                        <form>
                            <table cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <span>客户：</span>
                                        <input type="text" value={data.clientName} onChange={this.handleChange} data-name="clientName" placeholder="输入1-20位" data-ver="1-20" />
                                        <input type="hidden" data-name="clientId" id="clientId" data-corre="clientName" />
				                    	<button type="button" onClick={this.sboClient} title="搜索" level="m" className="layui-btn layui-btn-mini" style={{'line-height': '17px','width':'24px','margin-right': '10px'}}><i className="layui-icon"></i></button>

                                        <span>日期：</span>
                                        <input type="text" onFocus={this.timerFocus} value={data.bookTime} onChange={this.handleChange} data-name="bookTime" placeholder="输入1-20位" data-ver="1-20" />                     
                                        <span>编号：</span>
                                        <input type="text" value={data.cashNo} onChange={this.handleChange} data-name="cashNo" placeholder="输入1-20位" data-ver="1-20" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>服务商：</span>
                                        <input type="text" value={data.coagentName} onChange={this.handleChange} data-name="coagentName" placeholder="输入1-20位" data-ver="1-20" />
                                        <input type="hidden" data-name="coagentId" id="coagentId" data-corre="coagentName" />                                   
				                    	<button type="button" onClick={this.sboCoagent} title="搜索" level="m" className="layui-btn layui-btn-mini" style={{'line-height': '17px','width':'24px','margin-right': '10px'}}><i className="layui-icon"></i></button>

                                        <span>出纳员：</span>
                                        <input type="text" value={data.oprBill} onChange={this.handleChange} data-name="oprBill" disabled="true" />
                                        <span>出纳结账：</span>
                                        <input type="text" value={data.oprJz} onChange={this.handleChange} data-name="oprJz" ref="oprJz" disabled="true" />
                                    </td>                 
                                </tr>
                                <tr>
                                    <td>
                                        <span>备注：</span>
                                        <input type="text" value={data.remark} onChange={this.handleChange} data-name="remark" placeholder="输入1-20位" data-ver="1-20" style={{'width': '696px'}} />
                                    </td>                 
                                </tr>
                            </table>
                        </form>
                       	<p className="morexx" style={{'display':(data.id==0?'none':'')}}>更多信息：</p>
                        <table className="apl-tableSpecial" id="tabCashact" style={{'display':(data.id==0?'none':'')}}>
                            <thead>
                                <tr>
                                    <td style={{'display': 'none'}} data-level="m">编辑</td>
                                    <td><span>科目</span></td>
                                    <td><span>账户</span></td>
                                    <td><span>收入</span></td>
                                    <td><span>支出</span></td>
                                    <td><span>汇率</span></td>
                                    <td><span>备注</span></td>
                                    <td><span>销账</span></td>
                                    <td width="5%" style={{'display': 'none'}} data-level="m">删除</td>
                                </tr>
                            </thead> 
                            <Tbody data={this.state.data.cashact.rows} addList={this.state.data.addList}/>
                            <tfoot> 
                                <tr>
                                    <td colSpan="15">
                                        <button type="button" className="layui-btn layui-btn-small" onClick={this.addRow}>新增</button>
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
            document.getElementById('app')
        )
    </script>
</body>
</html>