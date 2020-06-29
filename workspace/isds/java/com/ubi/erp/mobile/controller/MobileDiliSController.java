package com.ubi.erp.mobile.controller;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.cmm.interceptor.MobileInterceptor;
import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.dailyWork.domain.DailyWorkVO;
import com.ubi.erp.dailyWork.service.DailyWorkService;

@Controller
public class MobileDiliSController {

	@Autowired
	private MobileInterceptor mobileInterceptor;

	@Autowired
	private DailyWorkService dailyWorkService;

	@RequestMapping(value = "/mobile/scm/dailyWork/indivisualDiliS")
	public ModelAndView sessionChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String uri = mobileInterceptor.returnUri(request, response);
		mav.setViewName(uri);
		return mav;
	}

	@RequestMapping(value = "/mobile/scm/dailyWork/indivisualDiliS/list", method = RequestMethod.POST)
	public @ResponseBody List<DailyWorkVO> searchList(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return dailyWorkService.selIndividualDili(dailyWorkVO);
	}

	@RequestMapping(value = "/mobile/scm/dailyWork/indivisualDiliS/combo")
	public @ResponseBody List<DailyWorkVO> selSiteCdMobile(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {
		String id = (String) session.getAttribute("id");
		dailyWorkVO.setId(id);
		return dailyWorkService.selSiteCdMobile(dailyWorkVO);
	}

	@RequestMapping(value = "/mobile/scm/dailyWork/indivisualDiliS/save", method = RequestMethod.POST)
	public @ResponseBody void prcsIndividualDili(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			dailyWorkVO.setId(id);
			dailyWorkVO.setCustCd(custCd);
			dailyWorkService.prcsIndividualDili(dailyWorkVO);
			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
		} catch (Exception e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR002");
		} finally {
			if (!ht.isEmpty()) {
				response.setHeader("EXCEPTION", "Y");
				MakeResponseUtil.makeResponse(response, "json", JsonUtil.parseToString(ht));
			}
		}
	}
}
