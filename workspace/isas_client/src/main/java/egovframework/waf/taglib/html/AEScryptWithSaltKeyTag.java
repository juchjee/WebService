package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.AEScryptWithSaltKey;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * AEScryptWithSaltKey로 인코딩 태그
 */

public class AEScryptWithSaltKeyTag extends DefaultTagSupport {
	

	private static final long serialVersionUID = 1L;
	private String query;
    /** logger */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
            query = getParsedValue(query);

		    JspWriter out = super.pageContext.getOut();
            
            StringBuffer html = new StringBuffer();
            if (query != null) {
                html.append(AEScryptWithSaltKey.encode(query));
            }
            
			out.print(html.toString());
		} catch (Exception e) {
			logger.error("" + e);
		}
		return (SKIP_BODY);
	}


    /**
     * @param query The query to set.
     */
    public void setQuery(String query) {
        this.query = query;
    }






}
