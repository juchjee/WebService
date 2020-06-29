package site.comm.startUpServer;

import java.lang.reflect.Field;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;

@Component("iConstant")
public final class IConstant implements IConstants{
	private static Map<String, String> iConstantsFieldsMap = null;
	public String get(String key){
		if(iConstantsFieldsMap == null){
			iConstantsFieldsMap = new HashMap<String, String>();
			Field[] fields = IConstants.class.getDeclaredFields();
			for (Field field : fields) {
				if("String".equals(field.getType().getSimpleName())){
					try {
						String value = (String) field.get(field);
						iConstantsFieldsMap.put(field.getName(), value);
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return iConstantsFieldsMap.get(key);
	}

	/**
	 * 요청한 페이지 URL
	 * @return
	 */
	public String getNowUri() {
		return EgovUserDetailsHelper.getNowUri().replaceFirst(ROOT_URI, "").replaceFirst(MNG_URI, "");
	}

	/**
	 * 현재 날짜
	 * @return
	 */
	public String nowYmd(){
		return CommonUtil.getNumberByPattern("yyyy-MM-dd");
	}

	/**
	 * 현재일 기준 월 계산 날짜
	 * @return
	 */
	public String prevMonthYmd(Integer monthNo){
		return CommonUtil.getNumberByPattern(CommonUtil.getDateAddMonth(new Date(), monthNo), "yyyy-MM-dd");
	}

	/**
	 * 현재일 기준  계산 날짜
	 * @return
	 */
	public String prevDayYmd(Integer dayNo){
		return CommonUtil.getNumberByPattern(CommonUtil.getDateAddDay(new Date(), dayNo), "yyyy-MM-dd");
	}



	/**
	 * 현재일 기준 월 계산 날짜
	 * @return
	 */
	public String prevMonthMKor(Integer monthNo){
		return CommonUtil.getNumberByPattern(CommonUtil.getDateAddMonth(new Date(), monthNo), "MM월");
	}

	/**
	 * 현재일 기준 일 계산 날짜
	 * @return
	 */
	public String prevDayMMddKor(Integer monthNo){
		return CommonUtil.getNumberByPattern(CommonUtil.getDateAddDay(new Date(), monthNo), "MM월 dd일");
	}


	/**
	 * 현재요일을 반환
	 */
	public static String getDayStr() throws Exception {
	    String day = "" ;
		Calendar rightNow = Calendar.getInstance();
	    int dayNum = rightNow.get(Calendar.DAY_OF_WEEK) ;

	    switch(dayNum){
	        case 1:
	            day = "일";
	            break ;
	        case 2:
	            day = "월";
	            break ;
	        case 3:
	            day = "화";
	            break ;
	        case 4:
	            day = "수";
	            break ;
	        case 5:
	            day = "목";
	            break ;
	        case 6:
	            day = "금";
	            break ;
	        case 7:
	            day = "토";
	            break ;

	    }
	    return day ;
	}




	public String prev1DayYmd(Integer dayNo) throws ParseException{
		String[] now = nowYmd().split("-");
		String nowDate = now[0]+now[1]+now[2];
		return CommonUtil.toOcsDateFormat(CommonUtil.getDateAddDay(nowDate, dayNo));
	}

}