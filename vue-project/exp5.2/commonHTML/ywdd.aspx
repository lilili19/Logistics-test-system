<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta http-equiv ="Content-Type" Content="text/html; charset=utf-8">
    <title>提货单</title>
    <link rel="stylesheet" href="../../plugins/layui2/css/layui.min.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">
    <link rel="stylesheet" href="../css5.2/common.css">
    <link rel="stylesheet" href="../css5.2/index.min.css">
    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css"> 
</head>
<body> 
    <div id="pagingSorting" style="display: none;">ywdd</div>

    <div id="preloader">
        <img src="../../images/load.gif" alt="">
    </div>
    <section style="width: auto;">
        <div id="exp">
            <div class="listParamBox">
                <select aplDataName="type" onChange="ad.doList(1)">
                    <option value="">类型</option>
                    <option value="1">快递</option>
                    <option value="2">空运</option>
                </select>&nbsp;&nbsp;
                日期：<input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="dateStart" class="input-text Wdate" style="width: 150px;">&nbsp;至&nbsp;<input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" type="text" aplDataName="dateEnd" class="input-text Wdate" style="width: 150px;">
                &nbsp;&nbsp;&nbsp;
                订单号：<input type="text" aplDataName="ddNo">
                &nbsp;&nbsp;
                提货人：<input type="text" aplDataName="thName">
                <br><br>                
                业务员：<input type="text" id="ywyName" aplDataName="ywyName">
                <input type="hidden" aplDataName="ywy" id="ywy" corre="ywyName">
                <button type="button" onclick="sbo.go2('user','#ywyName','c2', '#ywy', 'id')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
                &nbsp;&nbsp;
                客户：<select dataName="clientId" onChange="ad.doList(1)">
                            <option value="0">所有</option>
                            <option value="1">待提货</option>
                            <option value="2">自送货</option>
                            <option value="3">提货中</option>
                            <option value="4">已提货</option>
                            <option value="5">已入库</option>
                            <option value="6">无效的</option>
                      </select>
                &nbsp;&nbsp;
                关键字：<input type="text" aplDataName="key" />&nbsp;&nbsp;
                <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" @click="modifyData(0)" value="添加" style="padding: 5px;display: none;" level="m">
                <br><br>
            </div>
            <table cellspacing="0" cellpadding="0" width="">
                <thead>
                    <tr>
                        <td>订单类型</td>
                        <td>创建日期</td>
                        <td>状态</td>
                        <td>订单号</td>
                        <td>预约时间</td>
                        <td>提货人</td>
                        <td>提货费</td>
                        <td>重量</td>
                        <td>业务员</td>
                        <td>客户简称</td>
                        <td>区域</td>
                        <td>地址</td>
                        <td>电话</td>
                        <td>手机</td>
                        <td>联系人</td>
                        <td>备注</td>
                    </tr>
                </thead>
                <tbody>
                <tr v-for="(row,index) in rows">
                    <td>
                        <span v-if="row.type==1">快递</span>
                        <span v-if="row.type==2">空运</span>
                    </td>
                    <td>{{row.createTime}}</td>
                    <td>
                        <span v-if="row.state==1">已发货</span>
                        <span v-if="row.state==0">未发货</span>
                    </td>
                    <td>
                        <strong style="color: red;cursor: pointer;" @click="modifyData(row.ddId)">{{row.ddNo}}
                        </strong>
                    </td>
                    <td>{{row.proceedTime}}</td>
                    <td>{{row.thName}}</td>
                    <td>{{row.pickCharge}}</td>
                    <td>{{row.wt}}</td>                       
                    <td>{{row.ywyName}}</td>
                    <td>{{row.clientName}}</td>
                    <td>{{row.area}}</td>
                    <td>{{row.address}}</td>
                    <td>{{row.phone}}</td>
                    <td>{{row.mobile}}</td>
                    <td>{{row.linkman}}</td>
                    <td>{{row.remark}}</td>
                </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="18">
                            <div id="pager">
                                <ul class="pages">
                                    <!-- <div>首页</div>
                                    <p>上一页</p>                                      
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                    <p>下一页</p>
                                    <div>尾页</div>
                                    <span>总共5条数据</span> -->
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
    </section>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../js/vue.min.js"></script>
    <script src="../../plugins/layui2/layui.min.js"></script>
    <script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
    <script src="../../plugins/WdatePicker/WdatePicker.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="../js/common.js"></script> 
    <script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
</body>
</html>