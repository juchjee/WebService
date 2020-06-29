package com.ubi.erp.inusBath.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.inusBath.dao.MInusBathDao;
import com.ubi.erp.inusBath.domain.MInusBathVO;

@Service
public class MInusBathService {

	private MInusBathDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(MInusBathDao.class);
	}

	// [모바일] inusBath시공마감(시공점)
	public List<MInusBathVO> selMobileSigongFinishList(MInusBathVO mInusBathVO) {
		return dao.selMobileSigongFinishList(mInusBathVO);
	}

	// [모바일] 계약별시공금액내역
	public List<MInusBathVO> selMobileSigongSumList(MInusBathVO mInusBathVO) {
		return dao.selMobileSigongSumList(mInusBathVO);
	}

	// [모바일] inusbath 견적별 출하내역
	public List<MInusBathVO> selMobileItmShipList(MInusBathVO mInusBathVO) {
		return dao.selMobileItmShipList(mInusBathVO);
	}

	// [모바일] 견적별 출하내역 (상세내역)
	public List<MInusBathVO> selMobileItmShipDtlList(MInusBathVO mInusBathVO) {
		return dao.selMobileItmShipDtlList(mInusBathVO);
	}

	// [모바일] 시공점 콤보박스
	public List<MInusBathVO> selCustCdList(MInusBathVO mInusBathVO) {
		return dao.selCustCdList(mInusBathVO);
	}

	// [프로시저] 마감진행
	// 파라미터 : 견적번호[estNo], 상품구분[saleGubun], 시공마감여부[saleEndChk], 등록ID[regId]
	public void prcsSdh680SQuery(MInusBathVO mInusBathVO) {
		dao.prcsSdh680SQuery(mInusBathVO);
	}

	public void updSda180(MInusBathVO mInusBathVO) {
		dao.updSda180(mInusBathVO);
	}

	public int getCntEstNo(MInusBathVO mInusBathVO) {
		List<MInusBathVO> list = dao.getCntEstNo(mInusBathVO);
		int cnt = 0;

		if (list.size() > 0) {
			cnt = list.get(0).getCnt();
		}

		return cnt;
	}

	public void insSDA180(MInusBathVO mInusBathVO) {
		dao.insSDA180(mInusBathVO);
	}
}
