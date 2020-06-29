package egovframework.waf.taglib.html;

import java.security.MessageDigest;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * LG U+ XPay 영수증 출력 시 필요한 authdata 출력 태그
 * @FileName     : LgXPayMd5Tag.java
 * @Project      : kmrb
 * @Date         : 2012. 2. 24. 
 * @author       : PCN

 * @
 * @ 수정일                           수정자                 수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2012. 2. 24.   PCN         최초생성
 */

public class LgXPayMd5Tag extends DefaultTagSupport {
	
	private static final long serialVersionUID = -3752844106739210214L;
	private String lgd_mid;
    private String lgd_tid;
    private String lgd_mertkey;
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
			lgd_mid = getParsedValue(lgd_mid);
			lgd_tid = getParsedValue(lgd_tid);
			lgd_mertkey = getParsedValue(lgd_mertkey);

		    JspWriter out = super.pageContext.getOut();
            
            StringBuffer html = new StringBuffer();
            if (lgd_mid != null && lgd_tid != null) {
            	
            	StringBuffer sb = new StringBuffer();
            	sb.append(lgd_mid);
            	sb.append(lgd_tid);
        	    sb.append(lgd_mertkey);
        	    
        	    
        	    byte[] bNoti = sb.toString().getBytes();
        	    MessageDigest md = MessageDigest.getInstance("MD5");
        	    byte[] digest = md.digest(bNoti);

        	    StringBuffer strBuf = new StringBuffer();
        	    for (int i=0 ; i < digest.length ; i++) {
        	        int c = digest[i] & 0xff;
        	        if (c <= 15){
        	            strBuf.append("0");
        	        }
        	        strBuf.append(Integer.toHexString(c));
        	    }
            	
                html.append(strBuf.toString());
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
    public void setLgd_mid(String lgd_mid) {
        this.lgd_mid = lgd_mid;
    }

    /**
     * @param query The query to set.
     */
    public void setLgd_tid(String lgd_tid) {
        this.lgd_tid = lgd_tid;
    }
    
    /**
     * @param query The query to set.
     */
    public void setLgd_mertkey(String lgd_mertkey) {
        this.lgd_mertkey = lgd_mertkey;
    }




}
