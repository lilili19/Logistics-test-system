<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>服务商详情</title>
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
        #app table{margin-left: 10px;width: 1100px;}
        #app form table td{max-width: 1100px;padding: 10px;}
        #app form table input{width: 200px;margin-right: 10px;}
        #app form table select{height: 30px;margin-right: 10px;}
        #app td{padding: 5px;border: 1px solid #ddd;}
        #app td input{width: 100%;height: 30px;padding: 0px 5px;}
        .morexx{margin: 10px;color:red;font-weight: bold;font-size: 16px;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none">coagent</div>

    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <div id="app"> 
        
    </div>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="commonDetails.js"></script>
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
                            <input type="text" disabled="true" data-name="linkman" value={user.linkman} placeholder="请输入2-100位" data-ver="2-100" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="depName" value={user.depName} placeholder="0-100位内" data-ver="0-100" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="phone" value={user.phone} placeholder="100位内" data-ver="0-100" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="mobile"  value={user.mobile} placeholder="999999内" data-ver="-999999" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="email"  value={user.email} placeholder="999999内" data-ver="-999999" onBlur={this.hankChange} onChange={this.change} />
                        </td>
                        <td>
                            <input type="text" disabled="true" data-name="remark"  value={user.remark} placeholder="999999内" data-ver="-999999" onBlur={this.hankChange} onChange={this.change} />
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
                                        <input type="text" data-name="linkman" placeholder="1-100位内" data-ver="1-100" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="depName" placeholder="100位内" data-ver="0-100" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text"  data-name="phone" placeholder="100位内" data-ver="0-100" onBlur={_this.hankChange} />
                                    </td>
                                    <td>
                                        <input type="text" data-name="mobile" placeholder="100位内" data-ver="0-100" onBlur={_this.hankChange} onkeyup="APLDevel.clearNoNum(_this,3)" />
                                    </td>
                                    <td>
                                        <input type="text" data-name="email" placeholder="100位内" data-ver="0-100" onBlur={_this.hankChange} onkeyup="APLDevel.clearNoNum(_this,3)" />
                                    </td>
                                    <td>
                                        <input type="text" data-name="remark" placeholder="200位内" data-ver="0-200" onBlur={_this.hankChange} />
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
                                    coagentName:"",
                                    coagentNo:"",
                                    fullName:"",
                                    id:getId,
                                    remark:"",
                                    state:""
                                }
                            ]
                        },
                        coagentext:{
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
                                    <td>
                                        <span>服务商编号：</span>
                                        <input type="text" value={data.coagentNo} onChange={this.handleChange} data-name="coagentNo" placeholder="输入1-20位" data-ver="1-20" />
                                        <span>服务商简称：</span>
                                        <input type="text" value={data.coagentName} onChange={this.handleChange} data-name="coagentName" placeholder="输入1-20位" data-ver="1-20" />                     
                                        <span>服务商全称：</span>
                                        <input type="text" value={data.fullName} onChange={this.handleChange} data-name="fullName" placeholder="输入1-20位" data-ver="1-20" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>状态：</span>
                                        <select data-name="state" data-ver="1-20" value={data.state} onChange={this.handleChange}>
                                            <option value="1">有效</option>
                                            <option value="0">无效</option>
                                        </select>              
                                        <span>备注：</span>
                                        <input type="text" value={data.remark} onChange={this.handleChange} data-name="remark" placeholder="输入1-20位" data-ver="1-20" style={{'width': '600px'}} />
                                    </td>                    
                                </tr>
                            </table>
                        </form>
                        <p className="morexx" style={{'display':(data.id==0?'none':'')}}>更多信息：</p>
                        <table className="apl-tableSpecial" id="tabCoagent" style={{'display':(data.id==0?'none':'')}}>
                            <thead>
                                <tr>
                                    <td style={{'display': 'none'}} data-level="m">编辑</td>
                                    <td><span>联系人</span></td>
                                    <td><span>部门</span></td>
                                    <td><span>电话</span></td>
                                    <td><span>手机</span></td>
                                    <td><span>邮箱</span></td>
                                    <td><span>备注</span></td>
                                    <td width="5%" style={{'display': 'none'}} data-level="m">删除</td>
                                </tr>
                            </thead> 
                            <Tbody data={this.state.data.coagentext.rows} addList={this.state.data.addList}/>
                            <tfoot> 
                                <tr>
                                    <td colSpan="10">
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