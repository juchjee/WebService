package com.ubi.erp.orderDelivery.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.orderDelivery.dao.MOrderDeliveryDao;
import com.ubi.erp.orderDelivery.domain.MOrderDeliveryVO;

@Service
public class MOrderDeliveryService {

	private MOrderDeliveryDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(MOrderDeliveryDao.class);
	};

	// 제조 팝업 및 키타
	public List<MOrderDeliveryVO> selFacCd(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selFacCd(mOrderDeliveryVO);
	};

	public List<MOrderDeliveryVO> selFacCdMobile(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selFacCdMobile(mOrderDeliveryVO);
	};

	public List<MOrderDeliveryVO> selAllFacCd(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selAllFacCd(mOrderDeliveryVO);
	};

	public MOrderDeliveryVO selManuDeliverySeq(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuDeliverySeq(mOrderDeliveryVO);
	};

	// 제조 발주확인 등록 및 현황
	public List<MOrderDeliveryVO> selManuOrderChkS(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuOrderChkS(mOrderDeliveryVO);
	};

	public void prcsManuOrderChkS(List<MOrderDeliveryVO> list, String id, String custCd) {
		for (MOrderDeliveryVO mOrderDeliveryVO : list) {
			mOrderDeliveryVO.setId(id);
			mOrderDeliveryVO.setCustCd(custCd);
			if (mOrderDeliveryVO.getOutsCon().equals("1")) {
				dao.prcsManuOrderChkS(mOrderDeliveryVO);
			} else {
				dao.delManuOrderChkS(mOrderDeliveryVO);
			}
		}
	};

	public List<MOrderDeliveryVO> selManuOrderChkR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuOrderChkR(mOrderDeliveryVO);
	};

	// 제조 납품등록
	public List<MOrderDeliveryVO> selManuDeliverySMst(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuDeliverySMst(mOrderDeliveryVO);
	};

	public void prcsOutsEndYn(List<MOrderDeliveryVO> list) {
		for (MOrderDeliveryVO mOrderDeliveryVO : list) {
			if (mOrderDeliveryVO.getOutsEndYn().equals("1")) {
				dao.prcsOutsEndYn(mOrderDeliveryVO);
			}
		}
	};

	public List<MOrderDeliveryVO> selManuDeliveryDeliQty(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuDeliveryDeliQty(mOrderDeliveryVO);
	};

	public List<MOrderDeliveryVO> selManuDeliverySSub(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuDeliverySSub(mOrderDeliveryVO);
	};

	public void prcsManuDeliveryS(List<MOrderDeliveryVO> list, String id) {
		for (MOrderDeliveryVO mOrderDeliveryVO : list) {
			mOrderDeliveryVO.setId(id);
			if (mOrderDeliveryVO.getCudKey().equals("INSERT")) {
				String deliNo = dao.selManuDeliveryNo(mOrderDeliveryVO);
				mOrderDeliveryVO.setDeliNo(deliNo);
			}
			dao.prcsManuDeliveryS(mOrderDeliveryVO);
		}
	};

	public List<MOrderDeliveryVO> selManuDeliveryR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selManuDeliveryR(mOrderDeliveryVO);
	}

	public List<MOrderDeliveryVO> selInboundR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selInboundR(mOrderDeliveryVO);
	}

	// 납품대비 입고현황
	public List<MOrderDeliveryVO> selDeliInboundR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selDeliInboundR(mOrderDeliveryVO);
	}

	// 사업장코드
	public List<MOrderDeliveryVO> selComboFacCd(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selComboFacCd(mOrderDeliveryVO);
	};

	// 거래처코드
	public List<MOrderDeliveryVO> selComboCustCd(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selComboCustCd(mOrderDeliveryVO);
	};

	// 출하현황(대리점용)조회
	public List<MOrderDeliveryVO> selAgencyShipR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selAgencyShipR(mOrderDeliveryVO);
	};

	public List<MOrderDeliveryVO> selAgencyShipDtlR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selAgencyShipDtlR(mOrderDeliveryVO);
	};

	// 영업사원 콤보박스
	public List<MOrderDeliveryVO> selComboSalesEmp(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selComboSalesEmp(mOrderDeliveryVO);
	};

	// 영업부서 콤보박스
	public List<MOrderDeliveryVO> selComboSalesDept(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selComboSalesDept(mOrderDeliveryVO);
	};

	// 출하현황(영업용) 조회
	public List<MOrderDeliveryVO> selSalesShipR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selSalesShipR(mOrderDeliveryVO);
	};

	public List<MOrderDeliveryVO> selSalesShipDtlR(MOrderDeliveryVO mOrderDeliveryVO) {
		return dao.selSalesShipDtlR(mOrderDeliveryVO);
	};

}
