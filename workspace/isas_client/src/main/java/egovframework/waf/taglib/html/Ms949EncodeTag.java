package egovframework.waf.taglib.html;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * Ms949 형식으로 인코딩 태그
 * @author seominho
 *
 */
public class Ms949EncodeTag extends DefaultTagSupport {
	

    private static final long serialVersionUID = -1552762739382857473L;
    private String query;
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
                html.append(java.net.URLEncoder.encode(query, "utf-8"));
            }
            
			out.print(html.toString());
		} catch (Exception e) {
			logger.error("", e);
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
