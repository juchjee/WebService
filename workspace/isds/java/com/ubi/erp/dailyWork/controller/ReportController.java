
package com.ubi.erp.dailyWork.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ubi.erp.cmm.util.PropertyUtil;
import com.ubi.erp.dailyWork.domain.DailyWorkVO;
import com.ubi.erp.dailyWork.service.DailyWorkService;

@RestController
@RequestMapping("/erp/scm/work/report")
public class ReportController {

	@Autowired
	private DailyWorkService service;

	@SuppressWarnings("unused")
	@RequestMapping(value = "/perNoSearch")
	public ModelAndView perNoreportPdf(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {

		response.setContentType("image/jpeg");

		String siteCd = request.getParameter("siteCd");
		String custCd = request.getParameter("custCd");
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
}
