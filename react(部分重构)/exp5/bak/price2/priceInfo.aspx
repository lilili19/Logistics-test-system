<%@ Inherits="APLViewCheck.checkLogin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <link rel="stylesheet" href="../../css/apl-1.0.css">
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
    </style>
</head>
<body>
<div id="preloader" style="display: none">
    <img src="../../img/load.gif" alt="">
</div>
    <div id="app">
        <div class="apl-tool">
            <button type="button" class="layui-btn layui-btn-small layui-btn-danger" onclick="saveInfo()">保存</button>
            <button type="button" class="layui-btn layui-btn-small layui-btn-normal" onclick="APLDevel.closeCurrDlg()">关闭</button>
        </div>
        <div class="apl-table">
            <div class="layui-tab layui-tab-card">
                <ul class="layui-tab-title">
                    <li class="layui-this">基本信息</li>
                    <li>公式</li>
                    <li>销售系数</li>
                    <li>重量段</li>
                    <li>地址标签</li>
                </ul>
                <div class="layui-tab-content">
                    <!--基本信息-->
                    <div class="layui-tab-item layui-show">
                        <form id="aplForm" class="infoBox">
                            <table>
                                <tbody>
                                <!--第1行-->
                                <tr>
                                    <td>报价名称</td>
                                    <td>
                                        <input type="text" aplDataName="priceName"  v-model="info.priceName" Verification="2-20">
                                    </td>
                                    <td>销售名称</td>
                                    <td>
                                        <input type="text" aplDataName="priceNo" v-model="info.priceNo">
                                    </td>
                                    <td>有效日期</td>
                                    <td>
                                        <input onfocus="WdatePicker({dateFmt:'yy-MM-dd HH:mm'})" v-model="info.dateStart" class="input-text Wdate" style="width:150px; height: 25px; padding-left: 5px;" type="text" aplDataName="dateStart">
                                        至
                                        <input onfocus="WdatePicker({dateFmt:'yy-MM-dd HH:mm'})"  v-model="info.dateEnd" class="input-text Wdate" style="width:150px; height: 25px; padding-left: 5px;" type="text"  aplDataName="dateEnd">
                                    </td>
                                </tr>

                                <!--第2行-->
                                <tr>
                                    <td>报价代码</td>
                                    <td>
                                        <input type="text">
                                    </td>
                                    <td>渠道类型</td>
                                    <td>
                                        <select aplDataName="transit" v-model="info.transit">
                                            <option value="">-- 请选择 --</option>
                                            <option v-for="row in tabTransit" v-model="row.transit">{{row.transit}}</option>
                                        </select>
                                    </td>
                                    <td>分区表</td>
                                    <td>
                                        <input type="text" Verification="2-50" aplDataName="regionName" v-model="info.regionName" id="region" disabled>
                                        <button type="button" onclick="sbo.go2('region','#region','c2')" class="layui-btn layui-btn-mini" title="搜索"><i class="layui-icon">&#xe615;</i></button>
                                    </td>
                                </tr>

                                <!--第3行-->
                                <tr>
                                    <td>币制</td>
                                    <td>
                                        <select aplDataName="currency" v-model="info.currency">
                                            <option value="">-- 请选择 --</option>
                                            <option v-for="row in tabCurrency" v-model="row.currencyName">{{row.currencyName}}</option>
                                        </select>
                                    </td>
                                    <td>样式</td>
                                    <td>
                                        <select aplDataName="style" Verification="0-10" v-model="info.style">
                                            <option value="">-- 请选择 --</option>
                                            <option value="1">横向</option>
                                            <option value="2">竖向</option>
                                        </select>
                                    </td>
                                    <td>货物性质</td>
                                    <td>
                                        <span v-for="row in tabNature">
                                            <input type="checkbox" :id=`nature${info.id}`>
                                            <label :for=`nature${info.id}`>{{row.c2}}</label>
                                        </span>
                                    </td>
                                </tr>

                                <!--第4行-->
                                <tr>
                                    <td>体积</td>
                                    <td>
                                        <select aplDataName="VWTFM" v-model="info.VWTFM">
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
                                    <td>状态</td>
                                    <td>
                                        <select aplDataName="state" v-model="info.state">
                                            <option value="">-- 请选择 --</option>
                                            <option value="1">正常</option>
                                            <option value="2">计算账单</option>
                                            <option value="0">无效</option>
                                        </select>
                                    </td>
                                    <td>销售系数</td>
                                    <td>
                                        <select aplDataName="saleCoeffi" v-model="info.saleCoeffi">
                                            <option value="">-- 请选择 --</option>
                                            <option value="1" selected>加</option>
                                            <option value="0">不加</option>
                                        </select>
                                    </td>
                                </tr>

                                <!--第5行-->
                                <tr>
                                    <td>分公司</td>
                                    <td>
                                        <input type="text">
                                    </td>
                                    <td>帐号属性</td>
                                    <td>
                                        <select aplDataName="agentType" v-model="info.agentType">
                                            <option value="">-- 请选择 --</option>
                                            <option value="代理账号">代理账号</option>
                                            <option value="贸易账户">贸易账户</option>
                                            <option value="第三方帐号">第三方帐号</option>
                                        </select>
                                    </td>
                                    <td>时效</td>
                                    <td colspan="2">
                                        <input type="text" Verification="2-5" aplDataName="times" v-model="info.times">
                                    </td>
                                </tr>

                                <!--第6行-->
                                <tr>
                                    <td>偏远费</td>
                                    <td>
                                        <input type="text">
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>客户权限</td>
                                    <td colspan="2">
                                <span>
                                    <input type="checkbox" id="box7">
                                    <label for="box7">网站下单及计算</label>
                                </span>
                                        <span>
                                    <input type="checkbox" id="box8">
                                    <label for="box8">网站首页计算</label>
                                </span>
                                    </td>
                                </tr>

                                <!--第7行-->
                                <tr>
                                    <td>客户组</td>
                                    <td colspan="3"  id="clientGroupBox">
                                        <!--<span v-for="row in tabClientGroup">
                                             <input type="checkbox" aplDataName="cgs" v-model="row.id">
                                             <label  style="margin-right: 10px">{{row.clientGroup}}</label>
                                         </span>-->
                                </td>
                                <td>服务商</td>
                                <td colspan="2">
                                    <input type="text" id="coagent" value="哈哈" aplDataName="coagentName" v-model="info.coagentName" disabled>
                                    <button type="button" onclick="sbo.go2('coagent','#coagent','c3')" class="layui-btn layui-btn-mini" title="搜索"><i class="layui-icon">&#xe615;</i></button>
                                </td>
                            </tr>

                            <!--第8行-->
                                <tr>
                                    <td>客户</td>
                                    <td colspan="5">
                                        <input type="text">
                                        <button type="button" class="layui-btn layui-btn-mini">搜索</button>
                                        <button type="button" class="layui-btn layui-btn-normal layui-btn-mini">添加客户</button>
                                    </td>
                                </tr>

                                <!--第9行-->
                                <tr>
                                    <td>报价说明</td>
                                    <td colspan="5">
                                        <input type="text" style="width: 100%">
                                    </td>
                                </tr>

                                <!--第10行-->
                                <tr>
                                    <td>销售备注</td>
                                    <td colspan="5">
                                        <textarea aplDataName="remarkImp" v-model="info.remarkImp" rows="2"></textarea>
                                    </td>
                                </tr>

                                <!--第11行-->
                                <tr>
                                    <td>内部备注</td>
                                    <td colspan="5">
                                        <textarea aplDataName="remark" v-model="info.remark" rows="2"></textarea>
                                    </td>
                                </tr>

                                <!--第12行-->
                                <tr>
                                    <td>导出预报格式</td>
                                    <td colspan="5">
                                        <textarea aplDataName="exportFields" v-model="info.exportFields" rows="2"></textarea>
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
                                <td>编辑</td>
                                <td><span>公式</span></td>
                                <td><span>国家</span></td>
                                <td><span>分区</span></td>
                                <td><span>起始重</span></td>
                                <td><span>截止重</span></td>
                                <td>删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in exp">
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: inline-block;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'exp')" style="display: none;"  >保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                    <input type="text" name="expression" disabled="true" aplDataName="expression" v-model="row.expression" onblur="vertionRow(this)" Verification="1-100">
                                </td>
                                <td>
                                    <input type="text" name="countryNo" disabled="true" aplDataName="countryNo" v-model="row.countryNo"  onblur="vertionRow(this)" Verification="0-200">
                                </td>
                                <td>
                                    <input type="text" name="region" disabled="true" aplDataName="region"  v-model="row.region"   onblur="vertionRow(this)" Verification="0-100">
                                </td>
                                <td>
                                    <input type="number" name="wtStart" disabled="true" aplDataName="wtStart"  v-model="row.wtStart"  onblur="vertionRow(this)" Verification="0-20">
                                </td>
                                <td>
                                    <input type="number" name="wtEnd" disabled="true" aplDataName="wtEnd"  v-model="row.wtEnd"   onblur="vertionRow(this)" Verification="0-20">
                                </td>
                                <td>
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=exp')">删 除</a>
                                </td>
                            </tr>
                            <tr>
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'exp')" style="display: inline-block;">保 存</button>
                                    <input type="hidden" aplDataName="rowId"/>
                                </td>
                                <td>
                                    <input type="text" aplDataName="expression"  onblur="vertionRow(this)" Verification="1-100">
                                </td>
                                <td>
                                    <input type="text" aplDataName="countryNo" onblur="vertionRow(this)" Verification="0-200">
                                </td>
                                <td>
                                    <input type="text"  aplDataName="region" onblur="vertionRow(this)" Verification="0-100">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtStart" onblur="vertionRow(this)" Verification="0-20">
                                </td>
                                <td>
                                    <input type="number" aplDataName="wtEnd" onblur="vertionRow(this)" Verification="0-20">
                                </td>
                                <td>
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=exp')">删 除</a>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="7">
                                        <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabExp',3)">新增</button>
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
                                <td>客户组</td>
                                <td>计费</td>
                                <td>国家</td>
                                <td>分区</td>
                                <td>起始重</td>
                                <td>截止重</td>
                                <td>首重加</td>
                                <td>单位重加</td>
                                <td>比例加</td>
                                <td>每票加</td>
                                <td>删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in saleCoeffi">
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'saleCoeffi')" style="display: none;"  >保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                    <input type="text" name="clientGroupId" disabled="true" aplDataName="clientGroupId" v-model="row.clientGroupId">
                                </td>
                                <td>
                                    <input type="text" name="meterageId" disabled="true" aplDataName="meterageId" v-model="row.meterageId"  onblur="vertionRow(this)" Verification="1-10">
                                </td>
                                <td>
                                    <input type="text" name="countryNo" disabled="true" aplDataName="countryNo" v-model="row.countryNo" onblur="vertionRow(this)" Verification="0-200">
                                </td>
                                <td>
                                    <input type="text" name="region" disabled="true" aplDataName="region" v-model="row.region" onblur="vertionRow(this)" Verification="0-100">
                                </td>
                                <td>
                                    <input type="text" name="wtStart" disabled="true" aplDataName="wtStart" v-model="row.wtStart" onblur="vertionRow(this)" Verification="0-100">
                                </td>
                                <td>
                                    <input type="text" name="wtEnd" disabled="true" aplDataName="wtEnd" v-model="row.wtEnd">
                                </td>
                                <td>
                                    <input type="text" name="price1st" disabled="true" aplDataName="price1st" v-model="row.price1st">
                                </td>
                                <td>
                                    <input type="text" name="priceAdd" disabled="true" aplDataName="priceAdd" v-model="row.priceAdd">
                                </td>
                                <td>
                                    <input type="text" name="propo" disabled="true" aplDataName="propo" v-model="row.propo">
                                </td>
                                <td>
                                    <input type="text" name="cauda" disabled="true" aplDataName="cauda" v-model="row.cauda">
                                </td>
                                <td>
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=saleCoeffi')">删 除</a>
                                </td>
                            </tr>
                            <tr>
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'saleCoeffi')" >保 存</button>
                                    <input type="hidden" aplDataName="rowId"/>
                                </td>
                                <td>
                                    <input type="text" aplDataName="clientGroupId">
                                </td>
                                <td>
                                    <input type="text" aplDataName="meterageId">
                                </td>
                                <td>
                                    <input type="text" aplDataName="countryNo">
                                </td>
                                <td>
                                    <input type="text" aplDataName="region">
                                </td>
                                <td>
                                    <input type="text" aplDataName="wtStart">
                                </td>
                                <td>
                                    <input type="text" aplDataName="wtEnd">
                                </td>
                                <td>
                                    <input type="text" aplDataName="price1st">
                                </td>
                                <td>
                                    <input type="text" aplDataName="priceAdd">
                                </td>
                                <td>
                                    <input type="text" aplDataName="propo">
                                </td>
                                <td>
                                    <input type="text" aplDataName="cauda">
                                </td>
                                <td>
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
                                <td>编辑</td>
                                <td>计费</td>
                                <td>类型</td>
                                <td>起始重</td>
                                <td>截止重</td>
                                <td>首重</td>
                                <td>单位重</td>
                                <td>重量最低小数点</td>
                                <td>删除</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="row in priceWTSection">
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'priceWTSection')" style="display: none;"  >保 存</button>
                                    <input type="hidden" aplDataName="rowId" v-model="row.id" />
                                </td>
                                <td>
                                    <input type="text" name="meterageId" disabled="true" aplDataName="meterageId" v-model="row.expression">
                                </td>
                                <td>
                                    <input type="text" name="packDoc" disabled="true" aplDataName="packDoc" v-model="row.countryNo">
                                </td>
                                <td>
                                    <input type="text" name="wtStart" disabled="true" aplDataName="wtStart"  v-model="row.wtStart">
                                </td>
                                <td>
                                    <input type="text" name="wtEnd" disabled="true" aplDataName="wtEnd"  v-model="row.wtEnd">
                                </td>
                                <td>
                                    <input type="text" name="wt1st" disabled="true" aplDataName="wt1st"  v-model="row.wtEnd">
                                </td>
                                <td>
                                    <input type="text" name="wtAdd" disabled="true" aplDataName="wtAdd"  v-model="row.wtEnd">
                                </td>
                                <td>
                                    <input type="text" name="unitWT" disabled="true" aplDataName="unitWT"  v-model="row.wtEnd">
                                </td>
                                <td>
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=priceWTSection')">删 除</a>
                                </td>
                            </tr>
                            <tr>
                                <td align="cetner">
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-normal" name="btnEditRow" onclick="ad.editRow(this)" style="display: none;">编 辑</button>
                                    <button type="button" class="layui-btn layui-btn-small layui-btn-danger" name="btnSaveRow" onclick="saveRow(this,'priceWTSection')" >保 存</button>
                                    <input type="hidden" aplDataName="rowId"/>
                                </td>
                                <td>
                                    <input type="text" aplDataName="meterageId">
                                </td>
                                <td>
                                    <input type="text" aplDataName="packDoc">
                                </td>
                                <td>
                                    <input type="text" aplDataName="wtStart">
                                </td>
                                <td>
                                    <input type="text" aplDataName="wtEnd">
                                </td>
                                <td>
                                    <input type="text" aplDataName="wt1st">
                                </td>
                                <td>
                                    <input type="text" aplDataName="wtAdd">
                                </td>
                                <td>
                                    <input type="text" aplDataName="unitWT">
                                </td>
                                <td>
                                    <a href="javascript:;" onclick="delRow(this, 'dbTab=priceWTSection')">删 除</a>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="9">
                                    <button type="button" class="layui-btn layui-btn-small" onclick="ad.addRow('#tabPriceWTSection',3)">新增</button>
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
                                    <option v-for="row in lable" v-model="row.name">{{row.name}}</option>
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
    <script src="priceInfo.js"></script>

</body>
</html>