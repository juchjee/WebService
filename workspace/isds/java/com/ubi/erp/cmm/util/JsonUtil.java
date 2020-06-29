package com.ubi.erp.cmm.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class JsonUtil {
	private static Gson parseGson;

	private JsonUtil() {
		throw new AssertionError("Can not create Instance!!");
	};
	
	public static String parseToString(Object svo) {
		return getParseInstance().toJson(svo);
	};

	private static Gson getParseInstance() {
		if (parseGson == null) {
			GsonBuilder gb = new GsonBuilder();
			parseGson = gb.create();
		}
		return parseGson;
	};

}
