package com.ubi.erp.mobile.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ubi.erp.cmm.interceptor.MobileInterceptor;
import com.ubi.erp.stockItem.domain.MStockItemVO;
import com.ubi.erp.stockItem.service.MStockItemService;

@Controller
public class MobileStockItemController {

	@Autowired
	private MobileInterceptor mobileInterceptor;

	@Autowired
	private MStockItemService mStockItemService;

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemR/list", method = RequestMethod.POST)
	public @ResponseBody List<MStockItemVO> searchList(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		String stdDt = (String) request.getParameter("stdDt");
		String itmCd = (String) request.getParameter("itmCd");
		String itmInfo = (String) request.getParameter("itmInfo");
		String facCd = (String) request.getParameter("facCd");

		mStockItemVO.setStdDt(stdDt);
		mStockItemVO.setItmCd(itmCd);
		mStockItemVO.setItmInfo(itmInfo);
		mStockItemVO.setFacCd(facCd);

		return mStockItemService.selMobileStockItemList(mStockItemVO);
	}

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemByFacR/list", method = RequestMethod.POST)
	public @ResponseBody List<MStockItemVO> searchList2(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		String stdDt = (String) request.getParameter("stdDt");
		String itmCd = (String) request.getParameter("itmCd");
		String itmInfo = (String) request.getParameter("itmInfo");
		String facCd = (String) request.getParameter("facCd");

		mStockItemVO.setStdDt(stdDt);
		mStockItemVO.setItmCd(itmCd);
		mStockItemVO.setItmInfo(itmInfo);
		mStockItemVO.setFacCd(facCd);

		return mStockItemService.selMobileStockItemByFacList(mStockItemVO);
	}

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemR/combo")
	public @ResponseBody List<MStockItemVO> selFacCdMobile(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		return mStockItemService.selMobileItemCdList(mStockItemVO);
	}

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemByFacR/combo")
	public @ResponseBody List<MStockItemVO> selMobileFacCdList(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		return mStockItemService.selMobileFacCdList(mStockItemVO);
	}

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemGrdDtlR/list")
	public @ResponseBody List<MStockItemVO> selLes104SQuery(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		String stdDt = (String) request.getParameter("stdDt");
		String itmCd = (String) request.getParameter("itmCd");
		String facCd = (String) request.getParameter("facCd");

		mStockItemVO.setFacCd(facCd);

		String bsCd = mStockItemService.selBsCdByFacCd(mStockItemVO);

		mStockItemVO.setFrDt(stdDt);
		mStockItemVO.setToDt(stdDt);
		mStockItemVO.setItmCd(itmCd);
		mStockItemVO.setBsCd(bsCd);
		mStockItemVO.setChkIo("0");
		mStockItemVO.setChkLot("0");

		return mStockItemService.selLes104SQuery(mStockItemVO);
	}

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemGrdDtlR/listBaseNm")
	public @ResponseBody List<MStockItemVO> listBaseNm(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		String baseCd = (String) request.getParameter("baseCd");

		mStockItemVO.setBaseCd(baseCd);

		return mStockItemService.selBaseNm(mStockItemVO);
	}

	@RequestMapping(value = "/mobile/scm/stockItem/stockItemGrdDtlR/listWhNm")
	public @ResponseBody List<MStockItemVO> listWhNm(HttpServletRequest request, HttpServletResponse response, HttpSession session, MStockItemVO mStockItemVO) throws Exception {
		String whCd = (String) request.getParameter("whCd");

		mStockItemVO.setWhCd(whCd);

		return mStockItemService.selWhNmByWhCd(mStockItemVO);
	}
}
