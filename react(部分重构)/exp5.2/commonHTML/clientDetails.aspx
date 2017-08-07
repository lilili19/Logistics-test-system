<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>客户管理详情</title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">

    <link rel="stylesheet" href="../../exp5.2/css5.2/common.css">  
    <link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">  
    <link rel="stylesheet" href="../../css/popup.css">

    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
    <script src="../../react/react.min.js"></script>
    <script src="../../react/react-dom.min.js"></script>
    <script src="../../react/browser.min.js"></script>
    <style>
        #app table{margin:0px 0px 10px 10px;width: 1100px;}
        #app form table td{max-width: 1100px;padding: 10px;}
        #app form table td:nth-child(2n-1){font-weight: bold;}
        #app input{width: 200px;margin-right: 10px;}
        #app select{height: 30px;margin-right: 10px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #app td input{width: 100%;height: 30px;padding: 0px 5px;}
        .morexx{margin: 10px;color:red;font-weight: bold;font-size: 16px;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">client</div>

    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <div id="app">       
       
    </div>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../plugins/layer/layer.min.js"></script>
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
                saveRow(event.target,'coagentext');
            },
            delRow:function(event){
                delRow(event.target,'coagentext');
            },
            change:function(event){
                var name = $(event.target).attr('data-name');
                var data = setThis.state.data;
                data.coagentext.rows[this.props.index][name] = event.target.value;
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
                            <input type="text" disabled="true" data-name="linkman" value={user.linkman} placeholder="2-50位" data-ver="2-50" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="depName" value={user.depName} placeholder="30位内" data-ver="0-30" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="phone" value={user.phone} placeholder="20位内" data-ver="0-20" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="mobile" value={user.mobile} placeholder="20位内" data-ver="0-20" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="fax" value={user.fax} placeholder="20位内" data-ver="0-20" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="email" value={user.email} placeholder="30位内" data-ver="0-30" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="qq" value={user.qq} placeholder="50位内" data-ver="0-50" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="remark"  value={user.remark} placeholder="200位内" data-ver="0-200" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                         <td style={{'display': 'none'}} data-level="m" width="5%">
                            <a href="javascript:;" onClick={this.delRow} style={{'color': 'red'}}>删 除</a>
                        </td>
                    </tr>
                )
            }
        });
        var UserItem2 = React.createClass({
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
                saveRow(event.target,'regUser');
            },
            delRow:function(event){
                delRow(event.target,'regUser');
            },
            change:function(event){
                var name = $(event.target).attr('data-name');
                var data = setThis.state.data;
                data.user.rows[this.props.index][name] = event.target.value;
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
                            <input type="text" disabled="true" data-name="userId" value={user.userId} placeholder="请输入2-20位" data-ver="2-20" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="userPwd" value={user.userPwd} placeholder="2-20位内" data-ver="2-20" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <select value={user.state} data-name="state" disabled="true" data-ver="1-10" onChange={this.change}>
                                <option value="1">有效</option>
                                <option value="0">无效</option>
                            </select>
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
                saveRow(event.target,'coagentext');
            }, 
            delRow:function(event){
                delRow(event.target,'coagentext');
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
                                        <input type="text" data-name="linkman" placeholder="2-50位内" data-ver="2-50" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="depName" placeholder="30位内" data-ver="0-30" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text"  data-name="phone" placeholder="20位内" data-ver="0-20" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="mobile" placeholder="20位内" data-ver="0-20" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="fax" placeholder="20位内" data-ver="0-20" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="email" placeholder="30位内" data-ver="0-30" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="qq" placeholder="50位内" data-ver="0-50" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="remark" placeholder="200位内" data-ver="0-200" onBlur={_this.hankChange} onKeyup={_this.handKeyup} />
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
        var Tbody2 = React.createClass({
            hankChange:function(event){
                vertionCell(event.target);
            },
            editRow:function(event){
                editRow(event.target);
            },
            saveRow:function(event){
                saveRow(event.target,'regUser');
            }, 
            delRow:function(event){
                delRow(event.target,'regUser');
            },    
            handKeyup:function(event){
                APLDevel.clearNoNum(event.target,3)
            },
            render:function(){
                var _this = this;
                return (
                    <tbody>                   
                        {this.props.data.map(function(user,index){
                            return <UserItem2 data={user} index={index} />
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
                                        <input type="text" data-name="userId" placeholder="2-20位内" data-ver="2-20" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="userPwd" placeholder="2-20位内" data-ver="2-20" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <select data-name="state" data-ver="1-10">
                                            <option value="1">有效</option>
                                            <option value="0">无效</option>
                                        </select>
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
                        coagentext:{
                            rows:[]
                        },
                        user:{
                            rows:[]
                        },            
                        addList:[{}],
                        addList2:[{}]
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
            addRow2:function(){
                var data = this.state.data;
                data.addList2.push({},{},{});
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
                        <div className="apl-tool">
                            <button type="button" className="layui-btn layui-btn-small layui-btn-danger" onClick={this.saveInfo}>保存</button>
                            <button type="button" className="layui-btn layui-btn-small layui-btn-normal" onClick={this.Return}>关闭</button>
                        </div>
                        <form>
                            <table cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>客户编号</td>
                                    <td>
                                        <input type="text" value={data.clientNo} onChange={this.handleChange} data-name="clientNo" placeholder="输入2-20位" data-ver="2-20" />
                                    </td>
                                    <td>客户简称</td>
                                    <td>
                                        <input type="text" value={data.clientName} onChange={this.handleChange} data-name="clientName" placeholder="输入2-20位" data-ver="2-20" />
                                    </td>
                                    <td>客户中文全称</td>
                                    <td>
                                        <input type="text" value={data.fullName} onChange={this.handleChange} data-name="fullName" placeholder="输入100位之内" data-ver="0-100" />
                                    </td>                   
                                </tr>
                                <tr>
                                    <td>客户英文简称</td>
                                    <td>
                                        <input type="text" value={data.enName} onChange={this.handleChange} data-name="enName" placeholder="输入100位之内" data-ver="0-100" />
                                    </td>
                                    <td>审核</td>
                                    <td>
                                        {data.auditing==1?'已审':'未审'}
                                    </td>  
                                    <td></td>
                                    <td></td>
                                </tr>    
                                <tr>
                                    <td>地址</td>
                                    <td colSpan="5">
                                        <input type="text" value={data.province} onChange={this.handleChange} style={{'width': 'auto'}} data-name="province" placeholder="输入2-50位" />省 
                                        <input type="text" value={data.city} onChange={this.handleChange} style={{'width': 'auto','margin-left':'5px'}} data-name="city" placeholder="输入2-50位" />市
                                        <input type="text" value={data.county} onChange={this.handleChange} style={{'width': 'auto','margin-left':'5px'}} data-name="county" placeholder="输入2-50位" />县(区)
                                        <br/>详细地址：<input type="text" value={data.address} onChange={this.handleChange} style={{'margin-top': '5px','width': '100%'}} data-name="address" placeholder="输入2-200位" data-ver="2-200" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>业务员</td>
                                    <td>
                                        <input type="text" style={{'height': '30px','text-indent': '5px','width': 'auto'}} id="ywyName" onChange={this.handleChange} data-name="ywyName"  placeholder="请选择" data-ver="1-200"/ >
                                        <input type="hidden" data-name="ywy" id="ywy" data-corre="ywyName" />
                                        <button type="button" onclick="sbo.go2('user','#ywyName','c2', '#ywy', 'id')" title="搜索" level="m" className="layui-btn layui-btn-mini"><i className="layui-icon"></i></button>
                                    </td>
                                    <td>信用额度</td>
                                    <td>
                                        <input type="text" value={data.accountCyc} onChange={this.handleChange} data-name="accountCyc" />
                                    </td>
                                    <td>添加人</td>
                                    <td>
                                        {data.oprname}
                                    </td>
                                </tr>
                                <tr>
                                    <td>付款协议</td>
                                    <td>
                                        <input type="text" value={data.payType} onChange={this.handleChange} data-name="payType" />
                                    </td>
                                    <td>状态</td>
                                    <td>
                                        <select value={data.state} data-name="state" onChange={this.handleChange} data-ver="1-5">
                                            <option value="1">有效</option>
                                            <option value="0">无效</option>
                                        </select>
                                    </td>                                     
                                    <td>添加日期</td>
                                    <td>
                                        {data.bookTime}
                                    </td>
                                </tr>
                                <tr>
                                    <td>付款协议</td>
                                    <td>
                                        
                                    </td>
                                    <td>分公司</td>
                                    <td>
                                        
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>备注</td>
                                     <td colSpan="5">
                                        <input type="text" value={data.remark} onChange={this.handleChange} style={{'width': '100%'}} data-name="remark" placeholder="输入200位之内" data-ver="0-200" />
                                    </td>
                                </tr>
                            </table> 
                        </form>
                        <p className="morexx" style={{'display':(data.id==0?'none':'')}}>联系人：</p>
                        <table className="apl-tableSpecial" id="tabCashact" style={{'display':(data.id==0?'none':'')}}>
                            <thead>
                                <tr>
                                    <td style={{'display': 'none'}} data-level="m">编辑</td>
                                    <td><span>联系人</span></td>
                                    <td><span>部门</span></td>
                                    <td><span>电话</span></td>
                                    <td><span>手机</span></td>
                                    <td><span>传真</span></td>
                                    <td><span>邮箱</span></td>
                                    <td><span>qq</span></td>
                                    <td><span>备注</span></td>
                                    <td width="5%" style={{'display': 'none'}} data-level="m">删除</td>
                                </tr>
                            </thead> 
                            <Tbody data={this.state.data.coagentext.rows} addList={this.state.data.addList}/>
                            <tfoot> 
                                <tr>
                                    <td colSpan="15">
                                        <button type="button" className="layui-btn layui-btn-small" onClick={this.addRow}>新增</button>
                                    </td>
                                </tr> 
                            </tfoot>
                        </table> 
                        <p className="morexx" style={{'display':(data.id==0?'none':'')}}>账号信息：</p>
                        <table className="apl-tableSpecial" id="tabCashact" style={{'display':(data.id==0?'none':'')}}>
                            <thead>
                                <tr>
                                    <td style={{'display': 'none'}} data-level="m">编辑</td>
                                    <td><span>账号</span></td>
                                    <td><span>密码</span></td>
                                    <td><span>状态</span></td>
                                    <td width="5%" style={{'display': 'none'}} data-level="m">删除</td>
                                </tr>
                            </thead> 
                            <Tbody2 data={this.state.data.user.rows} addList={this.state.data.addList2}/>
                            <tfoot> 
                                <tr>
                                    <td colSpan="15">
                                        <button type="button" className="layui-btn layui-btn-small" onClick={this.addRow2}>新增</button>
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