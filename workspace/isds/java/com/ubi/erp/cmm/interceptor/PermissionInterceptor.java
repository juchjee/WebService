package com.ubi.erp.cmm.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ubi.erp.comm.service.MenuService;

public class PermissionInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MenuService menuService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		String reqUri = request.getRequestURI();

		if ("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
			return true;
		} else {
			if ("/erp/scm/login.do".equals(reqUri) || "/erp/scm/logout.do".equals(reqUri) || "/erp/scm/main.do".equals(reqUri) || reqUri.indexOf("POP") > 0 || reqUri.indexOf("report") > 0) {
				return true;
			} else if ("/erp/scm/work/partners/instPayment/billingFileSave.do".equals(reqUri) || "/erp/scm/work/partners/remicon/remiconS.do".equals(reqUri)
					|| "/erp/scm/work/partners/orderDelivery/inboundDetailR.do".equals(reqUri) || "/erp/scm/work/partners/instPayment/billingExcelUpload.do".equals(reqUri)) {
				return true;
			} else if ("/erp/scm/changePassword.do".equals(request.getRequestURI()) || "/erp/scm/userRegS.do".equals(request.getRequestURI())) {
				return true;
			} else {
				String id = (String) session.getAttribute("id");

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				map.put("uri", reqUri);

				boolean permission = menuService.getPermission(map);

				if (permission) {
					return true;
				} else {
					response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					response.sendRedirect("/sys/error/notPermission.jsp");
					return false;
				}
			}
		}
	}
}