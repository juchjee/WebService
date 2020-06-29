package com.ubi.erp.dailyWork.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.cmm.file.AttachFileService;
import com.ubi.erp.cmm.file.ImageUploadService;
import com.ubi.erp.cmm.util.AESEncoder;
import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.MakeResponseUtil;
import com.ubi.erp.cmm.util.PropertyUtil;
import com.ubi.erp.dailyWork.domain.DailyWorkVO;
import com.ubi.erp.dailyWork.service.DailyWorkService;

@RestController
@RequestMapping("/erp/scm/work")
public class DailyWorkController {

	@Autowired
	private DailyWorkService service;

	@Autowired
	private AESEncoder aesEncoder;

	@Autowired
	private AttachFileService attachFileService;

	@Autowired
	private ImageUploadService imageUploadService;

	// 패스워드 변경
	@RequestMapping(value = "/chageCheck", method = RequestMethod.POST)
	public int selChangeCheck(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selChangeCheck(dailyWorkVO);
	}

	@RequestMapping(value = "/passwordSave", method = RequestMethod.POST)
	public void prcsChangePassWord(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String id = (String) session.getAttribute("id");
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setId(id);
		dailyWorkVO.setCustCd(custCd);
		service.prcsChangePassWord(dailyWorkVO);
	};

