package site.mng.amM1.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.web.BaseController;

/**
 * 회원관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM1") /* /mng/amM1/ */
public class AmM1Controller extends BaseController{

	private static final String amM101ConUrl = MNG_URI + "amM1/amM102/";

	/**
	 * 회원관리
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1.do")
	public String amM1(ModelMap model) throws Exception {
		init(model);
		return messageRedirect(null, amM101ConUrl + "amM102.do", model);
	}

}
