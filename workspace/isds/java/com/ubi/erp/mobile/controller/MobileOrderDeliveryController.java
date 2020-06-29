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
import com.ubi.erp.orderDelivery.domain.OrderDeliveryVO;
import com.ubi.erp.orderDelivery.service.MOrderDeliveryService;
import com.ubi.erp.orderDelivery.service.OrderDeliveryService;

@Controller
public class MobileOrderDeliveryController {

	@Autowired
	private OrderDeliveryService orderDeliveryService;

	@Autowired
	private MOrderDeliveryService mOrderDeliveryService;

	@Autowired
	private MobileInterceptor mobileInterceptor;

	@RequestMapping(value = "/mobile/scm/orderDelivery/orderChk")
	public ModelAndView sessionChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String uri = mobileInterceptor.returnUri(request, response);
		mav.setViewName(uri);
		return mav;
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/selOrderChk", method = RequestMethod.POST)
	public @ResponseBody List<OrderDeliveryVO> selOrderChkM(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return orderDeliveryService.selWorkOrderChkS(orderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/prcsOrderChk", method = RequestMethod.POST)
	public @ResponseBody void prcsOrderChkS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");
			List<OrderDeliveryVO> list = new ArrayList<OrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<OrderDeliveryVO>>() {
			});
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setOutsCon("1");
			}
			orderDeliveryService.prcsWorkOrderChkS(list, id, custCd);

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

	@RequestMapping(value = "/mobile/scm/orderDelivery/mAgencyShipR/facCombo")
	public @ResponseBody List<MOrderDeliveryVO> selComboFacCd(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		return mOrderDeliveryService.selComboFacCd(mOrderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/mAgencyShipR/custCombo")
	public @ResponseBody List<MOrderDeliveryVO> selComboCustCd(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		// 대리점용이므로 각자 거래처코드만 나오도록 수정
		String custCd = (String) session.getAttribute("erpCustCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return mOrderDeliveryService.selComboCustCd(mOrderDeliveryVO);
	}

	// 제조 입고현황
	@RequestMapping(value = "/mobile/scm/orderDelivery/mAgencyShipR/list", method = RequestMethod.POST)
	public @ResponseBody List<MOrderDeliveryVO> selAgencyShipR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String frDt = (String) request.getParameter("frDt");
		String toDt = (String) request.getParameter("toDt");
		String facCd = (String) request.getParameter("facCd");
		String custCd = (String) request.getParameter("custCd");

		mOrderDeliveryVO.setFrDt(frDt);
		mOrderDeliveryVO.setToDt(toDt);
		mOrderDeliveryVO.setFacCd(facCd);
		mOrderDeliveryVO.setCustCd(custCd);

		return mOrderDeliveryService.selAgencyShipR(mOrderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/mAgencyShipDtlR/list", method = RequestMethod.POST)
	public @ResponseBody List<MOrderDeliveryVO> selAgencyShipDtlR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String outNo = (String) request.getParameter("outNo");
		String outSq = (String) request.getParameter("outSq");

		mOrderDeliveryVO.setOutNo(outNo);
		mOrderDeliveryVO.setOutSq(outSq);

		return mOrderDeliveryService.selAgencyShipDtlR(mOrderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/mSalesShipR/salesDeptCd")
	public @ResponseBody List<MOrderDeliveryVO> selComboSalesDept(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		return mOrderDeliveryService.selComboSalesDept(mOrderDeliveryVO);
	}

	@RequestMapping(value = "/mobile/scm/orderDelivery/mSalesShipR/salesEmpCombo")
	public @ResponseBody List<MOrderDeliveryVO> selComboSalesEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		// 대리점용이므로 각자 거래처코드만 나오도록 수정
		String deptCd = (String) request.getParameter("deptCd");
		mOrderDeliveryVO.setDeptCd(deptCd);
		return mOrderDeliveryService.selComboSalesEmp(mOrderDeliveryVO);
	}

	// 출하현황(영업용) 조회
	@RequestMapping(value = "/mobile/scm/orderDelivery/mSalesShipR/list", method = RequestMethod.POST)
	public @ResponseBody List<MOrderDeliveryVO> selSalesShipR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String deptCd = (String) request.getParameter("deptCd");
		String empNo = (String) request.getParameter("empNo");
		String outDt = (String) request.getParameter("outDt");
		String facCd = (String) request.getParameter("facCd");

		mOrderDeliveryVO.setDeptCd(deptCd);
		mOrderDeliveryVO.setEmpNo(empNo);
		mOrderDeliveryVO.setOutDt(outDt);
		mOrderDeliveryVO.setFacCd(facCd);

		return mOrderDeliveryService.selSalesShipR(mOrderDeliveryVO);
	}

	// 출하현황(영업용) 조회 detail
	@RequestMapping(value = "/mobile/scm/orderDelivery/mSalesShipDtlR/list", method = RequestMethod.POST)
	public @ResponseBody List<MOrderDeliveryVO> mSalesShipDtlR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String outNo = (String) request.getParameter("outNo");
		String outSq = (String) request.getParameter("outSq");

		mOrderDeliveryVO.setOutNo(outNo);
		mOrderDeliveryVO.setOutSq(outSq);

		return mOrderDeliveryService.selSalesShipDtlR(mOrderDeliveryVO);
	}
}
