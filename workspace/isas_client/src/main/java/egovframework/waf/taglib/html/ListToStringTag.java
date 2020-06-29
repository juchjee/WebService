package egovframework.waf.taglib.html;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;



import egovframework.waf.taglib.DefaultTagSupport;


/**
 * List를 문자열로 바꿔준다.
 */
public class ListToStringTag extends DefaultTagSupport {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private String prefix;
    private String posfix;
	private String delimiter;
    

    private String list;
    
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
            if (list != null) {
                @SuppressWarnings("rawtypes")
				List mList = (List)super.getParsedObject(list);
                if (mList != null && mList.size() > 0) {
                    StringBuffer html = new StringBuffer();
                    html.append(prefix);
                    for (int i = 0; i < mList.size(); i++) {
                        if (i > 0) {
                            html.append(delimiter);
                        }
                        html.append(mList.get(i));
                    }
                    html.append(posfix);
                    
                    JspWriter out = super.pageContext.getOut();
                    out.print(html.toString());
                }
            }
		
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}


    /**
     * @param delimiter The delimiter to set.
     */
    public void setDelimiter(String delimiter) {
        this.delimiter = delimiter;
    }


    /**
     * @param list The list to set.
     */
    public void setList(String list) {
        this.list = list;
    }


    /**
     * @param posfix The posfix to set.
     */
    public void setPosfix(String posfix) {
        this.posfix = posfix;
    }


    /**
     * @param prefix The prefix to set.
     */
    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }
    
    
}
