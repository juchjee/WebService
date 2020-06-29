package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * Ms949 형식으로 인코딩 태그
 * @author seominho
 *
 */
public class VisualViewerTag extends DefaultTagSupport {
	

    private static final long serialVersionUID = -1552762739382857473L;
    private String src;
    //private String fileNm;
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
			src = getParsedValue(src);
		    JspWriter out = super.pageContext.getOut();
            StringBuffer html = new StringBuffer();
            if (src != null) {
            	String ext = CommonUtil.getFileExt(src);
            	//플래시 파일일경우
            	if("swf".equals(ext)){
            		 html.append("<p id=\"subVisual\"></p>\n");
            		 html.append("<script type=\"text/javascript\">\n");
            		 html.append("//<![CDATA[ \n");
            		 html.append("embedSWF(\"" + src + "\", \"subVisual\", \"700\", \"100\", \"transparent\", \"subVisualObject\");\n"); 
            		 html.append("//]]>\n");
            		 html.append("</script><noscript></noscript>\n");
            	}else{
            		html.append("<img src=\""+src+"\" alt=\"이미지\" />\n");
            	}

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
    public void setSrc(String src) {
        this.src = src;
    }
    /*
    /**
     * @param query The query to set.
     */
    /*
    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }
    */
    




}
