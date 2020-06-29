package egovframework.waf.taglib.html;

import egovframework.waf.taglib.HtmlConstants;

/**
 * 라디오 버튼 생성 태그
 * @author seominho
 *
 */
public class RadioText implements HtmlConstants {

	private String name;
	private String script;
	private String[] values;
	private String[] texts;
	private String checkedValue;
	private String defaultValue;
	private String space;
	private String textSize;


	//protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	public RadioText(String name, String[] values, String script, String checkedValue, String defaultValue, String[] texts,  String space, String textSize) {
		this.name = name;
		this.script = (script != null) ? " " + script + " " : "";
		this.values = values;
		this.texts = (texts != null) ? texts : this.values;
		this.checkedValue = checkedValue;
        this.defaultValue = (checkedValue==null||"".equals(checkedValue.trim())) ? defaultValue : checkedValue;
		this.space = (space == null) ? "" : space;
		this.textSize = textSize;
	}


	public String buildHtml() {
	    String radioButtonName = name + "RB";
	    String textName = name + "Text";
	    boolean hasCheckedValue = false;
		StringBuffer html = new StringBuffer();
		try {
			html.append("<input type=\"hidden\" name=\"").append(name).append("\" value=\"");
			if (checkedValue != null) {
			    html.append(checkedValue);
			} else if (defaultValue != null) {
			    html.append(defaultValue);
			}
			html.append("\"").append(">");

			int size = (values.length == texts.length) ? values.length : 0;
			for (int i = 0; i < size ; i++) {
			    if (i > 0) {
			        html.append(space);
			    }
				html.append("<input type=\"radio\" name=\"").append(radioButtonName).append("\"");
				html.append(" value=\"").append(values[i]).append("\"");
				if (i == size-1) {
				    html.append(" onclick=\"this.form.").append(textName).append(".disabled=false;this.form.").append(textName).append(".focus();\" ");
				} else {
				    html.append(" onclick=\"this.form.").append(name).append(".value=this.value;this.form.").append(textName).append(".disabled=true;\" ");
				}

				html.append(script);
				if (values[i].equalsIgnoreCase(checkedValue) || values[i].equalsIgnoreCase(defaultValue)) {
					html.append(" checked");
					hasCheckedValue = (i < size-1);
				} else 	if (!hasCheckedValue && i == size-1) {
				    html.append(" checked");
				}
				html.append(">").append(texts[i]);
			}
			html.append(space).append("<input type=\"text\" name=\"").append(textName).append("\" value=\"");
			if (!hasCheckedValue) {
			    html.append(checkedValue);
			}
			html.append("\"");
			if (textSize != null && !textSize.equals("")) {
				html.append(" size=\"").append(textSize).append("\"");
			}
			if (hasCheckedValue) {
			    html.append(" disabled");
			}
			html.append(" onchange=\"this.form.").append(name).append(".value = this.value\">");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("TAG : " + e.toString());
		}


		return html.toString();
	}
}
