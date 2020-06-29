package egovframework.waf.taglib.html;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.HtmlConstants;

/**
 * Html Clob 문자열 처리 태그
 */
public class HtmlCrop implements HtmlConstants {
    
    private String text;
    private int length;
    private String tail;
    private String charset;
    
	private int remain;
    
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
    public HtmlCrop(String text, String length, String tail, String charset) {
		this.text = text;
		this.length = CommonUtil.convertInt(length, 0);
		this.tail = (tail != null) ? tail : "";
		this.charset = charset;
		
		this.remain = this.length;
    }


	public String buildHtml() {
		String html = null;
		try {
			if (length > 0) {
		        html = htmlcrop(text, tail);			        
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


	
	public String htmlcrop(String str, String tail) {
		StringBuffer result = new StringBuffer();

		int position = 0;
		int bIndex = -1;
		int eIndex = -1;
		String temp = str;
		
		while (position < temp.length()) {
			bIndex = temp.indexOf("<");
			eIndex = temp.indexOf(">", bIndex);
			
			if (bIndex > -1) {
				if (remain > 0) {
					result.append(crop(temp.substring(0, bIndex), remain, tail));
				}
				if (bIndex < eIndex) {
					position = eIndex + 1;
					result.append(temp.substring(bIndex, position));
					temp = temp.substring(position);
				} else {
					if (remain > 0) {
						result.append(crop(temp, remain, tail));
						temp = "";
					}
				}	
			} else {
				if (remain > 0) {
					result.append(crop(temp, remain, tail));
						temp = "";
				}
				position = temp.length();
			}
		}

		if (remain > 0) {
			result.append(crop(temp, remain, tail));
		}
		
		return result.toString();
	}
	

	public String crop(String source, int length, String tail) {
		if (source == null) return "";
		
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes().length > length) {
			while ( (bLength + 1)  < length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
			
		}
		remain = remain - result.length();
		return result;
		
	}
}
