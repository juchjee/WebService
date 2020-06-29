package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 병원명
 * @author vary
 *
 */
public class SiteNameTag extends DefaultTagSupport {


    /**
	 *
	 */
	private static final long serialVersionUID = -697723218425270157L;

	private String siteCd;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());


	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {


		    JspWriter out = super.pageContext.getOut();

            StringBuffer html = new StringBuffer();
            if (siteCd != null) {
               if("KCCH".equals(siteCd)){
            	   html.append("병원");
               }else if("KIRAMS".equals(siteCd)){
            	   html.append("의학원");
               }else if("HCARE".equals(siteCd)){
            	   html.append("종합건진센터");
               }else if("WAMIS".equals(siteCd)){
            	   html.append("진료협력센터");
               }else if("FUNERAL".equals(siteCd)){
            	   html.append("장례식장");
               }else if("RIRAMS".equals(siteCd)){
            	   html.append("방사선의학연구소");
               }else if("NREMC".equals(siteCd)){
            	   html.append("국가방사선비상진료센터");
               }else if("KHIMA".equals(siteCd)){
            	   html.append("의료용중입자가속기사업단");
               }else{
            	   html.append("&nbsp;");
               }
            }

			out.print(html.toString());
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}


    /**
     * 사이트 코드
     * @param value The value to set.
     */
    public void setSiteCd(String value) {
        this.siteCd = value;
    }


}
