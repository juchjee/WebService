package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * 문자열을 특정 길이로 자름
 * @author vary
 *
 */
public class SubjectTag extends BodyTagSupport {
	
	/**
     * 
     */
    private static final long serialVersionUID = 7869121703685869572L;
    private String text;
	private String length;
	private String tail;
	private String charset;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
   public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if (text != null) {
            try {
	            JspWriter out = getPreviousOut();
	            StringCrop stringCrop = new StringCrop(text, length, tail, charset);      
                String str = stringCrop.buildHtml();
                if (str != null) {
                    int index = str.indexOf("\n");
                    if (index > 0) {
                        str = str.substring(0, index);
                    }
                }
	            out.print(str);
			} catch (Exception e) {
				logger.error("", e);
			}
        }
        return SKIP_BODY;
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
}