	// 팝업 및 기타
	@RequestMapping(value = "/partners/dailyWork/siteCdSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selSiteCd(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String id = (String) session.getAttribute("id");
		dailyWorkVO.setId(id);
		return service.selSiteCd(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/weatherSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selWeather(HttpServletRequest request, HttpServletResponse response, DailyWorkVO dailyWorkVO) {
		return service.selWeather();
	}

	@RequestMapping(value = "/partners/dailyWork/commgrpmCdSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selCommgrpmCd(HttpServletRequest request, HttpServletResponse response, DailyWorkVO dailyWorkVO) {
		return service.selCommgrpmCd(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/commgrpsCdSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selCommgrpsCd(HttpServletRequest request, HttpServletResponse response, DailyWorkVO dailyWorkVO) {
		return service.selCommgrpsCd(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/perNumSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selPerNum(HttpServletRequest request, HttpServletResponse response, DailyWorkVO dailyWorkVO) throws Exception {
		List<DailyWorkVO> list = service.selPerNum(dailyWorkVO);
		for (int i = 0; i < list.size(); i++) {
			String encRegi = list.get(i).getRegiNo();
			String decRegi = aesEncoder.decrypt(encRegi);
			list.get(i).setRegiNo(decRegi);
			String encFore = list.get(i).getForeNo();
			String decFore = aesEncoder.decrypt(encFore);
			list.get(i).setForeNo(decFore);
		}
		return list;
	}

	@RequestMapping(value = "/partners/dailyWork/perNmSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selPerNm(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selPerNm(dailyWorkVO);
	}

	// 근무자 등록
	@RequestMapping(value = "/partners/dailyWork/workerS/perNoDelCheck", method = RequestMethod.POST)
	public List<DailyWorkVO> selWorkerDelCheck(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selWorkerDelCheck(dailyWorkVO);
	};

	@RequestMapping(value = "/partners/dailyWork/workerS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selWorkerS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		List<DailyWorkVO> list = service.selWorkerS(dailyWorkVO);
		for (int i = 0; i < list.size(); i++) {
			String encRegi = list.get(i).getRegiNo();
			String decRegi = aesEncoder.decrypt(encRegi);
			list.get(i).setRegiNo(decRegi);
			String encFore = list.get(i).getForeNo();
			String decFore = aesEncoder.decrypt(encFore);
			list.get(i).setForeNo(decFore);
		}
		return list;
	};

	@RequestMapping(value = "/partners/dailyWork/workerS/mainSave", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void prcsGridMain(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "jsonData", required = false) String jsonData) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");

			int cnt = 0;

			List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultiValueMap<String, MultipartFile> multiValueMap = multipartRequest.getMultiFileMap();
			List<MultipartFile> files = multiValueMap.get("attachFile");

			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						attachFileService.deleteFile(PropertyUtil.getString("attach.daily.savedir"), list.get(cnt).getFileSaveNm());

						String originalFileName = file.getOriginalFilename();
						String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
						String siteCd = list.get(cnt).getSiteCd();
						String perNo = list.get(cnt).getPerNo();
						String realFileName = siteCd + custCd + perNo + "." + ext;

						list.get(cnt).setFileNm(originalFileName);
						list.get(cnt).setFileSaveNm(realFileName);
						attachFileService.uploadFile(PropertyUtil.getString("attach.daily.savedir"), realFileName, file);
					}
					cnt++;
				}
			}

			service.prcsWorkerS(list, id, custCd, aesEncoder);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/workerS/getSignImg")
	public void getImage(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "fileNm", required = true) String fileNm) throws Exception {
		String context = "attach.daily.savedir";
		imageUploadService.getImage(response, context, fileNm);
	}

	// 일일근태 등록
	@RequestMapping(value = "/partners/dailyWork/dayByDiliS/PerNmSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDayByDiliSPerNo(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDayByDiliSPerNo(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dayByDiliS/selCommgrpm", method = RequestMethod.POST)
	public DailyWorkVO selCommgrpm(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selCommgrpm(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dayByDiliS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDayByDiliS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDayByDiliS(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dayByDiliS/diliChk", method = RequestMethod.POST)
	public int selDayByDiliChk(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		int cnt = service.selDayByDiliChk(dailyWorkVO);
		return cnt;
	}

	@RequestMapping(value = "/partners/dailyWork/dayByDiliS/mainSave", method = RequestMethod.POST)
	public void prcsDayByDiliS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");
			List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();
			ObjectMapper mapper = new ObjectMapper();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			service.prcsDayByDiliS(list, id, custCd);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/dayByDiliS/diliCreate", method = RequestMethod.POST)
	public void prcsGridMain(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String flag = request.getParameter("flag");
			String custCd = (String) session.getAttribute("bizNo");
			dailyWorkVO.setCustCd(custCd);
			service.prcsDayByDiliCreate(dailyWorkVO, flag);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	// 일일근태 조회
	@RequestMapping(value = "/partners/dailyWork/dayByDiliR/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDayByDiliR(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDayByDiliR(dailyWorkVO);
	}

	// 월근태 집계
	@RequestMapping(value = "/partners/dailyWork/monthByDiliR/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selMonthByDiliR(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selMonthByDiliR(dailyWorkVO);
	}

	// 공사일보 등록
	@RequestMapping(value = "/partners/dailyWork/constructionS/selConsWorkNm", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructWorkNm(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructWorkNm(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/itemAppvSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructAppvSubGrid(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructAppvSubGrid(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionPopSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructionPop(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructionPop(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/appvFormSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructionAppvForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructionAppvForm(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/formSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructionForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructionForm(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructionMain(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructionMain(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/gridSubSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructionSub(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructionSub(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/gridSub01Search", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructionSub01(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructionSub01(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/mainSave", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void prcsConstructionForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "formJsonData", required = false) String formJsonData)
			throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			DailyWorkVO dailyWorkVO = new DailyWorkVO();
			ObjectMapper mapper = new ObjectMapper();
			dailyWorkVO = mapper.readValue(formJsonData, new TypeReference<DailyWorkVO>() {
			});

			service.prcsConstructionForm(dailyWorkVO, custCd, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/constructionS/subSave", method = RequestMethod.POST)
	public void prcsConstructionSub(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");
			String jsonData2 = request.getParameter("jsonData2");
			String jsonData3 = request.getParameter("jsonData3");

			List<DailyWorkVO> main = new ArrayList<DailyWorkVO>();
			List<DailyWorkVO> sub = new ArrayList<DailyWorkVO>();
			List<DailyWorkVO> sub01 = new ArrayList<DailyWorkVO>();

			ObjectMapper mapper1 = new ObjectMapper();
			ObjectMapper mapper2 = new ObjectMapper();
			ObjectMapper mapper3 = new ObjectMapper();

			main = mapper1.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});
			sub = mapper2.readValue(jsonData2, new TypeReference<ArrayList<DailyWorkVO>>() {
			});
			sub01 = mapper3.readValue(jsonData3, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			service.prcsConstructionSub(main, sub, sub01, id, custCd);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/constructionS/delSave", method = RequestMethod.POST)
	public void delConstructionS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String custCd = (String) session.getAttribute("bizNo");
			dailyWorkVO.setCustCd(custCd);
			service.delConstructionS(dailyWorkVO);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@SuppressWarnings("unused")
	@RequestMapping(value = "/partners/dailyWork/constructionS/report/consSearch")
	public ModelAndView reportPdf(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {

		response.setContentType("image/jpeg");

		String siteCd = request.getParameter("siteCd");
		String custCd = (String) session.getAttribute("bizNo");
		String workDt = request.getParameter("workDt");

		boolean imageFlag = false;

		DailyWorkVO dailyWorkVO = new DailyWorkVO();
		dailyWorkVO.setSiteCd(siteCd);
		dailyWorkVO.setCustCd(custCd);
		dailyWorkVO.setWorkDt(workDt);

		File file = null;
		File file2 = null;
		File file3 = null;
		File file4 = null;

		DailyWorkVO sumPerVO = service.selConstructSumPreQty(dailyWorkVO);
		// DailyWorkVO workerNumVO =
		// service.selConstructSumWorkerNum(dailyWorkVO);
		DailyWorkVO appvPerVO = service.selConstructAppvSumNum(dailyWorkVO);
		if (appvPerVO == null) {
			appvPerVO = new DailyWorkVO();
			appvPerVO.setLegWorkCnt(0);
			appvPerVO.setAppvWorkCnt(0);
			appvPerVO.setTotalAppvWorkCnt(0);
		}
		/*
		 * if (workerNumVO == null) { workerNumVO = new DailyWorkVO();
		 * workerNumVO.setWorkerCnt(0); }
		 */

		List<DailyWorkVO> list = service.selConstructMainP(dailyWorkVO);
		list.get(0).setSumPreQty(sumPerVO.getSumPreQty());
		// list.get(0).setSumPerNum(sumPerVO.getSumPerNum() +
		// workerNumVO.getWorkerCnt());
		// list.get(0).setTotalPerNum(sumPerVO.getTotalPerNum() +
		// workerNumVO.getWorkerCnt());
		// list.get(0).setWorkerCnt(workerNumVO.getWorkerCnt());
		list.get(0).setSumPerNum(sumPerVO.getSumPerNum());
		list.get(0).setTotalPerNum(sumPerVO.getTotalPerNum());
		list.get(0).setLegWorkCnt(appvPerVO.getLegWorkCnt());
		list.get(0).setAppvWorkCnt(appvPerVO.getAppvWorkCnt());
		list.get(0).setTotalAppvWorkCnt(appvPerVO.getTotalAppvWorkCnt());

		list.get(0).setSumPreworkNum(sumPerVO.getSumPreQty() + appvPerVO.getLegWorkCnt());
		list.get(0).setSumNowWorkNum(list.get(0).getSumPerNum() + appvPerVO.getAppvWorkCnt());
		list.get(0).setAllPerNum(list.get(0).getSumPreworkNum() + list.get(0).getSumNowWorkNum());
		list.get(0).setTemperature(list.get(0).getTempMin() + "~" + list.get(0).getTempMax());

		String regEmpFileNm = list.get(0).getRegFileNm();
		String reviewEmpFileNm = list.get(0).getReviewFileNm();
		String review2EmpFileNm = list.get(0).getReview2FileNm();
		String confirmEmpFileNm = list.get(0).getConfirmFileNm();

		String regSett = list.get(0).getRegSett();
		String reviewSett = list.get(0).getReviewSett();
		String review2Sett = list.get(0).getReview2Sett();
		String confrimSett = list.get(0).getConfirmSett();

		if (regSett.equals("Y")) {
			file = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + regEmpFileNm);
		} else {
			list.get(0).setRegEmpName("");
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}
		if (reviewSett.equals("Y")) {
			file2 = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + reviewEmpFileNm);
		} else {
			list.get(0).setReviewEmpName("");
			file2 = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}
		if (review2Sett.equals("Y")) {
			file3 = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + review2EmpFileNm);
		} else {
			list.get(0).setReview2EmpName("");
			file3 = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}
		if (confrimSett.equals("Y")) {
			file4 = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + confirmEmpFileNm);
		} else {
			list.get(0).setConfirmEmpName("");
			file4 = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}

		FileInputStream fis = null;
		FileInputStream fis2 = null;
		FileInputStream fis3 = null;
		FileInputStream fis4 = null;
		OutputStream os = null;
		OutputStream os2 = null;
		OutputStream os3 = null;
		OutputStream os4 = null;

		try {
			imageFlag = true;
			fis = new FileInputStream(file);
			os = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			imageFlag = false;
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis = new FileInputStream(file);
			os = response.getOutputStream();
		}
		try {
			fis2 = new FileInputStream(file2);
			os2 = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis2 = new FileInputStream(file);
			os2 = response.getOutputStream();
		}
		try {
			fis3 = new FileInputStream(file3);
			os3 = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis3 = new FileInputStream(file);
			os3 = response.getOutputStream();
		}
		try {
			fis4 = new FileInputStream(file4);
			os4 = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis4 = new FileInputStream(file);
			os4 = response.getOutputStream();
		}

		List<DailyWorkVO> sub = service.selConstructSubP(dailyWorkVO);

		JRBeanCollectionDataSource datasrc = new JRBeanCollectionDataSource(list);
		JRBeanCollectionDataSource subData1 = new JRBeanCollectionDataSource(sub);

		Map<String, Object> parameterMap = new HashMap<String, Object>();

		parameterMap.put("datasource", datasrc);
		parameterMap.put("SubUrl1", PropertyUtil.getString("prj.base.dir2") + "/construnctionSubP.jasper");

		parameterMap.put("SubData1", subData1);
		parameterMap.put("regEmp", fis);
		parameterMap.put("reviewEmp", fis2);
		parameterMap.put("review2Emp", fis3);
		parameterMap.put("confirmEmp", fis4);
		parameterMap.put("format", "pdf");

		if (imageFlag) {
			return new ModelAndView("constructionP", parameterMap);
		} else {
			return new ModelAndView("constructionNoImgP", parameterMap);
		}
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/perNoReportCheck", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructPerNoP(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructPerNoP(dailyWorkVO);
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "/partners/dailyWork/constructionS/report/perNoSearch")
	public ModelAndView perNoreportPdf(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {

		response.setContentType("image/jpeg");

		String siteCd = request.getParameter("siteCd");
		String custCd = (String) session.getAttribute("bizNo");
		String workDt = request.getParameter("workDt");

		boolean imageFlag = false;

		DailyWorkVO dailyWorkVO = new DailyWorkVO();
		dailyWorkVO.setSiteCd(siteCd);
		dailyWorkVO.setCustCd(custCd);
		dailyWorkVO.setWorkDt(workDt);

		File file = null;
		File file2 = null;
		File file3 = null;
		File file4 = null;

		List<DailyWorkVO> checkList = service.selDailyAttendSForm(dailyWorkVO);

		String regEmpFileNm = checkList.get(0).getRegFileNm();
		String reviewEmpFileNm = checkList.get(0).getReviewFileNm();
		String review2EmpFileNm = checkList.get(0).getReview2FileNm();
		String confirmEmpFileNm = checkList.get(0).getConfirmFileNm();

		String regSett = checkList.get(0).getRegSett();
		String reviewSett = checkList.get(0).getReviewSett();
		String review2Sett = checkList.get(0).getReview2Sett();
		String confrimSett = checkList.get(0).getConfirmSett();

		List<DailyWorkVO> list = service.selConstructPerNoP(dailyWorkVO);
		if (regSett.equals("Y") || regSett.equals("P")) {
			list.get(0).setRegEmpName(checkList.get(0).getRegEmpName());
			file = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + regEmpFileNm);
		} else {
			list.get(0).setRegEmpName("");
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}
		if (reviewSett.equals("Y")) {
			list.get(0).setReviewEmpName(checkList.get(0).getReviewEmpName());
			file2 = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + reviewEmpFileNm);
		} else {
			list.get(0).setReviewEmpName("");
			file2 = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}
		if (review2Sett.equals("Y")) {
			list.get(0).setReview2EmpName(checkList.get(0).getReview2EmpName());
			file3 = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + review2EmpFileNm);
		} else {
			list.get(0).setReview2EmpName("");
			file3 = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}
		if (confrimSett.equals("Y")) {
			list.get(0).setConfirmEmpName(checkList.get(0).getConfirmEmpName());
			file4 = new File(PropertyUtil.getString("attach.daily.savedir") + "/" + confirmEmpFileNm);
		} else {
			list.get(0).setConfirmEmpName("");
			file4 = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
		}

		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);

		FileInputStream fis = null;
		FileInputStream fis2 = null;
		FileInputStream fis3 = null;
		FileInputStream fis4 = null;
		OutputStream os = null;
		OutputStream os2 = null;
		OutputStream os3 = null;
		OutputStream os4 = null;
		try {
			imageFlag = true;
			fis = new FileInputStream(file);
			os = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			imageFlag = false;
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis = new FileInputStream(file);
			os = response.getOutputStream();
		}
		try {
			fis2 = new FileInputStream(file2);
			os2 = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis2 = new FileInputStream(file);
			os2 = response.getOutputStream();
		}
		try {
			fis3 = new FileInputStream(file3);
			os3 = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis3 = new FileInputStream(file);
			os3 = response.getOutputStream();
		}
		try {
			fis4 = new FileInputStream(file4);
			os4 = response.getOutputStream();
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString("attach.basedir") + "/blank.jpg");
			fis4 = new FileInputStream(file);
			os4 = response.getOutputStream();
		}

		ModelAndView mav = new ModelAndView();

		if (imageFlag) {
			mav.setViewName("constructPerNoP");
		} else {
			mav.setViewName("constructPerNoNotImgP");
		}
		mav.addObject("format", "pdf");
		mav.addObject("regEmp", fis);
		mav.addObject("reviewEmp", fis2);
		mav.addObject("review2Emp", fis3);
		mav.addObject("confirmEmp", fis4);
		mav.addObject("datasource", src);

		return mav;
	}

	// 공사일보 추가구분
	@RequestMapping(value = "/partners/dailyWork/constructionS/appvSearchChk", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructDailyAttendChk(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructDailyAttendChk(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/appvSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructDailyAttend(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructDailyAttend(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/AppvEmpSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructAppvEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructAppvEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/perNoKindPop", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructKindEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructKindEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/perNoRegEmpPop", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructRegEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructRegEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/equiCodePop", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructEquiCodePop(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructEquiCodePop(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/itemCodePop", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructitemCodePop(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructitemCodePop(dailyWorkVO);
	}

	// 공사일보 등록 결재
	@RequestMapping(value = "/partners/dailyWork/constructionAppv/formSave", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void prcsConsturctionRForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "formJsonData", required = false) String formJsonData)
			throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			DailyWorkVO dailyWorkVO = new DailyWorkVO();
			ObjectMapper mapper = new ObjectMapper();
			dailyWorkVO = mapper.readValue(formJsonData, new TypeReference<DailyWorkVO>() {
			});

			service.prcsConsturctionRForm(dailyWorkVO, custCd, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	// 결재기준등록
	@RequestMapping(value = "/partners/dailyWork/approvalStanS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selApprovalStanS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selApprovalStanS(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/approvalStanS/mainSave", method = RequestMethod.POST)
	public void prcsApprovalStanS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");

			List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();

			ObjectMapper mapper1 = new ObjectMapper();

			list = mapper1.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			service.prcsApprovalStanS(list, custCd, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	// 일일출역표 등록
	@RequestMapping(value = "/partners/dailyWork/dailyAttendSPopSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendSPop(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendSPop(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/diliSSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendDiliS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendDiliS(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/formSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendSForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendSForm(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendSGrid(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendSGrid(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/perNoPop", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendRegEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendRegEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/AppvEmpSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendAppvEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendAppvEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/confirmRegEmp", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendConfirmRegEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendConfirmRegEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/formSave", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void prcsDailyAttendSForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "jsonData", required = false) String jsonData)
			throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			DailyWorkVO dailyWorkVO = new DailyWorkVO();
			ObjectMapper mapper = new ObjectMapper();
			dailyWorkVO = mapper.readValue(jsonData, new TypeReference<DailyWorkVO>() {
			});

			service.prcsDailyAttendSForm(dailyWorkVO, custCd, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/gridMainSave", method = RequestMethod.POST)
	public void prcsDailyAttendSGrid(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData2");

			List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();

			ObjectMapper mapper1 = new ObjectMapper();

			list = mapper1.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			service.prcsDailyAttendSGrid(list, custCd, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/dailyAttendS/delSave", method = RequestMethod.POST)
	public void delDailyAttendS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String custCd = (String) session.getAttribute("bizNo");

			service.delDailyAttendS(dailyWorkVO, custCd);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	// 일일출역표 결재
	@RequestMapping(value = "/partners/dailyWork/dailyAttendApproval/appvEmpSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendRAppvEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendRAppvEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendApproval/perNoKindPop", method = RequestMethod.POST)
	public List<DailyWorkVO> selDailyAttendRKindEmp(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selDailyAttendRKindEmp(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/dailyAttendApproval/formSave", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public void prcsDailyAttendRForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value = "jsonData", required = false) String jsonData)
			throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			DailyWorkVO dailyWorkVO = new DailyWorkVO();
			ObjectMapper mapper = new ObjectMapper();
			dailyWorkVO = mapper.readValue(jsonData, new TypeReference<DailyWorkVO>() {
			});

			service.prcsDailyAttendRForm(dailyWorkVO, custCd, id);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	// 공사일보 누계현황
	@RequestMapping(value = "/partners/dailyWork/constructStanS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructStanMst(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructStanMst(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructStanS/gridSubSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selConstructStanSub(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selConstructStanSub(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/constructStanS/gridSave", method = RequestMethod.POST)
	public void prcsConstructionStan(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");
			String jsonData2 = request.getParameter("jsonData2");

			List<DailyWorkVO> main = new ArrayList<DailyWorkVO>();
			List<DailyWorkVO> sub = new ArrayList<DailyWorkVO>();

			ObjectMapper mapper1 = new ObjectMapper();
			ObjectMapper mapper2 = new ObjectMapper();

			main = mapper1.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});
			sub = mapper2.readValue(jsonData2, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			service.prcsConstructionStan(main, sub, id, custCd);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

	@RequestMapping(value = "/partners/dailyWork/constructionS/report/perNoEmptySearch")
	public ModelAndView perNoEmptyreportPdf(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();
		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("constructPerNumEmptyP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	@RequestMapping(value = "/partners/dailyWork/constructionS/report/consEmptySearch")
	public ModelAndView constructEmptyreportPdf(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();
		JRBeanCollectionDataSource src = new JRBeanCollectionDataSource(list);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("constructEmptyP");
		mav.addObject("format", "pdf");
		mav.addObject("datasource", src);

		return mav;
	}

	// 세부공종등록
	@RequestMapping(value = "/partners/dailyWork/commgrpdS/popSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selCommgrpdSPop(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selCommgrpdSPop(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/commgrpdS/gridMainSearch", method = RequestMethod.POST)
	public List<DailyWorkVO> selCommgrpdS(HttpServletRequest request, HttpServletResponse response, HttpSession session, DailyWorkVO dailyWorkVO) {
		String custCd = (String) session.getAttribute("bizNo");
		dailyWorkVO.setCustCd(custCd);
		return service.selCommgrpdS(dailyWorkVO);
	}

	@RequestMapping(value = "/partners/dailyWork/commgrpdS/gridMainSave", method = RequestMethod.POST)
	public void insCommgrpdS(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		Hashtable<String, String> ht = new Hashtable<String, String>();
		try {

			String id = (String) session.getAttribute("id");
			String custCd = (String) session.getAttribute("bizNo");
			String jsonData = request.getParameter("jsonData");

			List<DailyWorkVO> list = new ArrayList<DailyWorkVO>();

			ObjectMapper mapper1 = new ObjectMapper();

			list = mapper1.readValue(jsonData, new TypeReference<ArrayList<DailyWorkVO>>() {
			});

			service.insCommgrpdS(list, id, custCd);

			Map<String, String> map = new HashMap<String, String>();
			map.put("rtnCode", "1");
			String jsonStr = new String(JsonUtil.parseToString(map));
			MakeResponseUtil.makeResponse(response, "json", jsonStr);
		} catch (DuplicateKeyException e) {
			ht.put("rtnCode", "-1");
			ht.put("EXCEPTION_TYPE", "BIZ");
			ht.put("EXCEPTION_MSG_CODE", "ERR005");
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

}
