package com.ubi.erp.orderDelivery.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.orderDelivery.domain.OrderDeliveryVO;
import com.ubi.erp.orderDelivery.service.OrderDeliveryService;

@RestController
@RequestMapping("/erp/scm/work/partners")
public class OrderDeliveryController {

	@Autowired
	private OrderDeliveryService service;

	// 공사 발주확인등록 및 현황
	@RequestMapping(value = "/orderDelivery/orderChkS/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selOrderChkS(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selWorkOrderChkS(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/orderChkS/gridMainSave", method = RequestMethod.POST)
	public void prcsOrderChkS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");
			List<OrderDeliveryVO> list = new ArrayList<OrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<OrderDeliveryVO>>() {
			});

			service.prcsWorkOrderChkS(list, id, custCd);

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

	@RequestMapping(value = "/orderDelivery/orderChkR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selOrderChkR(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selWorkOrderChkR(orderDeliveryVO);
	}

	// 공사 납품등록 및 현황
	@RequestMapping(value = "/orderDelivery/deliveryS/deliverySeq", method = RequestMethod.POST)
	public OrderDeliveryVO selWorkDeliverySeq(HttpServletRequest request, HttpServletResponse response, OrderDeliveryVO orderDeliveryVO) throws Exception {
		return service.selWorkDeliverySeq(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/deliveryS/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selDeliverySMst(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selWorkDeliverySMst(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/deliveryS/gridSubSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selDeliverySSub(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selWorkDeliverySSub(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/deliveryS/gridSubSave", method = RequestMethod.POST)
	public void prcsDeliveryS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String jsonData = request.getParameter("jsonData");
			List<OrderDeliveryVO> list = new ArrayList<OrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<OrderDeliveryVO>>() {
			});

			service.prcsWorkDeliveryS(list, id);

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

	@RequestMapping(value = "/orderDelivery/deliveryR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selDeliveryR(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selWorkDeliveryR(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/deliveryR/report/reportSch")
	public ModelAndView invoiceP(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");

		String siteCd = request.getParameter("siteCd");
		String stBalDt = request.getParameter("stBalDt");
		String edBalDt = request.getParameter("edBalDt");
		String nowDate = request.getParameter("nowDate");

		OrderDeliveryVO orderDeliveryVO = new OrderDeliveryVO();
		orderDeliveryVO.setCustCd(custCd);
		orderDeliveryVO.setSiteCd(siteCd);
		orderDeliveryVO.setStBalDt(stBalDt);
		orderDeliveryVO.setEdBalDt(edBalDt);

		List<OrderDeliveryVO> list = service.selWorkDeliveryRPrint(orderDeliveryVO);
		list.get(0).setNowDate(nowDate);
		int result = list.size() % 30;
		int sizeNum = 0;
		sizeNum = 30 - result;

		if (list.size() < 30) {
			OrderDeliveryVO orderDeliveryVO2 = new OrderDeliveryVO();
			for (int j = 0; j < sizeNum; j++) {
				list.add(orderDeliveryVO2);
			}
		}

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("invoiceP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	// 레미콘 RFID 등록 및 현황
	@RequestMapping(value = "/remicon/remiconR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconRMst(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		String id = (String) session.getAttribute("id");
		orderDeliveryVO.setCustCd(custCd);
		orderDeliveryVO.setId(id);
		return service.selRemiconRMst(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconR/gridSubSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconRSub(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		return service.selRemiconRSub(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconS/selRfidSqNo", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconRfidSqNo(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selRemiconRfidSqNo(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconS/formSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconSForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selRemiconSForm(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconS/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconSGrid(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selRemiconSGrid(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconS/selRemiconSumItemQn", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconSumItemQn(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selRemiconSumItemQn(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconS/remiconSExists", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconSExists(HttpServletRequest request, HttpServletResponse response, OrderDeliveryVO orderDeliveryVO) throws Exception {
		return service.selRemiconSExists(orderDeliveryVO);
	}

	@RequestMapping(value = "/remicon/remiconS/gridMainSave", method = RequestMethod.POST)
	public void prcsRemiconS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String jsonData = request.getParameter("jsonData");
			List<OrderDeliveryVO> list = new ArrayList<OrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<OrderDeliveryVO>>() {
			});

			service.prcsRemiconS(list, id);

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

	@RequestMapping(value = "/remicon/remiconS/gridMainSaveScm", method = RequestMethod.POST)
	public void prcsRemiconSScm(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String jsonData = request.getParameter("jsonData");
			List<OrderDeliveryVO> list = new ArrayList<OrderDeliveryVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<OrderDeliveryVO>>() {
			});

			service.prcsRemiconSScm(list, id);

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

	// 발주입고현황
	@RequestMapping(value = "/orderDelivery/inboundR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selInboundR(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selInboundR(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/inboundR/report/reportSch")
	public ModelAndView custDealP(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");

		String siteCd = request.getParameter("siteCd");
		String stInvoiceDt = request.getParameter("stInvoiceDt");
		String edInvoiceDt = request.getParameter("edInvoiceDt");
		String nowDate = request.getParameter("nowDate");

		OrderDeliveryVO orderDeliveryVO = new OrderDeliveryVO();
		orderDeliveryVO.setCustCd(custCd);
		orderDeliveryVO.setSiteCd(siteCd);
		orderDeliveryVO.setStInvoiceDt(stInvoiceDt);
		orderDeliveryVO.setEdInvoiceDt(edInvoiceDt);

		List<OrderDeliveryVO> list = service.selInboundRPrint(orderDeliveryVO);
		list.get(0).setNowDate(nowDate);
		int result = list.size() % 30;
		int sizeNum = 0;
		sizeNum = 30 - result;

		if (list.size() < 30) {
			OrderDeliveryVO orderDeliveryVO2 = new OrderDeliveryVO();
			for (int j = 0; j < sizeNum; j++) {
				list.add(orderDeliveryVO2);
			}
		}

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("custDealP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	@RequestMapping(value = "/orderDelivery/inboundDetailR/invoiceDelNo", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selInvoiceDelNo(HttpServletRequest request, HttpServletResponse response, OrderDeliveryVO orderDeliveryVO) throws Exception {
		return service.selInvoiceDelNo(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/inboundDetailR/formSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selInvoiceDetailForm(HttpServletRequest request, HttpServletResponse response, OrderDeliveryVO orderDeliveryVO) throws Exception {
		return service.selInvoiceDetailForm(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/inboundDetailR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selInvoiceDetailGrid(HttpServletRequest request, HttpServletResponse response, OrderDeliveryVO orderDeliveryVO) throws Exception {
		return service.selInvoiceDetailGrid(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/deliInboundR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selDeliInboundR(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selDeliInboundR(orderDeliveryVO);
	}

	@RequestMapping(value = "/orderDelivery/remiconInboundR/gridMainSearch", method = RequestMethod.POST)
	public List<OrderDeliveryVO> selRemiconInboundR(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDeliveryVO orderDeliveryVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		orderDeliveryVO.setCustCd(custCd);
		return service.selRemiconInboundR(orderDeliveryVO);
	}

}
