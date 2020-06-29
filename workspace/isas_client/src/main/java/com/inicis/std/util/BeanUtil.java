package com.inicis.std.util;

import java.lang.reflect.InvocationTargetException;
import java.util.Map;
import org.apache.commons.beanutils.BeanUtils;

public final class BeanUtil {
	@SuppressWarnings("rawtypes")
	public static Map beanToMap(Object obj)
			throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		if (obj instanceof Map) {
			return ((Map) obj);
		}
		Map map = BeanUtils.describe(obj);
		map.remove("class");
		return map;
	}
}