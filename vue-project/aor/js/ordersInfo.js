
	var url = 'http://192.168.1.135:9441' + '/updateOrder/doListAll';
	var postData = 'id=' + APLDevel.getUrlParam("id");
	$.ajax({
		type:'post',
        url:url,
        data:postData,
        dataType:'json',
		success:function(data) {
			data = data.listAll.rows;
			new Vue({
			    el: '#exp',
			    data: {
			    	items:data
			    }
			});
		},
		error:function() {
			alert('查询失败');
		}
	})

