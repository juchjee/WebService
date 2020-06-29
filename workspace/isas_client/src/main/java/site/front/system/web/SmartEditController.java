package site.front.system.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.web.BaseController;


@Controller
public class SmartEditController extends BaseController{

	/**
	 * 네이버 스마트 에디터 이미지 업로드
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(IConstants.ISDS_URL + "saveImgReturnUrl.action")
	public String saveImgReturnUrl(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		return fileUpLoad.editImgFileUpload("", IMAGE_UPLOAD_NAME, IMAGE_MAX_WIDTH);
	}
	
}
