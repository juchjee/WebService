package site.comm.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import egovframework.cmmn.IConstants;
import site.comm.service.impl.CaregoryService;

@ControllerAdvice
public class BaseControllerAdvice{

	/** 공통 서비스 */
	@Resource(name = "CaregoryService")
	private CaregoryService caregoryService;

	@ModelAttribute("homeUrl")
	public String getHomeUrl() {
		return IConstants.HOME_URL;
	}

	@ModelAttribute("rootUri")
	public String getRootUri() {
		return IConstants.ROOT_URI;
	}

	@ModelAttribute("frontUri")
	public String getMallUri() {
		return IConstants.ISDS_URL;
	}

//	@ModelAttribute("frontCategoryList")
//	public List<?> getMallCategoryList() throws Exception {
//		return caregoryService.getCategoryList("FRONT");
//	}


//	@ModelAttribute("mbrId")
//	public String getMbrId() throws Exception {
//		return "";
//	}

//	@ModelAttribute("mbrNm")
//	public String getMbrNm() throws Exception {
//		return "";
//	}

//	@ModelAttribute("mbrLevCd")
//	public String getMbrLevCd() throws Exception {
//		return "";
//	}

	@ModelAttribute("logInDate")
	public String getLogInDate() throws Exception {
		return "";
	}

}
