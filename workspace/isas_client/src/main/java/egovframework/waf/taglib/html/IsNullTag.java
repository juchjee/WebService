package egovframework.waf.taglib.html;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.MethodKey;

/**
 * 널 체크 확인 태그 
 * @author seominho
 *
 */
public class IsNullTag extends BodyTagSupport {
    
    /**
     * 
     */
    private static final long serialVersionUID = -9148484505405775612L;

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private String value;

    public int doAfterBody() {
        String text = null;
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        try {        
            String str = getParsedValue(value, null);
            if (str == null || str.trim().equals("")) {
                JspWriter out = getPreviousOut();
                out.print(text);
            }
        } catch (Exception e) {
            logger.error("", e);
        }
        return SKIP_BODY;
    }



    /**
     * 입력된 값이 변수이면 그 변수의 값을 반환하고,
     * 그 값이 null이면 해당 이름으로 값을 가져와서 반환하다.
     * 
     * @param name
     * @param value
     * @return
     * @throws Exception
     */
    protected String getParsedValue(String value, String name) throws Exception {
        if(value != null) {
            int index = value.indexOf("${");
            if (index > -1) {
                Object result = null;               
                String varName = value.substring(index + 2, value.lastIndexOf('}'));
                int dotIndex = varName.indexOf('.');
                if (dotIndex > -1) {
                    String varName1 = varName.substring(0, dotIndex);
                    String varName2 = varName.substring(dotIndex+1);
                    if ("param".equalsIgnoreCase(varName1)) {
                        result = super.pageContext.getRequest().getParameter(varName2);
                    } else {
                        Object obj = super.pageContext.getRequest().getAttribute(varName1);
                        if (obj == null) {
                            obj = super.pageContext.getAttribute(varName1);
                        }
                        if (obj != null) {
                            result = MethodKey.getMethodValue(obj, varName2);
                        }
                    }
                } else {
                    result = super.pageContext.getRequest().getAttribute(varName);
                }
                value = (result != null) ? result.toString() : null;                
            }
        } else {
            if (name != null) {
                ServletRequest request = super.pageContext.getRequest();
                value = request.getParameter(name);
                if (value == null) {
                    Object obj = request.getAttribute(name);
                    value = (obj != null) ? String.valueOf(obj) : null;
                }                           
            }
        }
        
        return value;
    }



    /**
     * @param value The value to set.
     */
    public void setValue(String value) {
        this.value = value;
    }

   

}
