package com.ubi.erp.custCard.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.custCard.dao.CustCardDao;
import com.ubi.erp.custCard.domain.CustCardVO;

@Service
public class CustCardService {

	private CustCardDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(CustCardDao.class);
	}

	// [조회] main_cd에 따른 공통코드
	public List<CustCardVO> selBaseCd(CustCardVO custCardVO) {
		return dao.selBaseCd(custCardVO);
	}

	// [조회] 고객상담카드내역 조회
	public List<CustCardVO> selCustCardR(CustCardVO custCardVO) {
		return dao.selCustCardR(custCardVO);
	}

	// [조회] 상담자(사원번호) 검색
	public List<CustCardVO> selEmpInfo(CustCardVO custCardVO) {
		return dao.selEmpInfo(custCardVO);
	}

	// [조회] 판매채널(거래처코드) 검색 팝업
	public List<CustCardVO> selCustInfoPOP(CustCardVO custCardVO) {
		return dao.selCustInfoPOP(custCardVO);
	}

	// [조회] 상품검색
	public List<CustCardVO> selSaleCode(CustCardVO custCardVO) {
		return dao.selSaleCode(custCardVO);
	}

	public String selCodeNo2(CustCardVO custCardVO) {
		List<CustCardVO> list = dao.selCodeNo2(custCardVO);
		String val = "";

		if (list.size() > 0) {
			val = list.get(0).getVal();
		}

		return val;
	}

	public void insAsa500(CustCardVO custCardVO) {
		dao.insAsa500(custCardVO);
	}

	public void updAsa500(CustCardVO custCardVO) {
		dao.updAsa500(custCardVO);
	}

	public void delAsa500(CustCardVO custCardVO, String ordNo) {
		custCardVO.setOrdNo(ordNo);
		dao.delAsa500(custCardVO);
	}

	// [조회] 고객상담카드내역 조회 (출력물)
	public List<CustCardVO> selCustCardRPrint(CustCardVO custCardVO) {
		return dao.selCustCardRPrint(custCardVO);
	}

	// load 시, id를 가지고 정보 get
	public List<CustCardVO> getScmUserInfo(CustCardVO custCardVO) {
		return dao.getScmUserInfo(custCardVO);
	}

	// [조회] inusbath 계약등록 테이블에 동일 고객/주문번호가 존재하는지 체크
	public int getCntOrdNo(String ordNo) {
		List<CustCardVO> list = dao.getCntOrdNo(ordNo);
		int ordCnt = 0;

		if (list.size() > 0) {
			ordCnt = list.get(0).getOrdCnt();
		}

		return ordCnt;
	}

	// [프로시저] 신규/수정시 호출 - SDH100 INSERT / UPDATE
	public List<CustCardVO> selAsa500WorkD(CustCardVO custCardVO) {
		return dao.selAsa500WorkD(custCardVO);
	}

	// [모바일] inus 품목 재고현황
	public List<CustCardVO> selMobileStockItemList(CustCardVO custCardVO) {
		return dao.selMobileStockItemList(custCardVO);
	}

	// [모바일] inus 품목 재고현황 - 품목코드 콤보박스
	public List<CustCardVO> selMobileItemCdList(CustCardVO custCardVO) {
		return dao.selMobileItemCdList(custCardVO);
	}

	// [모바일] inus 품목 재고현황 - 사업장 콤보박스
	public List<CustCardVO> selMobileFacCdList(CustCardVO custCardVO) {
		return dao.selMobileFacCdList(custCardVO);
	}

	// [모바일] inus 품목 재고현황 - 사업장별
	public List<CustCardVO> selMobileStockItemByFacList(CustCardVO custCardVO) {
		return dao.selMobileStockItemByFacList(custCardVO);
	}

	// [조회] 세트 고객 상담카드
	public List<CustCardVO> selSetCustCardR(CustCardVO custCardVO) {
		return dao.selSetCustCardR(custCardVO);
	}

	// [조회] 단품 고객 상담카드
	public List<CustCardVO> selPrdCustCardR(CustCardVO custCardVO) {
		return dao.selPrdCustCardR(custCardVO);
	}

	public void insAsa510(CustCardVO custCardVO) {
		dao.insAsa510(custCardVO);
	}

	public void updAsa510(CustCardVO custCardVO) {
		dao.updAsa510(custCardVO);
	}

	public void delAsa510(CustCardVO custCardVO, String ordNo) {
		custCardVO.setOrdNo(ordNo);
		dao.delAsa510(custCardVO);
	}

	// [조회] 세트 고객상담카드내역 조회 (출력물)
	public List<CustCardVO> selSetCustCardRPrint(CustCardVO custCardVO) {
		return dao.selSetCustCardRPrint(custCardVO);
	}


	public void insAsa520(CustCardVO custCardVO) {
		dao.insAsa520(custCardVO);
	}

	public void updAsa520(CustCardVO custCardVO) {
		dao.updAsa520(custCardVO);
	}

	public void delAsa520(CustCardVO custCardVO, String ordNo) {
		custCardVO.setOrdNo(ordNo);
		dao.delAsa520(custCardVO);
	}

	// [조회] 단품 고객상담카드내역 조회 (출력물)
	public List<CustCardVO> selPrdCustCardRPrint(CustCardVO custCardVO) {
		return dao.selPrdCustCardRPrint(custCardVO);
	}
}
