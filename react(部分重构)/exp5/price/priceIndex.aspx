<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="../../plugins/layui/css/layui.css">
    <link rel="stylesheet" href="../../css/common.css">
    <style>
        #app{
            padding: 0 15px 15px 15px;
        }
        #app .layui-tab-card>.apl-tab-title{
            background: #aaa;
        }
        #app .apl-tab-title li{
            font-size: 16px;
            font-weight: bold;
            letter-spacing: 5px;
            color: #fff;
        }
        #app .apl-tab-title li.layui-this{
            color: #E4393C;
            background: #fff;
        }
        #app .layui-tab-content iframe{
            width: 100%;
            min-height: 800px;
            border: none;
        }
        .apl-tab-title {
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
            font-size: 14px;
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
    </style>
</head>
<body>
    <div id="app">
        <div class="layui-tab layui-tab-card">
             <ul class="apl-tab-title">
                <li onClick="aplTab(this)">分区表</li>
                <li onClick="aplTab(this,1)" class="layui-this">销售价</li>
                <li onClick="aplTab(this,3)">客户价</li>
                <li onClick="aplTab(this,4)">成本价</li>
                <li onClick="aplTab(this,7)">公布价模版</li>
                <li onClick="aplTab(this)">销售系数</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item">
                    <!--<iframe src="/APL-EXP5/v/EXPrice/area1/index.html" frameborder="0" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"></iframe>-->
                </div>
                <div class="layui-tab-item layui-show">                    
                    <iframe src="priceList.html?priceType=1" frameborder="0"></iframe>
                </div>
                <div class="layui-tab-item">
                    <iframe src="priceList.html?priceType=3" frameborder="0"></iframe>
                </div>
                <div class="layui-tab-item">
                    <iframe src="priceList.html?priceType=4" frameborder="0"></iframe>
                </div>
                <div class="layui-tab-item">
                    <iframe src="priceList.html?priceType=7" frameborder="0"></iframe>
                </div>
                <div class="layui-tab-item">
                    <!--<iframe src="/APL-EXP5/v/EXPrice/area6/index.html" frameborder="0"></iframe>-->
                </div>
            </div>
        </div>
    </div>

    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script src="../../plugins/layui/layui.js"></script>
    <script>
        layui.use('element',function(){
            let element = layui.element();
        });
    </script>
</body>
</html>