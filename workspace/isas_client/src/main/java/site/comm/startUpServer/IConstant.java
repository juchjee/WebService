package site.comm.startUpServer;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.UAgentInfo;

@Component("iConstant")
public final class IConstant implements IConstants{

	private static Map<String, String> iConstantsFieldsMap = null;

	/**
	 * 상수 호출
	 * @param key
	 * @return
	 */
	public  String get(String key){
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
	 * 요청한 브라우저가 모바일 인지 여부
	 * @param request
	 * @return
	 */
	public boolean isMobile(HttpServletRequest request) {
		UAgentInfo uAgentInfo = new UAgentInfo(request);
		return uAgentInfo.detectMobileQuick();
	}

	/**
	 * 요청한 페이지 URL
	 * @return
	 */
	public String getNowUri() {
		return CommonUtil.getWebUrl(EgovUserDetailsHelper.getNowUri());
	}

	/**
	 * 요청한 페이지가 스토어 인지 여부
	 * @param regex
	 * @return
	 */
	public boolean isStore(){
		return (getNowUri().indexOf("store/store.do") > -1) || (getNowUri().indexOf("store/guide_all.do") > -1) || (getNowUri().indexOf("store/guide.do") > -1) || (getNowUri().indexOf("store_view.do") > -1);
	}

	/**
	 * 로그인 여부
	 * @return
	 */
	public boolean isLogIn(){
		return EgovUserDetailsHelper.isAuthenticated();
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
	 * 무구열이 포함 되어 있는지 여부
	 * @param str
	 * @param regex
	 * @return
	 */
	public boolean indexOf(String str, String regex){
		if(str == null) return false;
		if(regex == null) return false;
		return str.indexOf(regex) > -1;
	}
}
