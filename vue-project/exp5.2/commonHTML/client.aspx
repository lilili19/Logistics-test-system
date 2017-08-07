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
</head>
<body> 
    <div id="pagingSorting" style="display: none;">client</div>

    <div id="preloader">
        <img src="../../images/load.gif" alt="">
    </div>
    <section id="main" style="width: 95%;">
        <div class="content" style="width: 100%;">
            <div id="exp">
                <div class="listParamBox">
                    <select aplDataName="state" onChange="ad.doList(1)" style="height: 30px;">
                        <option value="1">有效的</option>
                        <option value="0">无效的</option>
                    </select>&nbsp;&nbsp;
                    <select aplDataName="auditing" onChange="ad.doList(1)" style="height: 30px;">
                        <option value="">审核状态</option>
                        <option value="1">已审的</option>
                        <option value="0">未审的</option>
                    </select>&nbsp;&nbsp;

                    业务员：<input type="text" style="height: 30px;text-indent: 5px;" id="ywyName" aplDataName="ywyName">
                    <input type="hidden" aplDataName="ywy" id="ywy" corre="ywyName">
                    <button type="button" onclick="sbo.go2('user','#ywyName','c2', '#ywy', 'id')" title="搜索" level="m" class="layui-btn layui-btn-mini" style="line-height: 16px;"><i class="layui-icon"></i></button>
                    &nbsp;&nbsp;
                    关键字 <input type="text" aplDataName="key" style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
                    <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" @click="modifyData(0)" value="添加" style="padding: 5px;display: none;" level="m">
                    <br><br>
                </div>
                <table cellspacing="0" cellpadding="0" width="100%">
                    <thead>
                        <tr>
                            <td>客户编号</td>
                            <td>客户简称</td>
                            <td>业务员</td>
                            <td>状态</td>
                            <td>审核</td>
                            <td level="m" style="display: none;"><i class="layui-icon" style="color: #333;">&#xe642;</i> 详细</td>
                        </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(row,index) in rows">                
                        <td>{{row.clientNo}}</td>
                        <td>{{row.clientName}}</td>
                        <td>{{row.ywyName}}</td>
                        <td>{{row.state}}</td>
                        <td>{{row.auditing}}</td>
                        <td level="m" style="display: none;">
                            <a href="javascript:;" @click="modifyData(row.id)">                 
                                <i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 详细
                            </a>
                        </td>
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
        </div>
    </section>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../js/vue.min.js"></script>
    <script src="../../plugins/layui2/layui.min.js"></script>
    <script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="../js/common.js"></script> 
    <script>
        var sbo = new SearchBox();
        sbo.url = "/search/doSearch";
    </script>
</body>
</html>