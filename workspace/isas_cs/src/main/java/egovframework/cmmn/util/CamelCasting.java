package egovframework.cmmn.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.web.util.HtmlUtils;

/**
 * CamelCasting
 * @author vary
 *
 */
public class CamelCasting{

	protected static final String UN_CAMEL_CASING_REGEX = "(?<=\\p{Ll})(?=\\p{Lu})|(?<=\\p{L})(?=\\p{Lu}\\p{Ll})";
	/**
	 * 첫 단어를 제외한 모든 단어의 첫 글자를 대문자로 나머지는 소문자로 표기하는 표기법
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, Object>> getCamelCasting(List<Map<String, Object>> params) throws Exception{
		List<Map<String, Object>> reParams = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> map : params) {
			reParams.add(getCamelCasting(map));
		}
		return reParams;
	}

	public static Map<String, Object> getCamelCasting(Map<String, Object> params) throws Exception{
		Map<String, Object> reParams = new HashMap<String, Object>();
		for(Entry<String, Object> entry : params.entrySet()){
			reParams.put(getCamelCasting(entry.getKey()), HtmlUtils.htmlEscape(CommonUtil.nvl(entry.getValue())));
        }
		return reParams;
	}

	public static String getCamelCasting(String param) throws Exception{
		return JdbcUtils.convertUnderscoreNameToPropertyName(param);
	}

	public static String getCamelCasting(Object param) throws Exception{
		return JdbcUtils.convertUnderscoreNameToPropertyName(CommonUtil.nvl(param));
	}

	/**
	 * 첫 단어를 제외한 모든 단어의 첫 글자를 대문자로 나머지는 소문자로 표기한 것을 복원한다
	 * @param param
	 * @param replacement
	 * @return
	 */
	public static List<Map<String, Object>> getUnCamelCasting(List<Map<String, Object>> params) {
		List<Map<String, Object>> reParams = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> map : params) {
			reParams.add(getUnCamelCasting(map));
		}
		return reParams;
	}

	public static Map<String, Object> getUnCamelCasting(Map<String, Object> params) {
		return getUnCamelCasting(params, "_", false);
	}

	public static Map<String, Object> getUnCamelCasting(Map<String, Object> params, String replacement, boolean isLowerCase) {
		Map<String, Object> reParams = new HashMap<String, Object>();
		for(Entry<String, Object> entry : params.entrySet()){
			reParams.put(getUnCamelCasting(entry.getKey(), replacement, false), HtmlUtils.htmlEscape(CommonUtil.nvl(entry.getValue())));
        }
		return reParams;
	}

	public static String getUnCamelCasting(String param, String replacement) {
	    return getUnCamelCasting(param, replacement, false);
	}

	public static String getUnCamelCasting(String param, String replacement, boolean isLowerCase) {
		if(isLowerCase){
			return param.replaceAll(UN_CAMEL_CASING_REGEX, replacement).toLowerCase();
		}else{
			return param.replaceAll(UN_CAMEL_CASING_REGEX, replacement).toUpperCase();
		}
	}

	/**
	 * 모든 단어의 첫 글자를 대문자로 나머지는 소문자로 표기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String, Object>> getPascalCasing(List<Map<String, Object>> params) throws Exception{
		List<Map<String, Object>> reParams = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> map : params) {
			reParams.add(getPascalCasing(map));
		}
		return reParams;
	}

	public static Map<String, Object> getPascalCasing(Map<String, Object> params) throws Exception{
		Map<String, Object> reParams = new HashMap<String, Object>();
		for(Entry<String, Object> entry : params.entrySet()){
			reParams.put(getPascalCasing(entry.getKey()), HtmlUtils.htmlEscape(CommonUtil.nvl(entry.getValue())));
        }
		return reParams;
	}

	public static String getPascalCasing(String param) throws Exception{
		return StringUtils.capitalize(JdbcUtils.convertUnderscoreNameToPropertyName(param));
	}

	public static String getPascalCasing(Object param) throws Exception{
		return StringUtils.capitalize(JdbcUtils.convertUnderscoreNameToPropertyName(CommonUtil.nvl(param)));
	}
}
