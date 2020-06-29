package egovframework.cmmn;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;


public class AEScryptWithSaltKey {


	public static SecretKeySpec key = keyInitializer();
	public static Cipher cipher = cipherInitializer();
	private static BASE64Adaptor cBase64;
	
	
	public AEScryptWithSaltKey() throws Exception {

		if( cBase64 == null )
			cBase64 = new BASE64Adaptor();
		if( key == null )
			key = keyInitializer();
	}


	private static SecretKeySpec keyInitializer() {

		try {
			MessageDigest digester = MessageDigest.getInstance("MD5");
			//Final salt key.
			final String SALTKEY = "X4UhiMxRuStpOO6cniy+uz8mOCdHG9W8J7mRlNidikBVgBlHTs3SkUQC6r7+bYUNqqm6IRJ2ShbJaokvmds502-sdfdsgv";
			char[] cSaltKey = SALTKEY.toCharArray();
			for (int i = 0; i < cSaltKey.length; i++) 
			    digester.update((byte)cSaltKey[i]);
			byte[] mbSaltKey = digester.digest();
			return new SecretKeySpec(mbSaltKey, "AES");
		} catch(Exception e) {	e.printStackTrace(); }
		return null;
	}


	private static Cipher cipherInitializer() {
		try {
			return Cipher.getInstance("AES/ECB/PKCS5Padding");
		} catch(Exception e) { e.printStackTrace(); }
		return null;
	}

	
	private static byte[] encodeAES(byte[] in) throws Exception {
	
		cipher.init(Cipher.ENCRYPT_MODE, key);
		return cryptAES(in, cipher);
	}
	
	
	private static byte[] decodeAES(byte[] in) throws Exception {
	
		cipher.init(Cipher.DECRYPT_MODE, key);
		return cryptAES(in, cipher);
	}
	
	
	//AES encode, then BASE64 encode.
	private static byte[] encode(byte[] in) throws Exception {
	
		new AEScryptWithSaltKey();
		byte[] out = encodeAES(in);
		return cBase64.encodeB64(out);
	}
	
	//BASE64 decode, then AES decode.
	private static byte[] decode(byte[] in) throws Exception {
	
		new AEScryptWithSaltKey();
		byte[] out = cBase64.decodeB64(in);
		return decodeAES(out);
	}
	
	/*
	*	Main encode.
	*	Do not throw Exception, instead return null String.
	*/
	public static String encode(String in) {
		try {
			byte[] out = encode(in.getBytes());
			return (new String(out)).trim();
		} catch( Exception e ) { 
			System.err.println("Error! while encoding plain data ["+in+"]\n<"+e.getMessage()+">"); 
		}
		return "";
	}		
	
	/*
	*	Main decode. Return plain data unless in is multiple of 16.
	*/
	public static String decode(String in) {

		byte[] out = null;
		try {
			if( in == null || in.equals("") ) return in;
			if( in.length() < 15 ) return in;
			out = decode(in.getBytes());
		} catch(javax.crypto.IllegalBlockSizeException ibse) {
			return in;
		} catch( Exception e ) {
			System.err.println("Error! while decoding encoded data ["+in+"]\n<"+e.getMessage()+">"); 
			return "";
		}
		return new String(out);
	}

	
	private static byte[] cryptAES(byte[] inBytes, Cipher cipher) throws IOException, GeneralSecurityException {

		byte[] outBytes = cipher.doFinal(inBytes);
		return outBytes;
	}
	

	//Adaptor BASE64 cryptor class.
	class BASE64Adaptor {


	    private byte[] encodeB64(byte[] encodeBytes) {
	
//	        BASE64Encoder base64Encoder = new BASE64Encoder();
//	        ByteArrayInputStream bin = new ByteArrayInputStream(encodeBytes);
//	        ByteArrayOutputStream bout = new ByteArrayOutputStream();
//	        byte[] buf = null;
//	        try{
//	            base64Encoder.encodeBuffer(bin, bout);
//	        } catch(Exception e) {  e.printStackTrace();  }
//	        buf = bout.toByteArray();
	        return null;//buf;
	    }
	
	
	    private byte[] decodeB64(byte[] strDecode) {
//	        
//	        BASE64Decoder base64Decoder = new BASE64Decoder();
//	        ByteArrayInputStream bin = new ByteArrayInputStream(strDecode);
//	        ByteArrayOutputStream bout = new ByteArrayOutputStream();
//	        byte[] buf = null;
//	        try {		
//	            base64Decoder.decodeBuffer(bin, bout);
//	        } catch(Exception e) { e.printStackTrace(); }
//	        buf = bout.toByteArray();
	        return null;//buf;
	    }
	}

}
