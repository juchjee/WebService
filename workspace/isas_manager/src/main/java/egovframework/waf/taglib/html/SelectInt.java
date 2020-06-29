package egovframework.waf.taglib.html;

import javax.servlet.jsp.JspException;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;


/**
 * 셀렉트 박스 생성 태그
 * @author seominho
 *
 */
public class SelectInt extends DefaultTagSupport {

    /**
     *
     */
    private static final long serialVersionUID = 835253724930373183L;
    private String begin;
    private String end;
    private String step;
    private String selected;
    private String  defaultValue;

	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}


	protected int getIntValue(Object obj) {
		int result = 0;
    	if (obj != null) {
        	if (obj instanceof Integer) {
        		result = ((Integer)obj).intValue();
        	} else if (obj instanceof Long) {
        		result = ((Long)obj).intValue();
        	} else {
        		result = CommonUtil.convertInt(String.valueOf(obj), 0);
        	}
    	}

		return result;
	}

	public int doStartTag() throws JspException {
        String s = "";
        String sel;

        int sdt = 0;
        int bt = 1;
        int et = 9;
        int st = 1;
        int dt = 10;
        try {
	        if(selected != null){
	        	sdt = getIntValue(selected);
	        }

	        bt = getIntValue(begin);
	        et = getIntValue(end);
	       	st = getIntValue(step);
	       	dt = getIntValue(defaultValue);
	       //	logger.info("bt >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + bt);
	       //	logger.info("et >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + et);
	       //	logger.info("st >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + st);
	       	if(dt==0) dt = 10;
	       	sdt = (sdt == 0) ? dt : sdt;
	       	st = (st == 0) ? 1 : st;
	        for (int i = bt; i <= et; i += st) {
	        	//logger.info("sdt >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + sdt);
	        	sel = (i == sdt) ? " selected " : "";
	            s = s + "<option value='" + CommonUtil.leftPad(i,2,"0") + "'" + sel + ">" + CommonUtil.leftPad(i,2,"0") + "</option>\n";
	        }
			pageContext.getOut().print(s);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}


    public int doEndTag() {

        return EVAL_PAGE;
    }
}
