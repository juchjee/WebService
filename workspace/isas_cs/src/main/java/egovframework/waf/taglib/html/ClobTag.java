package egovframework.waf.taglib.html;



import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.SQLException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.waf.taglib.DefaultTagSupport;

/**
 * Clob
 * 사용방법: 	<c:set var='clob' value='${eo.C}'/> <html:clob field='${clob}'/>
 * @author vary
 *
 */
public class ClobTag extends DefaultTagSupport {
	
	private static final long serialVersionUID = -3107700265559287056L;

	private String field;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
		    JspWriter out = super.pageContext.getOut();
            StringBuffer html = new StringBuffer();
        	Object obj = getParsedObject(field);
            //logger.info(obj);
        	if(obj != null){
        		Clob clob = (Clob)obj;
        		html.append(getString(clob.getCharacterStream()));
        	}
            
			out.print(html.toString());
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}

	protected String getString(Reader reader) throws SQLException {
        String result = null;
        if (reader != null) {
            StringBuffer sb = new StringBuffer();
            char[] buf = new char[1024];
            int read;
            try {
                while ((read = reader.read(buf, 0, 1024)) != -1) {
                    sb.append(buf, 0, read);
                }
            } catch (IOException e) {
                logger.error("", e);
                throw new SQLException(e.getMessage());
            } finally {
                if (reader != null) {
                    try { reader.close(); } catch(IOException ie) {}
                }
            }
            result = sb.toString();
        } 
        return result;
    }
	


    /**
     * 
     * @param value
     */
    public void setField(String value) {
    	this.field = value;
    }

}
