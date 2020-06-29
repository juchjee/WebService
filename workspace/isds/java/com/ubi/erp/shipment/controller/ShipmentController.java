package com.ubi.erp.shipment.controller;

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
import com.ubi.erp.shipment.domain.ShipmentVO;
import com.ubi.erp.shipment.service.ShipmentService;

@RestController
@RequestMapping("/erp/scm/remiconAdmin/partners")
public class ShipmentController {

	@Autowired
	private ShipmentService service;

	// [조회] 출하현황-출고증출력
	@RequestMapping(value = "/shipment/shipmentR/gridMainSearch", method = RequestMethod.POST)
	public List<ShipmentVO> selShipmentR(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {
		String facCd = (String) request.getParameter("facCd"); // 출하공장
		String outDtFr = (String) request.getParameter("outDtFr"); // 출하기간(from)
		String outDtTo = (String) request.getParameter("outDtTo"); // 출하기간(to)

		shipmentVO.setFacCd(facCd);
		shipmentVO.setOutDtFr(outDtFr);
		shipmentVO.setOutDtTo(outDtTo);

		// 중앙레미콘인 경우와 아닌 경우 ORDER BY가 다르다
		if (!"750".equals(facCd)) {
			shipmentVO.setOrderBy("A.OUT_NO DESC, A.OUT_DT, A.TRANS_NO");
		} else {
			shipmentVO.setOrderBy("CONVERT(VARCHAR, Z.CDT,8) DESC, A.OUT_NO, A.OUT_DT, A.TRANS_NO");
		}

		List<ShipmentVO> list = service.selShipmentR(shipmentVO);
		return list;
	}

	// [인쇄] 출하현황-출고증출력
	@RequestMapping(value = "/shipment/shipmentR/report/reportSch")
	public ModelAndView facCertificationP(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String facCd = (String) request.getParameter("facCd"); // 출하공장

		String transNo = (String) request.getParameter("transNo"); // 운송번호
		String fldCd = (String) request.getParameter("fldCd"); // 현장코드
		String carNo = (String) request.getParameter("carNo"); // 차량번호

		String nowDate = request.getParameter("nowDate");

		ShipmentVO shipmentVO = new ShipmentVO();
		shipmentVO.setFacCd(facCd);
		shipmentVO.setTransNo(transNo);
		shipmentVO.setFldCd(fldCd);
		shipmentVO.setCarNo(carNo);

		List<ShipmentVO> list = service.selShipmentRPrint(shipmentVO);
		list.get(0).setNowDate(nowDate);

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("facCertificationP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	// [삭제] 출하현황-출고증 출력
	@RequestMapping(value = "/shipment/shipmentR/delGridMain", method = RequestMethod.POST)
	public void delDailyAttendS(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String movNo = (String) request.getParameter("movNo"); // 이동번호
			String transNo = (String) request.getParameter("transNo"); // 운송번호

			shipmentVO.setMovNo(movNo);
			shipmentVO.setTransNo(transNo);

			// insert 역순으로 delete
			service.delLem150(shipmentVO, movNo);
			service.delLeb200(shipmentVO, transNo);
			service.delLem100(shipmentVO, movNo);

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

	// [콤보박스] 출고사업장조회[BCC200] - 중앙레미콘('75')만 조회
	@RequestMapping(value = "/shipment/bsCdSearch", method = RequestMethod.POST)
	public List<ShipmentVO> bsCdSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {
		String id = (String) session.getAttribute("id");
		shipmentVO.setId(id);
		List<ShipmentVO> list = service.selBsCd(shipmentVO);
		return list;
	}

	// [출하품목정보 조회] 출하처리
	@RequestMapping(value = "/shipment/shipProcessS/gridMainSearch", method = RequestMethod.POST)
	public List<ShipmentVO> selShipmentProcessR(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {
		String bsCd = (String) request.getParameter("bsCd"); // 출하공장
		String reqDtFr = (String) request.getParameter("reqDtFr"); // 출하요청기간(from)
		String reqDtTo = (String) request.getParameter("reqDtTo"); // 출하요청기간(to)

		shipmentVO.setBsCd(bsCd);
		shipmentVO.setReqDtFr(reqDtFr);
		shipmentVO.setReqDtTo(reqDtTo);

		List<ShipmentVO> list = service.selShipmentProcessR(shipmentVO);
		return list;
	}

	// [출하품목상세정보 조회] 출하처리
	@RequestMapping(value = "/shipment/shipProcessS/gridSubSearch", method = RequestMethod.POST)
	public List<ShipmentVO> selShipmentProcessDetailR(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {
		String movNo = (String) request.getParameter("movNo"); // 출하이동번호

		shipmentVO.setMovNo(movNo); // 출하이동번호

		List<ShipmentVO> list = service.selShipmentProcessDetailR(shipmentVO);
		return list;
	}

	// [팝업] 일일회전수
	@RequestMapping(value = "/shipment/dailyRevCntPop", method = RequestMethod.POST)
	public List<ShipmentVO> dailyRevCntPop(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {
		String outDt = (String) request.getParameter("outDt"); // 출하이동번호

		shipmentVO.setOutDt(outDt); // 출하일자

		List<ShipmentVO> list = service.selDailyRevCntPop(shipmentVO);
		return list;
	}

	// [팝업] 차량정보
	@RequestMapping(value = "/shipment/carInfoPop", method = RequestMethod.POST)
	public List<ShipmentVO> carInfoPop(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {
		String carNo = (String) request.getParameter("carNo"); // 차량번호

		shipmentVO.setCarNo(carNo); // 차량번호

		List<ShipmentVO> list = service.selCarInfoPop(shipmentVO);
		return list;
	}

	// [저장] 출하처리
	@RequestMapping(value = "/shipment/shipProcessS/gridMainSave", method = RequestMethod.POST)
	public void mainSave(HttpServletRequest request, HttpServletResponse response, HttpSession session, ShipmentVO shipmentVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			// 1. 가져온 id로 dept_cd 구하기
			String id = (String) session.getAttribute("id");
			String regId = service.selUserInfoById(id, "regId"); // 등록자ID
			String deptCd = service.selUserInfoById(id, "deptCd"); // 부서코드[입고,출고부서코드]

			// 2. request 값들 설정
			String outDt = request.getParameter("outDt");
			String bsCd = request.getParameter("bsCd"); // 75
			String carNo = request.getParameter("carNo");
			String drvNm = request.getParameter("drvNm");
			String drvHp = request.getParameter("drvHp");

			String custCd = request.getParameter("custCd");
			String fldCd = request.getParameter("fldCd");
			String itmCd = request.getParameter("itmCd");
			String outQtyInput = request.getParameter("outQtyInput");
			String movUp = request.getParameter("movUp");
			String soNo = request.getParameter("soNo");
			int soSq = Integer.parseInt(request.getParameter("soSq"));
			String reqNo = request.getParameter("reqNo");
			int reqSq = Integer.parseInt(request.getParameter("reqSq"));
			String itmId = request.getParameter("itmId");

			shipmentVO.setId(id);
			shipmentVO.setRegId(regId);
			shipmentVO.setDeptCd(deptCd);
			shipmentVO.setOutDt(outDt);
			shipmentVO.setBsCd(bsCd);
			shipmentVO.setCarNo(carNo);
			shipmentVO.setDrvNm(drvNm);
			shipmentVO.setDrvHp(drvHp);
			shipmentVO.setCustCd(custCd);
			shipmentVO.setFldCd(fldCd);
			shipmentVO.setItmCd(itmCd);
			shipmentVO.setOutQtyInput(outQtyInput);
			shipmentVO.setMovUp(movUp);
			shipmentVO.setSoNo(soNo);
			shipmentVO.setSoSq(soSq);
			shipmentVO.setReqNo(reqNo);
			shipmentVO.setReqSq(reqSq);
			shipmentVO.setItmId(itmId);

			// 3. selCodeNo2로 movNo와 transNo 구하기 [LEM100, outDt, bsCd], ['LEB200', outDt, bsCd]
			shipmentVO.setTableNm("LEM100");
			String movNo = service.selCodeNo2(shipmentVO);
			shipmentVO.setTableNm("LEB200");
			String transNo = service.selCodeNo2(shipmentVO);
			
			shipmentVO.setMovNo(movNo);
			shipmentVO.setTransNo(transNo);

			// 4. insLem100, insLeb200, inslem150 순차적 호출
			service.insLem100(shipmentVO); // movNo
			service.insLeb200(shipmentVO); // movNo, transNo
			service.insLem150(shipmentVO); // movNo
			
			// 5. 성공 후, movNo 반환
			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			map.put("movNo", movNo);
			map.put("transNo", transNo);
			map.put("fldCd", fldCd);
			map.put("carNo", carNo);
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

}
