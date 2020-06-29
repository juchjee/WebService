package egovframework.waf.taglib.html;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * alert 처리
 */
public class AlertTag extends DefaultTagSupport {
	

    private static final long serialVersionUID = -3845824886278697801L;

    private String value;
    private String location;
    private String target;
    private String script;
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
            value = getParsedValue(value);
		    JspWriter out = super.pageContext.getOut();
            
            StringBuffer html = new StringBuffer();
            html.append("<script type=\"text/javascript\">\n");
            html.append("//<![CDATA[\n");
            if (value != null) {
                html.append("alert(\"").append(value).append("\");");
            }
            
            if (location != null) {
            	if(target == null){
            		html.append("window.location.href=\"").append(location).append("\";");
            	}else{
            		html.append(target).append(".location.href=\"").append(location).append("\";");
            	}
            }
            
        	if("back".equals(script)){
        		html.append("history.back()");
        	}

            html.append("//]]>\n");
            html.append("</script><noscript></noscript>\n");
            
			out.print(html.toString());
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}


    /**
     * @param value The value to set.
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     * @param location The value to set.
     */
    public void setLocation(String location) {
        this.location = location;
    }
    
    /**
     * @param target The value to set.
     */
    public void setTarget(String target) {
        this.target = target;
    }
    
    /**
     * @param target The value to set.
     */
    public void setScript(String script) {
        this.script = script;
    }    
    
}
