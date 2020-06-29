package com.inicis.std.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

@SuppressWarnings({ "unused", "rawtypes", "unchecked" })
public class ParseUtil {
	private static final String AND = "&";
	private static final String EQUALS = "=";

	public static Map<String, String> parseStringToMap(String str) throws Exception {
		return parseStringToMap(str, "&", "=");
	}

	public static Map<String, String> parseStringToMap(String str, String and) throws Exception {
		return parseStringToMap(str, and, "=");
	}

	public static Map<String, String> parseStringToMap(String str, String and, String equals) throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(str, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();
				hash.put(temp.substring(0, temp.indexOf(equals)), temp.substring(temp.indexOf(equals) + 1));
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		return hash;
	}

	public static Map<String, String> parseStringToMapUrlDecode(String str) throws Exception {
		return parseStringToMapUrlDecode(str, "&", "=");
	}

	public static Map<String, String> parseStringToMapUrlDecode(String str, String and) throws Exception {
		return parseStringToMapUrlDecode(str, and, "=");
	}

	public static Map<String, String> parseStringToMapUrlDecode(String str, String and, String equals)
			throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(str, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();
				hash.put(temp.substring(0, temp.indexOf(equals)),
						URLDecoder.decode(temp.substring(temp.indexOf(equals) + 1), "UTF-8"));
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		return hash;
	}

	public static void parseStringToBean(Object obj, String str) throws Exception {
		parseStringToBean(obj, str, "&", "=");
	}

	public static void parseStringToBean(Object obj, String str, String and) throws Exception {
		parseStringToBean(obj, str, and, "=");
	}

	public static void parseStringToBean(Object obj, String str, String and, String equals) throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(str, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();
				hash.put(temp.substring(0, temp.indexOf(equals)), temp.substring(temp.indexOf(equals) + 1));
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		BeanUtils.populate(obj, hash);
	}

	public static String parseBeanToString(Object obj) throws Exception {
		return parseBeanToString(obj, "&", "=");
	}

	public static String parseBeanToString(Object obj, String and) throws Exception {
		return parseBeanToString(obj, and, "=");
	}

	public static String parseBeanToString(Object obj, String and, String equals) throws Exception {
		return parseMapToString(BeanUtil.beanToMap(obj), and, equals);
	}

	public static String parseMapToString(Map<String, String> parameters) throws Exception {
		return parseMapToString(parameters, "&", "=");
	}

	public static String parseMapToString(Map<String, String> parameters, String and) throws Exception {
		return parseMapToString(parameters, and, "&");
	}

	public static String parseMapToString(Map<String, String> parameters, String and, String equals) throws Exception {
		StringBuffer serializeString = new StringBuffer("");

		Map sortedParamMap = new TreeMap();
		sortedParamMap.putAll(parameters);
		Iterator pairs = sortedParamMap.entrySet().iterator();
		while (pairs.hasNext()) {
			Map.Entry pair = (Map.Entry) pairs.next();

			if ("class".equals(pair.getKey()))

			{
				continue;
			}

			serializeString.append((String) pair.getKey());
			serializeString.append(equals);

			serializeString.append(StringUtils.defaultString((String) pair.getValue()));

			if (!(pairs.hasNext()))
				continue;
			serializeString.append(and);
		}

		return serializeString.toString();
	}

	public static String parseBeanToStringByUrlEncode(Object obj) throws Exception {
		return parseBeanToStringByUrlEncode(obj, "&", "=");
	}

	public static String parseBeanToStringByUrlEncode(Object obj, String and) throws Exception {
		return parseBeanToStringByUrlEncode(obj, and, "=");
	}

	public static String parseBeanToStringByUrlEncode(Object obj, String and, String equals) throws Exception {
		return parseMapToStringByUrlEncode(BeanUtil.beanToMap(obj), and, equals);
	}

	public static String parseMapToStringByUrlEncode(Map<String, String> parameters) throws Exception {
		return parseMapToStringByUrlEncode(parameters, "&", "=");
	}

	public static String parseMapToStringByUrlEncode(Map<String, String> parameters, String and) throws Exception {
		return parseMapToStringByUrlEncode(parameters, and, "=");
	}

	public static String parseMapToStringByUrlEncode(Map<String, String> parameters, String and, String equals)
			throws Exception {
		StringBuffer serializeString = new StringBuffer("");

		Map sortedParamMap = new TreeMap();
		sortedParamMap.putAll(parameters);
		Iterator pairs = sortedParamMap.entrySet().iterator();
		while (pairs.hasNext()) {
			Map.Entry pair = (Map.Entry) pairs.next();

			if ("class".equals(pair.getKey()))

			{
				continue;
			}

			serializeString.append((String) pair.getKey());
			serializeString.append(equals);
			try {
				serializeString.append(URLEncoder.encode((String) pair.getValue(), "UTF-8"));
			} catch (Exception localException) {
			}
			if (!(pairs.hasNext()))
				continue;
			serializeString.append(and);
		}

		return serializeString.toString();
	}

	public static String removeEmpty(String parameters) throws Exception {
		return removeEmpty(parameters, "&", "=");
	}

	public static String removeEmpty(String parameters, String and) throws Exception {
		return removeEmpty(parameters, and, "=");
	}

	public static String removeEmpty(String parameters, String and, String equals) throws Exception {
		Map hash = new Hashtable();
		StringTokenizer token = new StringTokenizer(parameters, and);
		String temp = "";

		while (token.hasMoreElements()) {
			try {
				temp = token.nextToken();

				if (!("".equals(StringUtils.defaultString(temp.substring(temp.indexOf(equals) + 1)))))
					hash.put(temp.substring(0, temp.indexOf(equals)), temp.substring(temp.indexOf(equals) + 1));
			} catch (IndexOutOfBoundsException localIndexOutOfBoundsException) {
			}
		}
		parameters = parseMapToString(hash, and, equals);

		return parameters;
	}

	public static Map<String, String> removeEmpty(Map<String, String> parameters) {
		Set<String> set = parameters.keySet();

		for (String key : set) {
			if ("".equals(StringUtils.defaultString((String) parameters.get(key)))) {
				parameters.remove(key);
			}
		}

		return parameters;
	}
}