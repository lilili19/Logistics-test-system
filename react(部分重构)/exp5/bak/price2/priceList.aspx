<%@ Inherits="APLViewCheck.checkLogin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>快递价格管理</title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/apl-common.css">
    <style>
        #layerContent{
            padding: 15px;
        }
        #layerContent p{
            margin: 5px 0;
            padding: 5px 0;
            border-bottom: 1px dashed #ddd;
        }
        #layerContent p:hover{
            border-bottom: 1px solid #E4393C;
        }
        #layerContent span{
            display: inline-block;
            height: 30px;
            width: 80px;
        }
        #layerContent input{
            padding: 0 5px;
            height: 30px;
            width: 180px;
            border: 1px solid #ddd;
        }
        #layerContent input:focus{
            border: 1px solid #E4393C;
        }
    </style>
</head>
<body>
    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <section id="main">
        <div class="content">
            <div id="apl">
                <div class="listParamBox">
                关键字 <input type="text" aplDataName="key" style="height: 30px;text-indent: 5px;" />&nbsp;&nbsp;
                <input type="button" onClick="ad.doList(1)" value="搜索" style="padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" onClick="dlgAdd()" value="添加" style="padding: 5px;">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" onClick="delRow()" value="删除" style="padding: 5px;">
                </div> <br><br>
                <table cellspacing="0" cellpadding="0" id="tabList">
                    <thead>
                    <tr>
                        <td width="20"><input type="checkbox" onclick="APLDevel.checkAll('#tabList', this)" ></td>
                        <td>详细</td>
                        <td>客户组</td>
                        <td>客户组</td>
                        <td>渠道类型</td>
                        <td>报价名</td>
                        <td>销售名称</td>
                        <td>币制</td>
                        <td>体积系数</td>
                        <td>销售系数</td>
                        <td>截止日期</td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="row in rows">
                        <td width="20"><input type="checkbox" :value="row.id"></td>
                        <td>
                            <a href="javascript:;" @click="detailData(row.id)">详细</a>
                        </td>
                        <td>{{row.cg0}}</td>
                        <td>{{row.cg1}}</td>
                        <td>{{row.transit}}</td>
                        <td>{{row.priceName}}</td>
                        <td>{{row.priceNo}}</td>
                        <td>{{row.currency}}</td>
                        <td>{{row.VWTFM}}</td>
                        <td>{{row.SaleCoeffi}}</td>
                        <td>{{row.dateEnd}}</td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="13">
                            <div id="pager">
                                <ul class="pages"></ul>
                            </div>
                            <div>
                                <select id="selPageSize">
                                    <option value="5" selected>5</option>
                                    <option value="10">10</option>
                                    <option value="15">15</option>
                                    <option value="20">20</option>
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
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="priceList.js"></script>
</body>
</html>