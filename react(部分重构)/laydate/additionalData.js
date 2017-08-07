$(function(){
   startEnd();
})
$(function() {
  startEnd();
})
function startEnd() {
    var start = {
      elem: '#start',
      format: 'YYYY-MM-DD hh:mm',
      // min: 'laydate.now()', //设定最小日期为当前日期
      //min: '', //设定最小日期为当前日期
      //max: '', //最大日期
      // max: '2099-06-16 23:59:59', //最大日期
      istime: true,
      istoday: false,
      choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas //将结束日的初始值设定为开始日
      }
    };
    var end = {
      elem: '#end',
      format: 'YYYY-MM-DD hh:mm',
      //min: '',
      // min: laydate.now(),
      //max: '',
      // max: '2099-06-16 23:59:59',
      istime: true,
      istoday: false,
      choose: function(datas){
        start.max = datas; //结束日选好后，重置开始日的最大日期
      }
    };
    laydate(start);
    laydate(end);
}
