package com.ubi.erp.cmm.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.comm.service.MenuService;

@Service
public class MobileInterceptor {

	@Autowired
	private MenuService menuService;

	public String returnUri(HttpServletRequest request, HttpServletResponse response) {
		String returnUri = null;
		HttpSession session = request.getSession(false);
		String uri = request.getRequestURI();
		String id = (String) session.getAttribute("id");
		if (session != null && id != null) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("uri", uri);
			boolean permission = menuService.getPermission(map);
			if (permission) {
				returnUri = uri;
			} else {
				returnUri = "/mobile/scm/main/permissionError.do";
			}
		} else {
			returnUri = "/mobile/scm/main/sessionError.do";
		}
		return returnUri;
	}
}
