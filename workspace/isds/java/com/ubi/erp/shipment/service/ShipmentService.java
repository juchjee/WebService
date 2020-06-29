package com.ubi.erp.shipment.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.shipment.dao.ShipmentDao;
import com.ubi.erp.shipment.domain.ShipmentVO;

@Service
public class ShipmentService {

	private ShipmentDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(ShipmentDao.class);
	}

	// [조회] 출하현황-출고증출력
	public List<ShipmentVO> selShipmentR(ShipmentVO shipmentVO) {
		return dao.selShipmentR(shipmentVO);
	}

	// [인쇄] 출하현황-출고증출력
	public List<ShipmentVO> selShipmentRPrint(ShipmentVO shipmentVO) {
		return dao.selShipmentRPrint(shipmentVO);
	}

	// [출하품목정보 조회] 출하처리
	public List<ShipmentVO> selShipmentProcessR(ShipmentVO shipmentVO) {
		return dao.selShipmentProcessR(shipmentVO);
	}

	// [출하품목상세정보 조회] 출하처리
	public List<ShipmentVO> selShipmentProcessDetailR(ShipmentVO shipmentVO) {
		return dao.selShipmentProcessDetailR(shipmentVO);
	}

	// [팝업] 출고사업장조회 - 중앙레미콘('75')만
	public List<ShipmentVO> selBsCd(ShipmentVO shipmentVO) {
		return dao.selBsCd(shipmentVO);
	}

	// [팝업] 일일회전수
	public List<ShipmentVO> selDailyRevCntPop(ShipmentVO shipmentVO) {
		return dao.selDailyRevCntPop(shipmentVO);
	}

	// [팝업] 차량정보
	public List<ShipmentVO> selCarInfoPop(ShipmentVO shipmentVO) {
		return dao.selCarInfoPop(shipmentVO);
	}

	// id로 dept_cd, reg_id 조회
	public String selUserInfoById(String id, String div) {
		List<ShipmentVO> list = dao.selUserInfoById(id);
		String val = "";

		if (list.size() > 0) {
			if ("deptCd" == div)
				val = list.get(0).getDeptCd();
			else if ("regId" == div)
				val = list.get(0).getRegId();
		}

		return val;
	}

	// 이동번호, 운송번호 조회 [LEM100-mov_no / LEM200-tran_no]
	// parameter :: tableNm, outDt, bsCd
	public String selCodeNo2(ShipmentVO shipmentVO) {
		List<ShipmentVO> list = dao.selCodeNo2(shipmentVO);
		String val = "";

		if (list.size() > 0) {
			val = list.get(0).getVal();
		}

		return val;
	}

	// insert lem100
	public void insLem100(ShipmentVO shipmentVO) {
		dao.insLem100(shipmentVO);
	}

	// insert leb200
	public void insLeb200(ShipmentVO shipmentVO) {
		dao.insLeb200(shipmentVO);
	}

	// insert lem150
	public void insLem150(ShipmentVO shipmentVO) {
		dao.insLem150(shipmentVO);
	}

	// delete lem100
	public void delLem100(ShipmentVO shipmentVO, String movNo) {
		shipmentVO.setMovNo(movNo);
		dao.delLem100(shipmentVO);
	}

	// delete leb200
	public void delLeb200(ShipmentVO shipmentVO, String transNo) {
		shipmentVO.setTransNo(transNo);
		dao.delLeb200(shipmentVO);
	}

	// delete lem150
	public void delLem150(ShipmentVO shipmentVO, String movNo) {
		shipmentVO.setMovNo(movNo);
		dao.delLem150(shipmentVO);
	}
}
