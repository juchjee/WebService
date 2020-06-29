package com.ubi.erp.cmm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		if (session != null && (String) session.getAttribute("id") != null) {
			return true;
		} else {
			if ("/erp/scm/login.do".equals(request.getRequestURI()) || "/erp/scm/changePassword.do".equals(request.getRequestURI()) || "/erp/scm/userRegS.do".equals(request.getRequestURI())
					|| "/erp/scm/work/report/perNoSearch.do".equals(request.getRequestURI())) {
				return true;
			} else {
				response.setStatus(HttpServletResponse.SC_FORBIDDEN);
				response.sendRedirect("/sys/error/401.jsp");
				return false;
			}
		}
	}
}