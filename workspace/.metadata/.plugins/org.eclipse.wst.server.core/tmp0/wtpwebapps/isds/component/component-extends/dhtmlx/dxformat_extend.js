function dateformat(date){
	var isdate= date;      

        var yyyy = isdate.getFullYear().toString();       
        var mm = (isdate.getMonth()+1).toString();       
        var dd  = isdate.getDate().toString();                                   
        return yyyy + '/' + (mm[1]?mm:"0"+mm[0]) + '/' + (dd[1]?dd:"0"+dd[0]);
};

function dateformat2(date){ 
	var isdate= date;      

        var yyyy = isdate.getFullYear().toString();       
        var mm = (isdate.getMonth()+1).toString();       
        var dd  = isdate.getDate().toString();                                   
        return yyyy  + (mm[1]?mm:"0"+mm[0]) + (dd[1]?dd:"0"+dd[0]);
};

function fn_monthLen(month){
	 var initMonth;
		if(month < 10){		
			initMonth = "0"+month;
		}else{
			initMonth = month;
		}
		return initMonth;
};

function dateMask(data){
	var maskDate = null;
	if(data != null && data !=''){
	 var yyyy = data.substring(0,4);      
     var mm = data.substring(4,6);     
     var dd  = data.substring(6,8);   
     maskDate = yyyy+'/'+mm+'/'+dd;
	}else{
		maskDate = data;
	}
     return maskDate;
};

function dateTimeMask(data){
	var maskTime = null;
	if(data != null && data !=''){
	 var hh = data.substring(0,2);      
     var MM = data.substring(2,4);       
     maskTime = hh+':'+MM;
	}else{
		maskTime = data;
	}
     return maskTime;
};

function dateMaskM(data){
	var maskDateM = null;
	if(data != null && data !=''){
		var yyyy = data.substring(0,4);      
		var mm = data.substring(4,6);     
		maskDateM = yyyy+'/'+mm;
	}else{
		maskDateM = data;
	}
	return maskDateM;
};

function juminMask(data){
	var maskJumin = null;
	if(data != null && data !=''){
		var preValue = data.substring(0,6);
		var nextValue = data.substring(6,13);  
		//var nextValue = ' *******';
		maskJumin = preValue+'-'+nextValue;
		}else{
			maskJumin = data;
		}
	return maskJumin;	
};

function mobileMask(data){
	var maskMobile = null;
	if(data != null && data !=''){
		var preValue = data.substring(0,3);
		var nextValue = data.substring(3,7);  
		var lastValue = data.substring(7,11);  
		maskMobile = preValue+'-'+nextValue+'-'+lastValue;
	}else{
		maskMobile = data;
	}
	return maskMobile;	
};

function saupjaMask(data){
	var maskSaupja = null;
	if(data != null && data !=''){
		var preValue = data.substring(0,3);
		var nextValue = data.substring(3,5);  
		var lastValue = data.substring(5,10);  
		maskSaupja = preValue+'-'+nextValue+'-'+lastValue;
	}else{
		maskSaupja = data;
	}
	return maskSaupja;	
};

function bupinMask(data){
	var maskBupin = null;
	if(data != null && data !=''){
		var preValue = data.substring(0,6);
		var nextValue = data.substring(6,13);  
		//var lastValue = data.substring(4,10);  
		maskBupin = preValue+'-'+nextValue//+'-'+lastValue;
	}else{
		maskBupin = data;
	}
	return maskBupin;
};