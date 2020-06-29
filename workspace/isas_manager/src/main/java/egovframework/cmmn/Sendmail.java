package egovframework.cmmn;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

@SuppressWarnings("restriction")
public class Sendmail implements IConstants {

	/**
	 * nullcheck
	 * @param str, Defaultvalue
	 * @return
	 */

	public static String nullcheck(String str, String Defaultvalue) throws Exception {
		String ReturnDefault = "";
		if (str == null) {
			ReturnDefault = Defaultvalue;
		} else if (str == "") {
			ReturnDefault = Defaultvalue;
		} else {
			ReturnDefault = str;
		}
		return ReturnDefault;
	}

	/**
	 * BASE64 Encoder
	 * @param str
	 * @return
	 */
	public static String base64Encode(String str) throws java.io.IOException {
		BASE64Encoder encoder = new BASE64Encoder();
		byte[] strByte = str.getBytes();
		String result = encoder.encode(strByte);
		return result;
	}

	/**
	 * BASE64 Decoder
	 * @param str
	 * @return
	 */
	public static String base64Decode(String str) throws java.io.IOException {
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] strByte = decoder.decodeBuffer(str);
		String result = new String(strByte);
		return result;
	}

}
