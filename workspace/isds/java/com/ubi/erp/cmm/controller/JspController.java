package com.ubi.erp.cmm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.cmm.util.JsonUtil;

@Controller
public class JspController {

	@RequestMapping(value = "/erp/**/*.do", method = RequestMethod.GET)
	public ModelAndView pcGet(HttpServletRequest req, HttpServletResponse res) {
		String uri = req.getRequestURI();
		ModelAndView mav = new ModelAndView();
		mav.setViewName(uri);

		req.setAttribute("PARAM_INFO", JsonUtil.parseToString(req.getParameterMap()));

		return mav;
	}

	@RequestMapping(value = "mobile/**/*.do")
	public ModelAndView mobileGet(HttpServletRequest req, HttpServletResponse res) {
		String uri = req.getRequestURI();
		ModelAndView mav = new ModelAndView();
		mav.setViewName(uri);
		return mav;
	}

	@RequestMapping(value = "/erp/scm/login.do", method = RequestMethod.POST)
	public ModelAndView loginPost(HttpServletRequest req, HttpServletResponse res) {
		String uri = req.getRequestURI();
		ModelAndView mav = new ModelAndView();
		mav.setViewName(uri);
		req.setAttribute("PARAM_INFO", JsonUtil.parseToString(req.getParameterMap()));
		return mav;
	}

}
