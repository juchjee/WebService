package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class XssTag extends BodyTagSupport {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private String text;
    

    public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if (text != null) {
            try {
                JspWriter out = getPreviousOut();
                
                String outText = text.
                	replaceAll("(?i)<script", "<s_cript").
                	replaceAll("(?i)<iframe", "<i_frame").
                	replaceAll("(?i)</script", "</s_cript").
                	replaceAll("(?i)</iframe", "</i_frame")
                	;
                out.print(outText);
            } catch (Exception e) {
                logger.error("", e);
            }
        }
        return SKIP_BODY;
    }
   
    

}
