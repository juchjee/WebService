package com.ubi.erp.comm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ubi.erp.comm.domain.MenuVO;
import com.ubi.erp.comm.service.MenuService;


@RestController
public class MenuController {

	@Autowired
	private MenuService menuService;

	@RequestMapping(value = "/erp/scm/menu", method = RequestMethod.POST)
	public List<MenuVO> selMenu(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true);
		String kind = request.getParameter("kind");
		MenuVO menuVO = new MenuVO();
		menuVO.setId((String) session.getAttribute("id"));
		menuVO.setKind(kind);
		return menuService.selMenuList(menuVO);
	}

}