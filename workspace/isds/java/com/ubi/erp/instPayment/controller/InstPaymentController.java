package com.ubi.erp.instPayment.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jxls.transformer.XLSTransformer;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ubi.erp.cmm.file.AttachFileService;
import com.ubi.erp.cmm.file.TempData;
import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.cmm.util.PropertyUtil;
import com.ubi.erp.instPayment.domain.InstPaymentVO;
import com.ubi.erp.instPayment.service.InstPaymentService;

@RestController
@RequestMapping("/erp/scm")
public class InstPaymentController {

	@Autowired
	private InstPaymentService service;

	@Autowired
	private AttachFileService attachFileService;

	// 팝업 및 기타
	@RequestMapping(value = "/work/partners/instPayment/hadocontNo", method = RequestMethod.POST)
	public List<InstPaymentVO> selHadocontNo(HttpServletRequest request, HttpServletResponse response, HttpSession session, InstPaymentVO instPaymentVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		instPaymentVO.setCustCd(custCd);
		return service.selHadocontNo(instPaymentVO);
	}

	// 기성청구 들록
	@RequestMapping(value = "/work/partners/instPayment/billingS/currentNowDate", method = RequestMethod.POST)
	public InstPaymentVO selNowCurrentDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return service.selNowCurrentDate();
	}

	@RequestMapping(value = "/work/partners/instPayment/billingS/controlDateSearch", method = RequestMethod.POST)
	public InstPaymentVO selBillingDate(HttpServletRequest request, HttpServletResponse response, HttpSession session, InstPaymentVO instPaymentVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		instPaymentVO.setCustCd(custCd);
		return service.selBillingDate(instPaymentVO);
	}

	@RequestMapping(value = "/work/partners/instPayment/billingS/gridMainSearch", method = RequestMethod.POST)
	public List<InstPaymentVO> selBillingS(HttpServletRequest request, HttpServletResponse response, InstPaymentVO instPaymentVO) throws Exception {
		return service.selBillingS(instPaymentVO);
	}

	@RequestMapping(value = "/work/partners/instPayment/billingS/gridMainSave", method = RequestMethod.POST)
	public void prcsBillingS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");

			List<InstPaymentVO> list = new ArrayList<InstPaymentVO>();

			list = new ObjectMapper().readValue(jsonData, new TypeReference<ArrayList<InstPaymentVO>>() {
			});

			service.prcsBillingS(list, id, custCd);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
		} catch (UncategorizedSQLException e) {
			String errorMsg[] = e.getSQLException().getMessage().split("\\#");
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ00");
			ht.put("EXCEPTION_MSG_CODE", errorMsg[0]);
		} catch (Exception e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR002");
		} finally {
			if (!ht.isEmpty()) {
				response.setHeader("EXCEPTION", "Y");
				MakeResponseUtil.makeResponse(response, "json", JsonUtil.parseToString(ht));
			}
		}
	}

	@RequestMapping(value = "/work/partners/instPayment/billingS/delGridMain", method = RequestMethod.POST)
	public void prcsBillingS(HttpServletRequest request, HttpServletResponse response, HttpSession session, InstPaymentVO instPaymentVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String custCd = (String) session.getAttribute("bizNo");
			instPaymentVO.setCustCd(custCd);
			service.delBillingS(instPaymentVO);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
		} catch (UncategorizedSQLException e) {
			String errorMsg[] = e.getSQLException().getMessage().split("\\#");
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ00");
			ht.put("EXCEPTION_MSG_CODE", errorMsg[0]);
		} catch (Exception e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR002");
		} finally {
			if (!ht.isEmpty()) {
				response.setHeader("EXCEPTION", "Y");
				MakeResponseUtil.makeResponse(response, "json", JsonUtil.parseToString(ht));
			}
		}
	}

	@RequestMapping(value = "/work/partners/instPayment/billingR/gridMainSearch", method = RequestMethod.POST)
	public List<InstPaymentVO> selBillingR(HttpServletRequest request, HttpServletResponse response, InstPaymentVO instPaymentVO) throws Exception {
		return service.selBillingR(instPaymentVO);
	}

	// 첨부파일관리
	@RequestMapping(value = "/work/partners/instPayment/billingFileSave/gridMainSearch", method = RequestMethod.POST)
	public List<InstPaymentVO> selBillingFileSave(HttpServletRequest request, HttpServletResponse response, InstPaymentVO instPaymentVO) throws Exception {
		return service.selBillingFileSave(instPaymentVO);
	}

	@RequestMapping(value = "/work/partners/instPayment/billingFileSave/gridMainSave", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void prcsBillingFileSave(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "jsonData", required = false) String jsonData)
			throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			List<InstPaymentVO> list = new ArrayList<InstPaymentVO>();

			String id = (String) session.getAttribute("id");
			int cnt = 0;

			list = new ObjectMapper().readValue(jsonData, new TypeReference<ArrayList<InstPaymentVO>>() {
			});

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultiValueMap<String, MultipartFile> multiValueMap = multipartRequest.getMultiFileMap();
			List<MultipartFile> files = multiValueMap.get("attachFile");
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						attachFileService.deleteFile(PropertyUtil.getString("attach.billing.savedir"), list.get(cnt).getFilePath());

						String originalFileName = file.getOriginalFilename();
						String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
						String siteCd = list.get(cnt).getSiteCd();
						String hadocontNo = list.get(cnt).getHadocontNo();
						String workYm = list.get(cnt).getWorkYm();
						int sqSn = list.get(cnt).getSqSn();
						String realFileName = siteCd + hadocontNo + workYm + sqSn + "." + ext;

						list.get(cnt).setFileNm(originalFileName);
						list.get(cnt).setFilePath(realFileName);
						attachFileService.uploadFile(PropertyUtil.getString("attach.billing.savedir"), realFileName, file);
					}
					cnt++;
				}
			}

			service.prcsBillingFileSave(list, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
		} catch (UncategorizedSQLException e) {
			String errorMsg[] = e.getSQLException().getMessage().split("\\#");
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ00");
			ht.put("EXCEPTION_MSG_CODE", errorMsg[0]);
		} catch (Exception e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR002");
		} finally {
			if (!ht.isEmpty()) {
				response.setHeader("EXCEPTION", "Y");
				MakeResponseUtil.makeResponse(response, "json", JsonUtil.parseToString(ht));
			}
		}
	}

	// 엑셀업로드
	@RequestMapping(value = "/work/partners/instPayment/billingExcelUpload/excelSearch", method = RequestMethod.POST)
	public List<InstPaymentVO> selExcelUploadGrid(HttpServletRequest request, HttpServletResponse response, InstPaymentVO instPaymentVO) throws Exception {
		return service.selExcelUploadGrid(instPaymentVO);
	}

	@RequestMapping(value = "/work/partners/instPayment/billingExcelUpload/excelDown", method = RequestMethod.POST)
	public void selExcelUploadFile(HttpServletRequest request, HttpServletResponse response, InstPaymentVO instPaymentVO) throws Exception {
		String saveFileName = request.getParameter("siteCd") + "_" + request.getParameter("hadocontDs");
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String templateFile = PropertyUtil.getString("attach.basedir") + "/" + "BillingExcelTemplate.xls";
			String saveFile = PropertyUtil.getString("attach.basedir") + "/" + saveFileName + ".xls";
			String workYm = request.getParameter("workYm").substring(0, 4) + "-" + request.getParameter("workYm").substring(4, 6);
			List<InstPaymentVO> list = service.selExcelUploadGrid(instPaymentVO);
			Map<String, Object> sum = sumCalcul(list);
			Map<String, Object> info = new HashMap<String, Object>();
			info.put("siteCd", request.getParameter("siteCd"));
			info.put("siteDs", request.getParameter("siteDs"));
			info.put("hadocontNo", request.getParameter("hadocontNo"));
			info.put("hadocontDs", request.getParameter("hadocontDs"));
			info.put("workYm", workYm);

			Map<String, Object> excel = new HashMap<String, Object>();
			excel.put("info", info);
			excel.put("billing", list);
			excel.put("sum", sum);

			XLSTransformer transformer = new XLSTransformer();

			transformer.transformXLS(templateFile, excel, saveFile);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
		} catch (UncategorizedSQLException e) {
			String errorMsg[] = e.getSQLException().getMessage().split("\\#");
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ00");
			ht.put("EXCEPTION_MSG_CODE", errorMsg[0]);
		} catch (Exception e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR002");
		} finally {
			if (!ht.isEmpty()) {
				response.setHeader("EXCEPTION", "Y");
				MakeResponseUtil.makeResponse(response, "json", JsonUtil.parseToString(ht));
			}
		}
	}

	public Map<String, Object> sumCalcul(List<InstPaymentVO> list) {
		Map<String, Object> sum = new HashMap<String, Object>();
		double hadoSum = 0;
		double hadogspSum = 0;
		double hadogsSum = 0;
		double hadogstSum = 0;
		double hadogsmSum = 0;
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getHadoQn() > 0) {
				hadoSum = hadoSum + list.get(i).getHadoAm();
			}
			if (list.get(i).getHadogspQn() > 0) {
				hadogspSum = hadogspSum + list.get(i).getHadogspAm();
			}
			if (list.get(i).getHadogsQn() > 0) {
				hadogsSum = hadogsSum + list.get(i).getHadogsAm();
			}
			if (list.get(i).getHadogstQn() > 0) {
				hadogstSum = hadogstSum + list.get(i).getHadogstAm();
			}
			if (list.get(i).getHadogsmQn() > 0) {
				hadogsmSum = hadogsmSum + list.get(i).getHadogsmAm();
			}
		}
		sum.put("hadoSum", hadoSum);
		sum.put("hadogspSum", hadogspSum);
		sum.put("hadogsSum", hadogsSum);
		sum.put("hadogstSum", hadogstSum);
		sum.put("hadogsmSum", hadogsmSum);
		return sum;
	}

	@SuppressWarnings({ "unused" })
	@RequestMapping(value = "/work/partners/instPayment/billingExcelUpload/excelUpload.sc")
	@ResponseBody
	public void excelUpload(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {
			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String tempColumns = "";
			StringBuffer sb = new StringBuffer();
			try {
				Map<String, Object> map = attachFileService.excelUpload(request, response);

				int columnValueCnt = (int) map.get("columnCnt");

				for (int i = 0; i < columnValueCnt; i++) {
					if (i == 0) {
						tempColumns = "CLM" + (i + 1);
					} else {
						tempColumns = tempColumns + ", CLM" + (i + 1);
					}
				}
				map.put("V_COLUMNS", tempColumns);
				TempData tempData = new TempData();
				tempData.setFmtId((String) map.get("V_FMT_ID"));
				tempData.setRegIdx((int) map.get("V_REG_IDX"));

				List<TempData> templist = attachFileService.tempExcelData(tempData);
				String siteCd = templist.get(0).getClm2();
				String hadocontNo = templist.get(1).getClm2();
				String workYm = templist.get(2).getClm2().substring(0, 4) + templist.get(2).getClm2().substring(5, 7);
				InstPaymentVO tempCostId = new InstPaymentVO();
				tempCostId.setSiteCd(siteCd);
				tempCostId.setHadocontNo(hadocontNo);
				tempCostId.setWorkYm(workYm);
				tempCostId.setSqSn(0);
				List<InstPaymentVO> costIdList = service.selBillingS(tempCostId);
				Iterator<TempData> iter = templist.iterator();
				while (iter.hasNext()) {
					TempData item = iter.next();
					for (int i = 0; i < costIdList.size(); i++) {

						if (item.getClm16().equals(costIdList.get(i).getCostId() + "")) {
							InstPaymentVO instPaymentVO = new InstPaymentVO();
							instPaymentVO.setSiteCd(siteCd);
							instPaymentVO.setHadocontNo(hadocontNo);
							instPaymentVO.setWorkYm(workYm);
							instPaymentVO.setCustCd(custCd);
							instPaymentVO.setCostId(costIdList.get(i).getCostId());
							instPaymentVO.setId(id);
							String hadogsQn = item.getClm10();
							String hadogsAm = item.getClm11();
							String hadoUp = item.getClm6();
							if (hadogsQn.equals("")) {
								hadogsQn = "0";
							}
							if (hadogsAm.equals("")) {
								hadogsAm = "0";
							}
							if (hadoUp.equals("")) {
								hadoUp = "0";
							}

							double hadogsQnVal = Double.parseDouble(hadogsQn);
							double hadogsAmVal = Double.parseDouble(hadogsAm);
							double hadoUpVal = Double.parseDouble(hadoUp);

							if (hadogsQnVal <= 0) {
								hadogsQnVal = hadogsAmVal / hadoUpVal;
							} else {
								hadogsAmVal = hadogsQnVal * hadoUpVal;
							}

							instPaymentVO.setHadogsQn(hadogsQnVal);
							instPaymentVO.setHadogsAm(hadogsAmVal);
							service.prcsExcelBillingS(instPaymentVO);
							break;
						}
					}
				}

				attachFileService.deleteTempExcelData(tempData);

			} catch (Exception e) {
				Log.debug(e);
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
		} catch (UncategorizedSQLException e) {
			String errorMsg[] = e.getSQLException().getMessage().split("\\#");
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ00");
			ht.put("EXCEPTION_MSG_CODE", errorMsg[0]);
		} catch (Exception e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR002");
		} finally {
			if (!ht.isEmpty()) {
				response.setHeader("EXCEPTION", "Y");
				MakeResponseUtil.makeResponse(response, "json", JsonUtil.parseToString(ht));
			}
		}
	}

	@SuppressWarnings({ "unused" })
	@RequestMapping(value = "/work/partners/instPayment/billingExcelUpload/excelUploadCheck.sc")
	@ResponseBody
	public String excelUploadChk(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "jsonData", required = false) String jsonData) throws IOException, ParseException {
		String flag = "success";
		String tempColumns = "";
		StringBuffer sb = new StringBuffer();

		InstPaymentVO instPaymentVO = new InstPaymentVO();

		if (jsonData != null) {
			instPaymentVO = new ObjectMapper().readValue(jsonData, new TypeReference<InstPaymentVO>() {
			});
		}

		Map<String, Object> map = attachFileService.excelUpload(request, response);

		int columnValueCnt = (int) map.get("columnCnt");

		for (int i = 0; i < columnValueCnt; i++) {
			if (i == 0) {
				tempColumns = "CLM" + (i + 1);
			} else {
				tempColumns = tempColumns + ", CLM" + (i + 1);
			}
		}
		map.put("V_COLUMNS", tempColumns);
		TempData tempData = new TempData();
		tempData.setFmtId((String) map.get("V_FMT_ID"));
		tempData.setRegIdx((int) map.get("V_REG_IDX"));

		List<TempData> templist = attachFileService.tempExcelData(tempData);
		String siteCd = templist.get(0).getClm2();
		String hadocontNo = templist.get(1).getClm2();
		String workYm = templist.get(2).getClm2().substring(0, 4) + templist.get(2).getClm2().substring(5, 7);
		InstPaymentVO tempCostId = new InstPaymentVO();
		tempCostId.setSiteCd(siteCd);
		tempCostId.setHadocontNo(hadocontNo);
		tempCostId.setWorkYm(workYm);
		tempCostId.setSqSn(0);

		if (!instPaymentVO.getSiteCd().equals(siteCd)) {
			flag = "siteCdFail";
		} else if (!instPaymentVO.getHadocontNo().equals(hadocontNo)) {
			flag = "hadoFail";
		} else {
			flag = "success";
		}

		List<InstPaymentVO> costIdList = service.selBillingS(tempCostId);
		Iterator<TempData> iter = templist.iterator();
		while (iter.hasNext()) {
			TempData item = iter.next();
			for (int i = 0; i < costIdList.size(); i++) {
				if (item.getClm16().equals(costIdList.get(i).getCostId() + "")) {
					String hadogsQn = item.getClm10();
					String hadogspQn = item.getClm8();
					String dokubgsQn = item.getClm5();
					String hadogsAm = item.getClm11();
					String hadoUp = item.getClm6();

					if (hadogsQn.equals("")) {
						hadogsQn = "0";
					}
					if (hadogspQn.equals("")) {
						hadogspQn = "0";
					}
					if (dokubgsQn.equals("")) {
						dokubgsQn = "0";
					}
					if (hadogsAm.equals("")) {
						hadogsAm = "0";
					}
					if (hadoUp.equals("")) {
						hadoUp = "0";
					}
					double hadogsAmVal = Double.parseDouble(hadogsAm);
					double hadogsQnVal = Double.parseDouble(hadogsQn);
					double hadogspQnVal = Double.parseDouble(hadogspQn);
					double dokubgsQnVal = Double.parseDouble(dokubgsQn);
					double hadoUpVal = Double.parseDouble(hadoUp);
					if (hadogsQnVal <= 0) {
						hadogsQnVal = hadogsAmVal / hadoUpVal;
					}
					if (dokubgsQnVal < (hadogsQnVal + hadogspQnVal)) {
						flag = "qtyFail";
					}
					break;
				}
				if (flag.equals("qtyFail")) {
					break;
				}
			}

		}

		attachFileService.deleteTempExcelData(tempData);

		return flag;
	}

}
