package site.comm.service.impl;

import java.io.BufferedReader;
import java.io.Reader;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.vo.TableColumnVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 캐싱을 위한 스태틱 리스트 관리
 * @author vary
 *
 */
public class CommStatic implements IConstants{

	/**
	 * 데이터 베이스의 테이블 컬럼 목록을 캐싱 한다.
	 */
	private static Map<String, List<TableColumnVO>> DB_TABLES = null;
	private static List<String> PASS_CATEGORY = null;
	/**
	 * CATEGORY LIST를 캐싱 한다.
	 */
	private static Map<String, List<Map<String, Object>>> CATEGORY_LIST = null;
	private static Map<String, Map<String, Boolean>> AUTH_CATEGORY_LIST = null;
	/**
	 * 테이블의 컬럼 구조를 가지고 온다.
	 * @param key
	 * @param dao
	 * @return
	 * @throws Exception
	 */
	public static List<TableColumnVO> getDbTable(String key, CommDAO dao) throws Exception {
		if(DB_TABLES == null) DB_TABLES = new HashMap<String, List<TableColumnVO>>();
		List<TableColumnVO> reList = DB_TABLES.get(key);
		if(reList == null){
			reList = dao.getTableColumnList(key);
			DB_TABLES.put(key, reList);
		}
		return reList;
	}

	/**
	 * 해댱 권한에 대한 Menu Category list를 가지고 온다
	 * @param key 권한 코드
	 * @param dao
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static List<?> getCategoryList(String key, CommDAO dao) throws Exception{
		if(CATEGORY_LIST == null){
			CATEGORY_LIST = new HashMap<String, List<Map<String, Object>>>();
			AUTH_CATEGORY_LIST = new HashMap<String, Map<String, Boolean>>();
		}
		List<Map<String, Object>> reList = CATEGORY_LIST.get(key);
		if(reList == null && dao != null){
			reList = (List<Map<String, Object>>) dao.getCategoryList(key);
			CATEGORY_LIST.put(key, reList);
			Map<String, Boolean> auth_category_map = new HashMap<String, Boolean>();
			for (Object object : reList) {
				Map<String, String> map = (Map<String, String>) object;
				if(map != null){
					String admUrl = CommonUtil.nvl(map.get("admUrl"));
					if(!admUrl.equals("")){
						auth_category_map.put(admUrl.substring(0, admUrl.lastIndexOf("/")), true);
					}
				}
			}
			AUTH_CATEGORY_LIST.put(key, auth_category_map);
		}
		return reList;
	}

	/**
	 *  Menu Category Reset
	 * @throws Exception
	 */
	public static void getResetCategoryList() throws Exception{
		CATEGORY_LIST = null;
		AUTH_CATEGORY_LIST = null;
	}

	/**
	 * 요청 url을 체크해서 접근 권한이 있는지 확인 한다.
	 * @param admAuthCd
	 * @param servletPath
	 * @return
	 * @throws Exception
	 */
	private static boolean getAuthCategory(String admAuthCd, String servletPath, HttpServletRequest request) throws Exception{
		Map<String, Boolean> authCategoryMap = AUTH_CATEGORY_LIST.get(admAuthCd);
		if(authCategoryMap == null){
			WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			CommDAO commDAO = (CommDAO) wac.getBean("CommDAO");
			getCategoryList(admAuthCd, commDAO);
			authCategoryMap = AUTH_CATEGORY_LIST.get(admAuthCd);
			if(authCategoryMap != null){
				Boolean isAuthCategory = authCategoryMap.get(servletPath);
				if(isAuthCategory != null) return isAuthCategory;
				else return false;
			}else return false;
		}else{
			Boolean isAuthCategory = authCategoryMap.get(servletPath);
			if(isAuthCategory != null) return isAuthCategory;
			else return false;
		}
	}

	/**
	 * 요청 url을 체크해서 접근 권한이 있는지 확인 한다.
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static boolean isAdmAuthCd(HttpServletRequest request) throws Exception{
		String admAuthCd = EgovUserDetailsHelper.getAdmAuthCd();
		String servletPath = request.getServletPath();
		int firstIndex = servletPath.indexOf("/");
		int lastIndex = servletPath.lastIndexOf("/");
		if(firstIndex == lastIndex){
			return true;
		}else{
			servletPath = servletPath.substring(firstIndex + 1, lastIndex);
			if(MNG_URI.indexOf(servletPath) > -1){
				return true;
			}
			servletPath = servletPath.replace(MNG_URI, "");
			if("sa".equals(servletPath)){
				return true;
			}
		}
		if(PASS_CATEGORY == null){
			PASS_CATEGORY = new ArrayList<>();
			WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			EgovPropertyService propertyService = (EgovPropertyService) wac.getBean("propertiesService");
			String[] passCategory = propertyService.getStringArray("passCategory");
			for (String string : passCategory) {
				PASS_CATEGORY.add(string);
			}
		}
		if(PASS_CATEGORY.contains(servletPath)) return true;
		if(AUTH_CATEGORY_LIST == null){
			WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			CommDAO commDAO = (CommDAO) wac.getBean("CommDAO");
			getCategoryList(admAuthCd, commDAO);
		}
		return getAuthCategory(admAuthCd, servletPath, request);
	}
	
	public static String getString(Object _value){
		if(_value instanceof Clob){
			Clob clob = (Clob) _value;
			final StringBuilder sb = new StringBuilder();
			BufferedReader br = null;
            try{
                final Reader reader = clob.getCharacterStream();
                br = new BufferedReader(reader);
                int b;
                while(-1 != (b = br.read()))
                {
                    sb.append((char)b);
                }
                br.close();
                sb.trimToSize();
                return sb.toString();
            }catch (Exception ex){
            	 return "";
            }
		}else if(_value instanceof LinkedList<?>){
			return CommonUtil.nvl(((LinkedList<?>) _value).get(0));
		}else if(_value instanceof String){
			return CommonUtil.nvl(_value);
		}else if(_value instanceof String[]){
			String[] _values = (String[]) _value;
			return _values[0];
		}else if(_value instanceof Integer){
			return CommonUtil.nvl(_value);
		}else if(_value instanceof Integer[]){
			Integer[] _values = (Integer[]) _value;
			return CommonUtil.nvl(_values[0]);
		}
		return CommonUtil.nvl(_value);
	}
	
	/**
     * html의 특수문자를 표현하기 위해
     *
     * @param srcString
     * @return String
     * @exception Exception
     * @see
     */
    public static String getHtmlStrCnvr(String srcString) {
    	String tmpString = srcString;
    	do {
    		tmpString = tmpString.replaceAll("&amp;", "&");
		} while (tmpString.indexOf("&amp;") > -1);
    	tmpString = tmpString.replaceAll("&lt;", "<");
		tmpString = tmpString.replaceAll("&gt;", ">");
		tmpString = tmpString.replaceAll("&apos;", "\'");
		tmpString = tmpString.replaceAll("&quot;", "\"");
		tmpString = tmpString.replaceAll("&nbsp;", " ");
		return  tmpString;
	}

}
