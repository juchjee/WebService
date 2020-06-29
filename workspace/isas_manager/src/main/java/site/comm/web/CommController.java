package site.comm.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import devpia.dextupload.DEXTUploadException;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileDownLoad;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

/**
 * 회원관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI) /* /mng/ */
public class CommController extends BaseController{

	/**
	 * 네이버 스마트 에디터 호출
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("smartEditor.action")
	public String smart_editor(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("divName", commandMap.get("divName"));
		return "comm/smartEditor";
	}

	/**
	 * 네이버 스마트 에디터 이미지 업로드
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveImgReturnUrl.action")
	public String saveImgReturnUrl(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		return fileUpLoad.editImgFileUpload("", IMAGE_UPLOAD_NAME, IMAGE_MAX_WIDTH);
	}

	/**
	 * 엑셀 파일 다운로드
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("downLoadXlsFile.action")
	public void downLoadXlsFile(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String[] uploadMap = {"filexls"};
		Map<String, Object> paramMap = fileUpLoad.docFileUpload("xlsTemp", uploadMap);
		commService.downLoadXlsFile(response, paramMap);
	}

	/**
	 * 파일 다운 로드
	 * file downLoad
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "fileDownLoad.action")
	public String fileDownLoad(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		try {
			@SuppressWarnings("unchecked")
			CamelMap<String, Object> attchMap = (CamelMap<String, Object>) commService.getGAttch(paramMap);
			FileDownLoad fileDownLoad = new FileDownLoad(request, response);
			fileDownLoad.runFileDownLoad(attchMap);
			return null;
		} catch (FileNotFoundException e) {
			logger.error("FileNotFoundException", e);
			setMessage("alert.message", "파일이 시스템에 존재하지 않습니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		} catch (DEXTUploadException e) {
			logger.error("DEXTUploadException", e);
			setMessage("alert.message", "파일이 존재하지 않습니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		} catch (IOException e) {
			logger.error("IOException", e);
			setMessage("alert.message", "파일이 시스템에 존재하지 않습니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		}catch (Exception e) {
			logger.error("Exception", e);
			setMessage("alert.message", "시스템에 에러 입니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		}
		return "common/messageRedirect";
	}

	/**
	 * 쿠키 암호화
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "setCookie.do")
	public void setCookie(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String name = CommonUtil.nvl(paramMap.get("NAME"));
		String value = CommonUtil.nvl(paramMap.get("VALUE"));
		int expiretimes = CommonUtil.nvl(paramMap.get("EXPIRETIMES"), 60 * 60 * 24 * 30);
		CommonUtil.setCookie(response, name, value, expiretimes);
	}

	/**
	 * 현재일 기준 월 계산 날짜
	 * @return
	 */
	public String prevMonthMKor(Integer monthNo, String inputDate){
		DateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		Date myDate;
		try {
			myDate = df.parse(inputDate);
		} catch (ParseException e) {
			return "";
		}

		return CommonUtil.getNumberByPattern(CommonUtil.getDateAddMonth(myDate, monthNo), "MM월");
	}

	/**
	 * 현재일 기준 일 계산 날짜
	 * @return
	 */
	public String prevDayMMddKor(Integer monthNo, String inputDate){
		DateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		Date myDate;
		try {
			myDate = df.parse(inputDate);
		} catch (ParseException e) {
			return "";
		}


		return CommonUtil.getNumberByPattern(CommonUtil.getDateAddDay(myDate, monthNo), "MM월 dd일");
	}


	/**
	 * 현재요일을 반환
	 */
	public static String getDayStr(String inputDate) throws Exception {
	    String day = "" ;


	    DateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		Date myDate;
		try {
			myDate = df.parse(inputDate);
		} catch (ParseException e) {
			return "";
		}

		Calendar cld = Calendar.getInstance();
		cld.setTime(myDate);

	    int dayNum = cld.get(Calendar.DAY_OF_WEEK) ;

	    switch(dayNum){
	        case 1:
	            day = "일";
	            break ;
	        case 2:
	            day = "월";
	            break ;
	        case 3:
	            day = "화";
	            break ;
	        case 4:
	            day = "수";
	            break ;
	        case 5:
	            day = "목";
	            break ;
	        case 6:
	            day = "금";
	            break ;
	        case 7:
	            day = "토";
	            break ;

	    }
	    return day ;
	}


}
