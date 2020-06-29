package egovframework.waf.taglib.html;

import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;


/**
 * 특정 DB 정보를 바탕으로 셀렉트 박스 리스트  생성 태그
 * @FileName     : SelectCodeList.java
 * @Project      : kmrb
 * @Date         : 2011. 12. 6.
 * @author       : PCN

 * @
 * @ 수정일                           수정자                 수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2011. 12. 6.   PCN         최초생성
 */

@SuppressWarnings("serial")
public class SelectCodeList extends DefaultTagSupport {

	private String name;
	private String script;
	@SuppressWarnings("rawtypes")
	private List data;

	private String selectedValue;
	private String defaultValue;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}

    public int doEndTag() throws JspException {
    	try {
    		JspWriter out = super.pageContext.getOut();
    		out.print(buildHtml());

    	} catch (Exception e) {
			e.printStackTrace();
		}
		return (SKIP_BODY);
    }

	@SuppressWarnings("rawtypes")
	public String buildHtml() {
		StringBuffer html = new StringBuffer();
		try {
			html.append("<select id=\"").append(name).append("\"");
			html.append(" name=\"").append(name).append("\"");
			if (script != null) {
				html.append(" ");
				html.append(script);
			}
			html.append(">\n");
            if (this.data != null) {
                int size = (this.data != null) ? this.data.size() : 0;
                html.append("    <option value=\"\">선택</option>\n");
                for (int i = 0; i < size ; i++) {
                	Map map = (Map) this.data.get(i);

                    html.append("    <option value=\"").append(map.get("VALUE")).append("\"");
                    if(!CommonUtil.isNull(selectedValue)){
	                    if (((String)map.get("VALUE")).equalsIgnoreCase(selectedValue) || ((String)map.get("NAME")).equalsIgnoreCase(selectedValue)) {
	                        html.append(" selected=\"selected\"");
	                    }
                    }else{
	                    if (((String)map.get("VALUE")).equalsIgnoreCase(defaultValue) || ((String)map.get("NAME")).equalsIgnoreCase(defaultValue)) {
	                        html.append(" selected=\"selected\"");
	                    }
                    }
                    html.append(">");
                    html.append(((String)map.get("NAME"))).append("</option>\n");
                }
            }
			html.append("</select>");
		} catch (Exception e) {
			logger.error("", e);
		}


		return html.toString();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public String getSelectedValue() {
		return selectedValue;
	}

	public void setSelectedValue(String selectedValue) {
		this.selectedValue = selectedValue;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	@SuppressWarnings("rawtypes")
	public List getData() {
		return data;
	}

	@SuppressWarnings("rawtypes")
	public void setData(List dataList) {
		this.data = dataList;
	}
}
