<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>运件清单详情</title>
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
        table{margin:0px 0px 10px 10px;width: 1100px;}
        form table td{padding: 10px;width: 12.5%;}
        form table td:nth-child(2n-1){font-weight: bold;}
        input{width: 200px;margin-right: 10px;}
        select{height: 30px;margin-right: 10px;}
        td,th{padding: 5px;border: 1px solid #ddd;} 
        .tdCenter td{text-align: center;} 
        .tdCenter td a{color: red;}
        #info td input{width: 100%;height: 30px;padding: 0px 5px;}
        #info2 td input{width: 100%;height: 30px;padding: 0px 5px;}
        #app .modify{
            background-color: #FF5722;
            height: 30px;
            line-height: 30px;
            padding: 0 10px;
            font-size: 14px;
            text-align: center;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            opacity: .9;
            color: white;
            font-weight: normal;
        }
        #tabServMsg ul{margin:0px 0px 10px 10px;width: 1098px;border: 1px solid #ddd;border-bottom: 0;}
        #tabServMsg ul li{width: 100%;margin-bottom: 10px;border-bottom: 1px solid #ddd;padding: 5px;}
        #tabServMsg ul li input{width: 14px;height: 14px;vertical-align: middle;margin: 0 0 0 15px;}
        #tabServMsg ul li textarea{vertical-align: text-top;resize:none;width: 800px;height: 100px;padding:5px;}
        #tabServMsg ul li button{padding: 5px;margin-left: 5px;}
        #chargeList{overflow: hidden;}
        #chargeList p{float: left;width: 325px;}
    </style>
