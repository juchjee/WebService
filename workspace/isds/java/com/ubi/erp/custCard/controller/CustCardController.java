package com.ubi.erp.custCard.controller;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.custCard.domain.CustCardVO;
import com.ubi.erp.custCard.service.CustCardService;
import com.ubi.erp.shipment.service.ShipmentService;

@RestController
@RequestMapping("/erp/scm/inusBath/partners")
public class CustCardController {

	@Autowired
	private CustCardService service;

	@Autowired
	private ShipmentService shipmentService;

	// [combo] 공통코드 combobox 구성
	@RequestMapping(value = "/custCard/baseCdSearch", method = RequestMethod.POST)
	public List<CustCardVO> baseCdSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String mainCd = (String) request.getParameter("mainCd"); // BCA200V 의 BASE_CD
		custCardVO.setMainCd(mainCd);
		List<CustCardVO> list = service.selBaseCd(custCardVO);
		return list;
	}

	// [조회] 고객상담카드내역
	@RequestMapping(value = "/custCard/custConsultS/gridMainSearch", method = RequestMethod.POST)
	public List<CustCardVO> selCustCardR(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		// String sdDt = (String) request.getParameter("sdDt"); // 상담일자
		String sdFrDt = (String) request.getParameter("sdFrDt"); // 상담기간(시작일자)
		String sdToDt = (String) request.getParameter("sdToDt"); // 상담기간(종료일자)
		String empNo = (String) request.getParameter("empNo"); // 상담자(사원번호)
		String custNm = (String) request.getParameter("custNm"); // 고객명
		String surveyDt = (String) request.getParameter("surveyDt"); // 현장실측희망일
		String callDt = (String) request.getParameter("callDt"); // 해피콜일자
		String callStat = (String) request.getParameter("callStat"); // 해피콜진행상태[AS507]
		String custCd = (String) request.getParameter("custCd"); // 판매채널[schCustCd]

		// custCardVO.setSdDt(sdDt);
		custCardVO.setSdFrDt(sdFrDt);
		custCardVO.setSdToDt(sdToDt);
		custCardVO.setEmpNo(empNo);
		custCardVO.setCustNm(custNm);
		custCardVO.setSurveyDt(surveyDt);
		custCardVO.setCallDt(callDt);
		custCardVO.setCallStat(callStat);
		custCardVO.setCustCd(custCd);

		List<CustCardVO> list = service.selCustCardR(custCardVO);

		return list;
	}

	// [popup] 상담자(사원번호) 검색 팝업
	@RequestMapping(value = "/custCard/empInfoPOP", method = RequestMethod.POST)
	public List<CustCardVO> empInfoPOP(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String empNo = (String) request.getParameter("empNo");
		String id = (String) session.getAttribute("id");
		String menucd = (String) request.getParameter("menucd");
		// 20181018 ryul 권한그룹별이 아니라 해당 메뉴에 대해서 권한이 있는 사람 모두가 보이도록 수정
		// String grId = (String) session.getAttribute("grId");
		// String deptCd = (String) session.getAttribute("deptCd");

		// if ("000005".equals(grId)) {
		// grId = "";
		// }

		custCardVO.setEmpNo(empNo); /* id와 nm 동시 검색용 */
		custCardVO.setId(id); /* 사용자ID */
		custCardVO.setMenucd(menucd);
		// custCardVO.setGrId(grId); /* 메뉴그룹ID */
		// custCardVO.setDeptCd(deptCd); /* 사용자ID */

		List<CustCardVO> list = service.selEmpInfo(custCardVO);
		return list;
	}

	// [load] 화면 로드 시, 사용자의 id, nm, cust_cd, dept_cd, work_yn 조회
	@RequestMapping(value = "/custCard/loginUserInfoSearch", method = RequestMethod.POST)
	public List<CustCardVO> loginUserInfoSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String id = (String) session.getAttribute("id");

		custCardVO.setId(id); /* 사용자ID */

		List<CustCardVO> list = service.getScmUserInfo(custCardVO);
		return list;
	}

	// [pop] 제품코드 검색 팝업
	@RequestMapping(value = "/custCard/saleCodePOP", method = RequestMethod.POST)
	public List<CustCardVO> saleCodePOP(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String saleCode = (String) request.getParameter("saleCode");

		custCardVO.setSaleCode(saleCode);

		List<CustCardVO> list = service.selSaleCode(custCardVO);
		return list;
	}

	// [pop] 판매채널(거래처코드) 검색 팝업
	@RequestMapping(value = "/custCard/custInfoPOP", method = RequestMethod.POST)
	public List<CustCardVO> custInfoPOP(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String custCd = (String) request.getParameter("custCd");

		custCardVO.setCustCd(custCd);

		List<CustCardVO> list = service.selCustInfoPOP(custCardVO);
		return list;
	}

	// [저장] 상담고객카드 저장
	@RequestMapping(value = "/custCard/custConsultS/gridMainSave", method = RequestMethod.POST)
	public void mainSave(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String id = (String) session.getAttribute("id");
			String regId = shipmentService.selUserInfoById(id, "regId"); // 등록자ID

			String ordNo = request.getParameter("ordNo");
			String sdDt = request.getParameter("sdDt");

			String empNo = request.getParameter("empNo");
			String empNm = request.getParameter("empNm");
			String custGubun = request.getParameter("custGubun");
			String sdGubun = request.getParameter("sdGubun");
			String custNm = request.getParameter("custNm");
			String custTel = request.getParameter("custTel");
			String custAddr = request.getParameter("custAddr");
			String siteType = request.getParameter("siteType");
			String siteTypeEtc = request.getParameter("siteTypeEtc");
			String siteElevator = request.getParameter("siteElevator");
			String typeChk1 = request.getParameter("typeChk1");
			String typeChk2 = request.getParameter("typeChk2");
			String typeChk3 = request.getParameter("typeChk3");
			String typeChk4 = request.getParameter("typeChk4");
			String typeChk5 = request.getParameter("typeChk5");
			String preBathQty = request.getParameter("preBathQty");
			String preBathType1 = request.getParameter("preBathType1");
			String preBathType2 = request.getParameter("preBathType2");
			String preBathType3 = request.getParameter("preBathType3");
			String preBathType4 = request.getParameter("preBathType4");
			String preBathType5 = request.getParameter("preBathType5");
			String preBathType6 = request.getParameter("preBathType6");
			String reqBathQty = request.getParameter("reqBathQty");
			String reqBathType1 = request.getParameter("reqBathType1");
			String reqBathType2 = request.getParameter("reqBathType2");
			String reqBathType3 = request.getParameter("reqBathType3");
			String reqBathType4 = request.getParameter("reqBathType4");
			String reqBathTypeEtc = request.getParameter("reqBathTypeEtc");
			String inputRoute = request.getParameter("inputRoute");
			String interestProduct1 = request.getParameter("interestProduct1");
			String interestProduct2 = request.getParameter("interestProduct2");
			String interestProduct3 = request.getParameter("interestProduct3");
			String interestProduct4 = request.getParameter("interestProduct4");
			String interestProduct5 = request.getParameter("interestProduct5");
			String visitCnt = request.getParameter("visitCnt");
			String costType1 = request.getParameter("costType1");
			String costType2 = request.getParameter("costType2");
			String bathStyle1 = request.getParameter("bathStyle1");
			String bathStyle2 = request.getParameter("bathStyle2");
			String surveyDt = request.getParameter("surveyDt");
			String surveyHour = request.getParameter("surveyHour");
			String surveyMin = request.getParameter("surveyMin");
			String sigongDt = request.getParameter("sigongDt");
			String callDt = request.getParameter("callDt");
			String callStat = request.getParameter("callStat");
			String reservYn = request.getParameter("reservYn");
			String saleCode = request.getParameter("saleCode");
			String saleName = request.getParameter("saleName");
			String consultCont1 = request.getParameter("consultCont1");
			String consultCont2 = request.getParameter("consultCont2");
			String custCd = request.getParameter("custCd");

			custCardVO.setSdDt(sdDt);
			custCardVO.setEmpNo(empNo);
			custCardVO.setEmpNm(empNm);
			custCardVO.setCustGubun(custGubun);
			custCardVO.setSdGubun(sdGubun);
			custCardVO.setCustNm(custNm);
			custCardVO.setCustTel(custTel);
			custCardVO.setCustAddr(custAddr);
			custCardVO.setSiteType(siteType);
			custCardVO.setSiteTypeEtc(siteTypeEtc);
			custCardVO.setSiteElevator(siteElevator);
			custCardVO.setTypeChk1(typeChk1);
			custCardVO.setTypeChk2(typeChk2);
			custCardVO.setTypeChk3(typeChk3);
			custCardVO.setTypeChk4(typeChk4);
			custCardVO.setTypeChk5(typeChk5);
			custCardVO.setPreBathQty(preBathQty);
			custCardVO.setPreBathType1(preBathType1);
			custCardVO.setPreBathType2(preBathType2);
			custCardVO.setPreBathType3(preBathType3);
			custCardVO.setPreBathType4(preBathType4);
			custCardVO.setPreBathType5(preBathType5);
			custCardVO.setPreBathType6(preBathType6);
			custCardVO.setReqBathQty(reqBathQty);
			custCardVO.setReqBathType1(reqBathType1);
			custCardVO.setReqBathType2(reqBathType2);
			custCardVO.setReqBathType3(reqBathType3);
			custCardVO.setReqBathType4(reqBathType4);
			custCardVO.setReqBathTypeEtc(reqBathTypeEtc);
			custCardVO.setInputRoute(inputRoute);
			custCardVO.setInterestProduct1(interestProduct1);
			custCardVO.setInterestProduct2(interestProduct2);
			custCardVO.setInterestProduct3(interestProduct3);
			custCardVO.setInterestProduct4(interestProduct4);
			custCardVO.setInterestProduct5(interestProduct5);
			custCardVO.setVisitCnt(visitCnt);
			custCardVO.setCostType1(costType1);
			custCardVO.setCostType2(costType2);
			custCardVO.setBathStyle1(bathStyle1);
			custCardVO.setBathStyle2(bathStyle2);
			custCardVO.setSurveyDt(surveyDt);
			custCardVO.setSurveyHour(surveyHour);
			custCardVO.setSurveyMin(surveyMin);
			custCardVO.setSigongDt(sigongDt);
			custCardVO.setCallDt(callDt);
			custCardVO.setCallStat(callStat);
			custCardVO.setReservYn(reservYn);
			custCardVO.setSaleCode(saleCode);
			custCardVO.setSaleName(saleName);
			custCardVO.setConsultCont1(consultCont1);
			custCardVO.setConsultCont2(consultCont2);
			custCardVO.setRegId(regId);
			custCardVO.setCustCd(custCd);

			// 고객/주문번호가 null이면 insert 아니면 update
			if ("".equals(ordNo)) {
				// ordNo 발번
				custCardVO.setTableNm("ASA500");
				String newOrdNo = service.selCodeNo2(custCardVO);

				custCardVO.setOrdNo(newOrdNo);
				ordNo = newOrdNo;

				// insert 호출
				service.insAsa500(custCardVO);

			} else { // update
				custCardVO.setOrdNo(ordNo);

				// update 호출
				service.updAsa500(custCardVO);
			}

			service.selAsa500WorkD(custCardVO); // 신규, 수정 후 프로시저 호출 [거래처번호, 상담일자, 상담일자]

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			map.put("ordNo", ordNo);
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

	// [삭제] 상담고객카드등록
	@RequestMapping(value = "/custCard/custConsultS/delGridMain", method = RequestMethod.POST)
	public void delGridMain(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String ordNo = (String) request.getParameter("ordNo"); // 고객/주문번호

			custCardVO.setOrdNo(ordNo);

			int ordCnt = service.getCntOrdNo(ordNo);

			Map<String, String> map = new HashMap<String, String>();
			if (ordCnt > 0) {
				map.put("rtnCode", "0"); // 0은 삭제 예외[이미 예약등록에 데이터가 있는 경우]
			} else {
				service.delAsa500(custCardVO, ordNo);
				map.put("rtnCode", "1");
			}
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

	// [인쇄] 고객카드등록 출력
	@RequestMapping(value = "/custCard/custConsultS/report/reportSch")
	public ModelAndView custConsultP(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String ordNo = (String) request.getParameter("ordNo"); // 출하공장

		CustCardVO custCardVO = new CustCardVO();
		custCardVO.setOrdNo(ordNo);

		List<CustCardVO> list = service.selCustCardRPrint(custCardVO);

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("custConsultP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	/* 세트 */
	// [조회] 세트고객상담카드
	@RequestMapping(value = "/custCard/custSetCardS/gridMainSearch", method = RequestMethod.POST)
	public List<CustCardVO> listSet(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String sdFrDt = (String) request.getParameter("sdFrDt"); // 상담기간(시작일자)
		String sdToDt = (String) request.getParameter("sdToDt"); // 상담기간(종료일자)
		String empNo = (String) request.getParameter("empNo"); // 상담자(사원번호)
		String custNm = (String) request.getParameter("custNm"); // 고객명
		String surveyDt = (String) request.getParameter("surveyDt"); // 현장실측희망일
		String callDt = (String) request.getParameter("callDt"); // 해피콜일자
		String callStat = (String) request.getParameter("callStat"); // 해피콜진행상태[AS507]
		String custCd = (String) request.getParameter("custCd"); // 판매채널[schCustCd]

		custCardVO.setSdFrDt(sdFrDt);
		custCardVO.setSdToDt(sdToDt);
		custCardVO.setEmpNo(empNo);
		custCardVO.setCustNm(custNm);
		custCardVO.setSurveyDt(surveyDt);
		custCardVO.setCallDt(callDt);
		custCardVO.setCallStat(callStat);
		custCardVO.setCustCd(custCd);

		List<CustCardVO> list = service.selSetCustCardR(custCardVO);

		return list;
	}

	// [저장] 세트 상담고객카드 저장
	@RequestMapping(value = "/custCard/custSetCardS/gridMainSave", method = RequestMethod.POST)
	public void saveSet(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String id = (String) session.getAttribute("id");
			String regId = shipmentService.selUserInfoById(id, "regId"); // 등록자ID

			String sdDt = request.getParameter("sdDt");
			String empNo = request.getParameter("empNo");
			String empNm = request.getParameter("empNm");
			String ordNo = request.getParameter("ordNo");
			String custCd = request.getParameter("custCd");
			String custSalNm = request.getParameter("custSalNm");
			String custGubun = request.getParameter("custGubun");
			String sdGubun = request.getParameter("sdGubun");
			String sdGubunEtc = request.getParameter("sdGubunEtc");
			String custNm = request.getParameter("custNm");
			String custTel = request.getParameter("custTel");
			String custAddr = request.getParameter("custAddr");
			String inputRoute = request.getParameter("inputRoute");
			String siteType = request.getParameter("siteType");
			String siteElevator = request.getParameter("siteElevator");
			String constructType = request.getParameter("constructType");
			String typeChk = request.getParameter("typeChk");
			String preBathQty = request.getParameter("preBathQty");
			String preBathType1 = request.getParameter("preBathType1");
			String preBathType2 = request.getParameter("preBathType2");
			String preBathType3 = request.getParameter("preBathType3");
			String preBathType4 = request.getParameter("preBathType4");
			String preBathType5 = request.getParameter("preBathType5");
			String preBathTypeEtc = request.getParameter("preBathTypeEtc");
			String reqBathQty = request.getParameter("reqBathQty");
			String reqBathType1 = request.getParameter("reqBathType1");
			String reqBathType2 = request.getParameter("reqBathType2");
			String reqBathType3 = request.getParameter("reqBathType3");
			String reqBathType4 = request.getParameter("reqBathType4");
			String reqBathType5 = request.getParameter("reqBathType5");
			String reqBathTypeEtc = request.getParameter("reqBathTypeEtc");
			String custStat = request.getParameter("custStat");
			String requestDt = request.getParameter("requestDt");
			String requestTimeDiv = request.getParameter("requestTimeDiv");
			String requestHour = request.getParameter("requestHour");
			String requestMin = request.getParameter("requestMin");
			String sigongDt = request.getParameter("sigongDt");
			String costType1 = request.getParameter("costType1");
			String costType2 = request.getParameter("costType2");
			String bathStyle1 = request.getParameter("bathStyle1");
			String bathStyle2 = request.getParameter("bathStyle2");
			String callStat = request.getParameter("callStat");
			String infoAgreYn = request.getParameter("infoAgreYn");
			String lifeType = request.getParameter("lifeType");
			String lifeTypeEtc = request.getParameter("lifeTypeEtc");
			String consultCont = request.getParameter("consultCont");

			custCardVO.setSdDt(sdDt);
			custCardVO.setEmpNo(empNo);
			custCardVO.setEmpNm(empNm);
			custCardVO.setOrdNo(ordNo);
			custCardVO.setCustCd(custCd);
			custCardVO.setCustSalNm(custSalNm);
			custCardVO.setCustGubun(custGubun);
			custCardVO.setSdGubun(sdGubun);
			custCardVO.setSdGubunEtc(sdGubunEtc);
			custCardVO.setCustNm(custNm);
			custCardVO.setCustTel(custTel);
			custCardVO.setCustAddr(custAddr);
			custCardVO.setInputRoute(inputRoute);
			custCardVO.setSiteType(siteType);
			custCardVO.setSiteElevator(siteElevator);
			custCardVO.setConstructType(constructType);
			custCardVO.setTypeChk(typeChk);
			custCardVO.setPreBathQty(preBathQty);
			custCardVO.setPreBathType1(preBathType1);
			custCardVO.setPreBathType2(preBathType2);
			custCardVO.setPreBathType3(preBathType3);
			custCardVO.setPreBathType4(preBathType4);
			custCardVO.setPreBathType5(preBathType5);
			custCardVO.setPreBathTypeEtc(preBathTypeEtc);
			custCardVO.setReqBathQty(reqBathQty);
			custCardVO.setReqBathType1(reqBathType1);
			custCardVO.setReqBathType2(reqBathType2);
			custCardVO.setReqBathType3(reqBathType3);
			custCardVO.setReqBathType4(reqBathType4);
			custCardVO.setReqBathType5(reqBathType5);
			custCardVO.setReqBathTypeEtc(reqBathTypeEtc);
			custCardVO.setCustStat(custStat);
			custCardVO.setRequestDt(requestDt);
			custCardVO.setRequestTimeDiv(requestTimeDiv);
			custCardVO.setRequestHour(requestHour);
			custCardVO.setRequestMin(requestMin);
			custCardVO.setSigongDt(sigongDt);
			custCardVO.setCostType1(costType1);
			custCardVO.setCostType2(costType2);
			custCardVO.setBathStyle1(bathStyle1);
			custCardVO.setBathStyle2(bathStyle2);
			custCardVO.setCallStat(callStat);
			custCardVO.setInfoAgreYn(infoAgreYn);
			custCardVO.setLifeType(lifeType);
			custCardVO.setLifeTypeEtc(lifeTypeEtc);
			custCardVO.setConsultCont(consultCont);

			custCardVO.setRegId(regId);
			custCardVO.setCustCd(custCd);

			// 고객/주문번호가 null이면 insert 아니면 update
			if ("".equals(ordNo)) {
				// ordNo 발번
				custCardVO.setTableNm("ASA510");
				String newOrdNo = service.selCodeNo2(custCardVO);

				custCardVO.setOrdNo(newOrdNo);
				ordNo = newOrdNo;

				// insert 호출
				service.insAsa510(custCardVO);

			} else { // update
				custCardVO.setOrdNo(ordNo);

				// update 호출
				service.updAsa510(custCardVO);
			}

			/* 해당내용은 차장님께 확인 후 진행 */
			 service.selAsa500WorkD(custCardVO); // 신규, 수정 후 프로시저 호출 [거래처번호, 상담일자, 상담일자]

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			map.put("ordNo", ordNo);
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

	// [삭제] 상담고객카드등록
	@RequestMapping(value = "/custCard/custSetCardS/delGridMain", method = RequestMethod.POST)
	public void delSet(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String ordNo = (String) request.getParameter("ordNo"); // 고객/주문번호

			custCardVO.setOrdNo(ordNo);

			int ordCnt = service.getCntOrdNo(ordNo);

			Map<String, String> map = new HashMap<String, String>();
			if (ordCnt > 0) {
				map.put("rtnCode", "0"); // 0은 삭제 예외[이미 예약등록에 데이터가 있는 경우]
			} else {
				service.delAsa510(custCardVO, ordNo);
				map.put("rtnCode", "1");
			}
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

	// [인쇄] 세트 고객카드등록 출력
	@RequestMapping(value = "/custCard/custSetCardS/report/reportSch")
	public ModelAndView setCustConsultP(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String ordNo = (String) request.getParameter("ordNo"); // 출하공장

		CustCardVO custCardVO = new CustCardVO();
		custCardVO.setOrdNo(ordNo);

		List<CustCardVO> list = service.selSetCustCardRPrint(custCardVO);

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("setCustConsultP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	/* 단품 */
	// [조회] 단품고객상담카드
	@RequestMapping(value = "/custCard/custPrdCardS/gridMainSearch", method = RequestMethod.POST)
	public List<CustCardVO> listPrd(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String sdFrDt = (String) request.getParameter("sdFrDt"); // 상담기간(시작일자)
		String sdToDt = (String) request.getParameter("sdToDt"); // 상담기간(종료일자)
		String empNo = (String) request.getParameter("empNo"); // 상담자(사원번호)
		String custNm = (String) request.getParameter("custNm"); // 고객명
		String surveyDt = (String) request.getParameter("surveyDt"); // 현장실측희망일
		String callDt = (String) request.getParameter("callDt"); // 해피콜일자
		String callStat = (String) request.getParameter("callStat"); // 해피콜진행상태[AS507]
		String custCd = (String) request.getParameter("custCd"); // 판매채널[schCustCd]

		custCardVO.setSdFrDt(sdFrDt);
		custCardVO.setSdToDt(sdToDt);
		custCardVO.setEmpNo(empNo);
		custCardVO.setCustNm(custNm);
		custCardVO.setSurveyDt(surveyDt);
		custCardVO.setCallDt(callDt);
		custCardVO.setCallStat(callStat);
		custCardVO.setCustCd(custCd);

		List<CustCardVO> list = service.selPrdCustCardR(custCardVO);

		return list;
	}

	// [저장] 단품 상담고객카드 저장
	@RequestMapping(value = "/custCard/custPrdCardS/gridMainSave", method = RequestMethod.POST)
	public void savePrd(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String id = (String) session.getAttribute("id");
			String regId = shipmentService.selUserInfoById(id, "regId"); // 등록자ID

			String ordNo = request.getParameter("ordNo");
			String sdDt = request.getParameter("sdDt");
			String empNo = request.getParameter("empNo");
			String empNm = request.getParameter("empNm");
			String custGubun = request.getParameter("custGubun");
			String sdGubun = request.getParameter("sdGubun");
			String sdGubunEtc = request.getParameter("sdGubunEtc");
			String custNm = request.getParameter("custNm");
			String custAddr = request.getParameter("custAddr");
			String custTel = request.getParameter("custTel");
			String inputRoute = request.getParameter("inputRoute");
			String siteType = request.getParameter("siteType");
			String siteElevator = request.getParameter("siteElevator");
			String consultProduct1 = request.getParameter("consultProduct1");
			String consultProduct2 = request.getParameter("consultProduct2");
			String consultProduct3 = request.getParameter("consultProduct3");
			String consultProduct4 = request.getParameter("consultProduct4");
			String consultProductEtc = request.getParameter("consultProductEtc");
			String custStat = request.getParameter("custStat");
			String deliveryDt = request.getParameter("deliveryDt");
			String sigongYn = request.getParameter("sigongYn");
			String sigongPayYn = request.getParameter("sigongPayYn");
			String sigongDt = request.getParameter("sigongDt");
			String callStat = request.getParameter("callStat");
			String lifeType = request.getParameter("lifeType");
			String lifeTypeEtc = request.getParameter("lifeTypeEtc");
			String infoAgreYn = request.getParameter("infoAgreYn");
			String consultCont = request.getParameter("consultCont");
			String saleCode = request.getParameter("saleCode");
			String custCd = request.getParameter("custCd");
			String custSalNm = request.getParameter("custSalNm");

			custCardVO.setOrdNo(ordNo);
			custCardVO.setSdDt(sdDt);
			custCardVO.setEmpNo(empNo);
			custCardVO.setEmpNm(empNm);
			custCardVO.setCustGubun(custGubun);
			custCardVO.setSdGubun(sdGubun);
			custCardVO.setSdGubunEtc(sdGubunEtc);
			custCardVO.setCustNm(custNm);
			custCardVO.setCustAddr(custAddr);
			custCardVO.setCustTel(custTel);
			custCardVO.setInputRoute(inputRoute);
			custCardVO.setSiteType(siteType);
			custCardVO.setSiteElevator(siteElevator);
			custCardVO.setConsultProduct1(consultProduct1);
			custCardVO.setConsultProduct2(consultProduct2);
			custCardVO.setConsultProduct3(consultProduct3);
			custCardVO.setConsultProduct4(consultProduct4);
			custCardVO.setConsultProductEtc(consultProductEtc);
			custCardVO.setCustStat(custStat);
			custCardVO.setDeliveryDt(deliveryDt);
			custCardVO.setSigongYn(sigongYn);
			custCardVO.setSigongPayYn(sigongPayYn);
			custCardVO.setSigongDt(sigongDt);
			custCardVO.setCallStat(callStat);
			custCardVO.setLifeType(lifeType);
			custCardVO.setLifeTypeEtc(lifeTypeEtc);
			custCardVO.setInfoAgreYn(infoAgreYn);
			custCardVO.setConsultCont(consultCont);
			custCardVO.setSaleCode(saleCode);
			custCardVO.setCustCd(custCd);
			custCardVO.setCustSalNm(custSalNm);

			custCardVO.setRegId(regId);
			custCardVO.setCustCd(custCd);

			// 고객/주문번호가 null이면 insert 아니면 update
			if ("".equals(ordNo)) {
				// ordNo 발번
				custCardVO.setTableNm("ASA520");
				String newOrdNo = service.selCodeNo2(custCardVO);

				custCardVO.setOrdNo(newOrdNo);
				ordNo = newOrdNo;

				// insert 호출
				service.insAsa520(custCardVO);

			} else { // update
				custCardVO.setOrdNo(ordNo);

				// update 호출
				service.updAsa520(custCardVO);
			}

			/* 해당내용은 차장님께 확인 후 진행 */
			 service.selAsa500WorkD(custCardVO); // 신규, 수정 후 프로시저 호출 [거래처번호, 상담일자, 상담일자]

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			map.put("ordNo", ordNo);
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

	// [삭제] 상담고객카드등록
	@RequestMapping(value = "/custCard/custPrdCardS/delGridMain", method = RequestMethod.POST)
	public void delPrd(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String ordNo = (String) request.getParameter("ordNo"); // 고객/주문번호

			custCardVO.setOrdNo(ordNo);

			int ordCnt = service.getCntOrdNo(ordNo);

			Map<String, String> map = new HashMap<String, String>();
			if (ordCnt > 0) {
				map.put("rtnCode", "0"); // 0은 삭제 예외[이미 예약등록에 데이터가 있는 경우]
			} else {
				service.delAsa520(custCardVO, ordNo);
				map.put("rtnCode", "1");
			}
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

	// [인쇄] 단품 고객카드등록 출력
	@RequestMapping(value = "/custCard/custPrdCardS/report/reportSch")
	public ModelAndView prdCustConsultP(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String ordNo = (String) request.getParameter("ordNo"); // 출하공장

		CustCardVO custCardVO = new CustCardVO();
		custCardVO.setOrdNo(ordNo);

		List<CustCardVO> list = service.selPrdCustCardRPrint(custCardVO);

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("prdCustConsultP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	// [조회] 고객상담현황
	@RequestMapping(value = "/custCard/custConsultR/gridMainSearch", method = RequestMethod.POST)
	public List<CustCardVO> list(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustCardVO custCardVO) throws Exception {
		String gubun = (String) request.getParameter("gubun"); // 구분
		String sdFrDt = (String) request.getParameter("sdFrDt"); // 상담기간(시작일자)
		String sdToDt = (String) request.getParameter("sdToDt"); // 상담기간(종료일자)

		custCardVO.setSdFrDt(sdFrDt);
		custCardVO.setSdToDt(sdToDt);

		List<CustCardVO> list = null;
		if ("AS519100".equals(gubun)) {
			list = service.selSetCustCardR(custCardVO);
		} else if ("AS519200".equals(gubun)) {
			list = service.selPrdCustCardR(custCardVO);
		}

		return list;
	}
}
