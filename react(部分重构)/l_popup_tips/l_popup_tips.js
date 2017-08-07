var l_pIndex = 0;
//弹出层--------------------------------------
// l_popup({
	// 	title:'详细信息',
	// 	content:$('#id'),
	// 	btn:'保存',
	// 	width:'360px',//默认360px
	// 	yes:function(index) {
	// 		l_popup.close(index);//关闭当前
	// 	}
// })  l_popup({url:'baidu.com'})//全屏弹出
function l_popup(obj,all_) {
	// setTimeout(function() {
		var popupClose = function (close_,all_){
			$('.l_pIndex'+close_+' .l_pShow').attr('class','l_pShow l_popup_');
			setTimeout(function(){
				if (close_ != 0 && all_ != 1) {
					$('.l_pIndex'+close_+' .l_Pcontent').children().eq(0).hide();
					$('.l_pIndex'+close_+' .l_Pcontent').children().eq(0).insertBefore($('.l_pIndex'+close_));
				}				
				$('.l_pIndex'+close_).remove();
			},200);		
		}
		//关闭
		if (typeof(obj) == 'string' || typeof(obj) == 'number') {
			return popupClose(obj,all_);
		}		

		if (obj.width == undefined) {
			obj.width = '360px';
		}
		if (obj.title == undefined) {
			obj.title = '详细信息';
		}
		if (obj.btn == undefined) {
			obj.btn = '保存';
		}
		
		var string = "",close = '',all = null;
		if (typeof(obj.url) == 'string') {
			string = '<div class="l_popupBox l_boxAllClose l_pIndex0">'
							+'<div class="l_popupReaer"></div>'
					        +'<div class="l_pShow l_popup">'
					            +'<div class="l_Pinner">'					            				            			
					            		+'<div class="l_Pcontent"></div>'
					            +'</div>'
					        +'</div>'
					    +'</div>';
			var iframe = '<iframe scrolling="auto" allowtransparency="true" src="'+obj.url+'" ></iframe>';			
			close = '.l_pIndex0';
			obj.width = '100%';
			// $('.l_pIndex0').remove();
			$('body').append(string);
			$(close + ' .l_Pcontent').append(iframe);
			$(close + ' .l_Pcontent').height($(close).outerHeight()-20);
		}else{
			l_pIndex++;	
			string = '<div class="l_popupBox l_boxClose l_pIndex'+l_pIndex+'">'
				        +'<div class="l_popupReaer"></div>'
				        +'<div class="l_pShow l_popup">'
				            +'<div class="l_Pinner">'
				            		+'<div class="l_Ptitle">'
				            			+obj.title
				            			+'<div class="l_Pclose" onclick="l_popup('+l_pIndex+','+(typeof(obj.content)=='string'?1:0)+')"></div>'
				            		+'</div><div class="l_Pcontent">'
				            	    +'</div><div class="l_Pbtn"><a href="###">'
				            	    +obj.btn
				            	    +'</a></div>'
				            +'</div>'
				        +'</div>'
				    +'</div>';			    
			close = '.l_pIndex'+l_pIndex;
			if (typeof(obj.content) == 'string') {
				all = 1;
				$('body').append(string); 
				$(close + ' .l_Pcontent').append(obj.content); 
			}else{				
				obj.content.parent().append(string);
				$(close + ' .l_Pcontent').append(obj.content);
			}
		}			

		$(close + ' .l_Pinner .l_Pcontent').children().show();
		$(close + ' .l_pShow').width(obj.width);

		function locaTion(){
			if (typeof(obj.url) == 'string') {
				$(close + ' .l_pShow').css({'top':'0','left':'0'});
				return;
			}
			if ($(close).outerHeight() <= $(close + ' .l_pShow').outerHeight())
				$(close + ' .l_pShow').css('top','0');
			else
				$(close + ' .l_pShow').css('top',($(close).outerHeight()-$(close + ' .l_pShow').outerHeight())/2+'px');
			$(close + ' .l_pShow').css('left',($(close).outerWidth()-$(close + ' .l_pShow').outerWidth())/2+'px');
		}
		function popupShow(){
			$(close + ' .l_pShow').show();	
			$(close + ' .l_pShow').attr('class','l_pShow l_popup');
			locaTion();	//弹出层出现宽高已为0		
			$(close + ' .l_popupReaer').show();
		}
		popupShow();
		window.onresize=locaTion;//改变窗口大小重新定位
		if (typeof(obj.url) == 'string') return 0;

		//btn添加点击事件
		$(close + ' .l_Pbtn a').on("click",function() {
			obj.yes({l_pIndex:l_pIndex,all:all});
		});

		$(close + ' .l_Ptitle').on('mousedown',function(e) {//添加鼠标按下事件
			var l = $(close + ' .l_pShow').offset().left-$(document).scrollLeft();//目标元素距离body左边距
			var t = $(close + ' .l_pShow').offset().top-$(document).scrollTop();//目标元素距离body上边距
			var left = e.clientX - l;//鼠标至目标元素左边距
			var top = e.clientY - t;//鼠标至目标元素上边距
			$(document).on('mousemove',function(e) {
				var l_ = e.clientX - left;//移动后目标元素距离body该有的左边距
				var t_ = e.clientY - top;//移动后目标元素距离body该有的上边距
				if (l_ <= 0) {
					l_ = 0;
				}
				if (l_ >= $(window).width() - $(close + ' .l_pShow').outerWidth()) {
					l_ = $(window).width() - $(close + ' .l_pShow').outerWidth();
				}
				if (t_ <= 0) {
					t_ = 0;
				}
				if (t_ >= $(window).height() - $(close + ' .l_pShow').outerHeight()) {
					t_ = $(window).height() - $(close + ' .l_pShow').outerHeight();
				}
				$(close + ' .l_pShow').css('top',t_ + 'px');
				$(close + ' .l_pShow').css('left',l_ + 'px');			
			})
		});
		$(document).on('mouseup',function() {
			$(document).off('mousemove');//按起鼠标解除移动事件
		});
	// },0);

	return l_pIndex;	
}

