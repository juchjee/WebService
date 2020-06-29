package egovframework.waf.taglib.html;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.HtmlConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 문자열을 특정 길이로 자름
 * @author vary
 *
 */
public class StringCrop implements HtmlConstants {
    
    private String text;
    private int length;
    private String tail;
    private String charset;
    
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
    public StringCrop(String text, String length, String tail, String charset) {
		this.text = text;
		this.length = CommonUtil.convertInt(length, 0);
		this.tail = (tail != null) ? tail : "";
		this.charset = charset;
    }


	public String buildHtml() {
		String html = null;
		try {
			if (length > 0) {
			    if (charset != null) {
			        html = CommonUtil.crop(text, length, tail, charset);    
			    } else {
			        html = CommonUtil.crop(text, length, tail);			        
			    }
			} else {
			    if (charset != null) {
			        html = CommonUtil.decode(text, charset);
			    } else {
			        html = text;
			    }
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		
		
		return html;
	}

}
