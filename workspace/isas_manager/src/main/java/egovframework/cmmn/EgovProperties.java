package egovframework.cmmn;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;

/**
 * properties값들을 파일로부터 읽어와 정적변수로 로드시켜주는 클래스로
 *   문자열 정보 기준으로 사용할 전역변수를 시스템 재시작으로 반영할 수 있도록 한다.
 * @author vary
 *
 */
public class EgovProperties{

	/**
	 * 파일구분자
	 */
	public static final String FILE_SEPARATOR = System.getProperty("file.separator");
	
	/**
	 * 프로퍼티값 로드시 에러발생하면 반환되는 에러문자열
	 */
	public static final String ERR_CODE = " EXCEPTION OCCURRED ";
	public static final String ERR_CODE_FNFE = " EXCEPTION(FileNotFound) OCCURRED ";
	public static final String ERR_CODE_IOE = " EXCEPTION(IO) OCCURRED ";
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovProperties.class);

	//프로퍼티 파일의 물리적 위치
    public static final String RELATIVE_PATH_PREFIX = EgovProperties.class.getResource("").getPath()
    + FILE_SEPARATOR + ".." + FILE_SEPARATOR;

    public static final String PROPERTIES_FILE_URI = RELATIVE_PATH_PREFIX + "egovProps" + FILE_SEPARATOR;

    public static final Map<String, Properties> Map_PROPS = new HashMap<String, Properties>();
    static{
    	Map_PROPS.put("GLOBALS_PROPS", new Properties());
    	FileInputStream fis = null;
		try{
			fis  = new FileInputStream(PROPERTIES_FILE_URI + "globals.properties");
			Map_PROPS.get("GLOBALS_PROPS").load(new BufferedInputStream(fis));
		}catch(FileNotFoundException fne){
			LOGGER.error(ERR_CODE_FNFE, fne);
		}catch(IOException ioe){
			LOGGER.error(ERR_CODE_IOE,ioe);
		}catch(Exception e){
			LOGGER.error(ERR_CODE,e);
		}finally{
			try {
				if (fis != null) fis.close();
			} catch (Exception ex) {
				LOGGER.error("Exception ", ex);
			}
		}
		Map_PROPS.put("SITE_PROPS", new Properties());
		try{
			fis  = new FileInputStream(PROPERTIES_FILE_URI + "site.properties");
			Map_PROPS.get("SITE_PROPS").load(new BufferedInputStream(fis));
		}catch(FileNotFoundException fne){
			LOGGER.error(ERR_CODE_FNFE, fne);
		}catch(IOException ioe){
			LOGGER.error(ERR_CODE_IOE,ioe);
		}catch(Exception e){
			LOGGER.error(ERR_CODE,e);
		}finally{
			try {
				if (fis != null) fis.close();
			} catch (Exception ex) {
				LOGGER.error("Exception ", ex);
			}
		}
    };

	/**
	 * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다(Globals Property 전용)
	 * @param keyName String
	 * @return String
	*/
	public static String getGlobalsProperty(String keyName){
		String value = "";
		try{
			value = Map_PROPS.get("GLOBALS_PROPS").getProperty(keyName).trim();
		}catch(Exception e){
			LOGGER.error("Exception GLOBALS_PROPS GET", e);
		}
		return value;
	}

	/**
	 * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다(Site Property 전용)
	 * @param keyName String
	 * @return String
	*/
	public static String getSiteProperty(String keyName){
		String value = "";
		try{
			value = Map_PROPS.get("SITE_PROPS").getProperty(keyName).trim();
		}catch(Exception e){
			LOGGER.error("Exception SITE_PROPS GET", e);
		}
		return value;
	}

	public static int getSitePropertyInt(String keyName){
		int reInt = 0;
		try{
			reInt = CommonUtil.nvlInt(Map_PROPS.get("SITE_PROPS").getProperty(keyName));
		}catch(Exception e){
			LOGGER.error("Exception SITE_PROPS GET", e);
		}
		return reInt;
	}

	/**
	 * 주어진 파일에서 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 상대 경로값을 절대 경로값으로 반환한다
	 * @param fileName String
	 * @param key String
	 * @return String
	 */
	public static String getPathProperty(String fileName, String key){
		String value = "";
		Properties props = Map_PROPS.get(fileName);
		if(props == null){
			props = new Properties();
			Map_PROPS.put(fileName, props);
			FileInputStream fis = null;
			try{
				props = new Properties();
				fis = new FileInputStream(PROPERTIES_FILE_URI + fileName);
				props.load(new BufferedInputStream(fis));
			}catch(FileNotFoundException fne){
				LOGGER.error(ERR_CODE_FNFE + " " + fileName, fne);
			}catch(IOException ioe){
				LOGGER.error(ERR_CODE_IOE + " " + fileName,ioe);
			}catch(Exception e){
				LOGGER.error(ERR_CODE + " " + fileName,e);
			}finally{
				try {
					if (fis != null) fis.close();
				} catch (Exception ex) {
					LOGGER.error("BufferedInputStream Close Exception ", ex);
				}
			}
		}
		try{
			value = props.getProperty(key).trim();
		}catch(Exception e){
			LOGGER.error("Exception " + fileName + " GET", e);
		}
		return value;
	}
}

