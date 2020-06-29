package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Html Clob 문자열 처리 태그
 * @author seominho
 *
 */
public class HtmlCropTag extends BodyTagSupport {
	
	/**
     * 
     */
    private static final long serialVersionUID = -2196192683103719268L;
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
	            HtmlCrop stringCrop = new HtmlCrop(text, length, tail, charset);      
	            out.print(stringCrop.buildHtml());
			} catch (Exception e) {
				logger.error("", e);
			}
        }
        return SKIP_BODY;
    }

    /**
     * @param charset 설정하려는 charset.
     */
    public void setCharset(String charset) {
        this.charset = charset;
    }

    /**
     * @param length 설정하려는 length.
     */
    public void setLength(String length) {
        this.length = length;
    }
    /**
     * @param tail 설정하려는 tail.
     */
    public void setTail(String tail) {
        this.tail = tail;
    }
}
