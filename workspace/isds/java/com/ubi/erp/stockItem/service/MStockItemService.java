package com.ubi.erp.stockItem.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.stockItem.dao.MStockItemDao;
import com.ubi.erp.stockItem.domain.MStockItemVO;

@Service
public class MStockItemService {

	private MStockItemDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(MStockItemDao.class);
	}

	// [모바일] inus 품목 재고현황
	public List<MStockItemVO> selMobileStockItemList(MStockItemVO mStockItemVO) {
		return dao.selMobileStockItemList(mStockItemVO);
	}

	// [모바일] inus 품목 재고현황 - 품목코드 콤보박스
	public List<MStockItemVO> selMobileItemCdList(MStockItemVO mStockItemVO) {
		return dao.selMobileItemCdList(mStockItemVO);
	}

	// [모바일] inus 품목 재고현황 - 사업장 콤보박스
	public List<MStockItemVO> selMobileFacCdList(MStockItemVO mStockItemVO) {
		return dao.selMobileFacCdList(mStockItemVO);
	}

	// [모바일] inus 품목 재고현황 - 사업장별
	public List<MStockItemVO> selMobileStockItemByFacList(MStockItemVO mStockItemVO) {
		return dao.selMobileStockItemByFacList(mStockItemVO);
	}

	// 프로시저 호출 전, facCd가지고 bsCd get
	public String selBsCdByFacCd(MStockItemVO mStockItemVO) {
		List<MStockItemVO> list = dao.selBsCdByFacCd(mStockItemVO);
		String bsCd = "";

		if (list.size() > 0) {
			bsCd = list.get(0).getBsCd();
		}

		return bsCd;
	}

	// [프로시저] 타일쪽 선택된 품목별로 색상, 크기, 등급 정보 보여줄 화면 프로시저
	// 파라미터 : 기간시작(stdDt), 기간종료(stdDt), 공장코드(facCd), 품목코드(itmCd)
	public List<MStockItemVO> selLes104SQuery(MStockItemVO mStockItemVO) {
		return dao.selLes104SQuery(mStockItemVO);
	}

	// 공통코드 가지고 명칭 가져오기 [baseCd]
	public List<MStockItemVO> selBaseNm(MStockItemVO mStockItemVO) {
		return dao.selTitleByBaseCd(mStockItemVO);
	}

	// 창고코드에 따른 창고명 get [BCW100]
	public List<MStockItemVO> selWhNmByWhCd(MStockItemVO mStockItemVO) {
		return dao.selWhNmByWhCd(mStockItemVO);
	}
}
