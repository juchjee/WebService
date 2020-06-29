package egovframework.cmmn;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 암호화 표준(AES, Advanced Encryption Standard) 암호화와 복호화 과정에서 동일한 키를 사용하는 대칭 키 알고리즘
 * 
 * @author vary
 *
 */
public class AES256Cipher {
	
	private static final Logger logger = LoggerFactory.getLogger(AES256Cipher.class);
	
	private static final String secretKey = "cellBioSecretKey"; // 32bit
	private static final String IV = secretKey.substring(0, 16); // 16bit
	private static final byte[] keyData = secretKey.getBytes();
	private static final SecretKey secureKey = new SecretKeySpec(keyData, "AES");
	/**
	 * 암호화
	 * @param str
	 * @return
	 */
	public static String aesEncryptCbc(String str) {
		String enStr = "";
		try {
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(IV.getBytes()));
			byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
			enStr = new String(Base64.encodeBase64(encrypted));
		} catch (NoSuchAlgorithmException | NoSuchPaddingException e) {
			logger.error(e.getMessage());
		} catch (InvalidKeyException e) {
			logger.error(e.getMessage());
		} catch (InvalidAlgorithmParameterException e) {
			logger.error(e.getMessage());
		} catch (IllegalBlockSizeException e) {
			logger.error(e.getMessage());
		} catch (BadPaddingException e) {
			logger.error(e.getMessage());
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getMessage());
		}
		return enStr;
	}

	/**
	 * 복호화
	 * @param str
	 * @return
	 */
	public static String aesDecryptCbc(String str) {
		String deStr = "";
		try {
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec(IV.getBytes("UTF-8")));
			byte[] byteStr = Base64.decodeBase64(str.getBytes());
			deStr = new String(c.doFinal(byteStr), "UTF-8");
		} catch (NoSuchAlgorithmException e) {
			logger.error(e.getMessage());
		} catch (NoSuchPaddingException e) {
			logger.error(e.getMessage());
		} catch (InvalidKeyException e) {
			logger.error(e.getMessage());
		} catch (InvalidAlgorithmParameterException e) {
			logger.error(e.getMessage());
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getMessage());
		} catch (IllegalBlockSizeException e) {
			logger.error(e.getMessage());
		} catch (BadPaddingException e) {
			logger.error(e.getMessage());
		}
		return deStr;
	}
}
