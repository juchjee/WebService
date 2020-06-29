package egovframework.waf.taglib.html;

import java.net.URLEncoder;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.waf.taglib.DefaultTagSupport;

/**
 * alert 처리
 */
public class UrlEncodingTag extends DefaultTagSupport {
	

    private static final long serialVersionUID = -3845824886278697801L;

    private String value;
	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}


	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	@SuppressWarnings("deprecation")
	public int doEndTag() throws JspException {
		try {
            value = URLEncoder.encode(value);
		    JspWriter out = super.pageContext.getOut();
		    out.print(value.toString());
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}


}
