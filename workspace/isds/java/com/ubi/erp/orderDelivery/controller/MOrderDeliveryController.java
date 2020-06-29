package com.ubi.erp.orderDelivery.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.orderDelivery.domain.MOrderDeliveryVO;
import com.ubi.erp.orderDelivery.service.MOrderDeliveryService;

@RestController
@RequestMapping("/erp/scm/manufacture/partners")
public class MOrderDeliveryController {

	@Autowired
	private MOrderDeliveryService service;

	// 제조 팝업 및 기타
	@RequestMapping(value = "/orderDelivery/facCdSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selFacCd(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String id = (String) session.getAttribute("id");
		MOrderDeliveryVO mOrderDeliveryVO = new MOrderDeliveryVO();
		mOrderDeliveryVO.setId(id);
		return service.selFacCd(mOrderDeliveryVO);
	};

	@RequestMapping(value = "/orderDelivery/facCdAllSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selAllFacCd(HttpServletRequest request, HttpServletResponse response, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		return service.selAllFacCd(mOrderDeliveryVO);
	};

	@RequestMapping(value = "/orderDelivery/deliveryS/deliverySeq", method = RequestMethod.POST)
	public MOrderDeliveryVO selManuDeliverySeq(HttpServletRequest request, HttpServletResponse response, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		return service.selManuDeliverySeq(mOrderDeliveryVO);
	};

	// 제조 발주확인등록 및 현황
	@RequestMapping(value = "/orderDelivery/orderChkS/gridMainSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selManuOrderChkS(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selManuOrderChkS(mOrderDeliveryVO);
	};

	@RequestMapping(value = "/orderDelivery/orderChkS/gridMainSave", method = RequestMethod.POST)
	public void prcsManuOrderChkS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("custCd");
			String jsonData = request.getParameter("jsonData");
			List<MOrderDeliveryVO> list = new ArrayList<MOrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<MOrderDeliveryVO>>() {
			});

			service.prcsManuOrderChkS(list, id, custCd);

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
	};

	@RequestMapping(value = "/orderDelivery/orderChkR/gridMainSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selManuOrderChkR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selManuOrderChkR(mOrderDeliveryVO);
	};

	// 제조 납품등록
	@RequestMapping(value = "/orderDelivery/deliveryS/gridMainSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selManuDeliverySMst(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selManuDeliverySMst(mOrderDeliveryVO);
	};

	@RequestMapping(value = "/orderDelivery/deliveryS/outsEndYnChk", method = RequestMethod.POST)
	public void prcsOutsEndYn(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String jsonData = request.getParameter("jsonData2");
			List<MOrderDeliveryVO> list = new ArrayList<MOrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<MOrderDeliveryVO>>() {
			});

			service.prcsOutsEndYn(list);

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
	};

	@RequestMapping(value = "/orderDelivery/deliveryS/selQtyCheck", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selManuDeliveryDeliQty(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selManuDeliveryDeliQty(mOrderDeliveryVO);
	};

	@RequestMapping(value = "/orderDelivery/deliveryS/gridSubSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selManuDeliverySSub(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selManuDeliverySSub(mOrderDeliveryVO);
	};

	@RequestMapping(value = "/orderDelivery/deliveryS/gridSubSave", method = RequestMethod.POST)
	public void prcsDeliveryS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String jsonData = request.getParameter("jsonData");
			List<MOrderDeliveryVO> list = new ArrayList<MOrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<MOrderDeliveryVO>>() {
			});

			service.prcsManuDeliveryS(list, id);

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
	};

	@RequestMapping(value = "/orderDelivery/deliveryR/gridMainSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selManuDeliveryR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selManuDeliveryR(mOrderDeliveryVO);
	}

	// 제조 입고현황
	@RequestMapping(value = "/orderDelivery/inboundR/gridMainSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selInboundR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		mOrderDeliveryVO.setCustCd(custCd);
		return service.selInboundR(mOrderDeliveryVO);
	}

	// 납품대비 입고현황
	@RequestMapping(value = "/orderDelivery/deliInboundR/gridMainSearch", method = RequestMethod.POST)
	public List<MOrderDeliveryVO> selDeliInboundR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MOrderDeliveryVO mOrderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("custCd");
		String id = (String) session.getAttribute("id");
		mOrderDeliveryVO.setCustCd(custCd);
		mOrderDeliveryVO.setId(id);
		return service.selDeliInboundR(mOrderDeliveryVO);
	}

}
