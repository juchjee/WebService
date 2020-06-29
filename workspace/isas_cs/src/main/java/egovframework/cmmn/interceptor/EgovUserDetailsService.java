package egovframework.cmmn.interceptor;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.cmmn.vo.LoginVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 *
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 6. 25.
 * @version 1.0
 * @see
 *
 * <pre>
 * 개정이력(Modification Information)
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 12.    서준식        최초생성
 *
 *  </pre>
 */

public class EgovUserDetailsService extends EgovAbstractServiceImpl{

	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	public LoginVO getAuthenticatedUser() {
		if (RequestContextHolder.getRequestAttributes() == null) {
			return null;
		}
		return (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * 인증된 사용자 아이디를 거져온다.
	 * @return
	 */
	public String getMbrId() {
		LoginVO loginVO = getAuthenticatedUser();
		String mbrId = "";
		if (loginVO != null) {
			mbrId = loginVO.getMbrId();
		}
		return mbrId;
	}

	/**
	 * 인증된 사용자 IP를 거져온다.
	 * @return
	 */
	public String getMbrLoginIp() {
		LoginVO loginVO = getAuthenticatedUser();
		String mbrLoginIp = "";
		if (loginVO != null) {
			mbrLoginIp = loginVO.getMbrLoginIp();
		}
		return mbrLoginIp;
	}

	/**
	 * 인증된 사용자 여부를 체크한다.
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
	 */
	public Boolean isAuthenticated() {
		// 인증된 유저인지 확인한다.
		if (getAuthenticatedUser() == null) {
			return false;
		} else {
			return true;
		}
	}

	public Object getAttribute(String name){
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		Object reValue = null;
		if (requestAttributes != null) {
			reValue = requestAttributes.getAttribute(name, RequestAttributes.SCOPE_SESSION);
		}
		return reValue;
	}

	public void setAttribute(String name, Object value){
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		if (requestAttributes != null) {
			requestAttributes.setAttribute(name, value, RequestAttributes.SCOPE_SESSION);
		}
	}

	public String getAttributeString(String name){
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		String reValue = "";
		if (requestAttributes != null) {
			reValue = (String) requestAttributes.getAttribute(name, RequestAttributes.SCOPE_SESSION);
		}
		return reValue;
	}

	public void setAttributeString(String name, String value){
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		if (requestAttributes != null) {
			requestAttributes.setAttribute(name, value, RequestAttributes.SCOPE_SESSION);
		}
	}

	public void removeAttribute(String name){
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		if (requestAttributes != null) {
			requestAttributes.removeAttribute(name, RequestAttributes.SCOPE_SESSION);
		}
	}

	public void removeAllAttribute(){
		RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
		if (requestAttributes != null) {
			String[] attributeNames = requestAttributes.getAttributeNames(RequestAttributes.SCOPE_SESSION);
			for (String name : attributeNames) {
				requestAttributes.removeAttribute(name, RequestAttributes.SCOPE_SESSION);
			}
		}
	}
}
