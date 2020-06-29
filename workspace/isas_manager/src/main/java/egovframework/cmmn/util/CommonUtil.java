package egovframework.cmmn.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.AES256Cipher;
import egovframework.cmmn.EgovProperties;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.Tokenizer;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

public class CommonUtil implements IConstants{

	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);

    @SuppressWarnings({ "rawtypes", "unchecked" })
	public static List merge(List list0, List list1) {
        if (list0 == null) return list1;
        if (list1 == null) return list0;

        List list = new ArrayList(list0);
        for (int i = 0; i < list1.size(); i++) {
            list.add(list1.get(i));
        }
        return list;
    }

    public static boolean isNotNull(String str) {
    	return (!CommonUtil.isNull(str));
    }

    public static boolean isHave(int num, int[] numArray) {
        boolean result = false;
        if (numArray != null) {
            for (int i = 0; i < numArray.length; i++) {
                if (numArray[i] == num) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }

	/**
	 * 문자열로 구성될 날자를 조합해서 반환한다.
     * @param toYear
     * @param toMonth
     * @param toDay
     * @param string
     * @return
     */
	public static String getMergedStringDate(String year, String month, String day, String time) {
        StringBuffer result = new StringBuffer();
        result.append(year);
        if (month.length() == 1) {
            result.append('0');
        }
        result.append(month);
        if (day.length() == 1) {
            result.append('0');
        }
        result.append(day);
        result.append(time);

        return result.toString();
    }

    /**
     * 이전 페이지 주소를 가져온다.
     *
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static String getPrevUrl(HttpServletRequest request) {
        String url = request.getHeader("referer");

		if (url != null) {
    		StringBuffer sb = new StringBuffer(url);
    		Enumeration enumer = request.getParameterNames();
    		boolean isFirst = (url.indexOf("?") < 0);
            if (isFirst) {
                String name = null;
                String value = null;
                while(enumer.hasMoreElements()) {
                    name = (String)(enumer.nextElement());
                    value = request.getParameter(name);
                    if (value != null && !name.equals("url")) {
                        if(isFirst) {
                            sb.append('?');
                            sb.append(name).append("=").append(value);
                            isFirst = false;
                        } else {
                            sb.append('&').append(name).append("=").append(value);
                        }
                    }
                }
            }
    		url = sb.toString();
		}

        return url;
    }

    /**
     * html 태그 을 모두 제거
     * @param param
     * @return
     */
    public static String delHtmlTag(String param){
        Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
        Matcher m = p.matcher(param);
        param = m.replaceAll("").trim();
        return param;
    }

    /**
     * 세자리마다 콤마찍기
     * @param str
     * @return
     */
	public static String comma(String str){
        String temp = reverseString(str);
        String result = "";

        for(int i = 0 ; i < temp.length() ; i += 3) {
            if(i + 3 < temp.length()) {
                result += temp.substring(i, i + 3) + ",";
            }
            else {
                result += temp.substring(i);
            }
        }

        return reverseString(result);
    }

	public static String reverseString(String s){
        return new StringBuffer(s).reverse().toString();
    }

    /**
     * 오늘날짜구하기
     * @param str
     * @return
     */
	public static String getToday(){
		 Date now = new Date();
        return new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(now);
    }

    /**
     * 특정날짜구하기 (Dany)
     * @param str
     * @return
     */
	public static String getSomeDay(int string){
		Calendar cCal = Calendar.getInstance();
		cCal.add(Calendar.DATE, string);
		Date nDate = cCal.getTime();
		String strDate = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(nDate);
		return strDate;
    }

	/**
     * 오늘날짜구하기 포맷 원하는 모양으로(vary)
     * @param str
     * @return
     */
	public static String getToday(String formatString){
		 Date now = new Date();
		 SimpleDateFormat sdf = null;
		 if("".equals(CommonUtil.nvl(formatString))){
			 sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
		 }else{
			 sdf = new SimpleDateFormat(formatString, Locale.getDefault());
		 }
       return sdf.format(now);
	}
	/**
     * 오늘 기준으로 특정 기간후의 날짜 구하기(vary)
     * @param str
     * @return
     */
	public static String getDate(int iDay){
		return CommonUtil.getDate(iDay, null);
	}
	/**
     * 오늘 기준으로 특정 기간후의 날짜 구하기 포맷 원하는 모양으로(vary)
     * @param str
     * @return
     */
	public static String getDate(int iDay, String formatString){
		Calendar today = Calendar.getInstance();
		today.add(Calendar.DATE, iDay);
		Date returnday = today.getTime();
		SimpleDateFormat sdf = null;
		if("".equals(CommonUtil.nvl(formatString))){
			sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
		}else{
			sdf = new SimpleDateFormat(formatString, Locale.getDefault());
		}
		return sdf.format(returnday);
	}
	/**
     * 오늘 기준으로 특정 기간후의 주 구하기 포맷 원하는 모양으로(vary)
     * @param str
     * @return
     */
	public static String getWeek(int iWeek, String formatString){
		Calendar today = Calendar.getInstance();
		today.add(Calendar.WEDNESDAY, iWeek);
		Date returnday = today.getTime();
		SimpleDateFormat sdf = null;
		if("".equals(CommonUtil.nvl(formatString))){
			sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
		}else{
			sdf = new SimpleDateFormat(formatString, Locale.getDefault());
		}
		return sdf.format(returnday);
	}
	/**
     * 오늘 기준으로 특정 기간후의 달 구하기 포맷 원하는 모양으로(vary)
     * @param str
     * @return
     */
	public static String getMonth(int iMonth, String formatString){
		Calendar today = Calendar.getInstance();
		today.add(Calendar.MONTH, iMonth);
		Date returnday = today.getTime();
		SimpleDateFormat sdf = null;
		if("".equals(CommonUtil.nvl(formatString))){
			sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
		}else{
			sdf = new SimpleDateFormat(formatString, Locale.getDefault());
		}
		return sdf.format(returnday);
	}
	//(vary)
	public static boolean isEmpty(Object arg){
		boolean result = false;
		if(arg == null || String.valueOf(arg).trim().equals("")){
			result = true;
		}
		return result;
	}
	//(vary)
	public static String nvl(Object arg, String ch){
		if(arg == null) return ch;
		String str = String.valueOf(arg);
		if(str.trim().equals("") || str.trim().equalsIgnoreCase("null") || str.trim().equalsIgnoreCase("undefined")) return ch;
		return str;
	}
	//(vary)
	public static String nvl(Object arg){
		return nvl(arg, "");
	}
	//(vary)
	public static String nvlTrim(Object arg){
		return nvl(arg, "").trim();
	}
	//(vary)
	public static String nvlyn(Object arg){
		return nvl(arg, "N");
	}
	//(vary)
	public static boolean isNotEmpty(Object arg){
		return !isEmpty(arg);
	}
	//(vary)
	@SuppressWarnings("rawtypes")
	public static Map getFirstMapFromList(List _list){
		if(_list != null){
			if(_list.size() > 0) return (Map) _list.get(0);
			else return null;
		}else return	null;
	}
	//(vary)
	public static boolean isNotEmpty(Object arg,Object arg2){
		boolean returnValue = true;
		returnValue = !isEmpty(arg);
		returnValue = !isEmpty(arg2);
		return returnValue;
	}
	//(vary)
	public static int nvl(Object arg, int i){
		if(arg == null) return i;
		String tempS = "";
		try{
			tempS = nvl(arg);
			if("".equals(tempS)){
				return i;
			}else{
				return Integer.valueOf(tempS);
			}
		}catch(Exception e){
			return i;
		}
	}

	//(vary)
	public static long nvl(Object arg, long i){
		if(arg == null) return i;
		String tempS = "";
		try{
			tempS = nvl(arg);
			if("".equals(tempS)){
				return i;
			}else{
				return Long.valueOf(tempS);
			}
		}catch(Exception e){
			return i;
		}
	}
	//(vary)
	public static float nvlFloat(Object arg, float i){
		if(arg == null) return i;
		float returnValue;
		try{
			returnValue = Float.valueOf(nvl(arg, "0"));
		}catch(Exception e){
			return i;
		}
		if(returnValue == 0) returnValue = i;
		return returnValue;
	}
	//(vary)
	public static Double nvlDouble(Object arg, Double i){
		if(arg == null) return i;
		try{
			String tempS = nvl(arg);
			if("".equals(tempS)){
				return i;
			}else{
				return Double.valueOf(tempS);
			}
		}catch(Exception e){
			return i;
		}
	}
	//(vary)
	public static int nvlInt(Object arg){
		return nvl(arg, 0);
	}
	public static Double nvlDouble(Object arg){
		return nvlDouble(arg, null);
	}

	public static long nvlLong(Object arg){
		return nvl(arg, 0l);
	}
	public static String nvlStrArrVal(Object arg, int index){
		return "" + nvlArrVal(arg, index);
	}
	public static Object nvlArrVal(Object arg, int index){
		if(isEmpty(arg)){
			return "";
		}else{
			if(arg instanceof String[]){
				String[] strArr = (String[]) arg;
				return nvl(strArr[index]);
			}else if(arg instanceof int[]){
				int[] intArr = (int[]) arg;
				return nvl(intArr[index]);
			}else if(arg instanceof Double[]){
				Double[] doubleArr = (Double[]) arg;
				return nvl(doubleArr[index]);
			}else if(arg instanceof float[]){
				float[] floatArr = (float[]) arg;
				return nvl(floatArr[index]);
			}else if(arg instanceof long[]){
				long[] longArr = (long[]) arg;
				return nvl(longArr[index]);
			}else{
				return "";
			}
		}
	}

	public static Date fnGetStringDateToDate(String s_date)
	{
		Date d_return = new Date();

		try {
			d_return = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).parse(s_date);

		} catch (ParseException ex) {
			LoggerFactory.getLogger(EgovProperties.class).error("Exception", ex);
		}
		return d_return;
	}

	@SuppressWarnings("rawtypes")
	public static int getSize(List list){
		if(list == null) return 0;
		return list.size();
	}

	public static String checkFile(String filePath, String realFile){
		File CHECK_FILE = new File(filePath);
		if(!CHECK_FILE.exists()) CHECK_FILE.mkdir();
		int pos = 1;
		int count = 0;
		do {
			CHECK_FILE = new File ( filePath + "\\" + realFile );
			if(CHECK_FILE.exists()){
				String fileNm  = realFile.substring( 0, realFile.lastIndexOf(".") );      // 파일명
				String fileExt = realFile.substring( realFile.lastIndexOf(".") + 1, realFile.length() ); // 확장자
				String len = fileNm.substring(fileNm.length() - pos);
				try{
					count = Integer.parseInt(len);
					fileNm = fileNm.substring(0, fileNm.length() -pos);
				}catch(NumberFormatException ex){
					count = 0;
				}
				count++;
				fileNm = fileNm + count;
				realFile = fileNm + "." + fileExt;
				pos = ("" + count ).length();
			}
		}while ( CHECK_FILE.exists() );
	    return realFile;
	}

	/**
	 * 문자열(8859_1)을 지정된 character encoding 으로 변환한다.
	 * @param s 대상 문자열
	 * @param charset encoding charset
	 */
	public static String encode(String s, String charset) 	{
		if (charset == null || "8859_1".equals(charset)) return s;
		String out = null;
		if (s == null ) return null;

		try {
			out = new String(s.getBytes("8859_1"), charset);
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}


	/**
	 * 숫자를 ###,###,### 형식으로 포맷한다.
	 *
	 * @param val
	 * @return
	 */
	public static String formatNumber(Object val) {
		StringBuffer result = new StringBuffer();
		try {
			Object aobj[] = { val };
			MessageFormat messageformat = new MessageFormat(
					"{0,number,###,###,###,##0}");
			result.append(messageformat.format(((Object) (aobj))));
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result.toString();
	}

	/**
	 * 쿠키값을 생성한다.
	 *
	 * @param res
	 * @param name
	 * @param value
	 */
	public static void setCookie(HttpServletResponse response, String name, String value) {
		setCookie(response, name, value, -1);//-1이면 계속유지
	}

	/**
	 * 쿠키값을 생성한다.
	 *
	 * @param res
	 * @param name
	 * @param value
	 * @param age
	 */
	public static void setCookie(HttpServletResponse response, String name, String value, int age) {
		String aes256Value = AES256Cipher.aesEncryptCbc(value);
		Cookie cookie = new Cookie(name, aes256Value); // 쿠키 생성
		cookie.setMaxAge(age);// 쿠키의 생성시간 저장
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	/**
	 * 쿠키값을 가져온다.
	 *
	 * @param request
	 * @param name
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String name) {
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals(name)) {
					String aes256Value = AES256Cipher.aesDecryptCbc(cookies[i].getValue());
					cookie = new Cookie(cookies[i].getName(), aes256Value);
					break;
				}
			}
		}
		return cookie;
	}
	public static String getCookieValue(HttpServletRequest request, String name) {
		String _value = "";
		Cookie cookie = getCookie(request, name);
		if(cookie != null) _value = cookie.getValue();
		return _value;
	}
	/**
	 * 쿠키를 제거한다.
	 *
	 * @param request
	 * @param res
	 * @param name
	 */
	public static void removeCookie(HttpServletRequest request, HttpServletResponse response, String name) {
		 Cookie cookie = getCookie(request, name);
		 if(cookie != null){
			 cookie = new Cookie(name, null);
			 cookie.setMaxAge(0);
			 cookie.setPath("/");
			 response.addCookie(cookie);
		 }
	}

	/**
	 * 현재페이지의 주소를 가져온다.
	 *
	 * @param request
	 * @return
	 */
	public static String getURI(HttpServletRequest request) {
		return request.getRequestURI() + "?" + request.getQueryString();
	}

	/**
	 * 관심 컨텐츠로 등록하기 위한 현재페이지 주소를 가져온다.
	 *
	 * @param request
	 * @return
	 */
	public static String getURIForContent(HttpServletRequest request) {
		StringBuffer uri = new StringBuffer();
		uri.append(request.getRequestURI()).append("?");
		String query = request.getQueryString();
		if (query != null) {
			int index = -1;
			if ((index = query.indexOf("listURI")) > -1) {
				if (index > 0) {
					uri.append(query.substring(0, index - 1));
					int eIndex = query.indexOf("&", index + 1);
					if (eIndex > -1) {
						uri.append(query.substring(eIndex));
					}
				}

			} else {
				uri.append(query);
			}
		}
		return uri.toString();
	}

	public static String getListURL(HttpServletRequest request) {
		String listURI = request.getParameter("listURI");
		return CommonUtil.isNull(listURI) ? CommonUtil.getPrevUrl(request)
				: listURI;
	}

	/**
	 * 년,월을 yyyyMM 형식으로 리턴
	 *
	 * @param year
	 * @param month
	 * @return
	 */
	public static String mergeDateStringYYYYMM(String year, String month) {
		StringBuffer result = new StringBuffer();
		result.append(year);
		if (CommonUtil.isNull(month)) {
			result.append("00");
		} else {
			if (month.length() < 2) {
				result.append("0");
			}
			result.append(month);
		}
		return result.toString();
	}

	/**
	 * 년,월을 yyyyMM 형식으로 리턴
	 *
	 * @param year
	 * @param month
	 * @return
	 */
	public static String mergeDateStringYYYYMM(int year, int month) {
		return mergeDateStringYYYYMM(year == 0 ? "0000" : year + "",
				month == 0 ? "00" : month + "");
	}

	/**
	 * 년, 월, 일을 입력받아 하나(8자리 yyyyMMdd)로 합친다. 월, 일이 null일경우는 00으로 된다.
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public static String mergeDateString2(String year, String month, String day) {
		StringBuffer result = new StringBuffer();
		result.append(year);
		if (CommonUtil.isNull(month)) {
			result.append("00");
		} else {
			if (month.length() < 2) {
				result.append("0");
			}
			result.append(month);
		}

		if (CommonUtil.isNull(day)) {
			result.append("00");
		} else {
			if (day.length() < 2) {
				result.append("0");
			}
			result.append(day);
		}

		return result.toString();
	}

	/**
	 * 년월일 형식을 yyyyMMdd 형식으로 리턴
	 *
	 * @param request
	 * @param name1
	 *            year
	 * @param name2
	 *            month
	 * @param name3
	 *            day
	 * @return
	 */
	public static String mergeDateString2(HttpServletRequest request, String name1,
			String name2, String name3) {
		return mergeDateString2(request.getParameter(name1),
				request.getParameter(name2), request.getParameter(name3));
	}

	/**
	 * 년, 월, 일, 시, 분 yyyMMddHHmm 형식으로 리턴
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @param hour
	 * @param min
	 * @return
	 */
	public static String mergeDateString3(String year, String month,
			String day, String hour, String min) {
		StringBuffer result = new StringBuffer();
		result.append(year);
		if (CommonUtil.isNull(month)) {
			result.append("00");
		} else {
			if (month.length() < 2) {
				result.append("0");
			}
			result.append(month);
		}

		if (CommonUtil.isNull(day)) {
			result.append("00");
		} else {
			if (day.length() < 2) {
				result.append("0");
			}
			result.append(day);
		}

		if (CommonUtil.isNull(hour)) {
			result.append("00");
		} else {
			if (hour.length() < 2) {
				result.append("0");
			}
			result.append(hour);
		}

		if (CommonUtil.isNull(min)) {
			result.append("00");
		} else {
			if (min.length() < 2) {
				result.append(min);
			}
			result.append("0");
		}

		return result.toString();
	}

	/**
	 * yyyMMddHHmm 형식으로 리턴
	 *
	 * @param request
	 * @param name1
	 *            year
	 * @param name2
	 *            month
	 * @param name3
	 *            day
	 * @param name4
	 *            hour
	 * @param name5
	 *            minute
	 * @return
	 */
	public static String mergeDateString3(HttpServletRequest request, String name1,
			String name2, String name3, String name4, String name5) {
		return mergeDateString3(request.getParameter(name1),
				request.getParameter(name2), request.getParameter(name3),
				request.getParameter(name4), request.getParameter(name5));
	}

	/**
	 * 우편번호를 붙임
	 *
	 * @param zipcode1
	 * @param zipcode2
	 * @return
	 */
	public static String mergeZipcode(String zipcode1, String zipcode2) {
		StringBuffer result = new StringBuffer();
		if (zipcode1 != null) {
			result.append(zipcode1.trim());
		}
		if (zipcode2 != null) {
			result.append("-");
			result.append(zipcode2.trim());
		}
		return result.toString();
	}

	/**
	 * 이메일주소를 붙임
	 *
	 * @param email1
	 * @param email2
	 * @return
	 */
	public static String mergeEmail(String email1, String email2) {
		StringBuffer result = new StringBuffer();
		if (email1 != null) {
			result.append(email1.trim());
		}
		if (email2 != null) {
			result.append("@");
			result.append(email2.trim());
		}
		return result.toString();
	}

	/**
	 * 세 문자열을 입력받아 전화번호를 만든다.
	 *
	 * @param telNo1
	 * @param telNo2
	 * @param telNo3
	 * @return
	 */
	public static String mergeTelNo(String telNo1, String telNo2, String telNo3) {
		StringBuffer result = new StringBuffer();
		if (telNo1 != null) {
			result.append(telNo1.trim());
			if (telNo2 != null) {
				result.append("-");
				result.append(telNo2.trim());
			}
			if (telNo3 != null) {
				result.append("-");
				result.append(telNo3.trim());
			}
		} else {
			if (telNo2 != null) {
				result.append(telNo2.trim());
				if (telNo3 != null) {
					result.append("-");
					result.append(telNo3.trim());
				}
			} else {
				if (telNo3 != null) {
					result.append(telNo3.trim());
				}
			}
		}

		return result.toString();
	}

	/**
	 * 세 문자열을 입력받아 생년월일를 만든다.
	 *
	 * @param birth1
	 * @param birth2
	 * @param birth3
	 * @param deligater
	 * @return
	 */
	public static String mergeBrith(String birth1, String birth2,
			String birth3, String deligater) {
		StringBuffer result = new StringBuffer();
		if (birth1 != null) {
			result.append(birth1.trim());
			if (birth1 != null) {
				result.append(deligater);
				result.append(birth2.trim());
			}
			if (birth3 != null) {
				result.append(deligater);
				result.append(birth3.trim());
			}
		} else {
			if (birth2 != null) {
				result.append(birth2.trim());
				if (birth3 != null) {
					result.append(deligater);
					result.append(birth3.trim());
				}
			} else {
				if (birth3 != null) {
					result.append(birth3.trim());
				}
			}
		}

		return result.toString();
	}

	/**
	 *
	 * @param request
	 * @param name1
	 * @param name2
	 * @param name3
	 * @return
	 */
	public static String mergeTelNo(HttpServletRequest request, String name1,
			String name2, String name3) {
		return mergeTelNo(request.getParameter(name1),
				request.getParameter(name2), request.getParameter(name3));
	}

	/**
	 * Date형식으로 리턴
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @param hour
	 * @param min
	 * @param sec
	 * @return
	 */
	public static Date toDate(String year, String month, String day, int hour, int min, int sec) {
		return CommonUtil.toDate(convertInt(year, 1970), convertInt(month, 1), convertInt(day, 1), hour, min, sec);
	}


	/**
	 *현재시간 년월일시분초 가져오기
	 * @return
	 */
	public static String toDateTime() {
		Calendar calendar = Calendar.getInstance();
	    java.util.Date date = calendar.getTime();
	    String today = (new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(date));
		return today;
	}



	/**
	 * Date객체로 반환
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @param hour
	 * @param minute
	 * @param second
	 * @return
	 */
	public static Date toDate(int year, int month, int day, int hour, int minute, int second) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, day, hour, minute, second);
		return calendar.getTime();
	}

	/**
	 * 시작시각을 Date형식으로 리턴
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public static Date toStartDate(String year, String month, String day) {
		return toDate(year, month, day, 0, 0, 0);
	}

	/**
	 * 종료시각을 Date형식으로 리턴
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public static Date toEndDate(String year, String month, String day) {
		return toDate(year, month, day, 23, 59, 59);
	}

	/**
	 * 현재 날짜를 String형식으로 리턴
	 *
	 * @param formatString
	 * @return
	 */

	public static String getCurDateStr(String formatString) {
		SimpleDateFormat formatter = new SimpleDateFormat(formatString, Locale.getDefault());
		Date currentTime = new Date();
		return formatter.format(currentTime);
	}

	/**
	 * 달수를 더한 날짜를 리턴
	 *
	 * @param year
	 * @param month
	 * @param addMonth
	 * @return yyyyMM 형식
	 */
	public static String getDateAdd(String year, String month, int addMonth) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM", Locale.getDefault());
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(year),
				Integer.parseInt(month) - 1, 1);
		cal.add(Calendar.MONTH, addMonth);
		return formatter.format(cal.getTime());
	}

	/**
	 * 날짜에 날수를 더함
	 *
	 * @param date
	 * @param addDay
	 * @return
	 */
	public static Date getDateAddDay(Date date, int addDay) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(Calendar.DATE, addDay);
		return cal.getTime();
	}

	/**
	 * 날짜에 달을 더함
	 *
	 * @param date
	 * @param addMonth
	 * @return
	 */
	public static Date getDateAddMonth(Date date, int addMonth) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(Calendar.MONTH, addMonth);
		return cal.getTime();
	}

	/**
	 * 날짜에 날을 더하거나 빼기
	 *
	 * @param date
	 * @param addMonth
	 * @return
	 * @throws ParseException
	 */
	public static String getDateAddDay(String date, int addDay)
			throws ParseException {
		GregorianCalendar cal = new GregorianCalendar();

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		Date newDate2 = format.parse(date);

		cal.setTime(newDate2);
		cal.add(Calendar.DAY_OF_MONTH, addDay);

		return format.format(cal.getTime());
	}

	/**
	 * 날짜에 달을 더하거나 빼기
	 *
	 * @param date
	 * @param addMonth
	 * @return
	 * @throws ParseException
	 */
	public static String getDateAddMonth(String date, int addMonth)
			throws ParseException {
		GregorianCalendar cal = new GregorianCalendar();

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		Date newDate2 = format.parse(date);

		cal.setTime(newDate2);
		cal.add(Calendar.MONTH, addMonth);

		return format.format(cal.getTime());
	}

	/**
	 * 날수를 더한 날짜를 리턴
	 *
	 * @param year
	 * @param month
	 * @param day
	 * @param addDay
	 * @return yyyyMMdd
	 */
	public static String getDateAdd(String year, String month, String day,
			int addDay) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(year),
				Integer.parseInt(month) - 1, Integer.parseInt(day));
		cal.add(Calendar.DATE, addDay);
		return formatter.format(cal.getTime());
	}

	/**
	 * 달수를 더한 날짜를 리턴
	 *
	 * @param date
	 * @param addMonth
	 * @return yyyyMMdd
	 */
	public static String getDateAdd(String date, int addMonth) {
		int year = Integer.parseInt(date.substring(0, 4));
		int month = Integer.parseInt(date.substring(4, 6));
		int day = Integer.parseInt(date.substring(6, 8));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		GregorianCalendar cal = new GregorianCalendar(year, month - 1, day);
		cal.add(Calendar.MONTH, addMonth);
		return formatter.format(cal.getTime());
	}

	/**
	 * 시작일부터 종료일까지 사이의 날짜를 배열에 담아 리턴 ( 시작일과 종료일을 모두 포함한다 )
	 *
	 * @author JD_CHOI
	 * @param fromDate
	 *            yyyyMMdd 형식의 시작일
	 * @param toDate
	 *            yyyyMMdd 형식의 종료일
	 * @return yyyyMMdd 형식의 날짜가 담긴 배열
	 */
	public static String[] getDiffDays(String fromDate, String toDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		Calendar cal = Calendar.getInstance();

		try {
			cal.setTime(sdf.parse(fromDate));
		} catch (Exception e) {
		}

		int count = getDiffDayCount(fromDate, toDate);

		// 시작일부터
		cal.add(Calendar.DATE, -1);

		// 데이터 저장
		ArrayList<String> list = new ArrayList<String>();

		for (int i = 0; i <= count; i++) {
			cal.add(Calendar.DATE, 1);
			list.add(sdf.format(cal.getTime()));
		}

		String[] result = new String[list.size()];

		list.toArray(result);

		return result;
	}

	/**
	 * 그달의 끝날짜를 구함
	 *
	 * @param selectMonth
	 * @return
	 */
	public static int getEndDay(String selectMonth) {
		int endDay = 0;
		int year = Integer.parseInt(selectMonth.substring(0, 4));
		int month = Integer.parseInt(selectMonth.substring(4, 6));

		Calendar sday = Calendar.getInstance(); // 시스템이 새로 알맞는 시간을 불러들이기 위해 선언
		Calendar eday = Calendar.getInstance();// 끝
		sday.set(year, month - 1, 1); // 1일로 셋팅//0월부터 시작하기때문에 -1 해야함
		eday.set(year, month - 1, sday.getActualMaximum(Calendar.DATE));

		// 그월의 끝날을 구한다.
		endDay = eday.get(Calendar.DATE);
		return endDay;
	}

	/**
	 * 시작일부터 종료일까지 사이의 선택된 날짜를 배열로 받아서 그사이 선택된날짜를 제외한 날짜를 리턴
	 *
	 * @author JD_CHOI
	 * @param inDate
	 * @return emptyDays
	 */
	public static String[] getDiffDaysEmpty(String[] inDate, String fromDate,
			String toDate) {

		String[] fullDays = getDiffDays(fromDate, toDate);
		String[] emptyDays = new String[fullDays.length];

		int dayCnt = 0;
		int arrCnt = 0;

		if (!isNull(inDate) && !isNull(fullDays)) {
			for (int i = 0; i < fullDays.length; i++) {
				dayCnt = 0;
				for (int j = 0; j < inDate.length; j++) {
					if (fullDays[i].equals(inDate[j])) {
						dayCnt++;
					}
				}
				if (dayCnt == 0) {
					emptyDays[arrCnt] = fullDays[i];
					arrCnt++;
				}
			}
		}

		return emptyDays;
	}

	/**
	 * 두날짜 사이의 일수를 리턴
	 *
	 * @author JD_CHOI
	 * @param fromDate
	 *            yyyyMMdd 형식의 시작일
	 * @param toDate
	 *            yyyyMMdd 형식의 종료일
	 * @return 두날짜 사이의 일수
	 */
	public static int getDiffDayCount(String fromDate, String toDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		try {

			return (int) ((sdf.parse(toDate).getTime() - sdf.parse(fromDate)
					.getTime()) / 1000 / 60 / 60 / 24);

		} catch (Exception e) {

			return 0;
		}
	}

	/**
	 * 두날짜 사이에 속하는지 여부
	 *
	 * @param startDate
	 * @param endDate
	 * @param selectDate
	 * @return
	 */
	public static boolean getBetweenDateFlag(String startDate, String endDate,
			String selectDate) {
		boolean flag = false;

		try {
			String betweenDays[] = getDiffDays(startDate, endDate);
			if (!isNull(betweenDays))
				for (int i = 0; i < betweenDays.length; i++) {
					if (selectDate.equals(betweenDays[i]))
						flag = true;
				}
			return flag;
		} catch (Exception e) {
			return flag;
		}
	}

	/**
	 * 스트링형 데이트를 원하는 포맷으로 변환후 반환.
	 *
	 * @param formatString
	 * @param date
	 * @return
	 */

	public static String getStringDateFormat(Object dateString) {
		return getStringDateFormat(dateString, null);
	}

	public static String getStringDateFormat(Object dateString, String formatString) {
		String dateStr = nvl(dateString);
		formatString = nvl(formatString, "yyyy-MM-dd");
		if("".equals(dateStr)){
			return null;
		}
		try {
			DateFormat format = new SimpleDateFormat(formatString, Locale.getDefault());
			return format.format(format.parse(dateStr));
		} catch (ParseException e) {
			logger.error("parse error ", e);
		}
		return dateStr;
	}

	/**
	 * 데이트형을 스트링으로 반환한다.
	 *
	 * @param formatString
	 * @param date
	 * @return
	 */

	public static String getDate2Str(String formatString, Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat(formatString, Locale.getDefault());
		return formatter.format(date);
	}

	/**
	 * 데이트형을 스트링으로 반환한다.
	 *
	 * @param formatString
	 * @param date
	 * @return
	 */

	public static String getDateToStr(String formatString, Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat(formatString, Locale.getDefault());
		return formatter.format(date);
	}

	/**
	 * 파일 확장자
	 *
	 * @param fileName
	 * @return
	 */
	public static String getFileExt(String fileName) {
		String ext = null;
		int dot = fileName.lastIndexOf(".");
		if (dot != -1) {
			ext = fileName.substring(dot + 1);
		}
		return ext;
	}

	/**
	 * 파일 확장자를 소문자로 반환한다.
	 *
	 * @param filename
	 * @return
	 */
	public static String getFileExtLowerCase(String filename) {
		return getFileExt(filename).toLowerCase();
	}

	/**
	 * Map을 정렬후 리턴함
	 *
	 * @param map
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static SortedMap sortMap(Map map) {
		return Collections.synchronizedSortedMap(new TreeMap(map));
	}

	/**
	 * null을 문자열로 리턴. 좌우공백은 제거
	 *
	 * @param s
	 * @return
	 */
	public static String checkNull(String s) {
		return s = (s == null) ? "" : s.trim();
	}

	/**
	 * null을 문자열로 리턴. 좌우공백은 제거
	 *
	 * @param s
	 * @return
	 */
	public static String checkNull(String s, String d) {
		return s = (s == null) ? d : s.trim();
	}

	/**
	 * null을 문자열로 리턴. 좌우공백은 제거
	 *
	 * @param s
	 * @return
	 */
	public static int checkNull(String s, int d) {
		if (s == null)
			return d;
		else
			return Integer.parseInt(s.trim());
	}

	/**
	 * null을 문자열로 리턴. 좌우공백은 제거
	 *
	 * @param s
	 * @return
	 */
	public static String checkNull(Object s) {
		if (s == null)
			return "";
		else
			return s.toString().trim();
	}

	/**
	 * null을 문자열로 리턴. 좌우공백은 제거
	 *
	 * @param s
	 * @return
	 */
	public static String checkNull(Object s, String d) {
		if (s == null)
			return d;
		else
			return s.toString().trim();
	}

	/**
	 * null을 문자열로 리턴. 좌우공백은 제거
	 *
	 * @param s
	 * @return
	 */
	public static int checkNull(Object s, int d) {
		if (s == null)
			return d;
		else
			return Integer.parseInt(s.toString().trim());
	}

	/**
	 *
	 * @param s
	 * @return
	 */
	public static boolean isNull(String s) {
		return (s == null || "".equals(s.trim()));
	}

	/**
	 *
	 * @param s
	 * @return
	 */
	public static boolean isNull(Object obj) {
		return (obj == null);
	}

	/**
	 * 호스트명을 리턴
	 *
	 * @param request
	 * @return
	 */
	public static String getHostUrl(HttpServletRequest request) {
		StringBuffer hostSB = new StringBuffer();
		int port = request.getServerPort();
		if (port == 443) {
			hostSB.append("https://");
		} else {
			hostSB.append("http://");
		}
		hostSB.append(request.getServerName());
		if (port != 80 && port != 443) {
			hostSB.append(":").append(port);
		}
		return hostSB.toString();
	}

	/**
	 * 오늘의 week정보를 리턴
	 *
	 * @return 1(일),..,7(토)
	 */
	public static int getCurWeek() {
		Calendar rightNow = Calendar.getInstance();
		return rightNow.get(Calendar.DAY_OF_WEEK); // 일~토:1~7

	}

	/**
	 * 해당일의 요일정보 리턴
	 *
	 * @param sY
	 * @param sM
	 * @param sD
	 * @return 1(일),..,7(토)
	 */
	public static int getSelWeek(String sY, String sM, String sD) {
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(sY),
				Integer.parseInt(sM) - 1, Integer.parseInt(sD));
		return cal.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 선택한 날이 속한 주의 모든 날짜를 가져옴
	 *
	 * @param sY
	 * @param sM
	 * @param sD
	 * @return String[7]
	 */
	public static String[] selWeekDayRange(String sY, String sM, String sD) {
		String[] sa = new String[7];

		// int i = getCurWeek(); // 1~7
		int i = getSelWeek(sY, sM, sD);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(sY),
				Integer.parseInt(sM) - 1, Integer.parseInt(sD));
		cal.add(Calendar.DAY_OF_MONTH, -i + 1); // week First Day

		sa[0] = formatter.format(cal.getTime());
		for (int j = 1; j <= 6; j++) {
			cal.add(Calendar.DAY_OF_MONTH, 1);
			sa[j] = formatter.format(cal.getTime());
		}

		return sa;
	}

	/**
	 * 랜덤값을 n개만큼 가져옴
	 *
	 * @param max
	 *            최대값
	 * @param num
	 *            가져올 개수
	 * @return int[]
	 */
	public static int[] getRandomIdx(int max, int num) {
		int[] dat = new int[num];
		for (int i = 0; i < dat.length; i++)
			dat[i] = -1;

		Random ran = new Random();
		int r = 0;
		int n = 0;
		boolean dup = false;
		while (n < num) {
			r = ran.nextInt(max);
			if (r < 0)
				r *= -1;
			dup = false;
			for (int i = 0; i < n; i++) {
				if (r == dat[i])
					dup = true;
			}
			if (!dup) {
				dat[n++] = r;
			}
		}

		return dat;
	}

	/**
	 * 랜덤한 6자리 숫자값을 생성시킨다
	 *
	 * @return
	 */
	public static String getNewRandomValue() {
		DecimalFormat df = new DecimalFormat("000000");
		return df.format(Math.random() * 1000000);
	}

	/**
	 * ex) formatNumber("4", "00"); // 04
	 *
	 * @param n
	 * @param formatString
	 * @return
	 */
	public static String formatNumber(String n, String formatString) {
		return formatNumber(convertInteger(n, 0), formatString);
	}

	/**
	 *
	 * ex) formatNumber(4, "00"); // 04
	 *
	 * @param n
	 * @param formatString
	 * @return
	 */
	public static String formatNumber(int n, String formatString) {
		DecimalFormat form = new DecimalFormat(formatString);
		return form.format(n);
	}

	/**
	 * 문자열 앞에 문자를 채운다
	 *
	 * @param s
	 * @param chr
	 *            null이면 "0"으로 변경
	 * @param len
	 * @return
	 */
	public static String leftPad(String s, int len, String chr) {
		if (s == null || "".equals(s))
			return "";
		if (chr == null || "".equals(chr))
			chr = "0";
		if (s.length() >= len)
			return s.substring(0, len);

		for (int i = s.length(); i < len; i++) {
			s = chr + s;
		}
		return s;
	}

	/**
	 * 주어진 문자로 길이만큼 채운 후 돌려준다.
	 *
	 * @param i
	 * @param chr
	 *            null이면 "0"으로 변경
	 * @param len
	 * @return
	 */
	public static String leftPad(int i, int len, String chr) {
		return leftPad(i + "", len, chr);
	}

	/**
	 * 주어진 문자로 길이만큼 "0"으로 채운 후 돌려준다.
	 *
	 * @param s
	 * @param len
	 * @return
	 */
	public static String leftPad(Object o, int len) {
		return leftPad(nvlTrim(o), len, null);
	}

	/**
	 * 주어진 문자로 길이만큼 "0"으로 채운 후 돌려준다.
	 *
	 * @param s
	 * @param len
	 * @return
	 */
	public static String leftPad(String s, int len) {
		return leftPad(s, len, null);
	}

	/**
	 * 주어진 문자로 길이만큼 "0"으로 채운 후 돌려준다.
	 *
	 * @param i
	 * @param len
	 * @return
	 */
	public static String leftPad(int i, int len) {
		return leftPad(i + "", len, null);
	}

	/**
	 * 달의 마지막날
	 *
	 * @param Y
	 * @param M
	 * @return
	 */
	public static int getMonthLastDay(String Y, String M) {
		int dom[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		int yy = Integer.parseInt(Y);
		int mm = Integer.parseInt(M);
		mm--;

		GregorianCalendar cal = new GregorianCalendar(yy, mm, 1);
		int daysInMonth = dom[mm];
		if (cal.isLeapYear(cal.get(Calendar.YEAR)) && mm == 1) {
			daysInMonth++;
		}
		return daysInMonth;
	}

	/**
	 * 이메일 값이 올바른지 체크
	 *
	 * @param email
	 * @return
	 */
	public static boolean isEmail(String email) {
		if (email == null)
			return false;

		String thePattern = "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+";
		Pattern pattern = Pattern.compile(thePattern);
		Matcher match = pattern.matcher(email);
		boolean b = false;
		if (match.find()) {
			b = true;
		}
		return b;
	}

	/**
	 * 핸드폰 번호가 올바른지 체크
	 *
	 * @param sms
	 * @return
	 */
	public static boolean isSms(String sms) {
		if (sms == null)
			return false;
		String thePattern = ("01[0|1|6|7|8|9]-[0-9]{3,4}-[0-9]{4}");
		Pattern pattern = Pattern.compile(thePattern);
		Matcher match = pattern.matcher(sms);
		boolean b = false;
		if (match.find()) {
			b = true;
		}
		return b;
	}

	public static boolean isImage(String filename) {
		if (isNull(filename))
			filename = "";
		String ext = getFileExtLowerCase(filename);
		return ("gif".equals(ext) || "jpg".equals(ext) || "png".equals(ext) || "bmp".equals(ext));
	}

	/**
	 * OCS 날짜형식으로 반환 yyyymmdd -> yyyy-mm-dd
	 * @param dt
	 * @return
	 */
	public static String toOcsDateFormat(String dt) {
		if (dt.length() == 8) {
			return dt.substring(0, 4) + "-" + dt.substring(4, 6) + "-" + dt.substring(6, 8);
		} else {
			return dt;
		}
	}

	public static String toOcsDateFormatParam(String dt, String kindStr) {
		if (dt.length() == 8) {
			return dt.substring(0, 4) + kindStr + dt.substring(4, 6) + kindStr + dt.substring(6, 8);
		} else {
			return dt;
		}
	}

	public static String removeTag(String value) {
		String returnVal = value.replaceAll("(?i)<script", "<s_cript").replaceAll("(?i)<iframe", "<i_frame").replaceAll("(?i)</script", "</s_cript").replaceAll("(?i)</iframe", "</i_frame");
		return returnVal;
	}

	/**
	 * 체크박스 파라메터 체킹후 여러개일경우 "|" 붙여준다
	 * @param Array
	 * @return Value
	 */
	public static String chkBoxCheck(String[] Array) {

		String Value = "";

		if (Array != null) {
			for (int i = 0; i < Array.length; i++) {
				if (!"".equals(Value))
					Value += "|";
				Value += (String) Array[i];
			}
		}
		return Value;
	}

	public static String chkLocation(Object locationObj){
		return chkLocation(CommonUtil.nvl(locationObj));
	}

	public static String chkLocation(String location){
		if(!"".equals(location)){
			String reLocation = getWebUrl(location);
			if(!"".equals(reLocation)){
				return MNG_URI + reLocation;
			}
		}
		return location;
	}

	/**
	 * 문자열을 변환한다.
	 * @param text
	 * @param oldChar
	 * @param newChar
	 * @return
	 */
    public static String replaceAll(String text, String oldChar, String newChar) {
        String newText = text;
        if (text != null) {
            StringBuffer sb = new StringBuffer((int)(text.length() * 1.5));
            int index = 0;
            while ( (index = text.indexOf(oldChar)) > -1) {
                sb.append(text.substring(0, index));
                sb.append(newChar);
                if (index + oldChar.length() < text.length()) {
                    text = text.substring(index + oldChar.length());
                } else {
                    text = "";
                    break;
                }
            }
            sb.append(text);
            newText = sb.toString();

        }
        return newText;
    }

    /**
	 * String -> int
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int convertInteger(String value, int defaultValue) {
		return convertInt(value, defaultValue);
	}

	/**
	 * String -> Integer
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Integer convertInteger(String value, Integer defaultValue) {
        if (value == null) {
            return defaultValue;
        }
		try {
			return new Integer(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

    /**
	 * String -> int
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int convertInt(String value, int defaultValue) {
		return convertInteger(value, new Integer(defaultValue)).intValue();
	}

	/**
	 * 구분자로 구성된 문자열을 문자배열로 변환한다.
	 *
	 * @param str 문자열
	 * @param delimiter 구분자
	 */
	public static String[] toStringArray(String str, String delimiter) {
        String[] result = null;
        if (str != null) {
            Tokenizer t = new Tokenizer(str, delimiter);
            result = new String[t.countTokens()];
            for( int i = 0; t.hasMoreTokens(); i++) {
                result[i] = t.nextToken();
            }
        }
		return result;
	}

	/**
	 * 문자열을 8859_1로 인코딩한다.
	 * @param s 대상 문자열
	 * @param charset
	 * @return
	 */
	public static String decode(String s, String charset) 	{
		if (charset == null || "8859_1".equals(charset)) return s;
		String out = null;
		if (s == null ) return null;
		try {
			out = new String(s.getBytes(charset), "8859_1");
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}

	/**
	 * URLDecode
	 * @param
	 * @param charset
	 * @return
	 */
	public static String URLDecode(String url) 	{
		String result;
		try {
			result = java.net.URLDecoder.decode(url, CHARSET);
		} catch (UnsupportedEncodingException e) {
			result = url;
		}
		return result;
	}


	/**
	 * 나이(만)를 구한다.
	 *
	 * @param fromYear
	 * @param fromMonth
	 * @param fromDate
	 * @param toYear
	 * @param toMonth
	 * @param toDate
	 * @return
	 */
	public static int getAge(int fromYear,int fromMonth, int fromDate, int toYear, int toMonth, int toDate) {
	    int age = 0;
        if (toYear > fromYear) {
            age = toYear - fromYear;
            if (toDate(toYear, fromMonth, fromDate).getTime() > toDate(toYear, toMonth, toDate).getTime()) {
                age--;
            }
        }
        return age;
	}

	/**
	 * 나이(만)를 구한다.
	 *
	 * @param birthYear
	 * @param birthMonth
	 * @param birthDate
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static int getAge(int birthYear, int birthMonth, int birthDate) {
	    Date to = new Date(System.currentTimeMillis());
        return getAge(birthYear, birthMonth, birthDate, to.getYear() +  1900, to.getMonth() + 1,to.getDate()) ;
	}

	/**
	 * 문자열날짜를 Date객체로 반환
	 * @param str 문자열날짜
	 * @param pattern DateFormat
	 * @param defaultDate 디폴트 Date
	 * @return
	 */
	public static Date toDate(String str, String pattern, Date defaultDate) {
	    Date date = defaultDate;
	    try {
		    DateFormat dateFormat = new SimpleDateFormat(pattern, Locale.getDefault());
	        date = dateFormat.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
	    return date;
	}
	/**
	 * 문자열을 Date객체로 반환.
	 *
	 * @param str yyyy-MM-dd HH:mm:ss 형식
	 * @return
	 */
	public static Date toDate(String str) {
	    return toDate(str, "yyyy-MM-dd HH:mm:ss", new Date());
	}

	/**
	 * 문자열을 Date객체로 반환
	 * @param str yyyy-MM-dd HH:mm:ss 형식
	 * @param defaultDate
	 * @return
	 */
	public static Date toDate(String str, Date defaultDate) {
	    return toDate(str, "yyyy-MM-dd HH:mm:ss", defaultDate);
	}


	/**
	 * Date객체로 반환
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
    public static Date toDate(String year, String month, String day) {
        Date date = null;
        try {
            date = toDate(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
        } catch (NumberFormatException e) {
            date = new Date();
        }
        return date;
    }

	/**
	 * 입력받은 데이터를 Date형으로 변환한다.
	 *
	 * @param year 년
	 * @param month 월
	 * @param day 일
	 * @param hour 시
	 * @param minute 분
	 * @return
	 */
	public static Date toDate(int year, int month, int day, int hour, int minute) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month-1, day, hour, minute, 0);
		return calendar.getTime();
	}

	/**
	 * 입력받은 데이터를 Date형으로 변환한다.
	 *
	 * @param year 년
	 * @param month 월
	 * @param day 일
	 * @return
	 */
	public static Date toDate(int year, int month, int day) {
		return toDate(year, month, day, 0, 0);
	}

	/**
	 * 시작일부터 오늘까지의 기간을 구한다.
	 *
	 * @param year 시작한 년
	 * @param month 시작한 월
	 * @param day 시작한 일
	 * @param hour 시작한 시
	 * @param minute 시작한 분
	 * @return 기간의 1/1000초(ms)값
	 */
	public static long getPeriod(int year, int month, int day, int hour, int minute) {
		Calendar meet = Calendar.getInstance();
		meet.set(year, month-1, day, hour, minute);
		return getPeriod(meet.getTime());
	}

	/**
	 * 시작일부터 오늘까지의 기간을 구한다.
	 *
	 * @param year 시작한 년
	 * @param month 시작한 월
	 * @param day 시작한 일
	 * @return 기간의 1/1000초(ms)값
	 */
	public static long getPeriod(int year, int month, int day) {
		return getPeriod(year, month, day, 0, 0);
	}

	/**
	 * 시작일부터 오늘까지의 기간을 구한다.
	 *
	 * @param year 시작한 년
	 * @param month 시작한 월
	 * @param day 시작한 일
	 * @return 기간의 일(day)값
	 */
	public static int getPeriodByDay(int year, int month, int day) {
		return (int)(getPeriod(year, month, day) / (24 * 60 * 60 * 1000));
	}


	/**
	 * 시작일부터 오늘까지의 기간을 구한다.
	 *
	 * @param from 시작일
	 * @return 기간의 1/1000초(ms)
	 */
	public static long getPeriod(Date from) {
		return getPeriod(from, new Date());
	}


	/**
	 * 시작일부터 종료일까지의 기간을 구한다.
	 *
	 * @param from 시작일
	 * @param to 종료일
	 * @return 기간의 1/1000초(ms)
	 */
	public static long getPeriod(Date from, Date to) {
		return to.getTime() - from.getTime();
	}


	/**
	 * 시작일부터 오늘까지의 기간을 일(day)로 반환한다.
	 *
	 * @param from 시작일
	 * @return 기간의 일(day)수
	 */
	public static int getPeriodByDay(Date from) {
		return (int)(getPeriod(from) / (24 * 60 * 60 * 1000));
	}

	/**
	 * 시작일부터 종료일까지의 기간을 일(day)로 반환한다.
	 *
	 * @param from 시작일
	 * @param to 종료일
	 * @return 기간의 일(day)수
	 */
	public static int getPeriodByDay(Date from, Date to) {
		return (int)(getPeriod(from, to) / (24 * 60 * 60 * 1000)); //버그수정
	}

	/**
	 * 특정일의 요일을 반환
	 *
	 * @param inputDate
	 *            yyyyMMdd
	 * @return 1~7 (일~토)
	 */
	public static int getDayOfWeek(String inputDate) {

		DateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		Date myDate;
		try {
			myDate = df.parse(inputDate);
		} catch (ParseException e) {
			return 0;
		}
		Calendar cld = Calendar.getInstance();
		cld.setTime(myDate);

		return cld.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 현재 년을 반환한다.
	 *
	 * @return String representation of current day with  "yyyy".
	 */
	public static String getYear() {
		return getNumberByPattern("yyyy");
	}

	/**
	 * 현재 달을 반환한다.
	 *
	 * @return String representation of current day with  "MM".
	 */
	public static String getMonth() {
		return getNumberByPattern("MM");
	}

	/**
	 * 현재 날을 반환한다.
	 *
	 * @return String representation of current day with  "dd".
	 */
	public static String getDay() {
		return getNumberByPattern("dd");
	}

	public static String getTime(){
		return getNumberByPattern("HHmmssSSS");
	}

	/**
	 * pattern에 의한 날짜나 시간을 int형으로 반환한다.
	 *
	 * @param pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @return String representation of current day and time with  your pattern.
	 */
	public static String getNumberByPattern(String pattern) {
		SimpleDateFormat formatter = new SimpleDateFormat (pattern);
		String dateString = formatter.format(new Date());
		return dateString;
	}

	public static String getNumberByPattern(Date date, String pattern) {
		SimpleDateFormat formatter = new SimpleDateFormat (pattern);
		String dateString = formatter.format(date);
		return dateString;
	}


	/**
	 * 길이를 초과하는 문자열을 길이만큼 자른후 꼬리문자열을 붙인다.
	 *
	 * @param source 원본 문자열
	 * @param length 최대 길이
	 * @param tail 꼬리문자열
	 * @param charset 문자셋
	 * @return 길이만큼 잘라진 문자열
	 */
	public static String crop(String source, int length, String tail, String charset) throws UnsupportedEncodingException {
		if (source == null) return null;
		String result = strCut(source, null, length, 0, true, "...", charset);
		/*String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;

		if ( result.getBytes(charset).length > length) {
		    length = length - tail.length();
			while ( (bLength + 1) <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}*/
		return result;
	}

	/**
	 * 길이를 초과하는 문자열을 길이만큼 자른후 꼬리문자열을 붙인다.
	 *
	 * @param source 원본 문자열
	 * @param length 최대 길이
	 * @param tail 꼬리문자열
	 * @return 길이만큼 잘라진 문자열
	 */
	public static String crop(String source, int length, String tail) {
		if (source == null) return null;
		String result = strCut(source, null, length, 0, true, "...", null);
		/*String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		int resultBytes = result.getBytes().length;
		if (resultBytes > length) {
		    length = length - tail.length();
			while ( (bLength + 1)  <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}*/
		return result;

	}
	/**
	 * 길이를 초과하는 문자열을 길이만큼 자른후 꼬리문자열을 붙인다.
	 * @param source 원본 문자열
	 * @param szKey 시작 위치로 할 키워드
	 * @param length 최대 길이
	 * @param nPrev 키워드 위치에서 이전 포함길이
	 * @param isNotag 태그를없앨것인가
	 * @param tail 꼬리문자열
	 * @param charset 문자셋
	 * @return 길이만큼 잘라진 문자열
	 */
	// 2013,09.30
	// vary 수정
	 public static String strCut(String source, String szKey, int length, int nPrev, boolean isNotag, String tail, String charset){
		 String r_val = source;
		 int oF = 0, oL = 0, rF = 0, rL = 0;
		 int lengthPrev = 0;
		 Pattern p = Pattern.compile("<(/?)([^<>]*)?>", Pattern.CASE_INSENSITIVE); // 태그제거 패턴
		 if(isNotag) {r_val = p.matcher(r_val).replaceAll("");} // 태그 제거
		 r_val = r_val.replaceAll("&amp;", "&");
		 r_val = r_val.replaceAll("(!/|\r|\n|&nbsp;)", ""); // 공백제거

		 try {
		   byte[] bytes = r_val.getBytes(CHARSET); // 바이트로 보관
		   if(szKey != null && !szKey.equals("")) {
		     lengthPrev = (r_val.indexOf(szKey) == -1)? 0: r_val.indexOf(szKey); // 일단 위치찾고
		     lengthPrev = r_val.substring(0, lengthPrev).getBytes("MS949").length; // 위치까지길이를 byte로 다시 구한다
		     lengthPrev = (lengthPrev-nPrev >= 0)? lengthPrev-nPrev:0; // 좀 앞부분부터 가져오도록한다.
		   }

		   // x부터 y길이만큼 잘라낸다. 한글 안 깨지게.
		   int j = 0;
		   if(lengthPrev > 0) while(j < bytes.length) {
		     if((bytes[j] & 0x80) != 0) {
		       oF+=2; rF+=3; if(oF+2 > lengthPrev) {break;} j+=3;
		     } else {if(oF+1 > lengthPrev) {break;} ++oF; ++rF; ++j;}
		   }

		   j = rF;
		   while(j < bytes.length) {
		     if((bytes[j] & 0x80) != 0) {
		       if(oL+2 > length) {break;} oL+=2; rL+=3; j+=3;
		     } else {if(oL+1 > length) {break;} ++oL; ++rL; ++j;}
		   }
		   if(charset != null && charset.length() > 4){// charset 옵션
		 	  r_val = new String(bytes, rF, rL, charset);
		   }else{
		 	  r_val = new String(bytes, rF, rL, CHARSET);
		   }
		   if(tail != null && !"".equals(tail) && rF+rL+3 <= bytes.length) {
		 	  r_val+="...";
		   } // ...을 붙일지말지 옵션
		 } catch(UnsupportedEncodingException e){ e.printStackTrace(); }
		 return r_val;
	}

	/**
		 * String 값을 boolean형으로 변환후 반환한다.
	*/
	public static boolean convertBoolean(String value, boolean defaultValue) {
		return convertBoolean(value, new Boolean(defaultValue)).booleanValue();
	}

	/**
	 * String 값을 boolean형으로 변환후 반환한다.
	 */
	public static boolean convertBoolean(String value, boolean defaultValue, String trueString) {
		return convertBoolean(value, new Boolean(defaultValue), trueString).booleanValue();
	}

	/**
	 * String 값을 Boolean형으로 변환후 반환한다.<p>
	 * 만약 String 값이 yes, true, on, y일때는 true값으로,<p>
	 * no, false, off, n일때는 false값으로 변환된다.<p>
	 * 두 가지 다 해당되지 않은경우는 기본값으로 변환된다.
	 *
	 * @param value 원본 값
	 * @param defaultValue 기본값
	 * @return Boolean 값
	 */
	public static Boolean convertBoolean(String value, Boolean defaultValue) {
		if (value == null) 	{
			return defaultValue;
		} else if (value.equalsIgnoreCase("yes") ||
						value.equalsIgnoreCase("true") ||
						value.equalsIgnoreCase("on") ||
						value.equalsIgnoreCase("y") ) {
			return Boolean.TRUE;
		} else if(value.equalsIgnoreCase("no") ||
						value.equalsIgnoreCase("false") ||
						value.equalsIgnoreCase("off") ||
						value.equalsIgnoreCase("n") ) {
			return Boolean.FALSE;
		} else {
			return defaultValue;
		}
	}

	/**
	 * String -> Boolean
	 * @param value
	 * @param defaultValue
	 * @param trueString
	 * @return
	 */
	public static Boolean convertBoolean(String value, Boolean defaultValue, String trueString) {
		if (value == null) 	{
			return defaultValue;
		} else if (value.equalsIgnoreCase(trueString)) {
			return Boolean.TRUE;
		} else {
			return defaultValue;
		}
	}
	/**
	 * 현재 날짜나 시간을 pattern에 맞추어 반환한다.<p>
	 * 예) String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");
	 *
	 * @param pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @return formatted string representation of current day and time with  your pattern.
	 */
	public static String getFormatString(String pattern) {
		SimpleDateFormat formatter = new SimpleDateFormat (pattern);
		String dateString = formatter.format(new Date());
		return dateString;
	}
	/**
	 * 현재 날짜나 시간을 pattern에 맞추어 반환한다.<p>
	 * 예) String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");
	 *
	 * @param pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @param date
	 * @return
	 */
	public static String getFormatString(String pattern, Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat (pattern);
		String dateString = formatter.format(date);
		return dateString;
	}

	public static String getNowTime(){
		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("hh:mm:ss a", Locale.getDefault());
		String returnStr = dayTime.format(new Date(time));
		return returnStr;
	}

	//list to json string
	public static String listToJsonString(List<?> list){
		JSONArray jsonArr = new JSONArray(list);
		return jsonArr.toString();
	}

	//map to json string
	@SuppressWarnings("rawtypes")
	public static String mapToJsonString(Map map){
		JSONObject jsonObj = new JSONObject(map);
		return jsonObj.toString();
	}

	@SuppressWarnings({ "rawtypes"})
	public static String objectToJsonStringA(Object obj){
		if(obj instanceof List){
			return listToJsonString((List) obj);
		}else if (obj instanceof Map) {
			return mapToJsonString((Map) obj);
		}else{
			return "";
		}
	}

	//get remote addr
	public static String getRemoteAddr(HttpServletRequest request){
		String clientIp = null;
		try {
			clientIp = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			logger.error("", e);
		}
		if("".equals(nvl(clientIp))){
			clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if("".equals(nvl(clientIp))){
		  clientIp = request.getHeader("REMOTE_ADDR");
		}
		if("".equals(nvl(clientIp))){
			clientIp = request.getRemoteAddr();
		}
		return clientIp;
	}

	public static String ReplaceString(String Expression, String Pattern, String Rep) {
		if (Expression == null || Expression.equals(""))
			return "";
		int s = 0;
		int e = 0;
		StringBuffer result = new StringBuffer();
		while ((e = Expression.indexOf(Pattern, s)) >= 0) {
			result.append(Expression.substring(s, e));
			result.append(Rep);
			s = e + Pattern.length();
		}
		result.append(Expression.substring(s));
		return result.toString();
	}

	//특수 문자 변환하기 Decode
	public static String replaceDecodeScriptTag(Object strData) {
		String result = CommonUtil.nvl(strData);
		if ("".equals(result)) {
			return "";
		}
		result = ReplaceString(result, "&amp;", "&");
        result = ReplaceString(result, "&quot;", "\"");
        result = ReplaceString(result, "&apos;", "'");
		return result;
	}

	//특수 문자 변환하기 Encode
	public static String replaceEncodeScriptTag(Object strData) {
		if (strData == null) {
			return null;
		}
		String result = CommonUtil.nvl(strData);
		result = ReplaceString(result, "&", "&amp;");
		result = ReplaceString(result, "\"", "&quot;");
		result = ReplaceString(result, "'", "&apos;");
		result = ReplaceString(result, "<", "&lt;");
		result = ReplaceString(result, ">", "&gt;");
		return result;
	}

	//특수 문자 변환하기 Encode
		public static String replaceEncodeScriptTagForExcel(Object strData) {
			if (strData == null) {
				return null;
			}
			String result = CommonUtil.nvl(strData);
			result = ReplaceString(result, "<br>", "&#10;");
			result = ReplaceString(result, "\"", "&quot;");
			result = ReplaceString(result, "<", "&lt;");
			result = ReplaceString(result, ">", "&gt;");
			return result;
		}

	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent").toUpperCase();
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		}
		/*
		 * IE 10 버전 이하에서는 'MSIE' 문자열을 체크하여 브라우저가 IE인지 체크하였다. 하지만 IE 11 버전부터는
		 * 브라우저 정보에 MSIE라는 문자열이 들어가지 않는다 기존에 IE를 체크하던 로직은 IE 11을 나타내는 'rv:11'
		 * 문자열을 함께 체크하도록 해야 한다.
		 */
		else if (header.indexOf("RV:11.0") > -1) {
			return "ie11";
		} else if (header.indexOf("CHROME") > -1) {
			return "Chrome";
		} else if (header.indexOf("OPERA") > -1) {
			return "Opera";
		} else if (header.indexOf("ANDROID") > -1
				|| header.indexOf("IPHONE") > -1
				|| header.indexOf("IPOD") > -1
				|| header.indexOf("BLACKBERRY") > -1
				|| header.indexOf("WINDOWS CE") > -1
				|| header.indexOf("NOKIA") > -1
				|| header.indexOf("WEBOS") > -1
				|| header.indexOf("OPERA MINI") > -1
				|| header.indexOf("SONYERICSSON") > -1
				|| header.indexOf("OPERA mobi") > -1
				|| header.indexOf("IEMOBILE") > -1
		){
			return "mobile";
		}

		return "Firefox";
	}
	public static String getDisposition(String filename, String browser)
			throws Exception {
		String prefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, CHARSET).replaceAll(
					"\\+", "%20");
		} else if (browser.equals("ie11")) {
			encodedFilename = URLEncoder.encode(filename, CHARSET).replaceAll(
					"\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\""
					+ new String(filename.getBytes(CHARSET), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\""
					+ new String(filename.getBytes(CHARSET), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);

				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, CHARSET));
				} else {
					sb.append(c);
				}
			}

			encodedFilename = sb.toString();
		} else {
			throw new RuntimeException("Not Supported Browser.");
		}

		return prefix + encodedFilename;
	}
	//기준키를 이용해서 두개의 list를 하나로 머지 한다(2개의 list의 map을 기준키로 머지한다.
	public static List<Map<String, Object>> listToListKeyMerge(List<Map<String, Object>> list0, List<Map<String, Object>> list1, String key) {
        if (list0 == null) return list1;
        if (list1 == null) return list0;

        Map<String, Map<String, Object>> map1 = listmapToHashmapMap(list1, key);
        for (Map<String, Object> map : list0) {
        	String tempKey = nvl(map.get(key));
        	if("".equals(tempKey)){
        		continue;
        	}
        	Map<String, Object> tempMap = map1.get(tempKey);
        	if(tempMap != null){
        		map.putAll(tempMap);
        	}
		}
        return list0;
    }
	//List<Map>을 key을 key값으로 하는 HashMap<String, Map>으로 변환
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static HashMap<String, Map<String, Object>> listmapToHashmapMap(List<Map<String, Object>> list, String key){
		HashMap<String, Map<String, Object>> returnmap = new HashMap<String, Map<String, Object>>();
		String keyValue = "";
		for (Map map : list) {//정상 등록 가능한 데이터 리스트 HashMap에 추가
			keyValue = CommonUtil.nvl(map.get(key));
			if(!"".equals(keyValue) && returnmap.get(keyValue) == null){
				returnmap.put(keyValue, map);
			}
			keyValue = "";
		}
		return returnmap;
	}

	//List<Map>을 key1을 key값으로 하는 HashMap<String, HashMap<String, Map>key2를 key값으로 하는HashMap>으로 변환
	@SuppressWarnings("rawtypes")
	public static HashMap<String, HashMap<String, Map>> listmapToHashmapArrayList(List<Map> list, String key1, String key2){
		HashMap<String, HashMap<String, Map>> returnmap = new HashMap<String, HashMap<String, Map>>();
		HashMap<String, Map> tempHashMap = null;
		String keyValue = "";
		for (Map map : list) {//정상 등록 가능한 데이터 리스트 HashMap에 추가
			keyValue = CommonUtil.nvl(map.get(key1));
			if(!"".equals(keyValue)){
				tempHashMap = returnmap.get(keyValue);
				if(tempHashMap == null){
					tempHashMap = new HashMap<String, Map>();
					tempHashMap.put(CommonUtil.nvl(map.get(key2)), map);
					returnmap.put(keyValue, tempHashMap);
				}else{
					tempHashMap.put(CommonUtil.nvl(map.get(key2)), map);
				}
			}
			keyValue = "";
		}
		return returnmap;
	}
	//년월 사이의 달수를 구한다
	public static int getDiffMonth(String fromDate, String toDate) {
		Pattern p = Pattern.compile("[^0-9]");
        Matcher fm = p.matcher(fromDate);
        String startDate = fm.replaceAll("").trim();
        Matcher tm = p.matcher(toDate);
        String endDate = tm.replaceAll("").trim();
		int strtYear = Integer.parseInt(startDate.substring(0,4));
		int strtMonth = Integer.parseInt(startDate.substring(4,6));
		int endYear = Integer.parseInt(endDate.substring(0,4));
		int endMonth = Integer.parseInt(endDate.substring(4,6));
		int month = (endYear - strtYear)* 12 + (endMonth - strtMonth);
		return month;
	}

	/**
	 * BigDecimal null 체크
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static BigDecimal bigDecimalNullCheck(BigDecimal value,String defaultValue){
		BigDecimal returnValue = new BigDecimal(defaultValue);
		if(value != null){
			returnValue = value;
		}
		return returnValue;
	}

	/**
	 * BigDecimal 변수 생성
	 * @param value
	 * @return BigDecimal
	 */
	public static BigDecimal setBigDecimal(int value){
    	BigDecimal returnValue = new BigDecimal(value);
    	return returnValue;
    }

	/**
	 * vo등의 Object를 Map으로 변환 한다. Camel표기법으로 변환된 컬럼이름을 복구한다.
	 * @param obj
	 * @return Map<String, Object>
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	public static Map<String, Object> converObjectToMapUnCasingCamel(Object obj) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		Map<String, Object> newMap = converObjectToMap(obj);
		return CamelCasting.getUnCamelCasting(newMap);
	}

	/**
	 * vo등의 Object를 Map으로 변환 한다.
	 * @param obj
	 * @return Map<String, Object>
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> converObjectToMap(Object obj) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		BeanUtilsBean beanUtilsBean = new BeanUtilsBean();
		return beanUtilsBean.describe(obj);
	}

	/**
	 * Map을 vo등의 Object로 변환 한다. Camel표기법으로 변환 한다.
	 * @param map
	 * @param objClass
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws Exception
	 */
	public static void convertMapToObjectCasingCamel(Map<String, Object> map, Object objClass) throws IllegalAccessException, InvocationTargetException, Exception{
		Map<String, Object> newMap = CamelCasting.getCamelCasting(map);
		convertMapToObject(newMap, objClass);
	}
	/**
	 * Map을 vo등의 Object로 변환 한다.
	 * @param map
	 * @param objClass
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static void convertMapToObject(Map<String, Object> map, Object objClass) throws IllegalAccessException, InvocationTargetException{
		BeanUtils.populate(objClass, map);
	}

	public static String getWebUrl(Object url){
		return getWebUrl(nvlTrim(url));
	}

	public static String getWebUrl(String url){
		return getWebUrl(url, MNG_URI);
	}

	public static String getWebUrl(String url, String rep){
		if(url == null || rep == null) return "";
		String[] nowUrl = url.split(rep);
		int len = nowUrl.length;
		String reUrl = "";
		if(len > 0){
			for (int i = len - 1; i >= 0; i--) {
				reUrl = nowUrl[i];
				if(reUrl != null && !"".equals(reUrl)){
					break;
				}
			}
		}
		return reUrl;
	}

	public static String getWebUrl(String url, String rep, String putStr){
		if(url == null || rep == null) return "";
		String[] nowUrl = url.split(rep);
		int len = nowUrl.length;
		String reUrl = "";
		if(len > 0){
			for (int i = len - 1; i >= 0; i--) {
				reUrl = nowUrl[i];
				if(reUrl != null && !"".equals(reUrl)){
					reUrl = putStr + reUrl;
					break;
				}
			}
		}
		return reUrl;
	}

	public static UnCamelMap<String, Object> mapArrayItemToMapObjectItem(UnCamelMap<String, Object> map){
		UnCamelMap<String, Object> newMap = new UnCamelMap<>();
		Set<String> keys =  map.keySet();
		for (String key : keys) {
			String value = map.getString(key);
			if(!"".equals(value)){
				newMap.put(key, value);
			}
		}
		return newMap;
	}


	public static String getStrArrToFirstStr(Object value){
		if(value instanceof String){
			return CommonUtil.nvl(value);
		}else if(value instanceof String[]){
			String[] values = (String[]) value;
			return values[0];
		}
		return CommonUtil.nvl(value);
	}

	public static String objectToString(Object _value){
		if(_value == null){
			return "";
		}else if(_value instanceof String){
			return CommonUtil.nvl(_value);
		}else if(_value instanceof String[]){
			String[] _values = (String[]) _value;
			return _values[0];
		}else if(_value instanceof LinkedList<?>){
			return CommonUtil.nvl(((LinkedList<?>) _value).get(0));
		}
		return CommonUtil.nvl(_value);
	}

	public static String[] objectToArrayString(Object _value){
		if(_value == null){
			return null;
		}else if(_value instanceof String){
			return new String[]{CommonUtil.nvl(_value)};
		}else if(_value instanceof String[]){
			return (String[]) _value;
		}else if(_value instanceof LinkedList<?>){
			LinkedList<?> linkedList = (LinkedList<?>) _value;
			int cnt = linkedList.size();
			String[] _values = new String[cnt];
			for (int i = 0; i < cnt; i++) {
				_values[i] = CommonUtil.nvl(linkedList.get(i));
			}
			return _values;
		}
		return new String[]{CommonUtil.nvl(_value)};
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
		tmpString = tmpString.replaceAll("<p>", "");
		tmpString = tmpString.replaceAll("</p>", "");
		tmpString = tmpString.replaceAll("<br>", "\n");
		return  tmpString;
	}
}
