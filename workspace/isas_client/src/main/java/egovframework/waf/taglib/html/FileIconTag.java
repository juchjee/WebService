package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 파일명에 따라 해당 아이콘을 출력함.
 * @author vary
 *
 */
public class FileIconTag extends DefaultTagSupport {
	
	private static final long serialVersionUID = -4876609788065347319L;
	
	/** logger */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private String fileName;
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}

	public int doEndTag() throws JspException {
		try {
			JspWriter out = super.pageContext.getOut();
			String html = "";
			fileName = getParsedValue(fileName);
            if(!isNull(fileName)){
            	if(fileName.toLowerCase().endsWith(".doc")){
            		html = "icoWord.gif";
            	}else if(fileName.toLowerCase().endsWith(".hwp")){
            		html = "icoHwp.gif";
            	}else if(fileName.toLowerCase().endsWith(".pdf")){
            		html = "icoPdf.gif";
            	}else if(fileName.toLowerCase().endsWith(".ppt")||fileName.toLowerCase().endsWith(".pptx")){
            		html = "icoPpt.gif";
            	}else if(fileName.toLowerCase().endsWith(".xls")){
            		html = "icoExcel.gif";
            	}else {
            		html = "icoAddFile.gif";
            	}
            }
            if(!"".equals(html)){
            	html = "<img src='/images/common/ico/"+html+"' align='absmiddle' border='0' alt='다운로드' title='다운로드'>";
            }
            
            out.print(html);
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}

	public static boolean isNull(String str) {
        return (str == null || str.trim().equals(""));
    }
	
    /**
     * @param fileName
     */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    
}


