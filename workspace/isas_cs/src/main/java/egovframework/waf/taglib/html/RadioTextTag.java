package egovframework.waf.taglib.html;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;

public class RadioTextTag extends DefaultTagSupport {

	/**
     *
     */
    private static final long serialVersionUID = -7266932225712139720L;
    private String name;
	private String script;
	private String value;
	private String text;
	private String checkedValue;
	private String defaultValue;

	private String space;
	private String textSize;


    private String codeId;

    private String list;

	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	@SuppressWarnings("rawtypes")
	public int doEndTag() throws JspException {
		try {
		    checkedValue = getParsedValue(checkedValue, name);
            String[] values = null;
            String[] texts = null;


            if (codeId != null) {
            	/*
                CodeManager codeManager = CodeManager.getCodeManager();
                CodeVO pCode = codeManager.getCodeVO(codeId);
                if (pCode != null) {
                    List list = pCode.getChildList();
                    if (list != null) {
                        String[] tValues = null;
                        String[] tTexts = null;
                        if (value != null) {
                            tValues = (value != null) ? CommonUtil.toStringArray(value, DELIMITER) : null;
                            tTexts = (text != null) ? CommonUtil.toStringArray(text, DELIMITER) : tValues;
                        }
                        int fSize = tValues != null ? tValues.length : 0;
                        int size = list.size() + fSize;
                        values = new String[size];
                        texts = new String[size];
                        if (fSize > 0) {
                            for (int i = 0; i < fSize; i++) {
                                values[i] = tValues[i];
                                texts[i] = tTexts[i];
                            }
                        }
                        CodeVO cCode = null;
                        for (int i = 0; i < list.size(); i++) {
                            cCode = (CodeVO)list.get(i);
                            values[i+fSize] = cCode.getCodeId();
                            texts[i+fSize] = cCode.getCodeName();
                        }
                    } else {
                        logger.println(Logger.WARN, codeId + "에 대한 코드값을 가져올 수 없습니다.", this);
                    }


                } else {
                    values = (value != null) ? CommonUtil.toStringArray(value, DELIMITER) : null;
                    texts = (text != null) ? CommonUtil.toStringArray(text, DELIMITER) : values;
                }
                */

            } else if (list != null) {
                Object obj = getParsedObject(list);
//                if (obj == null) {
//                    obj = pageContext.getServletContext().getAttribute(list);
//                }
                if (obj != null) {
                    List list = (List)obj;


                    String[] tValues = null;
                    String[] tTexts = null;
                    if (value != null) {
                        tValues = (value != null) ? CommonUtil.toStringArray(value, DELIMITER) : null;
                        tTexts = (text != null) ? CommonUtil.toStringArray(text, DELIMITER) : tValues;
                    }
                    int fSize = tValues != null ? tValues.length : 0;
                    int size = list.size() + fSize;
                    values = new String[size];
                    texts = new String[size];
                    if (fSize > 0) {
                        for (int i = 0; i < fSize; i++) {
                            values[i] = tValues[i];
                            texts[i] = tTexts[i];
                        }
                    }
                    String[] data = null;
                    for (int i = 0; i < list.size(); i++) {
                        data = (String[])list.get(i);
                        values[i+fSize] = data[0];
                        texts[i+fSize] = data[1];
                    }

                } else {
                    values = (value != null) ? CommonUtil.toStringArray(value, DELIMITER) : null;
                    texts = (text != null) ? CommonUtil.toStringArray(text, DELIMITER) : values;
                }
            } else {
                values = (value != null) ? CommonUtil.toStringArray(value, DELIMITER) : null;
                texts = (text != null) ? CommonUtil.toStringArray(text, DELIMITER) : values;
            }

			JspWriter out = super.pageContext.getOut();
			RadioText radoText = new RadioText(name, values, script,  checkedValue, defaultValue, texts, space, textSize);

			out.println(radoText.buildHtml());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("TAG : " + e.toString());
		}
		return (SKIP_BODY);
	}

    /**
     * @return name을 리턴합니다.
     */
    public String getName() {
        return name;
    }
    /**
     * @param name 설정하려는 name.
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return radioNames을 리턴합니다.
     */
    public String getText() {
        return text;
    }
    /**
     * @param text 설정하려는 text.
     */
    public void setText(String radioNames) {
        this.text = radioNames;
    }
    /**
     * @return radioValues을 리턴합니다.
     */
    public String getValue() {
        return value;
    }
    /**
     * @param value 설정하려는 value.
     */
    public void setValue(String radioValues) {
        this.value = radioValues;
    }
    /**
     * @return script을 리턴합니다.
     */
    public String getScript() {
        return script;
    }
    /**
     * @param script 설정하려는 script.
     */
    public void setScript(String script) {
        this.script = script;
    }
    /**
     * @return selectedValue을 리턴합니다.
     */
    public String getCheckedValue() {
        return checkedValue;
    }
    /**
     * @param checkedValue 설정하려는 checkedValue.
     */
    public void setCheckedValue(String selectedValue) {
        this.checkedValue = selectedValue;
    }
    /**
     * @return space을 리턴합니다.
     */
    public String getSpace() {
        return space;
    }
    /**
     * @param space 설정하려는 space.
     */
    public void setSpace(String space) {
        this.space = space;
    }

    /**
     * @return defaultValue을 리턴합니다.
     */
    public String getDefaultValue() {
        return defaultValue;
    }
    /**
     * @param defaultValue 설정하려는 defaultValue.
     */
    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }


    /**
     * @return textSize을 리턴합니다.
     */
    public String getTextSize() {
        return textSize;
    }
    /**
     * @param textSize 설정하려는 textSize.
     */
    public void setTextSize(String textSize) {
        this.textSize = textSize;
    }


    /**
     * @param codeId The codeId to set.
     */
    public void setCodeId(String codeId) {
        this.codeId = codeId;
    }


    /**
     * @param list The list to set.
     */
    public void setList(String list) {
        this.list = list;
    }


}
