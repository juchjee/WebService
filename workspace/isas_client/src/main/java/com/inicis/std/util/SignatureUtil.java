package com.inicis.std.util;

import java.security.MessageDigest;
import java.security.SignatureException;
import java.util.Calendar;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SignatureUtil {
	protected static final Logger log = LoggerFactory.getLogger(SignatureUtil.class);

	protected static final String UTF_8_Encoding = "UTF-8";
	public static final String SIGNATURE_KEYNAME = "signKey";
	public static final String HMAC_SHA1_ALGORITHM = "HmacSHA1";
	public static final String HMAC_SHA256_ALGORITHM = "HmacSHA256";
	public static final String NewLine = "\n";
	public static final String EmptyUriPath = "/";
	public static final String Equals = "=";
	public static final String And = "&";

	public static String getTimestamp() {
		Calendar cal = Calendar.getInstance();
		return Long.toString(cal.getTimeInMillis());
	}

	public static String makeSignature(Map<String, String> parameters) throws Exception {
		if ((parameters == null) || (parameters.isEmpty())) {
			throw new RuntimeException("Parameters can not be empty.");
		}
		String parametersString = calculateString(parameters);
		log.info("signParam : " + parametersString);
		String signature = hash(parametersString, "SHA-256");
		log.info("signature : " + signature);
		return signature;
	}

	public static String hash(String data, String algorithm) throws Exception {
		MessageDigest md = MessageDigest.getInstance(algorithm);
		md.update(data.getBytes("UTF-8"));
		byte[] hashbytes = md.digest();
		StringBuilder sbuilder = new StringBuilder();
		for (int i = 0; i < hashbytes.length; ++i)
		{
			sbuilder.append(String.format("%02x", new Object[] { Integer.valueOf(hashbytes[i] & 0xFF) }));
		}
		return sbuilder.toString();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static String calculateString(Map<String, String> parameters) throws SignatureException {
		StringBuffer stringToSign = new StringBuffer("");
		Map sortedParamMap = new TreeMap();
		sortedParamMap.putAll(parameters);
		Iterator pairs = sortedParamMap.entrySet().iterator();
		while (pairs.hasNext()) {
			Map.Entry pair = (Map.Entry) pairs.next();
			stringToSign.append(((String) pair.getKey()).trim());
			stringToSign.append("=");
			stringToSign.append(((String) pair.getValue()).trim());
			if (!(pairs.hasNext()))
				continue;
			stringToSign.append("&");
		}
		return stringToSign.toString();
	}
}