//关闭弹出层
l_popup.close = function (l_pIndex) {
	if (l_pIndex == 0) l_pIndex={l_pIndex:0};
	l_popup(l_pIndex.l_pIndex,l_pIndex.all);
}

//提示框---------------------------------------
// l_tips('反而雾非雾','#id',{backgroundColor:'red',color:'white',position:'right'})
var l_tipsTimer = null;
function l_tips(msg,id,obj) {
	clearInterval(l_tipsTimer);
	$('.l_position').remove();
	if (id == undefined || id == null || id.length == 0) return;
	if (obj == undefined || typeof(obj) != 'object') obj = {'backgroundColor':'red','color':'white','position':'top'};
	if (typeof(id) == 'string') id = $(id);
	if (obj.backgroundColor == undefined) obj.backgroundColor = 'red';				
	if (obj.color == undefined) obj.color = 'white';
	var l_position = $('<div class="l_position l_position_enlarge">'+msg+'<div></div></div>');
	$('body').append(l_position);			
	var left_ = id.offset().left;//元素距离浏览器左边距离
	var idTop_ = id.offset().top - $(document).scrollTop();//元素距离浏览器顶端距离
	// var WH = $(window).height();//可视窗口高度
	if (obj.position == 'right' || obj.position == 'RIGHT') {
		var l_position_top = idTop_ + (id.height() - $('.l_position').outerHeight())/2;
		$('.l_position').css({
			'background-color':obj.backgroundColor,//背景颜色
			'top':l_position_top + 'px',
			'left':left_ + id.width() + 10 + 'px',
			// 'max-width':id.width()-20+'px',//最大宽度
			'color':obj.color//字体颜色
		});
		var l_position_bottom = ($('.l_position').outerHeight()-10)/2;;//三角形的下边位置
		$('.l_position div').css({
			'border-right-color':obj.backgroundColor,
			'bottom': l_position_bottom + 'px',
			'left':'-10px'
		});
	}else{
		var l_position_top = idTop_ - $('.l_position').outerHeight() - 5;//定位高度
		$('.l_position').css({
			'background-color':obj.backgroundColor,//背景颜色
			'top':l_position_top - 2 + 'px',
			'left':left_+'px',
			// 'max-width':id.width()-20+'px',//最大宽度
			'color':obj.color//字体颜色
		});
		var l_position_left;//三角形的左边位置
		if ($('.l_position').outerWidth() > id.width()) {
			l_position_left = (id.width()-10)/2;
		}else{
			l_position_left = ($('.l_position').outerWidth()-10)/2;
		} 
		$('.l_position div').css({
			'border-top-color':obj.backgroundColor,
			'top':$('.l_position').outerHeight()-1+'px',
			'left':l_position_left + 'px'
		});
	}
	$('.l_position').show();
	l_tipsTimer=setTimeout(function() {
		$('.l_position').remove();
	},3400);					
}

