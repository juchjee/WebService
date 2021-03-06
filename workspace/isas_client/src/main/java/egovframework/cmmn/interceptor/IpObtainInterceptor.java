package egovframework.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;


/**
 * 사용자IP 체크 인터셉터
 * @author 유지보수팀 이기하
 * @since 2013.03.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일     수정자          수정내용
 *  ----------  --------    ---------------------------
 *  2013.03.28	이기하          최초 생성
 *  </pre>
 */

public class IpObtainInterceptor extends HandlerInterceptorAdapter implements IConstants{

	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(IpObtainInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String remoteAddr = request.getRemoteAddr();
		String loginIp = "";
		boolean isPass = true;
		if (EgovUserDetailsHelper.isAuthenticated()) {
			loginIp = EgovUserDetailsHelper.getMbrLoginIp();
			/*if(!loginIp.equals(remoteAddr)){
				isPass = false;
			}*/
		}
		EgovUserDetailsHelper.setNowUri(request.getRequestURI());
		if(IS_SHOW_LOG){
			StringBuilder sb = new StringBuilder();
			sb.append(remoteAddr);
			sb.append(", loginIp : " + loginIp);
			sb.append(", RequestURI : " + EgovUserDetailsHelper.getNowUri());
			sb.append("\nRequestParams : " + CommonUtil.mapToJsonString(request.getParameterMap()));
			sb.trimToSize();
			logger.debug(sb.toString());
		}
		return isPass;
	}
}
