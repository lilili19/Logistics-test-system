//弹框关闭
function popupClose(){
	$('.pShow').attr('class','pShow popup_');
	$('.popupReaer').hide();
	setTimeout(function(){
		$('.popupBox').hide();
	},200);			
}
//弹框显示
function popupShow(){
	$('.popupReaer').show();
	$('.popupBox').show();
	$('.pShow').show();	
	$('.pShow').attr('class','pShow popup');
	locaTion();	//弹出层出现宽高已为0		

}
function locaTion(){
	if ($(".box").height() <= $('.popup .inner').height()*9/10)
		$('.pShow').css('top','5%');
	else
		$('.pShow').css('top',($(".popupBox").height()-$('.popup .inner').height())/2+'px');
	$('.pShow').css('left',($(".popupBox").width()-$('.popup .inner').width())/2+'px');
}

// $(".popupBox").resize(function() {
// 	locaTion();	
// })