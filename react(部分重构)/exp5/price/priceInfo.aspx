<!DOCTYPE html>
<%@ Inherits="LevelApp.checkLevel" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">

    <link rel="stylesheet" href="../../exp5.2/css5.2/common.css">  
    <link rel="stylesheet" href="../../exp5.2/css5.2/index.min.css">  
    <link rel="stylesheet" href="../../css/popup.css">

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

        #labelList{
            overflow: hidden;
        }
        #labelList>div{
            padding: 0 10px;
        }
        #labelList>div button{
            height: 30px;
            line-height: 30px;
        }
        #labelList select{
            height: 30px;
            color: #f60;
            font-weight: bold;
        }
        #labelList fieldset{
            padding: 5px;
            width: 250px;
            border: 1px solid #ccc;
            margin: 10px;
            float: left;
        }
        #labelList fieldset textarea{
            padding: 5px;
            width: 240px;
            border: 1px solid #ddd;
            color: #f60;
            font-weight: bold;
        }
        .newRow{display: none;}
        .tabSaleCoeffi table td>select{width: 70px;}
        #infoBox input[type="checkbox"]{vertical-align: text-top;margin-top: 2px;}
    </style>
</head>
<body>
    <div id="preloader" style="display: none">
        <img src="../../img/load.gif" alt="">
    </div>
    <div id="app">
        <div class="apl-tool">
            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" onclick="saveInfo()" style="display: none;" level="m">保存</button>
            <!-- <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="parent.APLDevel.closeDlg();if(isSaveInfo==1) parent.ad.doList(1)">关闭</button> -->
            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="parent.l_popup.close(0);if(isSaveInfo==1) parent.ad.doList(1)">关闭</button>
        </div>
        <div class="apl-table">
            <div class="layui-tab layui-tab-card">
                <ul class="layui-tab-title">
                    <li class="layui-this">基本信息</li>
                    <li>公式</li>
                    <li>销售系数</li>
                    <li>重量段</li>
                    <li>附加费</li>
                    <li>地址标签</li>
                </ul>
                <div class="layui-tab-content">
                    <!--基本信息-->
                    <div class="layui-tab-item layui-show">
                        <form id="infoBox" class="infoBox">
                            <table>
                                <tbody>
                                <!--第1行-->
                                <tr>
                                    <td aplName1st>报价名称</td>
                                    <td>
                                        <input type="text" aplDataName="priceName"  :value="info.priceName" placeholder="请输入2-55位" Verification="2-55">
                                    </td>
                                    <td aplName1st>销售名称</td>
                                    <td>
                                        <input type="text" aplDataName="priceNo" v-model="info.priceNo" placeholder="限制55位" Verification="0-55">
                                    </td>
                                    <td aplName1st>有效日期</td>
                                    <td>
                                        <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" v-model="info.dateStart" class="input-text Wdate" style="width:150px; height: 25px; padding-left: 5px;" type="text" aplDataName="dateStart" placeholder="不能为空" Verification="1-50">
                                        至
                                        <input onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"  v-model="info.dateEnd" class="input-text Wdate" style="width:150px; height: 25px; padding-left: 5px;" type="text" aplDataName="dateEnd" placeholder="不能为空" Verification="1-50">
                                    </td>
                                </tr>

                                <!--第2行-->
                                <tr>
                                    <td aplName1st>报价代码</td>
                                    <td>
                                        <input type="text" aplDataName="priceCode"  v-model="info.priceCode" placeholder="限制20位" Verification="0-20">
                                    </td>
                                    <td aplName1st>渠道类型</td>
                                    <td>
                                        <select aplDataName="transit" v-model="info.transit" Verification="1-20">
                                            <option value="">-- 请选择 --</option>
                                            <option v-for="row in tabTransit" v-bind:value="row.transit">{{row.transit}}</option>
                                        </select>
                                    </td>
                                    <td aplName1st>分区表</td>
                                    <td>
                                        <input type="text" v-model="info.regionName" aplDataName="regionName">
                                        <input type="hidden" aplDataName="regionId" corre="regionName" v-model="info.regionId"  nullVal="0">
                                        <button type="button" onclick="sbo.boxData=app.info;sbo.go2('region','regionName','c2', 'regionId', 'id')" class="layui-btn layui-btn-mini" title="搜索"  style="display: none;" level="m"><i class="layui-icon">&#xe615;</i></button>
                                    </td>
                                </tr>

                                <!--第3行-->
                                <tr>
                                    <td aplName1st>币制</td>
                                    <td>
                                        <select aplDataName="currency" v-model="info.currency" Verification="1-8">
                                            <option value="">-- 请选择 --</option>
                                            <option v-for="row in tabCurrency" :value="row.currencyName">{{row.currencyName}}</option>
                                        </select>
                                    </td>
                                    <td aplName1st>样式</td>
                                    <td>
                                        <select aplDataName="style" v-model="info.style" Verification="1-10">
                                            <option value="">-- 请选择 --</option>
                                            <option value="1">横向</option>
                                            <option value="2">竖向</option>
                                        </select>
                                    </td>
                                    <td>特殊货类</td>
                                    <td id="natureGoodsBox">
                                    </td>
                                </tr>

                                <!--第4行-->
                                <tr>
                                    <td aplName1st>体积系数</td>
                                    <td>
                                        <select aplDataName="VWTFM" v-model="info.VWTFM" Verification="1-8">
                                            <option value="">-- 请选择 --</option>
                                            <option value="5000" selected>5000</option>
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
                                    </td>
                                    <td aplName1st>状态</td>
                                    <td>
                                        <select aplDataName="state" v-model="info.state" Verification="1-1">
                                            <option value="">-- 请选择 --</option>
                                            <option value="1">正常</option>
                                            <option value="0">无效</option>
                                        </select>
                                    </td>
                                    <td aplName1st>销售系数</td>
                                    <td>
                                        <select aplDataName="saleCoeffi" v-model="info.saleCoeffi" Verification="1-1">
                                            <option value="">-- 请选择 --</option>
                                            <option value="1" selected>加</option>
                                            <option value="0">不加</option>
                                        </select>
                                    </td>
                                </tr>

                                <!--第5行-->
                                <tr>
                                    <!-- <td>分公司</td>
                                    <td>
                                        <input type="text">
                                    </td> -->
                                    <td aplName1st>账号属性</td>
                                    <td>
                                        <select aplDataName="agentType" v-model="info.agentType">
                                            <option value="0" selected></option>
                                            <option value="1">代理账号</option>
                                            <option value="2">贸易账户</option>
                                            <option value="3">第三方帐号</option>
                                        </select>
                                    </td>
                                    <td aplName1st>时效</td>
                                    <td colspan="2">
                                        <input type="text" aplDataName="times" v-model="info.times" placeholder="限制20位" Verification="0-20">
                                    </td>
                                </tr>

                                <!--第6行-->
                                <tr>
                                    <td>客户组</td>
                                    <td id="clientGroupBox">
                                         <!-- <span v-for="row in tabClientGroup">
                                             <input type="checkbox" :value="row.id">
                                             <label  style="margin-right: 10px">{{row.clientGroup}}</label>
                                         </span> -->
                                    </td>
                                    <td>客户权限</td>
                                    <td>
                                        <span>
                                            <input type="checkbox" id="isWeb" >
                                            <label for="box7">网站下单及计算</label>
                                        </span>
                                                <span>
                                            <input type="checkbox" id="isGuest" >
                                            <label for="box8">网站首页计算</label>
                                        </span>
                                    </td>

                                    <td aplName1st>服务商</td>
                                    <td colspan="2">
                                        <input type="text" id="coagentName" aplDataName="coagentName" v-model="info.coagentName">
                                        <input type="hidden" aplDataName="coagentId" corre="coagentName" v-model="info.coagentId" nullVal="0" >
                                        <button type="button" onclick="sbo.boxData=app.info;sbo.go2('coagent','coagentName','c3', 'coagentId', 'id')" class="layui-btn layui-btn-mini" title="搜索"  style="display: none;" level="m"><i class="layui-icon">&#xe615;</i></button>
                                    </td>
                                </tr>

                            <!--第8行-->
                                <tr>
                                    <td>客户</td>
                                    <td colspan="5">
                                        <span v-for="row in priceClient" style="margin-right: 5px;">
                                            <input type="checkbox" :value="row.id">
                                            <span>{{row.clientName}}</span>
                                        </span>
                                        <button type="button" class="layui-btn layui-btn-normal layui-btn-mini" style="display: none;margin-left: 10px;" level="m" id="addClient" onclick="clientAdd()">添加客户</button>
                                        <button type="button" class="layui-btn layui-btn-normal layui-btn-mini" style="display: none;" level="m" onclick="delClient()">删除客户</button>         
                                    </td>
                                </tr>

                                <!--第9行-->
                                <tr>
                                    <td aplName1st>报价说明</td>
                                    <td colspan="5">
                                        <input type="text" style="width: 100%" aplDataName="comm" v-model="info.comm" placeholder="限制100位" Verification="0-100">
                                    </td>
                                </tr>

                                <!--第10行-->
                                <tr>
                                    <td>销售备注</td>
                                    <td colspan="5">
                                        <textarea id="remarkImp" v-model="info.remarkImp" rows="2" ></textarea>
                                    </td>
                                </tr>

                                <!--第11行-->
                                <tr>
                                    <td>内部备注</td>
                                    <td colspan="5">
                                        <textarea id="remark" v-model="info.remark" rows="2"></textarea>
                                    </td>
                                </tr>

                                <!--第12行-->
                                <tr>
                                    <td>导出预报格式</td>
                                    <td colspan="5">
                                        <textarea aplDataName="exportFields" v-model="info.exportFields" rows=""></textarea>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>

                    <!--公式-->
                    <div class="layui-tab-item">
                        <table class="apl-tableSpecial" id="tabExp">
                            <thead>
                            <tr>
                                <td style="display: none;" level="m">编辑</td>
                                <td><span>公式</span></td>
                                <td><span>国家</span></td>
                                <td><span>分区</span></td>
                                <td><span>起始重</span></td>
                                <td><span>截止重</span></td>
                                <td style="display: none;" level="m">删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in exp">
                                <td align="cetner" style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'exp')" style="display: none;" >保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                    <input type="text" name="expression" disabled="true" aplDataName="expression" v-model="row.expression" placeholder="请输入2-100位" Verification="2-100" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="countryNo" disabled="true" aplDataName="countryNo" v-model="row.countryNo" placeholder="0-100位内" Verification="0-100" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="region" disabled="true" aplDataName="region"  v-model="row.region" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="number" name="wtStart" disabled="true" aplDataName="wtStart"  v-model="row.wtStart" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" name="wtEnd" disabled="true" aplDataName="wtEnd"  v-model="row.wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td style="display: none;" level="m">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=exp')">删 除</a>
                                </td>
                            </tr>
                            <tr class="newRow">
                                <td align="cetner"  style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'exp')" style="display: inline-block;">保 存</button>
                                    <input type="hidden" aplDataName="rowId"/>
                                </td>
                                <td>
                                    <input type="text" aplDataName="expression" placeholder="2-100位内" Verification="2-100" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" aplDataName="countryNo" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text"  aplDataName="region" placeholder="100位内" Verification="0-100" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtStart" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td  style="display: none;" level="m">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=exp')">删 除</a>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="7">
                                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabExp',3)"  style="display: none;" level="m">新增</button>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!--销售系数-->
                    <div class="layui-tab-item">
                        <table class="apl-tableSpecial" id="tabSaleCoeffi">
                            <thead>
                            <tr>
                                <td>编辑</td>
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
                                <td>删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in saleCoeffi">                               
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'saleCoeffi')" style="display: none;">保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                     <select name="clientGroupId" disabled="true" aplDataName="clientGroupId" v-model="row.clientGroupId" Verification="1-10" onblur="vertionCell(this)">
                                        <option value="">请选择</option>
                                        <option v-for="row2 in tabClientGroup"  :value="row2.id">{{row2.clientGroup}}</option>
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
                                <td width="5%">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=saleCoeffi')">删 除</a>
                                </td>
                            </tr>
                            <tr class="newRow">
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'saleCoeffi')" >保 存</button>
                                    <input type="hidden" aplDataName="rowId"/>
                                </td>
                                <td>
                                    <select aplDataName="clientGroupId" Verification="1-10" onblur="vertionCell(this)">
                                        <option value="">请选择</option>
                                        <option v-for="row2 in tabClientGroup" :value="row2.id">{{row2.clientGroup}}</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="number" aplDataName="meterageId" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="text" aplDataName="countryNo" placeholder="限制10位" Verification="0-10" onblur="vertionCell(this)">
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
                                <td width="5%">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=saleCoeffi')">删 除</a>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="12">
                                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabSaleCoeffi',3)">新增</button>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!--重量段-->
                    <div class="layui-tab-item">
                        <table class="apl-tableSpecial" id="tabPriceWTSection">
                            <thead>
                            <tr>
                                <td style="display: none;" level="m">编辑</td>
                                <td><span>计费</span></td>
                                <td><span>类型</span></td>
                                <td><span>起始重</span></td>
                                <td><span>截止重</span></td>
                                <td><span>首重</span></td>
                                <td><span>单位重</span></td>
                                <td><span>重量最低小数点</span></td>
                                <td style="display: none;" level="m">删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in priceWTSection">
                                <td align="cetner" style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'priceWTSection')" style="display: none;">保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                    <select disabled="true" aplDataName="meterageId" v-model="row.meterageId" Verification="1-5" onblur="vertionCell(this)" >
                                        <option></option>
                                        <option value="1">首续重</option>
                                        <option value="2">每公斤</option>
                                        <option value="3">计算好</option>
                                        <option value="4">累加</option>
                                        <option value="5">首重</option>
                                        <option value="6">续重</option>
                                        <option value="7">每票加</option>
                                    </select>
                                </td>
                                <td>
                                    <select disabled="true" aplDataName="packDoc" v-model="row.packDoc" placeholder="请输入1-3位" Verification="1-3" onblur="vertionCell(this)">
                                        <option value=""></option>
                                        <option value="WPX">WPX</option>
                                        <option value="DOC">DOC</option>
                                        <option value="PAK">PAK</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="number" name="wtStart" disabled="true" aplDataName="wtStart"  v-model="row.wtStart" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" name="wtEnd" disabled="true" aplDataName="wtEnd"  v-model="row.wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" name="wt1st" disabled="true" aplDataName="wt1st"  v-model="row.wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" name="wtAdd" disabled="true" aplDataName="wtAdd"  v-model="row.wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" name="unitWT" disabled="true" aplDataName="unitWT"  v-model="row.wtEnd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td width="5%"  style="display: none;" level="m">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=priceWTSection')">删 除</a>
                                </td>
                            </tr>
                            <tr class="newRow">
                                <td align="cetner" style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'priceWTSection')" >保 存</button>
                                    <input type="hidden" aplDataName="rowId"/>
                                </td>
                                <td>
                                    <select aplDataName="meterageId" Verification="1-5" onblur="vertionCell(this)" >
                                        <option value=""></option>
                                        <option value="1">首续重</option>
                                        <option value="2">每公斤</option>
                                        <option value="3">计算好</option>
                                        <option value="4">累加</option>
                                        <option value="5">首重</option>
                                        <option value="6">续重</option>
                                        <option value="7">每票加</option>
                                    </select>
                                </td>
                                <td>
                                    <select aplDataName="packDoc" placeholder="请输入1-3位" Verification="1-3" onblur="vertionCell(this)">
                                        <option value=""></option>
                                        <option value="WPX">WPX</option>
                                        <option value="DOC">DOC</option>
                                        <option value="PAK">PAK</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtStart" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtEnd" placeholder="999999内" Verification="0-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wt1st" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtAdd" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td>
                                    <input type="number" aplDataName="unitWT" placeholder="999999内" Verification="-999999" onblur="vertionCell(this)" onkeyup="APLDevel.clearNoNum(this,3)">
                                </td>
                                <td width="5%" style="display: none;" level="m">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=priceWTSection')">删 除</a>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="9">
                                    <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabPriceWTSection',3)" style="display: none;" level="m">新增</button>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!--附加费-->
                    <div class="layui-tab-item">
                        <table class="apl-tableSpecial" id="tabExtCharge">
                            <thead>
                            <tr>
                                <td style="display: none;" level="m">选择</td>
                                <td style="display: none;" level="m">编辑</td>
                                <td><span>费用名称</span></td>
                                <td><span>费用</span></td>
                                <td><span>币制</span></td>
                                <td><span>单位</span></td>
                                <td><span>描述</span></td>
                                <td><span>计算公式</span></td>
                                <td>删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in extCharge">
                                <td style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="" onclick="dlgExtCharge(this,'extCharge',0)">选 择</button>
                                </td>
                                <td align="cetner" style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'extCharge')" style="display: none;">保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                    <input type="text" name="chargeName" disabled="true" aplDataName="chargeName" v-model="row.chargeName" placeholder="请输入2-20位" verification="2-20" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="charge" disabled="true" aplDataName="charge"  v-model="row.charge" placeholder="请输入1-10位" verification="1-10" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="curr" disabled="true" aplDataName="curr"  v-model="row.curr" placeholder="请输入3-5位" verification="3-5" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="unit" disabled="true" aplDataName="unit"  v-model="row.unit" placeholder="请输入1-10位" verification="1-10" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="chargeDesc" disabled="true" aplDataName="chargeDesc"  v-model="row.chargeDesc" placeholder="限制50位" verification="0-50" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" name="calcForm" disabled="true" aplDataName="calcForm"  v-model="row.calcForm" placeholder="请输入2-50位" verification="2-50" onblur="vertionCell(this)">
                                </td>
                                <td width="5%" style="display: none;" level="m">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=extCharge')">删 除</a>
                                </td>
                            </tr>
                            <tr  class="newRow">
                                <td style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="dlgExtCharge(this,'extCharge',0)" style="">选择</button>
                                </td>
                                <td align="cetner" style="display: none;" level="m">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'extCharge')" >保 存</button>
                                    <input type="hidden" aplDataName="rowId" />
                                </td>                               
                                <td>
                                    <input type="text" aplDataName="chargeName" placeholder="请输入2-20位" verification="2-20" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" aplDataName="charge" placeholder="请输入1-10位" verification="1-10" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" aplDataName="curr" placeholder="请输入3-5位" verification="3-5" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" aplDataName="unit" placeholder="请输入1-10位" verification="1-10" onblur="vertionCell(this)">
                                </td>
                                <td>
                                    <input type="text" aplDataName="chargeDesc" placeholder="限制50位" verification="0-50" onblur="vertionCell(this)">
                                </td>
                                 <td>
                                    <input type="text" aplDataName="calcForm" placeholder="请输入2-50位" verification="2-50" onblur="vertionCell(this)">
                                </td>
                                <td width="5%" style="display: none;" level="m">
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=extCharge')">删 除</a>
                                </td>
                            </tr>

                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="9">
                                    <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabExtCharge',3)" style="display: none;" level="m">新增</button>
                                </td>
                            </tr>
                            </tfoot>
                        </table>


                    </div>

                    <!--地址标签-->
                    <div class="layui-tab-item">
                        <form id="labelList" class="infoBox">
                            <div>
                                <label for="printFormat">打印格式</label>
                                <select aplDataName="reportFile" id="printFormat" v-model="info.reportFile">
                                    <option value="0">-- 请选择 --</option>
                                   <!--  <option v-for="row in lable" v-model="row.name">{{row.name}}</option> -->
                                </select>
                            </div>
                            <fieldset>
                                <legend>
                                    <label for="params1">参数1</label>
                                </legend>
                                <textarea aplDataName="reportV1" v-model="info.reportV1" id="params1" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params2">参数2</label>
                                </legend>
                                <textarea aplDataName="reportV2" v-model="info.reportV2" id="params2" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params3">参数3</label>
                                </legend>
                                <textarea aplDataName="reportV3" v-model="info.reportV3" id="params3" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params4">参数4</label>
                                </legend>
                                <textarea aplDataName="reportV4" v-model="info.reportV4" id="params4" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params5">参数5</label>
                                </legend>
                                <textarea aplDataName="reportV5" v-model="info.reportV5" id="params5" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params6">参数6</label>
                                </legend>
                                <textarea aplDataName="reportV6" v-model="info.reportV6" id="params6" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params7">参数7</label>
                                </legend>
                                <textarea aplDataName="reportV7" v-model="info.reportV7" id="params7" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params8">参数8</label>
                                </legend>
                                <textarea aplDataName="reportV8" v-model="info.reportV8" id="params8" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params9">参数9</label>
                                </legend>
                                <textarea aplDataName="reportV9" v-model="info.reportV9" id="params9" rows="4"></textarea>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <label for="params10">参数10</label>
                                </legend>
                                <textarea aplDataName="reportV10" v-model="info.reportV10" id="params10" rows="4"></textarea>
                            </fieldset>
                        </form>
                    </div>

                    <!-- 附加费弹出框-->
                    <div id="dlgExtChargeBox" style="display: none;">
                        <div class="popupReaer"></div>
                        <div class="pShow popup1" style="max-height: 90%;overflow-y: auto;width: 95%;margin: 0 auto;">
                            <div class="inner1"> 
                                    <section id="main" style="width: 95%;">
                                        <div class="content" style="width: 100%;">
                                            <div >                                        
                                                <table cellspacing="0" cellpadding="0" width="">
                                                    <thead>
                                                        <tr>
                                                            <td></td>
                                                            <td>费用名称</td>
                                                            <td>费用</td>
                                                            <td>币制</td>
                                                            <td>单位</td>
                                                            <td>描述</td>
                                                            <td>计算公式</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr v-for="row in dlgExtChargeData">
                                                        <td width="5%"><input type="radio" :value="row.id" name="1" style="width: 30px;height: 30px;" onClick="dlgExtChargeFill($(this).parent().parent())"></td>
                                                        <td width="10%" aplDataName="chargeName">{{row.chargeName}}</td>
                                                        <td width="10%" aplDataName="charge">{{row.charge}}</td>
                                                        <td width="10%" aplDataName="curr">{{row.curr}}</td>
                                                        <td width="10%" aplDataName="unit">{{row.unit}}</td>
                                                        <td width="20%" aplDataName="chargeDesc">{{row.chargeDesc}}</td>
                                                        <td width="15%" aplDataName="calcForm">{{row.calcForm}}</td>
                                                    </tr>
                                                    </tbody>
                                                </table>                                                
                                            </div>
                                        </div>
                                    </section>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/WdatePicker/WdatePicker.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../plugins/SearchBoxJS/SearchBox-1.4.js"></script>
    <script src="../../plugins/layer/layer.min.js"></script>
    <script src="../../js/APLDevel.js"></script>
    <script src="../../l_popup_tips/l_popup_tips.js"></script>
    <script src="priceInfo.js"></script>

</body>
</html>