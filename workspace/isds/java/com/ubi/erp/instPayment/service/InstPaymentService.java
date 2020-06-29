package com.ubi.erp.instPayment.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.cmm.file.AttachFileService;
import com.ubi.erp.cmm.util.PropertyUtil;
import com.ubi.erp.instPayment.dao.InstPaymentDao;
import com.ubi.erp.instPayment.domain.InstPaymentVO;

@Service
public class InstPaymentService {

	private InstPaymentDao dao;

	@Autowired
	private AttachFileService attachFileService;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(InstPaymentDao.class);
	}

	// 팝업 및 기타
	public List<InstPaymentVO> selHadocontNo(InstPaymentVO instPaymentVO) {
		return dao.selHadocontNo(instPaymentVO);
	}

	// 기성청구 등록
	public InstPaymentVO selNowCurrentDate() {
		return dao.selNowCurrentDate();
	}

	public InstPaymentVO selBillingDate(InstPaymentVO instPaymentVO) {
		return dao.selBillingDate(instPaymentVO);
	}

	public List<InstPaymentVO> selBillingS(InstPaymentVO instPaymentVO) {
		return dao.selBillingS(instPaymentVO);
	}

	public void prcsBillingFinalDate(InstPaymentVO instPaymentVO) {
		dao.prcsBillingFinalDate(instPaymentVO);
	}

	public void prcsBillingS(List<InstPaymentVO> list, String id, String custCd) {
		for (InstPaymentVO instPaymentVO : list) {
			int cnt = dao.selExcelBillingS(instPaymentVO);
			if (cnt == 0) {
				instPaymentVO.setCudKey("INSERT");
			} else {
				instPaymentVO.setCudKey("UPDATE");
			}
			instPaymentVO.setId(id);
			instPaymentVO.setCustCd(custCd);
			dao.prcsBillingS(instPaymentVO);
			dao.prcsBillingFinalDate(instPaymentVO);
		}
	}

	public void prcsExcelBillingS(InstPaymentVO instPaymentVO) {
		int cnt = dao.selExcelBillingS(instPaymentVO);
		if (cnt == 0) {
			instPaymentVO.setCudKey("INSERT");
		} else {
			instPaymentVO.setCudKey("UPDATE");
		}
		dao.prcsExcelBillingS(instPaymentVO);
		dao.prcsBillingFinalDate(instPaymentVO);
	}

	public void delBillingS(InstPaymentVO instPaymentVO) {
		dao.delBillingS(instPaymentVO);
		dao.delBillingFinalDate(instPaymentVO);
	}

	public List<InstPaymentVO> selBillingR(InstPaymentVO instPaymentVO) {
		return dao.selBillingR(instPaymentVO);
	}

	// 첨부파일관리
	public List<InstPaymentVO> selBillingFileSave(InstPaymentVO instPaymentVO) {
		return dao.selBillingFileSave(instPaymentVO);
	}

	public void prcsBillingFileSave(List<InstPaymentVO> list, String id) {
		int cnt = 0;
		for (InstPaymentVO instPaymentVO : list) {
			if (instPaymentVO.getCudKey().equals("DELETE")) {
				attachFileService.deleteFile(PropertyUtil.getString("attach.billing.savedir"), list.get(cnt).getFileNm());
			}
			instPaymentVO.setId(id);
			dao.prcsBillingFileSave(instPaymentVO);
			cnt++;
		}
	}

	// 엑셀업로드
	public List<InstPaymentVO> selExcelUploadGrid(InstPaymentVO instPaymentVO) {
		return dao.selExcelUploadGrid(instPaymentVO);
	}
}
