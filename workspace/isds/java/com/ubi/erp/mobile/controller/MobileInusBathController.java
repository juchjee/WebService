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

import com.ubi.erp.cmm.interceptor.MobileInterceptor;
import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.inusBath.domain.MInusBathVO;
import com.ubi.erp.inusBath.service.MInusBathService;
import com.ubi.erp.shipment.service.ShipmentService;

@Controller
public class MobileInusBathController {

	@Autowired
	private MobileInterceptor mobileInterceptor;

	@Autowired
	private MInusBathService mInusBathService;

	@Autowired
	private ShipmentService shipmentService;

	// 이누스바스 시공마감(시공점) - 사용자 거래처코드 get
	@RequestMapping(value = "/mobile/scm/inusBath/mSigonFinishR/getUserInfo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String erpCustCd = (String) session.getAttribute("erpCustCd");
		String erpCustNm = (String) session.getAttribute("erpCustNm");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("custCd", erpCustCd);
		map.put("custNm", erpCustNm);

		return map;
	}

	// 마감현황
	@RequestMapping(value = "/mobile/scm/inusBath/mSigongFinishR/list", method = RequestMethod.POST)
	public @ResponseBody List<MInusBathVO> searchList(HttpServletRequest request, HttpServletResponse response, HttpSession session, MInusBathVO mInusBathVO) throws Exception {
		String frDt = (String) request.getParameter("frDt");
		String toDt = (String) request.getParameter("toDt");
		String serveyCust = (String) request.getParameter("custCd");
		String estNo = (String) request.getParameter("estNo");

		mInusBathVO.setFrDt(frDt);
		mInusBathVO.setToDt(toDt);
		mInusBathVO.setServeyCust(serveyCust);
		mInusBathVO.setEstNo(estNo);

		return mInusBathService.selMobileSigongFinishList(mInusBathVO);
	}

	// 계약시공금액내역
	@RequestMapping(value = "/mobile/scm/inusBath/mSigongFinishGrdDtlS/list", method = RequestMethod.POST)
	public @ResponseBody List<MInusBathVO> searchList2(HttpServletRequest request, HttpServletResponse response, HttpSession session, MInusBathVO mInusBathVO) throws Exception {
		String estNo = (String) request.getParameter("estNo");

		mInusBathVO.setEstNo(estNo);

		return mInusBathService.selMobileSigongSumList(mInusBathVO);
	}

	// 견적번호[estNo], 상품구분[saleGubun], 시공마감여부[saleEndChk], 등록ID[regId]
	@RequestMapping(value = "/mobile/scm/inusBath/mSigonFinishDetailS/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response, HttpSession session, MInusBathVO mInusBathVO) throws Exception {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String estNo = (String) request.getParameter("estNo");
			// String saleGubun = (String) request.getParameter("saleGubun");
			// String saleEndChk = (String) request.getParameter("saleEndChk");
			String id = (String) session.getAttribute("id");
			String regId = shipmentService.selUserInfoById(id, "regId"); // 등록자ID
			
			mInusBathVO.setEstNo(estNo);
			mInusBathVO.setEndChk("SDH4110"); // 진행마감
			// mInusBathVO.setSaleGubun(saleGubun);
			// mInusBathVO.setSaleEndChk(saleEndChk);
			mInusBathVO.setRegId(regId);
			
			// 데이터 있는지 확인 후, 없다면 insert 먼저 후, update 처리
			int cnt = mInusBathService.getCntEstNo(mInusBathVO); // regId, estNo

			if (1 > cnt) {
				mInusBathService.insSDA180(mInusBathVO);
			}

			mInusBathService.updSda180(mInusBathVO);
			// mInusBathService.prcsSdh680SQuery(mInusBathVO);
			
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

	@RequestMapping(value = "/mobile/scm/inusBath/mSigongFinishR/combo")
	public @ResponseBody List<MInusBathVO> selCustCdList(HttpServletRequest request, HttpServletResponse response, HttpSession session, MInusBathVO mInusBathVO) throws Exception {
		String frDt = (String) request.getParameter("frDt");
		String toDt = (String) request.getParameter("toDt");
		String id = (String) session.getAttribute("id");
		String custCd = (String) session.getAttribute("custCd");	//로그인한 사용자의 거래처코드 [본사여부]

		mInusBathVO.setFrDt(frDt);
		mInusBathVO.setToDt(toDt);

		List<MInusBathVO> list = null;
		if (!"a".equals(custCd)) {
			mInusBathVO.setCustCd(id); // 로그인 유저의 아이디로 현재 거래처 코드에 있는지 확인
		}
		
		list = mInusBathService.selCustCdList(mInusBathVO);
		

		return list;
	}

	// inusBath 견적별 출하내역 Main 조회 + Dtl Form
	@RequestMapping(value = "/mobile/scm/inusBath/mItmShipR/list", method = RequestMethod.POST)
	public @ResponseBody List<MInusBathVO> mItmShiphR(HttpServletRequest request, HttpServletResponse response, HttpSession session, MInusBathVO mInusBathVO) throws Exception {
		String frDt = (String) request.getParameter("frDt");
		String toDt = (String) request.getParameter("toDt");
		String serveyCust = (String) request.getParameter("custCd");
		String estNo = (String) request.getParameter("estNo");

		mInusBathVO.setFrDt(frDt);
		mInusBathVO.setToDt(toDt);
		mInusBathVO.setServeyCust(serveyCust);
		mInusBathVO.setEstNo(estNo);

		return mInusBathService.selMobileItmShipList(mInusBathVO);
	}

	// inusBath 견적별 출하내역 상세내역 조회
	@RequestMapping(value = "/mobile/scm/inusBath/mItmShipGrdDtlR/list", method = RequestMethod.POST)
	public @ResponseBody List<MInusBathVO> mItmShipGrdDtlS(HttpServletRequest request, HttpServletResponse response, HttpSession session, MInusBathVO mInusBathVO) throws Exception {
		String estNo = (String) request.getParameter("estNo");

		mInusBathVO.setEstNo(estNo);

		return mInusBathService.selMobileItmShipDtlList(mInusBathVO);
	}

}
