package egovframework.waf.taglib.html;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import egovframework.cmmn.util.CommonUtil;


/**
 * 특정 조건(url포함)에서 매뉴보여주기
 * @author ktlee
 *
 */
public class ShowMenuTag extends BodyTagSupport {


    //protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
	 *
	 */
	private static final long serialVersionUID = 2211331435086813198L;
	/**
	 *
	 */
	private String text;
    private String path;

    public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if (text != null && path != null) {
            try {
            	JspWriter out = getPreviousOut();

            	HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();

            	StringBuffer html = new StringBuffer();
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
    		            	exists = true;
    		            	break;
    		            }
                	}
                }
                if(exists){
                	out.print(text);
                }

            } catch (Exception e) {
            	e.printStackTrace();
    			System.out.println("TAG : " + e.toString());
            }
        }
        return SKIP_BODY;
    }



    /**
     * '|'로 구분해서 포함될 url을 다수 기입
     * @param path
     */
    public void setPath(String path) {
        this.path = path;
    }



}
