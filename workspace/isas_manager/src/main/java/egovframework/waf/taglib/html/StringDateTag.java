package egovframework.waf.taglib.html;

import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;


/**
 * <pre><xmp>
 * 문자열 날짜데이터를 포맷화해서 출력.
 * 날짜형식은 yyyy[MM[dd[HH[mm[ss]]]]]
 * ex)
 * 	<html:stringDate value='${EO.regDt}' pattern='yyyy-MM-dd' />
 * </xmp></pre>
 * @author pcn
 * @version 2008. 01. 10
 */
public class StringDateTag extends DefaultTagSupport {

    /**
     *
     */
    private static final long serialVersionUID = -4078416491705043671L;
    private String value;
    private String pattern;
    private String defaultValue;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());


	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
            JspWriter out = super.pageContext.getOut();
            String strDt = "";

            value = getParsedValue(value);

            if(value == null || "".equals(value)){
            	value = defaultValue;
            }

            //공백, : 제거
            value = CommonUtil.replaceAll(value, " ", "");
            value = CommonUtil.replaceAll(value, ":", "");
            value = CommonUtil.replaceAll(value, ".", "");
            value = CommonUtil.replaceAll(value, "-", "");

            //logger.println(Logger.DEBUG, value, this);

            if(value != null && !"".equals(value)){
            	int len = value.length();
            	//yyyyMMddHHiiss
            	int yyyy = len>=4 ? Integer.parseInt(value.substring(0, 4)) : 0;
            	int mm = len>=6 ? Integer.parseInt(value.substring(4, 6)) : 0;
            	int dd = len>=8 ? Integer.parseInt(value.substring(6, 8)) : 1; //값이 없으면 1일로 세팅. 0일이면 이전 달로 됨
            	int hh = len>=10 ? Integer.parseInt(value.substring(8, 10)) : 0;
            	int ii = len>=12 ? Integer.parseInt(value.substring(10, 12)) : 0;
            	int ss = len>=14 ? Integer.parseInt(value.substring(12, 14)) : 0;

            	//logger.info("### "+yyyy+","+mm+","+dd+","+hh+","+ii+","+ss);

            	Date date = CommonUtil.toDate(yyyy, mm, dd, hh, ii, ss);

            	strDt = CommonUtil.getFormatString(pattern, date);
            }

			out.print(strDt);
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
     * @param defaultValue
     */
    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }


    /**
     * @param pattern
     */
    public void setPattern(String pattern) {
        this.pattern = pattern;
    }

}
