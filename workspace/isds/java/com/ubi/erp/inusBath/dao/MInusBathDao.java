package com.ubi.erp.inusBath.dao;

import java.util.List;

import com.ubi.erp.inusBath.domain.MInusBathVO;


public interface MInusBathDao {

	public List<MInusBathVO> selMobileSigongFinishList(MInusBathVO mInusBathVO); // 모바일:inusBath시공마감(시공점)

	public List<MInusBathVO> selMobileSigongSumList(MInusBathVO mInusBathVO); // 모바일:계약별시공금액내역

	public List<MInusBathVO> selMobileItmShipList(MInusBathVO mInusBathVO); // 모바일:inusbath 견적별 출하내역

	public List<MInusBathVO> selMobileItmShipDtlList(MInusBathVO mInusBathVO); // 모바일:inusbath 견적별 출하내역 (상세내역)

	// [프로시저] 마감진행
	// 파라미터 : 견적번호[estNo], 상품구분[saleGubun], 시공마감여부[saleEndChk], 등록ID[regId]
	public void prcsSdh680SQuery(MInusBathVO mInusBathVO);

	public void updSda180(MInusBathVO mInusBathVO); /* 마감진행 (업데이트만) */

	public void insSDA180(MInusBathVO mInusBathVO); // insert SDA180 [est_no]
	
	public List<MInusBathVO> getCntEstNo(MInusBathVO mInusBathVO); /* 마감진행 전에 데이터 있는지 확인 */

	public List<MInusBathVO> selCustCdList(MInusBathVO mInusBathVO); /* 마감진행 시공사 콤보박스 */
};