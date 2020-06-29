package site.front.view.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import site.front.view.service.impl.ViewService;


@Controller
@RequestMapping(value = IConstants.ISDS_URL + "view")
public class ViewController extends BaseController{

	private static final String conUrl = ISDS_URL + "view/";

	/** EtcService */
	@Resource(name = "ViewService")
	private ViewService viewService;

	@RequestMapping(value = "view.do")
	public String view(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
		init(model);
		String url = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));

		if(CommonUtil.isMobile(request)){
			url = url + "_m";
		}
		
		return conUrl + url;
	}


}
