package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.Tokenizer;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 특정 형식으로 포맷한다. (ex-> 전화번호 ###-####-####, 구분자 ###,###,###)
 * @author seominho
 *
 */
public class SubStringTag extends DefaultTagSupport {

    /**
     *
     */
    private static final long serialVersionUID = 2840470200899334105L;

    private String value;

    // 1. 시작위치와 끝위치
    private String begin;
    private String end;

    // 2. 구분자를 이용하기
    private String delimiter;
    private String index;

    private String option;


	protected final Logger logger = LoggerFactory.getLogger(this.getClass());


	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
            JspWriter out = super.pageContext.getOut();
            StringBuffer html = new StringBuffer();

            value = getParsedValue(value);

            if (value != null) {
                if (delimiter != null) {
                    if (option == null) {
                        int i = CommonUtil.convertInt(index, -1);
                        if (i > -1) {
                            Tokenizer tokenizer = new Tokenizer(value, delimiter);
                            String str = tokenizer.toArray(i+1)[i];
                            if (str != null) {
                                html.append(str);
                            }
                        } else {
                            html.append(value);
                        }
                    } else if ("telNo".equals(option)) {
                        value = value.trim();
                        if (value.startsWith("(")) {
                            value = value.substring(1);
                        }
                        if (value.indexOf(")") > -1) {
                            value = value.replaceAll("\\)", "-");
                        }
                        int i = CommonUtil.convertInt(index, -1);
                        if (i > -1) {
                            Tokenizer tokenizer = new Tokenizer(value, delimiter);
                            String[] telNoArray = tokenizer.toArray();
                            String str = null;
                            if (telNoArray.length > 2) {
                                str = telNoArray[i];
                            } else if (telNoArray.length == 2) {
                                if (i > 0) {
                                    str = telNoArray[i-1];
                                }
                            } else {
                                if (i > 2) {
                                    str = telNoArray[i-2];
                                }
                            }

                            if (str != null) {
                                html.append(str);
                            }
                        } else {
                            html.append(value);
                        }

                    }
                } else {
                    int sIndex = CommonUtil.convertInt(begin, -1);
                    int eIndex = CommonUtil.convertInt(end, -1);

                    if (sIndex <= eIndex && sIndex > -1 && value.length() >= eIndex) {
                        html.append(value.substring(sIndex, eIndex));
                    } else {
                        html.append(value);
                    }
                }
            }

			out.print(html.toString());
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
     * @param endIndex The endIndex to set.
     */
    public void setEnd(String endIndex) {
        this.end = endIndex;
    }


    /**
     * @param startIndex The startIndex to set.
     */
    public void setBegin(String startIndex) {
        this.begin = startIndex;
    }


    /**
     * @param delimiter The delimiter to set.
     */
    public void setDelimiter(String delimiter) {
        this.delimiter = delimiter;
    }


    /**
     * @param index The index to set.
     */
    public void setIndex(String index) {
        this.index = index;
    }


    /**
     * @param option The option to set.
     */
    public void setOption(String option) {
        this.option = option;
    }



}
