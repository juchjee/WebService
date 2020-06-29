package egovframework.waf.taglib.html;

import java.net.URLEncoder;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 특정 문자을 다른 문자로 치환하는 태크
 * @author seominho
 *
 */
public class StringReplaceTag extends BodyTagSupport {
    

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private String text;
    private String arg1;
    private String arg2;
    
    private String option;
    

    @SuppressWarnings("deprecation")
	public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if(option != null && "encode".equals(option)){ //URL Encode
            if(text != null){
                try {
                    JspWriter out = getPreviousOut();
                    String outText = text;
                    if(arg1 != null && arg2 != null)
                        outText = outText.replaceAll(arg1, arg2);
                    outText = URLEncoder.encode(outText);
                    out.print(outText);
                } catch (Exception e) {
                    logger.error("", e);
                }
            }
        }else{
            if (text != null && arg1 != null && arg2 != null) {
                try {
                    JspWriter out = getPreviousOut();
                    
                    String outText = text.replaceAll(arg1, arg2);
                    out.print(outText);
                } catch (Exception e) {
                    logger.error("", e);
                }
            }
        }
        return SKIP_BODY;
    }
   
    

    /**
     * @param arg1 The arg1 to set.
     */
    public void setArg1(String arg1) {
        this.arg1 = arg1;
    }

    /**
     * @param arg2 The arg2 to set.
     */
    public void setArg2(String arg2) {
        this.arg2 = arg2;
    }
    
    
    public void setOption(String option){
        this.option = option;
    }

}