</head>
<body>
    <div id="pagingSorting" style="display: none;">waybill</div>
    
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
        //运件清单详情留言信息保存
        function servMsgSave() {
            var xxlx = $('#tabServMsg input:radio:checked').val();
            if(!xxlx){
                l_tips('请选择信息流向',$('.xxlx'),{backgroundColor:'blue'});
                return;
            }
            if ($('#tabServMsg textarea').val() == '') {
                l_tips('内容不能为空',$('#tabServMsg textarea'),{backgroundColor:'blue'});
                return;
            }
            var data = 'mapFile='+dbTab+'.xml&modelName=servMsg&way='+xxlx+'&remark='+$('#tabServMsg textarea').val()+"&mainTabId="+getId;
            var url = host + '/general5/doSave';
            $.ajax({
                data:data,
                type:'post',
                dataType:'json',
                url:url,
                success:function(resData) {
                    var data = setThis.state.data;
                    data.servMsg.rows.push({id:resData.id,way:xxlx,remark:$('#tabServMsg textarea').val(),bookTime:APLDevel.time()})
                    setThis.setState({
                        data:data
                    })
                    $('#tabServMsg input:radio:checked').attr('checked',false);
                    $('#tabServMsg textarea').val('');
                    if (resData.Message != undefined) l_status('success',resData.Message);

                    // detailsInfo();
                },
                error:function() {
                    alert('保存失败');
                }
            })
        } 
        //删除
        function delData(par,id,index) {
            if (!confirm('确定删除这条记录吗？')) return;
            var url = host + '/general5/doDel';
            var data = 'mapFile='+dbTab+'.xml&id='+id+'&mainTabId='+getId+'&dbTab='+par;
            $('#preloader').show();
            $.ajax({
                url:url,
                data:data,
                type:'post',
                dataType:'json',
                success:function(resData) { 
                    $('#preloader').hide();
                    if(resData.Error != undefined) alert(resData.Error);
                    if(resData.success==true) {
                        l_status('success','删除成功');
                        var data = setThis.state.data;
                        data[par].rows.splice(index, 1);                                                 
                        setThis.setState({
                            data:data
                        });     
                    }                       
                },
                error:function() {
                    $('#preloader').hide();
                    l_status('error','删除失败');
                }
            })
        }
        //各种添加修改
        function modifyData(par,user,index) {
            var string = "";
            var data = 'mapFile='+dbTab+'.xml';
            switch(par){
                case 'info':
                    string ='<table cellspacing="0" cellpadding="0" id="info" style="display: none;"><tr><td>运件类型</td><td><select value="'+user.type+'" data-name="type" data-ver="1-5"><option value="1">快递</option><option value="2" '+(user.type==2?'selected':'')+'>空运</option></select></td><td>客户单号</td><td><input type="text" value="'+user.inCorpNo+'" data-name="inCorpNo" placeholder="请输入0-30位" data-ver="0-30"></td> <td>运单号</td><td><input type="text" value="'+user.inNo+'" data-name="inNo" placeholder="请输入1-20位" data-ver="1-20"></td><td>转单号</td><td><input type="text" value="'+user.webNo+'" data-name="webNo"></td></tr> <tr><td>起运地</td><td><input type="text" value="'+user.startShip+'" data-name="startShip"></td><td>国家</td><td><input type="text" value="'+user.countryNo+'" data-name="countryNo"  placeholder="请输入1-6位" data-ver="1-6"></td><td>件数</td><td><input type="text" value="'+user.piece+'" data-name="piece"></td><td></td><td></td></tr>  <tr><td>收渠道类型</td><td><input type="text" value="'+user.inTransit+'" data-name="inTransit"></td><td>出渠道类型</td><td><input type="text" value="'+user.outtransit+'" data-name="outtransit"></td><td>收包裹类型</td><td><input type="text" value="'+user.inPackdoc+'" data-name="inPackdoc"></td><td>出包裹类型</td><td><input type="text" value="'+user.outPackDoc+'" data-name="outPackDoc"></td></tr><tr><td>总申报价值</td><td><input type="text" value="'+user.worth+'" data-name="worth"></td><td>品名</td><td><input type="text" value="'+user.goods+'" data-name="goods"></td><td>邮编</td><td><input type="text" value="'+user.postalCode+'" data-name="postalCode"></td><td>核销单</td><td><input type="text" value="'+user.hxd+'" data-name="hxd"></td></tr> <tr><td>附加项目</td><td colspan="7"><input type="text" value="'+user.shipServ+'" data-name="shipServ"></td></tr><tr><td>内部备注</td><td colspan="7"><input type="text" value="'+user.remark+'" data-name="remark"></td></tr><tr><td>收货备注</td><td colspan="7"><input type="text" value="'+user.inRemark+'" data-name="inRemark"></td></tr><tr><td>出货备注</td><td colspan="7"><input type="text" value="'+user.outRemark+'" data-name="outRemark"></td></tr></table>';
                    data += '&id='+getId+'&modelName=checkin';
                break;
                case 'info2':
                    string = '<table cellspacing="0" cellpadding="0" id="info2" style="display: none;"><tr><td>寄件国家</td><td><input type="text" value="'+user.fromCountryNo+'" data-name="fromCountryNo" placeholder="请输入0-30位" data-ver="0-30"></td><td>寄件人公司</td><td><input type="text" value="'+user.fromCompany+'" data-name="fromCompany"></td><td>寄件人名</td><td><input type="text" value="'+user.fromMan+'" data-name="fromMan"></td></tr><tr><td>寄个人电话</td><td><input type="text" value="'+user.fromPhone+'" data-name="fromPhone"></td><td>寄件人地址</td><td><input type="text" value="'+user.fromAddress+'" data-name="fromAddress"></td><td>收件人公司</td><td><input type="text" value="'+user.recipCompany+'" data-name="recipCompany"></td></tr> <tr><td>收件人名</td><td><input type="text" value="'+user.recipMan+'" data-name="recipMan"></td><td>收件人手机</td><td><input type="text" value="'+user.recipMobile+'" data-name="recipMobile"></td><td>收件人电话</td><td><input type="text" value="'+user.recipPhone+'" data-name="recipPhone"></td></tr><tr><td>收件人邮箱</td><td><input type="text" value="'+user.recipEmail+'" data-name="recipEmail"></td><td>收件地址1行</td><td><input type="text" value="'+user.recipAddress+'" data-name="recipAddress"></td><td>收件地址2行</td><td><input type="text" value="'+user.recipAddress2+'" data-name="recipAddress2"></td></tr> <tr><td>收件地址3行</td><td><input type="text" value="'+user.recipAddress3+'" data-name="recipAddress3"></td><td>州(省)</td><td><input type="text" value="'+user.toState+'" data-name="toState"></td><td>城市</td><td><input type="text" value="'+user.toCity+'" data-name="toCity"></td></tr><tr><td>数量</td><td><input type="text" value="'+user.qty+'" data-name="qty"></td><td>投保值</td><td><input type="text" value="'+user.insureValue+'" data-name="insureValue"> </td><td>申报明细</td><td><input type="text" value="'+user.goodsInfo+'" data-name="goodsInfo"></td></tr></table>';
                    data += '&mainTabId='+getId+'&id='+user.id+'&modelName=checkinInfo';
                break;
                case 'servMsg':
                    string = '<div id="servMsg" style="display: none;">'
                                +'<p>'
                                    +'<span>信息流向：</span>'
                                    +'<select data-ver="1-10" data-name="way" value="'+user.way+'">'
                                        +'<option value="1">From服务商</option>'
                                        +'<option value="2">To服务商</option>'
                                        +'<option value="3">From客户</option>'
                                        +'<option value="4">TO客户</option>'
                                        +'<option value="5">内部备注</option>'
                                    +'</select>'
                                    +'</p>'
                                    +'<p style="height: auto;overflow: hidden;">'
                                    +'<span style="float: left;margin-right: 3px;">内容：</span>'
                                    +'<textarea value="'+user.remark+'" data-ver="1-1000000" data-name="remark" onblur="APLDevel.Vertion(null,$(this),$(this).prev())">'+user.remark+'</textarea>'
                                    +'</p>'
                            +'</div>';
                    data += '&mainTabId='+getId+'&id='+user.id+'&modelName='+par;
                break;
                case 'chargeList':
                    string = '<div id="chargeList" style="display: none;"><p><span>方向：</span><select data-name="way" value="'+user.way+'"><option value="1">收入</option><option value="2">支出</option></select></p><p><span>服务商：</span><input type="text" data-name="dxId" value="'+user.dxId+'" placeholder="请输入1-10位"></p><p><span>实重：</span><input type="text" data-name="GWT" value="'+user.GWT+'"></p><p><span>体积重：</span><input type="text" data-name="VWT" value="'+user.VWT+'"></p><p><span>计费重：</span><input type="text" data-name="CWT" value="'+user.CWT+'"></p><p><span>体积：</span><input type="text" data-name="vwtfm" value="'+user.vwtfm+'"></p><p><span>费用名：</span><input type="text" data-name="chargeName" value="'+user.chargeName+'" placeholder="请输入1-10位"></p><p><span>金额：</span><input type="text" data-name="charge" value="'+user.charge+'"></p><p><span>币制：</span><input type="text" data-name="currency" value="'+user.currency+'"></p><p><span>汇率：</span><input type="text" data-name="hl" value="'+user.hl+'"></p><p><span>销账：</span><input type="text" data-name="chargeAcc" value="'+user.chargeAcc+'"></p><p><span>公式：</span><input type="text" data-name="exp" value="'+user.exp+'"></p><p><span>渠道：</span><input type="text" data-name="priceName" value="'+user.priceName+'"></p><p><span>备注：</span><input type="text" data-name="remark" value="'+user.remark+'" placeholder="请输入1-50位"></p><p><span>审核：</span><input type="text" data-name="auditing" value="'+user.auditing+'"></p></div>';
                    data += '&mainTabId='+getId+'&id='+user.id+'&modelName='+par;
                break; 
                case 'track':
                    string = '<div id="track" style="display: none;">'
                                +'<p>'
                                    +'<span>转运地点：</span>'
                                    +'<input type="text" data-name="location" value="'+user.location+'">'
                                +'</p>'
                                +'<p>'
                                    +'<span>转运信息：</span>'
                                    +'<input type="text" data-name="activity" value="'+user.activity+'">'
                                +'</p>'
                            +'</div>';
                    data += '&mainTabId='+getId+'&id='+user.id+'&modelName='+par;
                break; 
            }
            l_popup({
                title: '详细信息',
                content: string,
                btn: '保存',
                width: par=='servMsg'?'360px':par=='chargeList'?'720px':'auto',
                yes: function(ind){
                    if(!APLDevel.Vertion('#'+par)) return;
                    var parData = "";
                    $('#'+par).find("["+APLDevel.dataName+"]").each(function() {
                        var name = $(this).attr('data-name');
                        var value = $(this).val();
                        parData += "&" + name + "=" +value;
                    });
                    parData = data + parData;
                    var url = host + '/general5/doSave';
                    $('#preloader').show();
                    $.ajax({
                        url:url,
                        data:parData,
                        type:'post',
                        dataType:'json',
                        success:function(resData) { 
                            $('#preloader').hide();
                            if(resData.Error != undefined) alert(resData.Error);
                            if(resData.success==true) {                                
                                l_status('success','保存成功');
                                var userData = {};                                
                                $('#'+par).find("["+APLDevel.dataName+"]").each(function () {
                                    var name = $(this).attr(APLDevel.dataName);
                                    userData[name] = $(this).val();
                                });
                                getId = resData.mainTabId;
                                var data = setThis.state.data;
                                data.info.rows[0].id = getId;
                                if(par == 'chargeList' || par == 'track'){
                                    if (index != undefined) {
                                        userData.id = resData.id;
                                        userData.datetime = APLDevel.time();
                                        data[par].rows[index] = userData;
                                    }else{
                                        userData.id = resData.id;
                                        userData.datetime = APLDevel.time();
                                        data[par].rows.push(userData);
                                    } 
                                }else if (par == 'servMsg') {
                                    userData.id = resData.id;
                                    userData.bookTime = APLDevel.time();
                                    data[par].rows[index] = userData;
                                }else{
                                    data[par].rows[0] = userData;
                                }                                                               
                                setThis.setState({
                                    data:data
                                },function() {
                                    APLDevel.level();
                                });     
                                l_popup.close(ind);     
                            }                       
                        },
                        error:function() {
                            $('#preloader').hide();
                            l_status('error','保存失败');
                        }
                    })                    
                }
            });
        }
    </script>
    <script type="text/babel">
        var ServMsgItem = React.createClass({
            componentDidMount: function(){
                APLDevel.level();
            },
            modifyData:function(event){
                var par = $(event.target).attr('data-par');
                modifyData(par,this.props.data,this.props.index);
            },
            render:function(){
                var index = this.props.index;
                var user = this.props.data;
                return (
                       <li>
                            <button className="modify" onClick={this.modifyData} data-level="m" style={{'display': 'none','margin-right':'10px'}} data-par="servMsg">编辑</button>
                            <span style={{'color': 'red','margin-right':'10px'}}>操作时间：{user.bookTime}</span> 
                            <span>操作人：{user.oprName}</span>
                            <br/>
                            <span style={{'padding': '10px 0 0 10px','display': 'inline-block'}}>备注：
                                {user.way==1?'From服务商':user.way==2?'To服务商':user.way==3?'From客户':user.way==4?'TO客户':'内部备注'}
                                ：{user.remark}
                            </span>
                       </li>
                    )
            }
        })

        var ServMsg = React.createClass({
            servMsgSave:function(){
                servMsgSave()
            },
            render:function(){
                return (
                    <ul>
                        {this.props.data.map(function(user,index){
                            return <ServMsgItem data={user} index={index} />
                        })}
                        <li>
                            <span className="xxlx">信息流向：</span>
                            <input type="radio" name="1" value="1" /> From服务商
                            <input type="radio" name="1" value="2" /> To服务商
                            <input type="radio" name="1" value="3" /> From客户
                            <input type="radio" name="1" value="4" /> TO客户
                            <input type="radio" name="1" value="5" /> 内部备注
                            <br/><br/>
                            内容：<textarea></textarea>
                            <br/><br/>
                            <button onClick={this.servMsgSave}>提交</button>
                        </li>
                    </ul>
                )
             }
        })
        
        var ChargeList = React.createClass({
            modifyData:function(event){
                var par = $(event.target).attr('data-par');
                modifyData(par,this.props.data,this.props.index);
            },
            delData:function(event){
                var par = $(event.target).attr('data-par');
                delData(par,this.props.data.id,this.props.index);
            },
            render:function(){
                var index = this.props.index;
                var user = this.props.data;
                return (
                    <tr>
                       <td>
                            {user.way==1?'收入':'支出'}
                       </td>
                       <td>{user.dxId}</td>
                       <td>{user.GWT}</td>
                       <td>{user.VWT}</td>
                       <td>{user.CWT}</td>
                       <td>{user.vwtfm}</td>
                       <td>{user.chargeName}</td>
                       <td>{user.charge}</td>
                       <td>{user.currency}</td>
                       <td>{user.hl}</td>
                       <td>{user.chargeAcc}</td>
                       <td>{user.exp}</td>
                       <td>{user.priceName}</td>
                       <td>{user.remark}</td>
                       <td>{user.auditing}</td>
                       <td data-level="m" style={{'display': 'none'}}>
                            <a href="javascript:;" onClick={this.modifyData} data-par="chargeList">
                                <i className="layui-icon" style={{'font-size': '22px', 'color': '#E4393C'}}>&#xe642;</i> 修改
                            </a>
                        </td>
                        <td data-level="m" style={{'display': 'none'}}>
                            <a href="javascript:;" onClick={this.delData} data-par="chargeList"> 
                                删除
                            </a>
                        </td>
                    </tr> 
                )
            }  
        })

        var TrackList = React.createClass({
            modifyData:function(event){
                var par = $(event.target).attr('data-par');
                modifyData(par,this.props.data,this.props.index);
            },
            delData:function(event){
                var par = $(event.target).attr('data-par');
                delData(par,this.props.data.id,this.props.index);
            },
            render:function(){
                var index = this.props.index;
                var user = this.props.data;
                return (
                    <tr>
                       <td>{user.datetime}</td>
                       <td>{user.location}</td>
                       <td>{user.activity}</td>
                       <td data-level="m" style={{'display': 'none'}}>
                            <a href="javascript:;" onClick={this.modifyData} data-par="track">
                                <i className="layui-icon" style={{'font-size': '22px', 'color': '#E4393C'}}>&#xe642;</i> 修改
                            </a>
                        </td>
                        <td data-level="m" style={{'display': 'none'}}>
                            <a href="javascript:;" onClick={this.delData} data-par="track"> 
                                删除
                            </a>
                        </td>
                    </tr> 
                )
            }  
        })

        var Table = React.createClass({
            getInitialState: function () {
                return {
                    data: {
                        info:{
                            rows:[
                                {
                                    id:getId,
                                    checkinTime:"",
                                    type:"",
                                    inNoAll:"",                                   
                                    clientName:"",
                                    inCorpNo:"",
                                    inNo:"",
                                    webNo:"",
                                    shipServ:"",
                                    startShip:"",
                                    countryNo:"",
                                    countryCn:"",
                                    piece:"",
                                    inTransit:"",
                                    outtransit:"",
                                    inPackdoc:"",
                                    outPackDoc:"",
                                    worth:"",
                                    goods:"",
                                    postalCode:"",
                                    hxd:"",
                                    ywyName:"",
                                    outState:"",
                                    state:"",
                                    inOpr:"",
                                    trackState:"",
                                    payment:"",
                                    gain:"",
                                    outOpr:"",
                                    remark:"",
                                    inRemark:"",
                                    outRemark:"",
                                }
                            ]
                        },  
                        info2:{
                            rows:[
                                {
                                    fromCountryNo:"",
                                    fromCompany:"",
                                    fromMan:"",
                                    fromPhone:"",
                                    fromAddress:"",
                                    recipCompany:"",
                                    recipMan:"",
                                    recipMobile:"",
                                    recipPhone:"",
                                    recipEmail:"",
                                    recipAddress:"",
                                    recipAddress2:"",
                                    recipAddress3:"",
                                    toState:"",
                                    toCity:"",
                                    qty:"",
                                    insureValue:"",
                                    goodsInfo:""
                                }
                            ]
                        },
                        chargeList:{
                            rows:[]
                        },
                        oprLog:{
                            rows:[]
                        },
                        servMsg:{
                            rows:[]
                        }, 
                        track:{
                            rows:[]
                        },
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
            timerFocus:function(){
                WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});
            },
            modifyData:function(event){
                var par = $(event.target).attr('data-par');
                var user = {};
                switch(par){
                    case 'info':
                        user = this.state.data.info.rows[0];
                    break;
                    case 'info2':
                        user = this.state.data.info2.rows[0];
                    break;
                    case 'chargeList':
                        user = {
                            id:0,
                            way:"",
                            dxId:"",
                            GWT:"",
                            VWT:"",
                            CWT:"",
                            vwtfm:"",
                            chargeName:"",
                            charge:"",
                            currency:"",
                            hl:"",
                            chargeAcc:"",
                            exp:"",
                            priceName:"",
                            remark:"",
                            auditing:"",
                        };
                    break;
                    case 'track':
                        user = {
                            id:0,
                            location:"",
                            activity:"",
                        };
                    break;
                }
                modifyData(par,user);
            },
            render:function(){
                var data = this.state.data.info.rows[0];
                var data2 = this.state.data.info2.rows[0];
                return (
                    <div>
                        <div className="apl-tool">
                            <button type="button" className="layui-btn layui-btn-small layui-btn-normal" onClick={this.Return}>关闭</button>
                        </div>
                        <p style={{'margin': '10px','color':'red','font-weight': 'bold','font-size': '16px'}}>基本信息：<button className="modify" onClick={this.modifyData} data-level="m" style={{'display': 'none'}}
                        data-par="info">修改</button></p>
                        <form>
                            <table cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>下单日期</td>
                                    <td>
                                        {data.checkinTime}
                                    </td>
                                    <td>订单类型</td>
                                    <td>
                                        {data.type==1?'快递':'空运'}
                                    </td>
                                    <td>入库批号</td>
                                    <td>
                                        {data.inNoAll}
                                    </td> 
                                    <td>客户简称</td>
                                    <td>
                                        {data.clientName}
                                    </td>                      
                                </tr>
                                <tr>
                                    <td>客户单号</td>
                                    <td>
                                        {data.inCorpNo}
                                    </td> 
                                    <td>运单号</td>
                                    <td>
                                        {data.inNo}
                                    </td>
                                    <td>转单号</td>
                                    <td>
                                        {data.webNo}
                                    </td>
                                     <td>附加项目</td>
                                    <td>
                                        {data.shipServ}
                                    </td>
                                </tr> 
                                <tr>
                                    <td>起运地</td>
                                    <td>
                                        {data.startShip}
                                    </td>
                                    <td>国家简码</td>
                                    <td>
                                        {data.countryNo}
                                    </td>
                                    <td>国家名</td>
                                    <td>
                                        {data.countryCn}
                                    </td> 
                                    <td>件数</td>
                                    <td>
                                        {data.piece}
                                    </td>
                                </tr>  
                                <tr>
                                    <td>收渠道类型</td>
                                    <td>
                                        {data.inTransit}
                                    </td>
                                    <td>出渠道类型</td>
                                    <td>
                                        {data.outtransit}
                                    </td>
                                    <td>收裹类型</td>
                                    <td>
                                        {data.inPackdoc}
                                    </td>                    
                                    <td>出裹类型</td>
                                    <td>
                                        {data.outPackDoc}
                                    </td>
                                </tr>      
                                <tr>
                                    <td>总申报价值</td>
                                    <td>
                                        {data.worth}
                                    </td>                    
                                    <td>品名</td>
                                    <td>
                                        {data.goods}
                                    </td>
                                    <td>邮编</td>
                                    <td>
                                        {data.postalCode}
                                    </td>
                                    <td>核销单</td>
                                    <td>
                                        {data.hxd}
                                    </td>
                                </tr>      
                                <tr>
                                    <td>业务员</td>
                                    <td>
                                        {data.ywyName}
                                    </td>
                                    <td>出货状态</td>
                                    <td>
                                        {data.outState}
                                    </td>                    
                                    <td>状态</td>
                                    <td>
                                        {data.state}
                                    </td>
                                     <td>收货员</td>
                                    <td>
                                        {data.inOpr}
                                    </td>
                                </tr>
                                <tr>
                                    <td>上网状态</td>
                                    <td>
                                        {data.trackState}
                                    </td>
                                    <td>付款结算</td>
                                    <td>
                                        {data.payment}
                                    </td>                    
                                    <td>毛利</td>
                                    <td>
                                        {data.gain}
                                    </td>   
                                     <td>出货员</td>
                                    <td>
                                        {data.outOpr}
                                    </td>                  
                                </tr>                
                                <tr>
                                    <td>内部备注</td>
                                    <td colSpan="7">
                                        {data.remark}
                                    </td>                                   
                                </tr>
                                <tr>
                                    <td>收货备注</td>
                                    <td colSpan="7">
                                        {data.inRemark}
                                    </td> 
                                </tr> 
                                <tr>
                                    <td>出货备注</td>
                                    <td colSpan="7">
                                        {data.outRemark}
                                    </td> 
                                </tr>                                                
                            </table>                          
                        </form>

                        <p style={{'margin': '10px','color':'red','font-weight': 'bold','font-size': '16px'}}>基本信息2：<button className="modify" onClick={this.modifyData} data-level="m" style={{'display': 'none'}}
                        data-par="info2">修改</button></p>
                        <form>
                            <table cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>寄件国家</td>
                                    <td>
                                        {data2.fromCountryNo}
                                    </td>
                                    <td>寄件人公司</td>
                                    <td>
                                         {data2.fromCompany}
                                    </td>
                                    <td>寄件人名</td>
                                    <td>
                                        {data2.fromMan}
                                    </td>                   
                                </tr>
                                <tr>
                                    <td>寄个人电话</td>
                                    <td>
                                        {data2.fromPhone}
                                    </td>                    
                                    <td>寄件人地址</td>
                                    <td>
                                        {data2.fromAddress}
                                    </td>
                                    <td>收件人公司</td>
                                    <td>
                                        {data2.recipCompany}
                                    </td>
                                </tr> 
                                <tr>
                                    <td>收件人名</td>
                                    <td>
                                        {data2.recipMan}
                                    </td>                    
                                    <td>收件人手机</td>
                                    <td>
                                        {data2.recipMobile}
                                    </td>
                                    <td>收件人电话</td>
                                    <td>
                                        {data2.recipPhone}
                                    </td>
                                </tr>  
                                <tr>
                                    <td>收件人邮箱</td>
                                    <td>
                                        {data2.recipEmail}
                                    </td>                    
                                    <td>收件地址1行</td>
                                    <td>
                                        {data2.recipAddress}
                                    </td>
                                    <td>收件地址2行</td>
                                    <td>
                                        {data2.recipAddress2}
                                    </td>
                                </tr> 
                                <tr>
                                    <td>收件地址3行</td>
                                    <td>
                                        {data2.recipAddress3}
                                    </td>                    
                                    <td>州(省)</td>
                                    <td>
                                        {data2.toState}
                                    </td>
                                    <td>城市</td>
                                    <td>
                                        {data2.toCity}
                                    </td>
                                </tr>      
                                <tr>
                                    <td>数量</td>
                                    <td>
                                        {data2.qty}
                                    </td>                    
                                    <td>投保值</td>
                                    <td>
                                        {data2.insureValue}
                                    </td>
                                    <td>申报明细</td>
                                    <td>
                                        {data2.goodsInfo}
                                    </td>
                                </tr>                                     
                            </table>                          
                        </form>
                        
                        <div id="tabServMsg" style={{'display':(data.id==0?'none':'')}}>
                            <p style={{'margin': '10px','color':'red','font-weight': 'bold','font-size': '16px'}}>留言信息：</p>
                            <ServMsg data={this.state.data.servMsg.rows} />
                        </div>   
                         
                        <div id="tabOprLog" className="tdCenter" style={{'display':(data.id==0?'none':'')}}>
                            <p style={{'margin': '10px','color':'red','font-weight': 'bold','font-size': '16px'}}>操作日志：</p>
                            <table class="apl-tableSpecial">
                                <tr>
                                    <th>日期</th>
                                    <th>内容1</th>
                                    <th>内容2</th>
                                    <th>操作人</th>
                                </tr>
                                {this.state.data.oprLog.rows.map(function(user,index){
                                    return (
                                        <tr>
                                            <td>{user.oprTime}</td>
                                            <td>{user.content1}</td>
                                            <td>{user.content2}</td>
                                            <td>{user.oprName}</td>
                                        </tr> 
                                    )
                                })} 
                            </table> 
                        </div> 

                        <div id="tabChargeList" className="tdCenter">
                            <p style={{'margin': '10px','color':'red','font-weight': 'bold','font-size': '16px'}}>重量及费用：<button className="modify" onClick={this.modifyData} data-level="m" style={{'display': 'none'}}
                            data-par="chargeList">添加</button></p>
                            <table className="apl-tableSpecial">
                                <tr>
                                    <th>方向</th>
                                    <th>服务商</th>
                                    <th>实重</th>
                                    <th>体积重</th>
                                    <th>计费重</th>
                                    <th>体基</th>
                                    <th>费用名</th>
                                    <th>金额</th>
                                    <th>币制</th>
                                    <th>汇率</th>
                                    <th>销账</th>
                                    <th>公式</th>
                                    <th>渠道</th>
                                    <th>备注</th>
                                    <th>审核</th>
                                    <td data-level="m" style={{'display': 'none'}}><i className="layui-icon">&#xe642;</i> 修改</td>
                                    <td data-level="m" style={{'display': 'none'}}>删除</td>
                                </tr>
                                {this.state.data.chargeList.rows.map(function(user,index){
                                    return <ChargeList data={user} index={index} />
                                })}                                              
                            </table>
                        </div>

                        <div id="tabTrack" className="tdCenter">
                            <p style={{'margin': '10px','color':'red','font-weight': 'bold','font-size': '16px'}}>转运信息：<button className="modify" onClick={this.modifyData} data-level="m" style={{'display': 'none'}}
                            data-par="track">添加</button></p>
                            <table className="apl-tableSpecial">
                                <tr>
                                    <th>日期时间</th>
                                    <th>转运地点</th>
                                    <th>转运信息</th>
                                    <td data-level="m" style={{'display': 'none'}}><i className="layui-icon">&#xe642;</i> 修改</td>
                                    <td data-level="m" style={{'display': 'none'}}>删除</td>
                                </tr>
                                {this.state.data.track.rows.map(function(user,index){
                                    return <TrackList data={user} index={index} />
                                })}                                        
                            </table>
                        </div>               
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