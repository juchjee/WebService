package com.ubi.erp.mobile.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.comm.domain.MenuVO;
import com.ubi.erp.comm.service.MenuService;

@Controller
public class MobileMainController {

	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = "/mobile/scm/main/main")
	public ModelAndView sessionChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		if (session != null && (String) session.getAttribute("id") != null) {
			mav.setViewName("/mobile/scm/main/main.do");
		} else {
			mav.setViewName("/mobile/scm/main/sessionError.do");
		}
		return mav;
	}

	@RequestMapping(value = "/mobile/scm/main/list")
	public @ResponseBody List<MenuVO> menuList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setId((String) session.getAttribute("id"));
		menuVO.setKind("mobile");
		return menuService.selMenuList(menuVO);
	}

}
