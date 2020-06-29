package site.mng.main.web;


import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import site.mng.main.service.impl.MainService;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.web.BaseController;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "main") // /mng/main/
public class MainController extends BaseController{

	private static final String conUrl = MNG_URI + "main/";

	/** MainService */
	@Resource(name = "MainService")
	private MainService mainService;

	@RequestMapping("home.action")
	public String main(ModelMap model) throws Throwable{
		init(model);
		model.addAttribute("saLoginPage", ROOT_URI + MNG_URI + "sa/egovLoginUsr.action");
		return conUrl + "home";
	}

}
