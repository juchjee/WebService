package com.ubi.erp.custCard.dao;

import java.util.List;

import com.ubi.erp.custCard.domain.CustCardVO;


public interface CustCardDao {

	public List<CustCardVO> selBaseCd(CustCardVO custCardVO); /* 공통코드 조회 */

	public List<CustCardVO> selCustCardR(CustCardVO custCardVO); /* 고객 상담내역 조회 */

	public List<CustCardVO> selEmpInfo(CustCardVO custCardVO); /* 상담자(사원번호) 검색 */

	public List<CustCardVO> selSaleCode(CustCardVO custCardVO); /* 상품코드 검색 팝업 */

	public List<CustCardVO> selCustInfoPOP(CustCardVO custCardVO); /* 판매채널(거래처코드) 검색 팝업 */

	public List<CustCardVO> selCodeNo2(CustCardVO custCardVO); /* ASA500 insert 시, ordNo 발번 */

	public void insAsa500(CustCardVO custCardVO); // insert asa500 [ord_no]

	public void updAsa500(CustCardVO custCardVO); // update asa500 [ord_no]

	public void delAsa500(CustCardVO custCardVO); // delete asa500 [ord_no]
	
	public List<CustCardVO> selCustCardRPrint(CustCardVO custCardVO); /* 고객 상담내역 조회[출력물] */

	public List<CustCardVO> getCntOrdNo(String ordNo); /* inusbath 계약등록 테이블에 동일 고객/주문번호가 존재하는지 체크 */

	public List<CustCardVO> getScmUserInfo(CustCardVO custCardVO); /* 화면 load 시 로그인 유저 정보 get */

	public List<CustCardVO> selAsa500WorkD(CustCardVO custCardVO); // [프로시저] 신규/수정시 호출 - SDH100 INSERT / UPDATE

	public List<CustCardVO> selMobileStockItemList(CustCardVO custCardVO); // 모바일 - inus 품목 재고현황

	public List<CustCardVO> selMobileItemCdList(CustCardVO custCardVO); // 모바일 - inus 품목 재고현황 [품목코드 콤보박스]

	public List<CustCardVO> selMobileFacCdList(CustCardVO custCardVO); // 모바일 - inus 품목 재고현황 [사업장 콤보박스]

	public List<CustCardVO> selMobileStockItemByFacList(CustCardVO custCardVO); // 모바일 - inus 사업장별 품목 재고현황
	
	/* 세트 */
	public List<CustCardVO> selSetCustCardR(CustCardVO custCardVO); /* 세트 고객 상담내역 조회 */

	public void insAsa510(CustCardVO custCardVO); // insert asa510 [ord_no]

	public void updAsa510(CustCardVO custCardVO); // update asa510 [ord_no]

	public void delAsa510(CustCardVO custCardVO); // delete asa510 [ord_no]
	
	public List<CustCardVO> selSetCustCardRPrint(CustCardVO custCardVO); /* 세트 고객 상담내역 조회[출력물] */
	
	/* 단품 */
	public List<CustCardVO> selPrdCustCardR(CustCardVO custCardVO); /* 단품 고객 상담내역 조회 */	

	public void insAsa520(CustCardVO custCardVO); // insert asa520 [ord_no]

	public void updAsa520(CustCardVO custCardVO); // update asa520 [ord_no]

	public void delAsa520(CustCardVO custCardVO); // delete asa520 [ord_no]

	public List<CustCardVO> selPrdCustCardRPrint(CustCardVO custCardVO); /* 단품 고객 상담내역 조회[출력물] */
};