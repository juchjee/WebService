package egovframework.waf.taglib;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;

public class ContentPagingTagXp extends DefaultTagSupport {

	private static final long serialVersionUID = 1L;

	/** logger */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    private String uri;
    private String parameters;
    private String preSeqNo;
    private String nextSeqNo;

    public void setUri(String uri) {
        this.uri = uri;
    }

    public void setParameters(String parameters) {
        this.parameters = parameters;
    }

    public void setPreSeqNo(String preSeqNo){
    	this.preSeqNo = preSeqNo;
    }

    public void setNextSeqNo(String nextSeqNo){
    	this.nextSeqNo = nextSeqNo;
    }

    public int doStartTag() throws JspException {
        return (SKIP_BODY);
    }

    //
    private boolean isEmpty(String s){
    	return s==null || "".equals(s) ? true : false;
    }

    public int doEndTag() throws JspException {
        try {
            HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
            /*
             * parameters 값에서 &를 &amp;로 바꾼다.
             */
            if (parameters == null) {
                Object objParam = request.getAttribute("parameters");
                parameters = (objParam != null) ? String.valueOf(objParam) : "";
            } else {
                parameters = getParsedValue(parameters);
            }
            if(parameters != null){
            	parameters = CommonUtil.replaceAll(parameters, "&", "&amp;");
            } else {
            	parameters = "";
            }

            int previousSequenceNumber = CommonUtil.convertInt(getParsedValue(this.preSeqNo, "preSeqNo"), 0);
            int nextSequenceNumber = CommonUtil.convertInt(getParsedValue(this.nextSeqNo, "nextSeqNo"), 0);

            StringBuffer html = new StringBuffer();

            if (isEmpty(uri)) {
            	if(request.getAttribute("requestURI") != null) //.do
                	uri = (String)request.getAttribute("requestURI");
                else{
                    uri = request.getRequestURI();
                }
            }

            //html.append("<div class='pageNum'>\n");

            // 다음
            if (nextSequenceNumber!=0) {
        		html.append("<a href=\"").append(uri).append("?SEQ_NO=").append(nextSequenceNumber).append(parameters).append("\" class='menu'>");
        		html.append("다음</a> ");
            }

            // 이전
            if (previousSequenceNumber!=0) {
            	html.append(" <a href=\"").append(uri).append("?SEQ_NO=").append(previousSequenceNumber).append(parameters).append("\" class='menu'>");
            	html.append("이전</a>");
            }

            JspWriter out = super.pageContext.getOut();
            out.print(html.toString());
        } catch (Exception e) {
        	logger.error("", e);
        }
        return (SKIP_BODY);
    }


}
