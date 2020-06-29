package site.mng.amM7.amM707.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.comm.service.impl.CommStatic;
import site.mng.amM7.amM707.service.impl.AmM707Service;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM7/amM707")
public class AmM707Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM7/amM707/";

	@Resource(name = "AmM707Service" )
	private AmM707Service amM707Service;

	/**
	 * 설정 : 서버캐시 초기화 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM707.do")
	public String amM7007(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM707";
	}

	/**
	 * 설정 : 서버캐시 초기화
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM707.action")
	public String amM7007Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{

		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		
		if(paramMap.get("TP").equals("admin")){  //관리자초기화
			CommStatic.getResetCategoryList();
			model.addAttribute("outData", "ok");
		}else if(paramMap.get("TP").equals("front")){ //프론트초기화
			try{
				commService.resetFrontCategory();
				model.addAttribute("outData", "ok");
			}catch(Exception e){
				model.addAttribute("outData", "ng");
			}
		}else{
			model.addAttribute("outData", "ng");
		}
		
		return "common/out";
	}

}
