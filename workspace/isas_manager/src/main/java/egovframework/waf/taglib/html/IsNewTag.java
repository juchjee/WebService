package egovframework.waf.taglib.html;

import java.util.Date;
import java.util.Map;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.MethodKey;
import egovframework.cmmn.util.CommonUtil;

/**
 * 최근 글 여부 확인 태그
 * @author seominho
 *
 */
public class IsNewTag extends BodyTagSupport {

    /**
     *
     */
    private static final long serialVersionUID = -5549606535783641602L;

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    private String value;
    private String day = "1";



    public int doAfterBody() {
        String text = null;



        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        try {
        	Date date = null;
        	int days = CommonUtil.convertInt(day , 1);
        	if(date == null){
	            //Date
	        	//String receiveDate = (valueEx != null ? valueEx : value);
        		String receiveDate = value;

	        	String year = "";
	        	String month = "";
	        	String day = "";

	        	if (receiveDate.indexOf("-") >= 0) { //receiveDate 형태가 yyyy-MM-dd 일때
	        		year = receiveDate.split("-")[0].trim();
	            	month = receiveDate.split("-")[1].trim();
	            	day = receiveDate.split("-")[2].trim();
	        	} else { //receiveDate 형태가 yyyyMMdd 일때
	        		year = receiveDate.substring(0, 4);
	        		month = receiveDate.substring(4, 6);
	        		day = receiveDate.substring(6, 8);
	        	}

	        	date = CommonUtil.toDate(year, month, day);
        	}

            if ((date != null && (date.getTime() + (days * 24 * 60 * 60 * 1000)) > System.currentTimeMillis())) {
                JspWriter out = getPreviousOut();
                out.print(text);
            }
        } catch (Exception e) {
            logger.error("", e);
        }
        return SKIP_BODY;
    }


    /**
     * @param vale The vale to set.
     */
    public void setValue(String vale) {
        this.value = vale;
    }


    /**
     * @param day The day to set.
     */
    public void setDay(String day) {
        this.day = day;
    }


    @SuppressWarnings("rawtypes")
	protected Object getParsedObject(String value) throws Exception {
        Object result = value;
        if(value != null) {
            int index = value.indexOf("${");
            if (index > -1) {
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
                        	if(obj.getClass().getName().indexOf("Map") >= 0) {
                        		Map map = (Map) obj;
                        		result = map.get(varName2);
                        	} else {
                        		result = MethodKey.getMethodValue(obj, varName2);
                        	}
                        }
                    }
                } else {
                    result = super.pageContext.getRequest().getAttribute(varName);
                    if (result == null) {
                    	result = super.pageContext.getAttribute(varName);
                    }
                	//logger.info("======="+varName+":"+result);
                }
            } else {
            	result = super.pageContext.getRequest().getAttribute(value);
                if (result == null) {
                	result = super.pageContext.getAttribute(value);
                }
            }
        }

        return result;
    }



}
