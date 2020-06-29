package egovframework.cmmn.interceptor;

import egovframework.cmmn.vo.LoginVO;

/**
 * EgovUserDetails Helper 클래스
 *
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon         최초 생성
 *   2011.07.01	 서준식          interface 생성후 상세 로직의 분리
 * </pre>
 */

public class EgovUserDetailsHelper {

	static EgovUserDetailsService egovUserDetailsService;

	public EgovUserDetailsService getEgovUserDetailsService() {
		return egovUserDetailsService;
	}

	public void setEgovUserDetailsService(EgovUserDetailsService egovUserDetailsService) {
		EgovUserDetailsHelper.egovUserDetailsService = egovUserDetailsService;
	}

	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	public static LoginVO getAuthenticatedUser() {
		if(egovUserDetailsService != null) return egovUserDetailsService.getAuthenticatedUser();
		return null;
	}

	/**
	 * 인증된 사용자 아이디를 거져온다.
	 * @return
	 */
	public static String getMbrId(){
		return egovUserDetailsService.getMbrId();
	}


	/**
	 * 인증된 사용자 IP를 거져온다.
	 * @return
	 */
	public static String getMbrLoginIp(){
		return egovUserDetailsService.getMbrLoginIp();
	}

	/**
	 * 인증된 사용자 여부를 체크한다.
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
	 */
	public static Boolean isAuthenticated() {
		return egovUserDetailsService.isAuthenticated();
	}

	/**
	 * 요청 받은 url
	 * @return
	 */
	public static String getNowUri() {
		return egovUserDetailsService.getAttributeString("nowUri");
	}

	public static void setNowUri(String value) {
		egovUserDetailsService.setAttributeString("nowUri", value);
	}

	public static Object getAttribute(String name){
		return egovUserDetailsService.getAttribute(name);
	}

	public static void setAttribute(String name, Object value){
		egovUserDetailsService.setAttribute(name, value);
	}

	public static String getAttributeString(String name){
		return egovUserDetailsService.getAttributeString(name);
	}

	public static void setAttributeString(String name, String value){
		egovUserDetailsService.setAttributeString(name, value);
	}

	public static void removeAttribute(String name){
		egovUserDetailsService.removeAttribute(name);
	}

	public static void removeAllAttribute(){
		egovUserDetailsService.removeAllAttribute();
	}
}
