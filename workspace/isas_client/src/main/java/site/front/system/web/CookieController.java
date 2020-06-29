package site.front.system.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;


@Controller
public class CookieController extends BaseController{

	/**
	 * 쿠키 암호화 새로 쓰기
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(IConstants.ISDS_URL + "setCookie.action")
	public String setCookie(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String name = CommonUtil.nvl(paramMap.get("NAME"));
		String value = CommonUtil.nvl(paramMap.get("VALUE"));
		int expiretimes = CommonUtil.nvl(paramMap.get("EXPIRETIMES"), 60 * 60 * 24 * 30);
		CommonUtil.setCookie(response, name, value, expiretimes);
		model.addAttribute("outData", true);
		return "common/httpOut";
	}

	/**
	 * 쿠키 암호화 합치기
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(IConstants.ISDS_URL + "setCookieCombining.action")
	public String setCookieCombining(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String name = CommonUtil.nvl(paramMap.get("NAME"));
		String value = CommonUtil.nvl(paramMap.get("VALUE"));
		int expiretimes = CommonUtil.nvl(paramMap.get("EXPIRETIMES"), 60 * 60 * 24 * 30);
		String oldCookieVal = CommonUtil.getCookieValue(request, name);
		if(!"".equals(oldCookieVal)){
			String key = value.split("▤")[0];
			String[] row = oldCookieVal.split("▥");
			if(oldCookieVal.indexOf(key) > -1){
				StringBuilder newCookie = new StringBuilder();
				for (int i = 0; i < row.length; i++) {
					if(!key.equals(row[i].split("▤")[0])){
						if (newCookie.length() > 0) {
							newCookie.append("▥");
						}
						newCookie.append(row[i]);
					}
				}
				newCookie.trimToSize();
				oldCookieVal = newCookie.toString();
			}
			oldCookieVal += "▥" + value;
		}else{
			oldCookieVal = value;
		}
		CommonUtil.setCookie(response, name, oldCookieVal, expiretimes);
		model.addAttribute("outData", true);
		return "common/httpOut";
	}
	
}
