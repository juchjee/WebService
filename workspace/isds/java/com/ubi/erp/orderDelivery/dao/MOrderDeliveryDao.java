package com.ubi.erp.orderDelivery.dao;

import java.util.List;

import com.ubi.erp.orderDelivery.domain.MOrderDeliveryVO;

public interface MOrderDeliveryDao {
	// 팝업 및 기타
	public List<MOrderDeliveryVO> selFacCd(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selFacCdMobile(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selAllFacCd(MOrderDeliveryVO mOrderDeliveryVO);

	public MOrderDeliveryVO selManuDeliverySeq(MOrderDeliveryVO mOrderDeliveryVO);

	public String selManuDeliveryNo(MOrderDeliveryVO mOrderDeliveryVO);

	// 제조 발주확인
	public List<MOrderDeliveryVO> selManuOrderChkS(MOrderDeliveryVO mOrderDeliveryVO);

	public void prcsManuOrderChkS(MOrderDeliveryVO mOrderDeliveryVO);

	public void delManuOrderChkS(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selManuOrderChkR(MOrderDeliveryVO mOrderDeliveryVO);

	// 납품등록
	public List<MOrderDeliveryVO> selManuDeliverySMst(MOrderDeliveryVO mOrderDeliveryVO);

	public void prcsOutsEndYn(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selManuDeliverySSub(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selManuDeliveryDeliQty(MOrderDeliveryVO mOrderDeliveryVO);

	public void prcsManuDeliveryS(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selManuDeliveryR(MOrderDeliveryVO mOrderDeliveryVO);

	// 제조 입고현황
	public List<MOrderDeliveryVO> selInboundR(MOrderDeliveryVO mOrderDeliveryVO);

	// 납품대비 입고현황
	public List<MOrderDeliveryVO> selDeliInboundR(MOrderDeliveryVO mOrderDeliveryVO);

	public List<MOrderDeliveryVO> selComboFacCd(MOrderDeliveryVO mOrderDeliveryVO); // 사업장코드

	public List<MOrderDeliveryVO> selComboCustCd(MOrderDeliveryVO mOrderDeliveryVO); // 거래처코드

	public List<MOrderDeliveryVO> selAgencyShipR(MOrderDeliveryVO mOrderDeliveryVO); // 출하현황(대리점용)조회

	public List<MOrderDeliveryVO> selAgencyShipDtlR(MOrderDeliveryVO mOrderDeliveryVO); // 출하현황(대리점용)조회-detail

	public List<MOrderDeliveryVO> selComboSalesEmp(MOrderDeliveryVO mOrderDeliveryVO); // 영업사원 콤보박스

	public List<MOrderDeliveryVO> selComboSalesDept(MOrderDeliveryVO mOrderDeliveryVO); // 영업부서 콤보박스

	public List<MOrderDeliveryVO> selSalesShipR(MOrderDeliveryVO mOrderDeliveryVO); // 출하현황(영업용) 조회
	
	public List<MOrderDeliveryVO> selSalesShipDtlR(MOrderDeliveryVO mOrderDeliveryVO); // 출하현황(영업용) 조회 - detail
};
