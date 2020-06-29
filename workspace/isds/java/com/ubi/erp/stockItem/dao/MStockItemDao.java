package com.ubi.erp.stockItem.dao;

import java.util.List;

import com.ubi.erp.stockItem.domain.MStockItemVO;


public interface MStockItemDao {

	public List<MStockItemVO> selMobileStockItemList(MStockItemVO stockItemVO); // 모바일 - inus 품목 재고현황

	public List<MStockItemVO> selMobileItemCdList(MStockItemVO stockItemVO); // 모바일 - inus 품목 재고현황 [품목코드 콤보박스]

	public List<MStockItemVO> selMobileFacCdList(MStockItemVO stockItemVO); // 모바일 - inus 품목 재고현황 [사업장 콤보박스]

	public List<MStockItemVO> selMobileStockItemByFacList(MStockItemVO stockItemVO); // 모바일 - inus 사업장별 품목 재고현황

	// [프로시저] 타일쪽 선택된 품목별로 색상, 크기, 등급 정보 보여줄 화면 프로시저
	// 파라미터 : 기간시작(stdDt), 기간종료(stdDt), 공장코드(facCd), 품목코드(itmCd)
	public List<MStockItemVO> selLes104SQuery(MStockItemVO stockItemVO);

	public List<MStockItemVO> selBsCdByFacCd(MStockItemVO stockItemVO);	//프로시저 호출 전, facCd가지고 bsCd get

	public List<MStockItemVO> selTitleByBaseCd(MStockItemVO stockItemVO);

	public List<MStockItemVO> selWhNmByWhCd(MStockItemVO stockItemVO);
};