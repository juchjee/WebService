package site.comm.web;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;

@ControllerAdvice
public class BaseControllerAdvice{

	@ModelAttribute("homeUrl")
	public String getHomeUrl() {
		return IConstants.HOME_URL;
	}

	@ModelAttribute("rootUri")
	public String getRootUri() {
		return IConstants.ROOT_URI;
	}

	@ModelAttribute("mngUri")
	public String getMallUri() {
		return IConstants.MNG_URI;
	}
	
	@ModelAttribute("isDev")
	public boolean getIsDev() throws Exception {//개발 모드인지 운영 모드인지
		return IConstants.isDev;
	}
	
	@ModelAttribute("admId")
	public String getAdmId() throws Exception {
		return "";
	}

	@ModelAttribute("admName")
	public String getAdmName() throws Exception {
		return "";
	}

	@ModelAttribute("admPosition")
	public String getAdmPosition() throws Exception {
		return "";
	}

	@ModelAttribute("logInDate")
	public String getLogInDate() throws Exception {
		return "";
	}

	@ModelAttribute("nowYmd")
	public String getNowYmd() throws Exception {
		return CommonUtil.getNumberByPattern("yyyy-MM-dd");
	}

}
