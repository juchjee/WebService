package egovframework.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.MessageBox;
import site.comm.service.impl.CommStatic;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */


public class AuthenticInterceptor extends HandlerInterceptorAdapter implements IConstants{

	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 * 요청 url을 체크해서 접근 권한이 있는지 확인 한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (EgovUserDetailsHelper.isAuthenticated()) {
			if(CommStatic.isAdmAuthCd(request)){
				return true;
			}else{
				throw new ModelAndViewDefiningException(setMessageRedirect("정상적인 접근이 아닙니다."));
			}
		} else {
			throw new ModelAndViewDefiningException(setMessageRedirect("해당 페이지는 로그인 후 이용 가능 합니다."));
		}
	}

	private static ModelAndView setMessageRedirect(String message){
		ModelAndView modelAndView = new ModelAndView("common/messageRedirect");
		modelAndView.addObject(MESSAGE_BOX_KEY, new MessageBox("alert.message", message));
		modelAndView.addObject("rootUri", ROOT_URI);
		modelAndView.addObject("mngUri", MNG_URI);
		modelAndView.addObject("location", MAIN_PAGE);
		return modelAndView;
	}

}
