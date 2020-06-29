package com.ubi.erp.mobile.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
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
import com.ubi.erp.orderDelivery.domain.MOrderDeliveryVO;
import com.ubi.erp.orderDelivery.service.MOrderDeliveryService;

@Controller
public class MoblieMorderDeliveryController {

	@Autowired
	private MOrderDeliveryService mOrderDeliveryService;

	@Autowired
	private MobileInterceptor mobileInterceptor;

	@RequestMapping(value = "/mobile/scm/orderDelivery/mOrderChk")
	public ModelAndView sessionChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String uri = mobileInterceptor.returnUri(request, response);
		mav.setViewName(uri);
		return mav;
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/MOrderChk/combo")
	public @ResponseBody List<MOrderDeliveryVO> selFacCdMobile(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String id = (String) session.getAttribute("id");
		mOrderDeliveryVO.setId(id);
		return mOrderDeliveryService.selFacCdMobile(mOrderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/selMOrderChk", method = RequestMethod.POST)
	public @ResponseBody List<MOrderDeliveryVO> selOrderChkM(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return mOrderDeliveryService.selManuOrderChkS(mOrderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/prcsMOrderChk", method = RequestMethod.POST)
	public @ResponseBody void prcsOrderChkS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("custCd");
			String jsonData = request.getParameter("jsonData");
			List<MOrderDeliveryVO> list = new ArrayList<MOrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<MOrderDeliveryVO>>() {
			});

			for (int i = 0; i < list.size(); i++) {
				list.get(i).setOutsCon("1");
			}

			mOrderDeliveryService.prcsManuOrderChkS(list, id, custCd);

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
