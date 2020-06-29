package com.ubi.erp.dailyWork.dao;

import java.util.List;

import com.ubi.erp.dailyWork.domain.DailyWorkVO;

public interface DailyWorkDao {

	// 비밀번호 변경
	public int selChangeCheck(DailyWorkVO dailyWorkVO);

	public void prcsChangePassWord(DailyWorkVO dailyWorkVO);

	// 팝업 및 기타
	public List<DailyWorkVO> selSiteCd(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selWeather();

	public List<DailyWorkVO> selCommgrpmCd(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selCommgrpsCd(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selPerNum(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selPerNm(DailyWorkVO dailyWorkVO);

	// 근무자 등록
	public String selWorkerSSeq(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selWorkerDelCheck(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selWorkerS(DailyWorkVO dailyWorkVO);

	public void prcsWorkerS(DailyWorkVO dailyWorkVO);

	// 일일근태 등록
	public List<DailyWorkVO> selDayByDiliSPerNo(DailyWorkVO dailyWorkVO);

	public DailyWorkVO selCommgrpm(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDayByDiliS(DailyWorkVO dailyWorkVO);

	public int selDayByDiliChk(DailyWorkVO dailyWorkVO);

	public void prcsDayByDiliS(DailyWorkVO dailyWorkVO);

	public void prcsDayByDiliCreate(DailyWorkVO dailyWorkVO);

	public void prcsDayByDiliDelCreate(DailyWorkVO dailyWorkVO);

	// 일일근태 현황
	public List<DailyWorkVO> selDayByDiliR(DailyWorkVO dailyWorkVO);

	// 개인근태등록 모바일
	public List<DailyWorkVO> selIndividualDili(DailyWorkVO dailyWorkVO);

	public void prcsIndividualDili(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selSiteCdMobile(DailyWorkVO dailyWorkVO);

	// 월근태 집계
	public List<DailyWorkVO> selMonthByDiliR(DailyWorkVO dailyWorkVO);

	// 공사일보 등록
	public List<DailyWorkVO> selConstructWorkNm(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructionPop(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructionAppvForm(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructionForm(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructionMain(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructionSub(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructionSub01(DailyWorkVO dailyWorkVO);

	public void prcsConstructionForm(DailyWorkVO dailyWorkVO);

	public void delConstructionForm(DailyWorkVO dailyWorkVO);

	public void prcsConstructionMain(DailyWorkVO dailyWorkVO);

	public void prcsConstructionSub(DailyWorkVO dailyWorkVO);

	public void prcsConstructionSub01(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructPerNoP(DailyWorkVO dailyWorkVO);

	// 공사일보 추가 구분
	public List<DailyWorkVO> selConstructDailyAttendChk(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructDailyAttend(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructAppvSubGrid(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructAppvEmp(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructKindEmp(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructRegEmp(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructEquiCodePop(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructitemCodePop(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructMainP(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructSubP(DailyWorkVO dailyWorkVO);

	public DailyWorkVO selConstructSumPreQty(DailyWorkVO dailyWorkVO);

	public DailyWorkVO selConstructSumWorkerNum(DailyWorkVO dailyWorkVO);

	public DailyWorkVO selConstructAppvSumNum(DailyWorkVO dailyWorkVO);

	// 공사일보등록 결재
	public void prcsConsturctionRForm(DailyWorkVO dailyWorkVO);

	// 결재기준등록
	public List<DailyWorkVO> selApprovalStanS(DailyWorkVO dailyWorkVO);

	public void prcsApprovalStanS(DailyWorkVO dailyWorkVO);

	// 일일출역표 등록
	public List<DailyWorkVO> selDailyAttendDiliS(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendSPop(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendSForm(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendSGrid(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendRegEmp(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendAppvEmp(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendConfirmRegEmp(DailyWorkVO dailyWorkVO);

	public void prcsDailyAttendSForm(DailyWorkVO dailyWorkVO);

	public void prcsDailyAttendSGrid(DailyWorkVO dailyWorkVO);

	public void delDailyAttendS(DailyWorkVO dailyWorkVO);

	// 일일출역표 결재
	public List<DailyWorkVO> selDailyAttendRAppvEmp(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selDailyAttendRKindEmp(DailyWorkVO dailyWorkVO);

	public void prcsDailyAttendRForm(DailyWorkVO dailyWorkVO);

	// 공사일보 누계 등록
	public List<DailyWorkVO> selConstructStanMst(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selConstructStanSub(DailyWorkVO dailyWorkVO);

	public void insConstructStanMst(DailyWorkVO dailyWorkVO);

	public void insConstructStanSub(DailyWorkVO dailyWorkVO);

	// 세부공종 등록
	public String selCommgrpdSSeq(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selCommgrpdSPop(DailyWorkVO dailyWorkVO);

	public List<DailyWorkVO> selCommgrpdS(DailyWorkVO dailyWorkVO);

	public void insCommgrpdS(DailyWorkVO dailyWorkVO);
}