//验证1--------------------------------------
// l_Vertion($('#id'))//验证id内所有
// l_Vertion(null,$('#id'),$('#content'))//验证单个
function l_Verification(arr1,arr2,arr3){
    for (var i = 0; i < arr1.length; i++) {
        var arr = arr3[i].split('=');
        if (arr[0] == 'input') {
            if (arr[1].indexOf('-') == -1) {
                if (arr1[i].val() == '' || arr1[i].val() == null) {
                    l_tips(arr2[i]+'不能为空',arr1[i]);
                    return false;
                }
                if (arr1[i].val().length != arr[1]) {
                    l_tips('只能输入'+arr[1]+'位',arr1[i]);
                    return false;
                }              
            }else{
                var arr_ = arr[1].split('-');                
                if (arr1[i].attr("type") == 'number') {
                    if (arr_[0] != null && arr_[0] != '') {
                        if (arr1[i].val() == '' || arr1[i].val() == null) {
                            l_tips(arr2[i]+'不能为空',arr1[i]);
                            return false;
                        }                                 
                        if (arr1[i].val() >= (arr_[1]+1) || arr1[i].val() < arr_[0]) {
                            l_tips('大小限定'+arr[1],arr1[i]);
                            return false; 
                        }
                    }else{                      
                        if (arr1[i].val() < 0) {
                            l_tips(arr2[i]+'不能小于0',arr1[i]);
                            return false;
                        }
                        if (arr1[i].val() - arr_[1] > 1) {
                            l_tips(arr2[i]+'不能超过'+(arr_[1]+1),arr1[i]);
                            return false;
                        }                        
                    }
                }else if (arr1[i].attr("type") == 'text' || arr1[i].attr("type") == 'password' || !arr1[i].attr("type")) {
                    if (arr_[0] == 0) {
                        if (arr1[i].val().length > arr_[1]) {
                            l_tips(arr2[i]+'不能超过'+arr_[1]+'位',arr1[i]);
                            return false;
                        }
                    }else{
                        if (arr1[i].val() == '' || arr1[i].val() == null) {                            
                            l_tips(arr2[i]+'不能为空',arr1[i]);
                            return false;
                        }
                         if (arr1[i].val().length > arr_[1] || arr1[i].val().length < arr_[0]) {
                            l_tips('请输入'+arr[1]+'位',arr1[i]);
                            return false;
                        }
                    }
                }                
            }
        };  
    }
    return true;
};
//验证2
var l_vCallback = null;//用于最后自定义验证
var l_VerTips = null;//选取名称标签
var l_VerName = "Verification";//添加的验证属性
function l_Vertion(box,e,eTitle){
    //box = '#id'所需验证此行的容器
    //e = $(this) 所需验证的单个节点（若传则验证单个）
    //eTitle = $(this).prev() 所需验证单个名称的节点 
    var arr1=[],arr2=[],arr3=[];
    if (e == null) {
        var Verification = $(box).find('['+l_VerName+']');
        var span = null;
        if(l_VerTips!=null){
            span = l_VerTips;
            l_VerTips = null;
        }
        else{
            span = $(box).find("span");
        }
        for (var i = 0; i < Verification.length; i++) {             
            arr2[i] = span.eq(i).text().replace(":","").replace("：","");
            arr1[i] = Verification.eq(i);
            arr3[i] = 'input='+arr1[i].attr(l_VerName);
        }
    }else{
    	if (typeof(eTitle) == 'string')  
    		arr2[0] = eTitle.replace(":","").replace("：","");
    	else
        	arr2[0] = eTitle.text().replace(":","").replace("：","");
        arr1[0] = e;
        arr3[0] = 'input='+arr1[0].attr(l_VerName);
    } 
    var rVal = l_Verification(arr1,arr2,arr3);
    if(rVal && box!=null && l_vCallback!=null)
        rVal = l_vCallback(box);
    l_vCallback=null;

    return rVal;
};

//成功状态
function l_status(status,msg){
	var status_ = "";
	if (status == 'success') {
		status_ = '<div id="l_Status">'
			+'<div class="l_StatusReaer"></div>'
			+'<div class="l_Status l_success_color">'
		        +'<div class="l_quan"></div>'       
		        +'<div class="l_statusSuccess"></div>'
		        +'<div class="l_successMoban">'
					+'<div class="l_successMoban_ l_success_color">'
						+'<div class="l_quan">'
				        +'</div>'
					+'</div>'
				+'</div>'
		        +'<p>'+msg+'</p>'
		    +'</div>'
		+'</div>'
	    $('body').append(status_);
	    $('.l_Status .l_successMoban_').width($('.l_Status').outerWidth());
		$('.l_Status .l_statusSuccess').css('left',($('.l_Status').outerWidth()-50)/2+5+'px');
	}else if(status == 'error'){
		status_ =  '<div id="l_Status">'
			+'<div class="l_StatusReaer"></div>'
			+'<div class="l_Status l_error_color">'
		        +'<div class="l_quan"></div>'       
		        +'<div class="l_statusError1"></div>'
		        +'<div class="l_errorMoban1">'
					+'<div class="l_error_right l_error_color">'
						+'<div class="l_quan"></div>'
					+'</div>'
				+'</div>'
				+'<div class="l_statusError2"></div>'
		        +'<div class="l_errorMoban2">'
					+'<div class="l_error_left l_error_color">'
						+'<div class="l_quan"></div>'
					+'</div>'
				+'</div>'
		        +'<p>'+msg+'</p>'
		    +'</div>'
		+'</div>'
	    $('body').append(status_);
	    $('.l_Status .l_error_left').width($('.l_Status').outerWidth());
		$('.l_Status .l_error_right').width($('.l_Status').outerWidth());
		$('.l_Status .l_statusError1').css('left',($('.l_Status').outerWidth()-50)/2+'px');
		$('.l_Status .l_statusError2').css('left',($('.l_Status').outerWidth()-50)/2+'px');
	}	
	$('.l_Status').css({
		'margin-top':-$('.l_Status').outerHeight()/2+'px',
		'margin-left':-$('.l_Status').outerWidth()/2+'px',
	});
	setTimeout(function() {
		$('#l_Status').remove();
	},2500);
}

