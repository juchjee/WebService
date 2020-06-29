package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;

/**
 * 문자열을 특정 길이로 자름
 * @author vary
 *
 */
public class StringCropTag extends BodyTagSupport {
	
	/**
     * 
     */
    private static final long serialVersionUID = 7106115462083252753L;
    private String text;
	private String length;
	private String tail;
	private String charset;
	private String ignoreXml;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
   public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if (text != null) {
           if (ignoreXml != null && CommonUtil.convertBoolean(ignoreXml, false)) {
                text = ignoreXml(text);
                text = text.replaceAll("&nbsp;", " ");
           }
        	
            try {
	            JspWriter out = getPreviousOut();
	            StringCrop stringCrop = new StringCrop(text, length, tail, charset);      
	            out.print(stringCrop.buildHtml());
			} catch (Exception e) {
				logger.error("", e);
			}
        }
        return SKIP_BODY;
    }
   protected String ignoreXml(String text) {
       StringBuffer result = new StringBuffer();

       int position = 0;
       int bIndex = -1;
       int eIndex = -1;
       String temp = text;
       int textLength = temp.length();
       while (position < textLength) {
           bIndex = temp.indexOf("<", position);
           eIndex = temp.indexOf(">", bIndex);
           
           if (bIndex > -1) {
               
               if (eIndex < 0 || eIndex > textLength) {
                   eIndex = textLength - 1;
               }
               
               result.append(temp.substring(position, bIndex));
               String tag = temp.substring(bIndex, eIndex + 1);

               position = eIndex + 1;
               if (tag.equalsIgnoreCase("<style>")) {
                   String closeTag = getCloseTag(tag);
                   int cIndex = temp.indexOf(closeTag, position);
                   if (cIndex > -1) {
                       position = cIndex + closeTag.length();
                   }
               }

            } else {
                result.append(temp.substring(position));
                position = textLength;
            }
        }

       if (position < textLength) {
           result.append(temp.substring(position));
       }
        
       return result.toString();
   }
   protected String getCloseTag(String openTag) {
       String closeTag = openTag;
       if (openTag != null && openTag.length() > 1) {
           StringBuffer sb = new StringBuffer();
           sb.append("</").append(openTag.substring(1));
           closeTag = sb.toString();
       }
       return closeTag;
   }

    /**
     * @return charset을 리턴합니다.
     */
    public String getCharset() {
        return charset;
    }
    /**
     * @param charset 설정하려는 charset.
     */
    public void setCharset(String charset) {
        this.charset = charset;
    }
    /**
     * @return length을 리턴합니다.
     */
    public String getLength() {
        return length;
    }
    /**
     * @param length 설정하려는 length.
     */
    public void setLength(String length) {
        this.length = length;
    }
    /**
     * @return tail을 리턴합니다.
     */
    public String getTail() {
        return tail;
    }
    /**
     * @param tail 설정하려는 tail.
     */
    public void setTail(String tail) {
        this.tail = tail;
    }
    /**
     * @return text을 리턴합니다.
     */
    public String getText() {
        return text;
    }
    /**
     * @param text 설정하려는 text.
     */
    public void setText(String text) {
        this.text = text;
    }
    
    public void setIgnoreXml(String ignoreXml){
    	this.ignoreXml = ignoreXml;
    }
}
