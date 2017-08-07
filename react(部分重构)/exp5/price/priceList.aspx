<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>快递价格管理</title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/apl-common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">

    <link rel="stylesheet" href="../../css/common.css"> 
    <link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">
    <link rel="stylesheet" href="../../l_popup_tips/l_popup_tips.css">
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
        .section select{height: 31px;}
        .section2 select{height: 31px;}
        .section input{height: 30px;text-indent: 5px;}
        .section2 input{height: 30px;text-indent: 5px;}
        .section button{padding: 5px;}
        .section2 button{padding: 5px;}
        .section3 input{text-align: center;}


        .apl-tab-title li.layui-this{
            color: #E4393C;
            background: #fff;
        }
       
        .apl-tab-title {
            background: #aaa;
            position: relative;
            left: 0;
            height: 40px;
            white-space: nowrap;
            font-size: 0;
            border-bottom: 1px solid #e2e2e2;
            transition: all .2s;
            -webkit-transition: all .2s;
        }
        .apl-tab-title li {
            font-weight: bold;
            letter-spacing: 5px;
            color: #fff;
            font-size: 16px;
            transition: all .3s;
            -webkit-transition: all .3s;
            position: relative;
            line-height: 40px;
            min-width: 65px;
            padding: 0 10px;
            display: inline-block;
            vertical-align: middle;
            cursor: pointer;
            text-align: center;
        }
        .section2 table{width: 70%;margin: 15px auto;border: 1px solid #ccc;text-align: center;}
        .section3 table{width: 70%;margin: 15px auto;border: 1px solid #ccc;text-align: center;}
        .newRow{display: none;}
        .tabSaleCoeffi table td>select{width: 70px;}
    </style>
</head>
<body>
    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <ul class="apl-tab-title">
        <li onClick="aplTab(this,'region')">分区表</li>
        <li onClick="aplTab(this,1)" class="layui-this">销售价</li>
        <li onClick="aplTab(this,3)">客户价</li>
        <li onClick="aplTab(this,4)">成本价</li>
        <li onClick="aplTab(this,7)">公布价模版</li>
        <li onClick="aplTab(this,'saleCoeffi')">销售系数</li>
    </ul>
    <div id="apl">
        <section  class="section">
            <div class="content">
                <div>
                    <div class="listParamBox">
                    <select aplDataName="state" onChange="ad.doList(1)">
                        <option value="0">状态</option>
                        <option value="1">有效的</option>
                        <option value="2">无效的</option>
                        <option value="3">已过期</option>
                    </select>
                    <select aplDataName="VWTFM"  onChange="ad.doList(1)">
                        <option value="">体积系数</option>
                        <option value="5000">5000</option>
                        <option value="5500">5500</option>
                        <option value="6000">6000</option>
                        <option value="6500">6500</option>
                        <option value="7000">7000</option>
                        <option value="7500">7500</option>
                        <option value="8000">8000</option>
                        <option value="8500">8500</option>
                        <option value="9000">9000</option>
                        <option value="9500">9500</option>
                    </select>
                    <select aplDataName="transit" onChange="ad.doList(1)">
                        <option value="">渠道类型</option>
                        <option v-for="row in tabTransit" :value="row.transit">{{row.transit}}</option>
                    </select>
                    <select aplDataName="clientGroupId" id="clientGroupId" style="display: none;" aplName="1" onChange="ad.doList(1)">
                        <option value="">客户组</option>
                        <option v-for="row in tabClientGroup" :value="row.id">{{row.clientGroup}}</option>
                    </select>
                    <span id="spanClient" style="display: none;" aplName="3"> 
                        &nbsp;&nbsp;&nbsp;&nbsp;客户&nbsp;<input type="text" id="clientName" > 
                        <input type="hidden"  aplDataName="clientId" id="clientId" >
                        <button onClick="sbo.go2('client','#clientId','id','#clientName','c2')" class="layui-btn layui-btn-mini" style="padding: 3px;">
                            <i class="layui-icon"></i>
                        </button>
                    </span>
                    <span id="spanCoagent" style="display: none;" aplName="4"> 
                        &nbsp;&nbsp;&nbsp;&nbsp;服务商&nbsp;<input type="text" id="coagentName" aplDataName="coagentName"  > 
                        <input type="hidden"  aplDataName="coagentId" id="coagentId" corre="coagentName"  >
                        <button onClick="sbo.go2('coagent','#coagentId','id','#coagentName','c3')" class="layui-btn layui-btn-mini" style="padding: 3px;">
                            <i class="layui-icon"></i>
                        </button>              
                    </span>
                    关键字 <input type="text" aplDataName="key"/>&nbsp;&nbsp;
                    <button onClick="ad.doList(1)">搜索</button>&nbsp;&nbsp;
                    <!-- <button onClick="dlgAdd('price')">添加</button>&nbsp;&nbsp; -->
                    <button onClick="delRow('price')" style="display: none;" level="m">删除</button>
                    </div> <br><br>
                    <table cellspacing="0" cellpadding="0" id="tabList">
                        <thead>
                        <tr>
                            <td width="20"><input type="checkbox" onclick="APLDevel.checkAll('#tabList', this)" ></td>
                            <td>详细</td>
                            <td id="dxTitle">客户组</td>
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
                        <tr v-for="(row,index) in priceListData">
                            <td width="20"><input type="checkbox" :value="row.id"></td>
                            <td>
                                <a href="javascript:;" @click="priceInfo(row.id)">详细</a>
                            </td>
                            <td>{{row.dxName}}</td>
                            <td>{{row.transit}}</td>
                            <td><a href="###" style="color: black;" @click="priceIdUrl(index)">{{row.priceName}}</a></td>
                            <td>{{row.priceNo}}</td>
                            <td>{{row.currency}}</td>
                            <td>{{row.VWTFM}}</td>
                            <td>{{row.SaleCoeffi}}</td>
                            <td doData>{{row.dateEnd}}</td>
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
                                        <option value="15" selected>15</option>
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

        <section style="display: none;"  class="section2">
            <select aplDataName="state" onChange="ad.doList(1)">
                <option value="0">状态</option>
                <option value="1">有效的</option>
                <option value="2">无效的</option>
                <option value="3">已过期</option>
            </select>
            <select aplDataName="transit" onChange="ad.doList(1)">
                <option value="">渠道类型</option>
                <option v-for="row in tabTransit" :value="row.transit">{{row.transit}}</option>
            </select>

            关键字 <input type="text" aplDataName="key"/>&nbsp;&nbsp;
            <button onClick="ad.doList(1)">搜索</button>&nbsp;&nbsp;
            <button onClick="dlgAdd('region')" level="m" style="display: none;">添加</button>&nbsp;&nbsp;
            <button onClick="delRow('region')" level="m" style="display: none;">删除</button>

            <table cellspacing="0" cellpadding="0" id="tabList2">
                <thead>
                    <tr>
                        <td width="20"><input type="checkbox" onclick="APLDevel.checkAll('#tabList2', this)" ></td>
                        <td>渠道类型</td>
                        <td>分区表名称</td>
                        <td level="m" style="display: none;">
                            <i class="layui-icon" style="color: #333;">&#xe642;</i> 修改
                        </td>
                        <td level="m" style="display: none;">删除</td>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(row,index) in regionListData">
                        <td width="20"><input type="checkbox" :value="row.id"></td>
                        <td>{{row.transit}}</td>
                        <td><a href="###" onclick="window.open('/aspx/exp2/regionact.aspx?RegionID='+$(this).parent().prev().prev().find('input').val())">{{row.regionName}}</a></td>
                        <td width="10%" level="m" style="display: none;">
                            <a href="javascript:;" @click="editData('region', index)">                    
                                <i class="layui-icon" style="font-size: 22px; color: #E4393C;">&#xe642;</i> 修改
                            </a>
                        </td>
                        <td width="10%" level="m" style="display: none;">
                            <a href="javascript:;" @click="delRowVue('region', row.id)">                    
                                删除
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="13">
                            <div id="pager">
                                <ul class="pages pages2"></ul>
                            </div>
                            <div style="text-align: left;">
                                <select id="selPageSize2">
                                    <option value="15" selected>15</option>
                                    <option value="20">20</option>
                                </select>
                            </div>
                            
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section style="display: none;"  class="section3">
            <div class="apl-table">
                <div class="layui-tab layui-tab-card">
                    <ul class="layui-tab-title">
                        <li class="layui-this">销售系数</li>
                    </ul>
                    <div class="layui-tab-content">
                        <!--销售系数-->
                        <div class="layui-tab-item layui-show">
                            <table class="apl-tableSpecial" id="tabSaleCoeffi">
                                <thead>
                                    <tr>
                                        <td  style="display: none;" level="m">编辑</td>
                                        <td><span>客户组</span></td>
                                        <td><span>计费</span></td>
                                        <td><span>国家</span></td>
                                        <td><span>分区</span></td>
                                        <td><span>起始重</span></td>
                                        <td><span>截止重</span></td>
                                        <td><span>首重加</span></td>
                                        <td><span>单位重加</span></td>
                                        <td><span>比例加</span></td>
                                        <td><span>每票加</span></td>
                                        <td  style="display: none;" level="m">删除</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="row in salesListData">
                                        <td align="cetner"  style="display: none;" level="m">
                                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)">编 辑</button>
                                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow('saleCoeffi',this)" style="display: none;">保 存</button>
                                            <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                        </td>
                                        <td>
                                            <select name="clientGroupId" disabled="true" aplDataName="clientGroupId" v-model="row.clientGroupId" Verification="1-10" onblur="vertionCell(this)">
                                                <option value="">请选择</option>
                                                <option v-for="item in tabClientGroup" :value="item.id">{{item.clientGroup}}</option>
                                            </select>                                                                  
                                        </td>
                                        <td>
                                            <input type="number" name="meterageId" disabled="true" aplDataName="meterageId" v-model="row.meterageId" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                        </td>
                                        <td>
                                            <input type="text" name="countryNo" disabled="true" aplDataName="countryNo" v-model="row.countryNo" placeholder="限制10位" Verification="0-10" onblur="vertionCell(this)">
                                        </td>
                                        <td>
                                            <input type="text" name="region" disabled="true" aplDataName="region" v-model="row.region" placeholder="限制15位" Verification="0-15" onblur="vertionCell(this)">
                                        </td>
                                        <td>
                                            <input type="number" name="wtStart" disabled="true" aplDataName="wtStart" v-model="row.wtStart" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                        </td>
                                        <td>
                                            <input type="number" name="wtEnd" disabled="true" aplDataName="wtEnd" v-model="row.wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                        </td>
                                        <td>
                                            <input type="number" name="price1st" disabled="true" aplDataName="price1st" v-model="row.price1st" placeholder="9999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,2)">
                                        </td>
                                        <td>
                                            <input type="number" name="priceAdd" disabled="true" aplDataName="priceAdd" v-model="row.priceAdd" placeholder="9999999内" Verification="-9999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,2)">
                                        </td>
                                        <td>
                                            <input type="number" name="propo" disabled="true" aplDataName="propo" v-model="row.propo" placeholder="99内" Verification="-99" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,4)">
                                        </td>
                                       <td>
                                            <input type="text" name="cauda" disabled="true" aplDataName="cauda" v-model="row.cauda" placeholder="限制15位" Verification="0-15" onblur="vertionCell(this)">
                                        </td>                                        
                                        <td width="5%"  style="display: none;" level="m">
                                            <a href="javascript:;" onclick="delRow('saleCoeffi', 'rowId', this)">删 除</a>
                                        </td>
                                    </tr>
                                    <tr class="newRow">
                                        <td align="cetner"  style="display: none;" level="m">
                                            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow('saleCoeffi',this)" >保 存</button>
                                            <input type="hidden" aplDataName="rowId"/>
                                        </td>
                                        <td>
                                            <select aplDataName="clientGroupId" Verification="1-10" onblur="vertionCell(this)">
                                                <option value="">请选择</option>
                                                <option v-for="row in tabClientGroup" :value="row.id">{{row.clientGroup}}</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="number" aplDataName="meterageId" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                        </td>
                                        <td>
                                            <input type="text" aplDataName="countryNo"  placeholder="限制10位" Verification="0-10" onblur="vertionCell(this)">
                                        </td>
                                        <td>
                                            <input type="text" aplDataName="region" placeholder="限制15位" Verification="0-15" onblur="vertionCell(this)">
                                        </td>
                                        <td>
                                            <input type="number" aplDataName="wtStart"  placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                        </td>
                                        <td>
                                            <input type="number" aplDataName="wtEnd"  placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                        </td>
                                        <td>
                                            <input type="number" aplDataName="price1st" placeholder="9999999内" Verification="-9999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,2)">
                                        </td>
                                        <td>
                                            <input type="number" aplDataName="priceAdd" placeholder="9999999内" Verification="-9999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,2)">
                                        </td>
                                        <td>
                                            <input type="number" aplDataName="propo"  placeholder="99内" Verification="-99" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,4)">
                                        </td>
                                        <td>
                                            <input type="text" aplDataName="cauda"  placeholder="限制15位" Verification="0-15" onblur="vertionCell(this)">
                                        </td>
                                        <td width="5%"  style="display: none;" level="m">
                                            <a href="javascript:;" onclick="delRow('saleCoeffi', 'rowId', this)">删 除</a>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="12" style="text-align: left;">
                                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabSaleCoeffi',3)"  style="display: none;" level="m">新增</button>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                    </div>
                </div>
            </div>
        </section>

        <div style="display: none;" id="regionInfoBox">
            <div id="layuiContent">
                <form>
                    <p style="display: none;">
                        <span>状态：</span>
                        <select aplDataName="state">
                            <option value="0"></option>
                            <option value="1">有效的</option>
                            <option value="2">无效的</option>
                            <option value="3">已过期</option>
                        </select>
                    </p>
                    <p>
                        <span>渠道类型：</span>
                        <select aplDataName="transit" style="height: 30px;" v-model="regionInfoData.transit">
                            <option value="">渠道类型</option>
                            <option v-for="row in tabTransit" :value="row.transit">{{row.transit}}</option>
                        </select>                      
                    </p>
                    <p>
                        <span>分区表名称：</span>
                        <input type="text" :value="regionInfoData.regionName" aplDataName="regionName" placeholder="输入限制2-20位" Verification="2-20">

                    </p>
                </form>
            </div>
        </div>
    </div>    

    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../plugins/layer/layer.min.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="priceList.js"></script>
</body>
</html>