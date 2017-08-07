<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
    <title>客户管理</title>
    <link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">
    <link rel="stylesheet" href="../css5.2/common.css">
    <link rel="stylesheet" href="../css5.2/index.min.css">
    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
    <script src="../../react/react.min.js"></script>
    <script src="../../react/react-dom.min.js"></script>
    <script src="../../react/browser.min.js"></script>
    <style>
        #exp .listParamBox input{margin-right: 5px;}
        #exp .listParamBox select{margin-right: 5px;}
    </style>
</head>
<body> 
    <div id="pagingSorting" style="display: none;">client</div>

    <div id="preloader">
        <img src="../../images/load.gif" alt="">
    </div>
    <section id="main" style="width: 95%;">
        <div class="content" style="width: 100%;">
            <div id="exp">
                
            </div>
        </div>
    </section>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui2/layui.min.js"></script>
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
            componentDidMount: function(){
                APLDevel.level();
            },
            modify: function () {
                APLDevel.dlgFull(dbTab+'Details.aspx?id='+this.props.data.id);
            },
            render: function () {
                var index = this.props.index;
                var user = this.props.data;
                return (
                    <tr>
                        <td>{user.clientNo}</td>
                        <td>{user.clientName}</td>
                        <td>{user.ywyName}</td>
                        <td>{user.state==1?'有效的':'无效的'}</td>
                        <td>{user.auditing==1?'已审的':'未审的'}</td>
                        <td data-level="m" style={{'display': 'none'}}>
                            <a href="javascript:;" onClick={this.modify}>                 
                                <i className="layui-icon" style={{'font-size': '22px', 'color': '#E4393C'}}>&#xe642;</i> 详细
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
                            <select data-name="state" onChange={this.searhClick} style={{'height': '30px'}}>
                                <option value="1">有效的</option>
                                <option value="0">无效的</option>
                            </select>
                            <select data-name="auditing" onChange={this.searhClick} style={{'height': '30px'}}>
                                <option value="">审核状态</option>
                                <option value="1">已审的</option>
                                <option value="0">未审的</option>
                            </select>
                            业务员：<input type="text" style={{'height': '30px','text-indent': '5px'}} id="ywyName" data-name="ywyName" />
                            <input type="hidden" data-name="ywy" id="ywy" data-corre="ywyName" />
                            <button type="button" onClick={this.sboUser} title="搜索" data-level="m" className="layui-btn layui-btn-mini" style={{'line-height': '16px','margin-right':'5px'}}><i className="layui-icon"></i></button>
                            关键字 <input type="text" data-name="key" style={{'height': '30px','text-indent': '5px'}} />
                            <input type="button" onClick={this.searhClick} value="搜索" style={{'padding': '5px'}} />
                            <input type="button" onClick={this.handleClick} value="添加" style={{'padding': '5px','display': 'none'}} data-level="m" />
                            <br/><br/>
                        </div>
                        <table cellspacing="0" cellpadding="0" width="100%">
                            <thead>
                                <tr>                
                                    <td>客户编号</td>
                                    <td>客户简称</td>
                                    <td>业务员</td>
                                    <td>状态</td>
                                    <td>审核</td>
                                    <td data-level="m" style={{'display': 'none'}}><i className="layui-icon">&#xe642;</i> 详细</td>
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