package com.ubi.erp.dailyWork.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.cmm.file.AttachFileService;
import com.ubi.erp.cmm.util.AESEncoder;
import com.ubi.erp.cmm.util.PropertyUtil;
import com.ubi.erp.dailyWork.dao.DailyWorkDao;
import com.ubi.erp.dailyWork.domain.DailyWorkVO;

@Service
public class DailyWorkService {

	private DailyWorkDao dao;

	@Autowired
	private AttachFileService attachFileService;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(DailyWorkDao.class);
	}

	// 비밀번호 변경
	public int selChangeCheck(DailyWorkVO dailyWorkVO) {
		return dao.selChangeCheck(dailyWorkVO);
	}

	public void prcsChangePassWord(DailyWorkVO dailyWorkVO) {
		dao.prcsChangePassWord(dailyWorkVO);
	}

	// 팝업 및 기타
	public List<DailyWorkVO> selSiteCd(DailyWorkVO dailyWorkVO) {
		return dao.selSiteCd(dailyWorkVO);
	};

	public List<DailyWorkVO> selWeather() {
		return dao.selWeather();
	};

	public List<DailyWorkVO> selCommgrpmCd(DailyWorkVO dailyWorkVO) {
		return dao.selCommgrpmCd(dailyWorkVO);
	};

	public List<DailyWorkVO> selCommgrpsCd(DailyWorkVO dailyWorkVO) {
		return dao.selCommgrpsCd(dailyWorkVO);
	};

	public List<DailyWorkVO> selPerNum(DailyWorkVO dailyWorkVO) {
		return dao.selPerNum(dailyWorkVO);
	};

	public List<DailyWorkVO> selPerNm(DailyWorkVO dailyWorkVO) {
		return dao.selPerNm(dailyWorkVO);
	};

	// 근무자 등록
	public List<DailyWorkVO> selWorkerDelCheck(DailyWorkVO dailyWorkVO) {
		return dao.selWorkerDelCheck(dailyWorkVO);
	};

	public List<DailyWorkVO> selWorkerS(DailyWorkVO dailyWorkVO) {
		return dao.selWorkerS(dailyWorkVO);
	};

	public void prcsWorkerS(List<DailyWorkVO> list, String id, String custCd, AESEncoder aesEncoder) {
		int cnt = 0;
		for (DailyWorkVO dailyWorkVO : list) {
			dailyWorkVO.setId(id);
			dailyWorkVO.setCustCd(custCd);
			try {
				String encRegi = aesEncoder.encrypt(dailyWorkVO.getRegiNo());
				dailyWorkVO.setRegiNo(encRegi);
				String encFore = aesEncoder.encrypt(dailyWorkVO.getForeNo());
				dailyWorkVO.setForeNo(encFore);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (dailyWorkVO.getCudKey().equals("DELETE")) {
				attachFileService.deleteFile(PropertyUtil.getString("attach.daily.savedir"), list.get(cnt).getFileSaveNm());
				dao.prcsWorkerS(dailyWorkVO);
			} else if (dailyWorkVO.getCudKey().equals("INSERT")) {
				String year = dailyWorkVO.getEnterDt().substring(0, 4);
				dailyWorkVO.setYear(year);
				String seq = dao.selWorkerSSeq(dailyWorkVO);
				String perNo = year + seq;
				dailyWorkVO.setPerNo(perNo);
				dao.prcsWorkerS(dailyWorkVO);
			} else if (dailyWorkVO.getCudKey().equals("UPDATE")) {
				dao.prcsWorkerS(dailyWorkVO);
			}
			cnt++;
		}
	};

	// 일일근태 등록
	public List<DailyWorkVO> selDayByDiliSPerNo(DailyWorkVO dailyWorkVO) {
		return dao.selDayByDiliSPerNo(dailyWorkVO);
	};

	public DailyWorkVO selCommgrpm(DailyWorkVO dailyWorkVO) {
		return dao.selCommgrpm(dailyWorkVO);
	};

	public List<DailyWorkVO> selDayByDiliS(DailyWorkVO dailyWorkVO) {
		return dao.selDayByDiliS(dailyWorkVO);
	};

	public int selDayByDiliChk(DailyWorkVO dailyWorkVO) {
		return dao.selDayByDiliChk(dailyWorkVO);
	}

	public void prcsDayByDiliS(List<DailyWorkVO> list, String id, String custCd) {
		for (DailyWorkVO dailyWorkVO : list) {
			dailyWorkVO.setId(id);
			dailyWorkVO.setCustCd(custCd);
			dao.prcsDayByDiliS(dailyWorkVO);
		}
	}

	public void prcsDayByDiliCreate(DailyWorkVO dailyWorkVO, String flag) {
		if (flag == "N" || flag.equals("N")) {
			dao.prcsDayByDiliCreate(dailyWorkVO);
		} else {
			dao.prcsDayByDiliDelCreate(dailyWorkVO);
		}
	}

	// 일일근태 조회
	public List<DailyWorkVO> selDayByDiliR(DailyWorkVO dailyWorkVO) {
		return dao.selDayByDiliR(dailyWorkVO);
	};

	// 개인 근태등록 모바일
	public List<DailyWorkVO> selIndividualDili(DailyWorkVO dailyWorkVO) {
		return dao.selIndividualDili(dailyWorkVO);
	};

	public void prcsIndividualDili(DailyWorkVO dailyWorkVO) {
		dao.prcsIndividualDili(dailyWorkVO);
	};

	public List<DailyWorkVO> selSiteCdMobile(DailyWorkVO dailyWorkVO) {
		return dao.selSiteCdMobile(dailyWorkVO);
	};

	// 월근태 집계
	public List<DailyWorkVO> selMonthByDiliR(DailyWorkVO dailyWorkVO) {
		return dao.selMonthByDiliR(dailyWorkVO);
	};

	// 공사 일보 등록
	public List<DailyWorkVO> selConstructWorkNm(DailyWorkVO dailyWorkVO) {
		return dao.selConstructWorkNm(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructionPop(DailyWorkVO dailyWorkVO) {
		return dao.selConstructionPop(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructionAppvForm(DailyWorkVO dailyWorkVO) {
		return dao.selConstructionAppvForm(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructionForm(DailyWorkVO dailyWorkVO) {
		return dao.selConstructionForm(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructionMain(DailyWorkVO dailyWorkVO) {
		return dao.selConstructionMain(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructionSub(DailyWorkVO dailyWorkVO) {
		return dao.selConstructionSub(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructionSub01(DailyWorkVO dailyWorkVO) {
		return dao.selConstructionSub01(dailyWorkVO);
	};

	public void prcsConstructionForm(DailyWorkVO dailyWorkVO, String custCd, String id) {
		dailyWorkVO.setId(id);
		dailyWorkVO.setCustCd(custCd);
		dao.prcsConstructionForm(dailyWorkVO);
	};

	public void prcsConstructionSub(List<DailyWorkVO> main, List<DailyWorkVO> sub, List<DailyWorkVO> sub01, String id, String custCd) {
		for (DailyWorkVO dailyWorkVOMain : main) {
			dailyWorkVOMain.setId(id);
			dailyWorkVOMain.setCustCd(custCd);
			dao.prcsConstructionMain(dailyWorkVOMain);
		}
		for (DailyWorkVO dailyWorkVOSub : sub) {
			dailyWorkVOSub.setId(id);
			dailyWorkVOSub.setCustCd(custCd);
			dao.prcsConstructionSub(dailyWorkVOSub);
		}
		for (DailyWorkVO dailyWorkVOSub01 : sub01) {
			dailyWorkVOSub01.setId(id);
			dailyWorkVOSub01.setCustCd(custCd);
			dao.prcsConstructionSub01(dailyWorkVOSub01);
		}
	};

	public void delConstructionS(DailyWorkVO dailyWorkVO) {
		dao.delConstructionForm(dailyWorkVO);
	}

	public List<DailyWorkVO> selConstructPerNoP(DailyWorkVO dailyWorkVO) {
		return dao.selConstructPerNoP(dailyWorkVO);
	};

	// 공사일보 추가 구분
	public List<DailyWorkVO> selConstructDailyAttendChk(DailyWorkVO dailyWorkVO) {
		return dao.selConstructDailyAttendChk(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructDailyAttend(DailyWorkVO dailyWorkVO) {
		return dao.selConstructDailyAttend(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructAppvSubGrid(DailyWorkVO dailyWorkVO) {
		return dao.selConstructAppvSubGrid(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructAppvEmp(DailyWorkVO dailyWorkVO) {
		return dao.selConstructAppvEmp(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructKindEmp(DailyWorkVO dailyWorkVO) {
		return dao.selConstructKindEmp(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructRegEmp(DailyWorkVO dailyWorkVO) {
		return dao.selConstructRegEmp(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructEquiCodePop(DailyWorkVO dailyWorkVO) {
		return dao.selConstructEquiCodePop(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructitemCodePop(DailyWorkVO dailyWorkVO) {
		return dao.selConstructitemCodePop(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructMainP(DailyWorkVO dailyWorkVO) {
		return dao.selConstructMainP(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructSubP(DailyWorkVO dailyWorkVO) {
		return dao.selConstructSubP(dailyWorkVO);
	};

	public DailyWorkVO selConstructSumPreQty(DailyWorkVO dailyWorkVO) {
		return dao.selConstructSumPreQty(dailyWorkVO);
	};

	public DailyWorkVO selConstructSumWorkerNum(DailyWorkVO dailyWorkVO) {
		return dao.selConstructSumWorkerNum(dailyWorkVO);
	};

	public DailyWorkVO selConstructAppvSumNum(DailyWorkVO dailyWorkVO) {
		return dao.selConstructAppvSumNum(dailyWorkVO);
	};

	// 공사일보등록 결재
	public void prcsConsturctionRForm(DailyWorkVO dailyWorkVO, String custCd, String id) {
		dailyWorkVO.setCustCd(custCd);
		dailyWorkVO.setId(id);
		dao.prcsConsturctionRForm(dailyWorkVO);
	}

	// 결재기준등록
	public List<DailyWorkVO> selApprovalStanS(DailyWorkVO dailyWorkVO) {
		return dao.selApprovalStanS(dailyWorkVO);
	};

	public void prcsApprovalStanS(List<DailyWorkVO> list, String custCd, String id) {
		for (DailyWorkVO dailyWorkVO : list) {
			dailyWorkVO.setCustCd(custCd);
			dailyWorkVO.setId(id);
			dao.prcsApprovalStanS(dailyWorkVO);
		}
	}

	// 일일출역표 등록
	public List<DailyWorkVO> selDailyAttendDiliS(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendDiliS(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendSPop(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendSPop(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendSForm(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendSForm(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendSGrid(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendSGrid(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendRegEmp(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendRegEmp(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendAppvEmp(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendAppvEmp(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendConfirmRegEmp(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendConfirmRegEmp(dailyWorkVO);
	};

	public void prcsDailyAttendSForm(DailyWorkVO dailyWorkVO, String custCd, String id) {
		dailyWorkVO.setCustCd(custCd);
		dailyWorkVO.setId(id);
		dao.prcsDailyAttendSForm(dailyWorkVO);
	}

	public void prcsDailyAttendSGrid(List<DailyWorkVO> list, String custCd, String id) {
		for (DailyWorkVO dailyWorkVO : list) {
			dailyWorkVO.setCustCd(custCd);
			dailyWorkVO.setId(id);
			dao.prcsDailyAttendSGrid(dailyWorkVO);
		}
	}

	public void delDailyAttendS(DailyWorkVO dailyWorkVO, String custCd) {
		dailyWorkVO.setCustCd(custCd);
		dao.delDailyAttendS(dailyWorkVO);
	}

	// 일일출역표 결재
	public List<DailyWorkVO> selDailyAttendRAppvEmp(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendRAppvEmp(dailyWorkVO);
	};

	public List<DailyWorkVO> selDailyAttendRKindEmp(DailyWorkVO dailyWorkVO) {
		return dao.selDailyAttendRKindEmp(dailyWorkVO);
	};

	public void prcsDailyAttendRForm(DailyWorkVO dailyWorkVO, String custCd, String id) {
		dailyWorkVO.setCustCd(custCd);
		dailyWorkVO.setId(id);
		dao.prcsDailyAttendRForm(dailyWorkVO);
	}

	// 공사일보 누계 현황
	public List<DailyWorkVO> selConstructStanMst(DailyWorkVO dailyWorkVO) {
		return dao.selConstructStanMst(dailyWorkVO);
	};

	public List<DailyWorkVO> selConstructStanSub(DailyWorkVO dailyWorkVO) {
		return dao.selConstructStanSub(dailyWorkVO);
	};

	public void prcsConstructionStan(List<DailyWorkVO> main, List<DailyWorkVO> sub, String id, String custCd) {
		for (DailyWorkVO dailyWorkVO : main) {
			dailyWorkVO.setCustCd(custCd);
			dailyWorkVO.setId(id);
			dao.insConstructStanMst(dailyWorkVO);
		}
		for (DailyWorkVO dailyWorkVO : sub) {
			dailyWorkVO.setCustCd(custCd);
			dailyWorkVO.setId(id);
			dao.insConstructStanSub(dailyWorkVO);
		}
	};

	// 세부공종등록
	public List<DailyWorkVO> selCommgrpdSPop(DailyWorkVO dailyWorkVO) {
		return dao.selCommgrpdSPop(dailyWorkVO);
	};

	public List<DailyWorkVO> selCommgrpdS(DailyWorkVO dailyWorkVO) {
		return dao.selCommgrpdS(dailyWorkVO);
	};

	public void insCommgrpdS(List<DailyWorkVO> list, String id, String custCd) {
		for (DailyWorkVO dailyWorkVO : list) {
			dailyWorkVO.setCustCd(custCd);
			dailyWorkVO.setId(id);
			if (dailyWorkVO.getCudKey().equals("INSERT")) {
				String descCd = dao.selCommgrpdSSeq(dailyWorkVO);
				dailyWorkVO.setDescCd(descCd);
				dao.insCommgrpdS(dailyWorkVO);
			} else {
				dao.insCommgrpdS(dailyWorkVO);
			}
		}
	};

}
