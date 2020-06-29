package egovframework.waf.taglib.html;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.MethodKey;

/**
 * 글 내용 출력
 * 
 * @author vary
 * 
 */
public class ForEachTag extends BodyTagSupport {

	private static final long serialVersionUID = -2301128422097502785L;

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	private String text = null;

	private String var;
	
	private String varStatus;

	private String items;
	private int rpt=0;
	@SuppressWarnings("rawtypes")
	private List list = null;

	@SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	public int doAfterBody() {
		if(varStatus == null)
			varStatus = "status";
		
		try {
			JspWriter out = getPreviousOut();

			if(list == null)
				list = (List)getParsedObject(items);
			
			if(list != null){
				Map statusMap = new HashMap();
				if(rpt <list.size()){
					Object obj = list.get(rpt);
					pageContext.setAttribute(var, obj);
					
					statusMap.put("index", new Integer(rpt));
					pageContext.setAttribute(varStatus, statusMap);
					
					BodyContent body = getBodyContent();
					text = body.getString();
					if(rpt>0)
						out.println(text);
					body.clearBody();
					
					logger.info("### rpt:"+rpt+", body:"+text);
					rpt++;
					return EVAL_BODY_TAG;
				}else{
					rpt = 0;
					BodyContent body = getBodyContent();
					text = body.getString();
					out.println(text);
					logger.info("### rpt:"+rpt+", body:"+text);
				}
			}else{
				logger.info("list is null", this);
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return SKIP_BODY;
	}

	protected Object getParsedObject(String value) throws Exception {
		Object result = value;
		if (value != null) {
			int index = value.indexOf("${");
			if (index > -1) {
				String varName = value.substring(index + 2, value
						.lastIndexOf('}'));
				int dotIndex = varName.indexOf('.');
				if (dotIndex > -1) {
					String varName1 = varName.substring(0, dotIndex);
					String varName2 = varName.substring(dotIndex + 1);
					if ("param".equalsIgnoreCase(varName1)) {
						result = super.pageContext.getRequest().getParameter(
								varName2);
					} else {
						Object obj = super.pageContext.getRequest()
								.getAttribute(varName1);
						if (obj == null) {
							obj = super.pageContext.getAttribute(varName1);
						}
						if (obj != null) {
							result = MethodKey.getMethodValue(obj, varName2);
						}
					}
				} else {
					result = super.pageContext.getRequest().getAttribute(
							varName);
					if (result == null) {
						result = super.pageContext.getAttribute(varName);
					}
				}
			}
		}

		return result;
	}

	/**
	 * @param var
	 */
	public void setVar(String var) {
		this.var = var;
	}

	/**
	 * @param items
	 */
	public void setItems(String items) {
		this.items = items;
	}

	public void setVarStatus(String varStatus) {
		this.varStatus = varStatus;
	}
}
