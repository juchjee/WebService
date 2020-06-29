package com.ubi.erp.instPayment.dao;

import java.util.List;

import com.ubi.erp.instPayment.domain.InstPaymentVO;

public interface InstPaymentDao {
	// 팝업 및 기타
	public List<InstPaymentVO> selHadocontNo(InstPaymentVO instPaymentVO);

	// 기성청구 등록
	public InstPaymentVO selNowCurrentDate();

	public InstPaymentVO selBillingDate(InstPaymentVO instPaymentVO);

	public List<InstPaymentVO> selBillingS(InstPaymentVO instPaymentVO);

	public void prcsBillingS(InstPaymentVO instPaymentVO);

	public void prcsExcelBillingS(InstPaymentVO instPaymentVO);

	public void delBillingS(InstPaymentVO instPaymentVO);

	public void delBillingFinalDate(InstPaymentVO instPaymentVO);

	public List<InstPaymentVO> selBillingR(InstPaymentVO instPaymentVO);

	public void prcsBillingFinalDate(InstPaymentVO instPaymentVO);

	// 첨부파일관리
	public List<InstPaymentVO> selBillingFileSave(InstPaymentVO instPaymentVO);

	public void prcsBillingFileSave(InstPaymentVO instPaymentVO);

	// 엑셀 업로드
	public List<InstPaymentVO> selExcelUploadGrid(InstPaymentVO instPaymentVO);

	public int selExcelBillingS(InstPaymentVO instPaymentVO);

}
