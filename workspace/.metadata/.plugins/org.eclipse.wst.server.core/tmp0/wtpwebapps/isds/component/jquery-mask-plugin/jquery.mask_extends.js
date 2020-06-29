/**
 *
 */
var msk_options =  {
  onInvalid: function(val, e, f, invalid, options){
	var error = invalid[0];
	var offset = $(e.currentTarget).offset();
	var posY = offset.top - $(window).scrollTop();
	var posX = offset.left - $(window).scrollLeft();

	dhtmlx.message({
	    text:"잘못 된 값입니다.",
	    expire:500

	});

	$( ".dhtmlx_message_area" ).css("top",posY-30).css("left",posX).css("position","absoulte");
  }
};

$(function(){
	  $('.format_date').mask('0000/00/00', $.extend(msk_options,{placeholder: "____/__/__"}));
	  $('.format_month').mask('0000/00', $.extend(msk_options,{placeholder: "____/__"}));
	  $('.format_time').mask('00:00', $.extend(msk_options,{placeholder: "__:__"}));
	  $('.format_jumin').mask('000000-0000000', $.extend(msk_options,{placeholder: "______-_______"}));
	  $('.format_foreNo').mask('000000-0000000', $.extend(msk_options,{placeholder: "______-_______"}));
	  $('.format_saupja').mask('000-00-00000', $.extend(msk_options,{placeholder: "___-__-_____"}));
	  $('.format_bupin').mask('000000-0000000', $.extend(msk_options,{placeholder: "______-_______"}));
	  $('.format_mobileNo').mask('000-0000-0000', $.extend(msk_options));
	  $('.format_int').mask('#,##0',{reverse: true},$.extend(msk_options));

});