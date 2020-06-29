package egovframework.waf.taglib.html;

import java.text.MessageFormat;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 문자형 숫자를 ###,###,### 또는 ###,###.## 형식으로 포맷한다.
 * @author seominho
 *
 */
public class FormatNumber extends DefaultTagSupport {

	protected static final Logger log = LoggerFactory.getLogger(FormatNumber.class);

	private static final long	serialVersionUID	= 1L;
	private String						value;
	private String						pattern;

	public int doStartTag() throws JspException {
		return(SKIP_BODY);
	}

	public int doEndTag() throws JspException {
		try {
			JspWriter out = super.pageContext.getOut();
			StringBuffer html = new StringBuffer();

			value = getParsedValue(value);
			if (value != null || !"".equals(value.trim())) {
				if("###,###,###".equals(pattern)) {
					Object aobj[] = { new Long(value) };
					MessageFormat messageformat = new MessageFormat("{0,number,###,###,###,##0}");
					html.append(messageformat.format(((Object) (aobj))));
				} else if ("###,###.##".equals(pattern)) {
					Object aobj[] = { new Double(value) };
					MessageFormat messageformat = new MessageFormat("{0,number,###,###,###,##0.00}");
					html.append(messageformat.format(((Object) (aobj))));
				}
			}

			out.print(html.toString());
		} catch(Exception e) {
			log.info("TAG : " + e.toString());
		}
		return(SKIP_BODY);
	}

	/**
	 * @param value The value to set.
	 */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * @param startIndex The startIndex to set.
	 */
	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

}
