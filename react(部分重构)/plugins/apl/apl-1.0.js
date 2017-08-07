
function apl(){
    //alert('apl');
    this.av = this;

    this.ajaxType = 'post'; //ajax请求类型，默认post
    this.ajaxDataType = 'json'; //ajax返回数据的格式，默认json

    //AJAX请求
    this.getAJAX = function(ajaxModuleName){
        let url;
        if(ajaxModuleName)
            url = `${this.ajaxHost}${this.ajaxModelName}/${ajaxModuleName}`;
        else
            url = `${this.ajaxHost}/${this.ajaxModelName}`;

        //alert(`url=${url}&type=${this.ajaxType}&dataType=${this.ajaxDataType}&data=${this.ajaxData}`);
        //http://192.168.1.116:86/exp5/price/doList&type=post&dataType=json&data=priceType=1

        $.ajax({
            url: url,
            type: this.ajaxType,
            cache: false,
            dataType: this.ajaxDataType,
            data: this.ajaxData,
            success: function(data){
                //alert(data);
                app.getData(data.rows);
            },
            error: function(XMLHttpRequest,status,errorThrown){
                //alert(errorThrown);
            }
        });
    };

}