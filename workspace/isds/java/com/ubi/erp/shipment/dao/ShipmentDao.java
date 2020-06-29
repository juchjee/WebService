package com.ubi.erp.shipment.dao;

import java.util.List;

import com.ubi.erp.shipment.domain.ShipmentVO;

public interface ShipmentDao {

	public List<ShipmentVO> selShipmentR(ShipmentVO shipmentVO); // [조회] 출하현황-출고증출력

	public List<ShipmentVO> selShipmentRPrint(ShipmentVO shipmentVO); // [인쇄] 출하현황-출고증출력
	
	public List<ShipmentVO> selShipmentProcessR(ShipmentVO shipmentVO); // [출하품목정보 조회] 출하처리
	
	public List<ShipmentVO> selShipmentProcessDetailR(ShipmentVO shipmentVO); // [출하품목상세정보 조회] 출하처리

	public List<ShipmentVO> selBsCd(ShipmentVO shipmentVO); // [팝업] 출고사업장조회 - 중앙레미콘('75')만

	public List<ShipmentVO> selDailyRevCntPop(ShipmentVO shipmentVO); // [팝업] 일일회전수

	public List<ShipmentVO> selCarInfoPop(ShipmentVO shipmentVO); // [팝업] 차량정보

	public List<ShipmentVO> selUserInfoById(String id); // id로 dept_cd, reg_id 조회

	public List<ShipmentVO> selCodeNo2(ShipmentVO shipmentVO); // 이동번호, 운송번호 조회 [LEM100-mov_no / LEM200-tran_no]

	public void insLem100(ShipmentVO shipmentVO); // insert lem100

	public void insLeb200(ShipmentVO shipmentVO); // insert leb200

	public void insLem150(ShipmentVO shipmentVO); // insert lem150

	public void delLem100(ShipmentVO shipmentVO); // delete lem100 [mov_no]

	public void delLeb200(ShipmentVO shipmentVO); // delete leb200 [transNo]

	public void delLem150(ShipmentVO shipmentVO); // delete lem150 [mov_no]
};