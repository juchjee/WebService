package egovframework.waf.taglib.html;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 현재 경로를 통한 문자열 출력.<br>
 * 현재 uri에서 path에 해당하는 url경로가 존재하면
 * script문자열을 출력함
 * @author vary
 *
 */
public class CurrentMenuTag extends DefaultTagSupport {

    /**
     *
     */
    private static final long serialVersionUID = 7324787233959902128L;
    /** url 경로: '|'를 구분해서 다수 입력 가능 */
    private String path;
    /** 해당 url경로가 있는 경우 이 스크립트를 출력 */
    private String script;
    private String elsescript;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());


	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
			path = getParsedValue(path);
            script = getParsedValue(script);

            JspWriter out = super.pageContext.getOut();

            StringBuffer html = new StringBuffer();
            HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();

            html.append("http://").append(request.getServerName());
            int port = request.getServerPort();
            if (port != 80) {
                html.append(":").append(port);
            }

            if(request.getAttribute("requestURI") != null) //.do
            	html.append((String)request.getAttribute("requestURI"));
            else{
            	if(request.getRequestURI() != null){ //.jsp
                	html.append(request.getRequestURI());
            	}
            }
            if(request.getQueryString() != null){
            	html.append("?");
            	html.append(request.getQueryString());
            }

            String uri = html.toString();

            String[] tmp = CommonUtil.toStringArray(path, "|");
            boolean exists = false;
            if(tmp != null){
            	for(int i=0; i<tmp.length; i++){
		            if(tmp[i] != null && uri.indexOf(tmp[i].trim())>=0){
		            	out.print(script);
		            	exists = true;
		            	break;
		            }
            	}
            	out.print("");
            }
            if(elsescript != null && !exists){
            	out.print(elsescript);
            }

		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}


	public void setPath(String path) {
		this.path = path;
	}


	public void setScript(String script) {
		this.script = script;
	}

	public void setElsescript(String elsescript){
		this.elsescript = elsescript;
	}
}
