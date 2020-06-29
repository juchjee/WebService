//캘린더
function dateTimeInput(id, option, firstVal){
	var defaultOption = {
		culture: 'ko'
		, formatString: 'd'
		, width: '96px'
		, height: '26px'
		, showFooter: true
		, animationType: 'none'
		, enableBrowserBoundsDetection:true
		, theme: 'custom'
	};
	if(option != undefined || option != null){
		$.extend(defaultOption, option);
	}
	if(firstVal != undefined && firstVal != null && firstVal != ''){
		if(firstVal.length > 10){
			defaultOption.value = firstVal.replace(/[.]0$/gi, "").replace(/-/gi, "/");
		}else{
			defaultOption.value = firstVal;
		}
	}else{
		defaultOption.value = null;
	}

	$("#"+id).jqxDateTimeInput(defaultOption);
    $("#input"+id).attr("name",id);

}