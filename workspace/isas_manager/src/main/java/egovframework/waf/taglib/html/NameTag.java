package egovframework.waf.taglib.html;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.MethodKey;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 코드 네이을 가져오는 태그
 * @author seominho
 *
 */
public class NameTag extends DefaultTagSupport {

	/**
     *
     */
    private static final long serialVersionUID = 2077736094392321160L;
    private String value;
    private String code;
	private String name;

    private String defaultName;

    private String list;
    private String listCode;
    private String listName;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());


	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
            String[] codes = null;
            String[] names = null;
            if (list != null) {
                @SuppressWarnings("rawtypes")
				List mList = (List)super.getParsedObject(list);
                if (mList != null) {
                    codes = new String[mList.size()];
                    names = new String[mList.size()];

                    Object data = null;
                    Object codeObj = null;
                    Object nameObj = null;
                    for (int i = 0; i < mList.size(); i++) {
                        data = mList.get(i);
                        codeObj = MethodKey.getMethodValue(data, listCode);
                        nameObj = MethodKey.getMethodValue(data, listName);
                        codes[i] = (codeObj != null) ? String.valueOf(codeObj) : null;
                        names[i] = (nameObj != null) ? String.valueOf(nameObj) : null;
                    }
                }
            } else {
                codes = (code != null) ? CommonUtil.toStringArray(code, DELIMITER) : null;
                names = (name != null) ? CommonUtil.toStringArray(name, DELIMITER) : codes;
            }


            value = super.getParsedValue(value);

            StringBuffer html = new StringBuffer();
            if (value != null) {
                boolean hasCode = false;
                if (codes != null) {
                    for (int i = 0; i < codes.length; i++) {
                        if (value.equals(codes[i])) {
                            hasCode = true;
                            html.append(names[i]);
                            break;
                        }
                    }
                }
                if (!hasCode) {
                    if (defaultName != null) {
                        html.append(defaultName);
                    } else {
                        html.append(value);
                    }
                }
            } else {
                if (defaultName != null) {
                    html.append(defaultName);
                }
            }

			JspWriter out = super.pageContext.getOut();
			out.print(html.toString());
		} catch (Exception e) {
			logger.error("", e);
		}
		return (SKIP_BODY);
	}


    /**
     * @param code The code to set.
     */
    public void setCode(String code) {
        this.code = code;
    }


    /**
     * @param name The name to set.
     */
    public void setName(String name) {
        this.name = name;
    }


    /**
     * @param value The value to set.
     */
    public void setValue(String value) {
        this.value = value;
    }


    /**
     * @param defaultName The defaultName to set.
     */
    public void setDefaultName(String defaultName) {
        this.defaultName = defaultName;
    }


    /**
     * @param list The list to set.
     */
    public void setList(String list) {
        this.list = list;
    }


    /**
     * @param listCode The listCode to set.
     */
    public void setListCode(String listCode) {
        this.listCode = listCode;
    }


    /**
     * @param listName The listName to set.
     */
    public void setListName(String listName) {
        this.listName = listName;
    }



}
