package egovframework.cmmn.util;

import java.io.FileNotFoundException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import devpia.dextupload.FileDownload;
import egovframework.cmmn.IConstants;
import egovframework.rte.psl.dataaccess.util.CamelMap;

/**
 * 데이터 입출력용 유틸리티 클래스
 */
public class FileDownLoad implements IConstants{

	protected static final Logger logger = LoggerFactory.getLogger(FileDownLoad.class);

	private FileDownload down;
	private String userAgent;

	public FileDownLoad(HttpServletRequest request, HttpServletResponse response) {
		userAgent = request.getHeader("User-Agent").toUpperCase();
		down = new FileDownload(request, response, CHARSET);
	}

	public void runFileDownLoad(CamelMap<String, Object> attchMap) throws Exception{
		//ATTCH_FILE_NM, ATTCH_ABSOLUTE_PATH, ATTCH_REAL_ABSOLUTE_PATH
		String attchFileNm = "";
		String attchRealAbsolutePath = CommonUtil.nvl(CommonUtil.nvl(attchMap.getString("attchRealAbsolutePath"), attchMap.getString("attchAbsolutePath")));
		if(!"".equals(attchRealAbsolutePath)){
			if (userAgent.indexOf("TRIDENT") != -1 || userAgent.indexOf("MSIE") != -1 || userAgent.indexOf("EDGE") != -1) {//IE
				attchFileNm = URLEncoder.encode(attchMap.getString("attchFileNm"),	"UTF-8");
			}else{
				attchFileNm = new String(attchMap.getString("attchFileNm").replaceAll("%", "").getBytes(CHARSET), "ISO-8859-1");
			}
			down.Download(attchRealAbsolutePath, attchFileNm, true, true);
		}else{
			throw new FileNotFoundException();
		}
	}

}
