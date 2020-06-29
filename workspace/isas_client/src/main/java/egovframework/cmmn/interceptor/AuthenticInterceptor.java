package egovframework.cmmn.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.MessageBox;

public class AuthenticInterceptor extends HandlerInterceptorAdapter implements IConstants{

	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (EgovUserDetailsHelper.isAuthenticated()) {
			return true;
		} else {
			Map<String, Object> dataMap = new HashMap<>();
			dataMap.putAll(request.getParameterMap());
			String referUrl = request.getParameter("referUrl");
			if(referUrl == null || "".equals(referUrl)){
				dataMap.put("referUrl", request.getRequestURI());
			}else{
				dataMap.put("referUrl", CommonUtil.getWebUrl(referUrl));
			}
			EgovUserDetailsHelper.setAttribute("loginParams", dataMap);
			throw new ModelAndViewDefiningException(setMessageRedirect("해당 페이지는 로그인 후 이용 가능 합니다."));
		}
	}

	private static ModelAndView setMessageRedirect(String message){
		ModelAndView modelAndView = new ModelAndView("common/messageRedirect");
		modelAndView.addObject(MESSAGE_BOX_KEY, new MessageBox("alert.message", message));
		modelAndView.addObject("rootUri", ROOT_URI);
		modelAndView.addObject("frontUri", ISDS_URL);
		modelAndView.addObject("location", LOGIN_PAGE);
		return modelAndView;
	}
}
