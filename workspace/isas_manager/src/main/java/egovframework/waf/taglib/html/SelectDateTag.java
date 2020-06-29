package egovframework.waf.taglib.html;

import java.util.Calendar;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 날짜 선택박스.
 *
 * @author vary
 *
 */
public class SelectDateTag extends DefaultTagSupport {

    /**
	 *
	 */
	private static final long serialVersionUID = 2372073186505500250L;

	private String name1;
	private String name2;
	private String name3;
	private String script1;
	private String script2;
	private String script3;
    /** 현재 년도를 기준으로 몇년 전부터의 연도 */
    private String yearM;
    /** 현재 년도를 기준으로 몇년 후까지의 연도 */
    private String yearP;
    /** 선택한 날짜 yyyyMMdd */
    private String selDt;

    private String startYear;

    private String addDefault;

    private String addText;

	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}


	public int doEndTag() throws JspException {
		try {
			yearM = getParsedValue(yearM);
			yearP = getParsedValue(yearP);
			startYear = getParsedValue(startYear);
			selDt = getParsedValue(selDt); //yyyyMMdd
			boolean bAddDefault = "true".equals(addDefault) ? true : false;
			boolean bAddText = "false".equals(addText) ? false :  true;

			int sY = 0;
			int sM = 0;
			int sD = 0;
            int cY = Integer.parseInt(CommonUtil.getYear());
            int cM = Integer.parseInt(CommonUtil.getMonth());
            int cD = Integer.parseInt(CommonUtil.getDay());


			if(!CommonUtil.isNull(selDt)){
				if(selDt.length()>8){
					if(selDt.length()>=4)
						sY = CommonUtil.convertInt(selDt.substring(0,4), 0);
					if(selDt.length()>=7)
						sM = CommonUtil.convertInt(selDt.substring(5,7), 0);
					if(selDt.length()>=10)
						sD = CommonUtil.convertInt(selDt.substring(8,10), 0);
				}else{
					if(selDt.length()>=4)
						sY = CommonUtil.convertInt(selDt.substring(0,4), 0);
					if(selDt.length()>=6)
						sM = CommonUtil.convertInt(selDt.substring(4,6), 0);
					if(selDt.length()>=8)
						sD = CommonUtil.convertInt(selDt.substring(6,8), 0);
				}
			}else{
				if(!bAddDefault){
					sY = cY;
					sM = cM;
					sD = cD;
				}
			}

            Calendar calendar = Calendar.getInstance();
            calendar.set(sY,sM-1,sD);
            int maxDate = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

            JspWriter out = super.pageContext.getOut();

            String html = "";

            int yM = CommonUtil.convertInt(yearM, 5);
            int yP = CommonUtil.convertInt(yearP, 5);
            int sy = CommonUtil.convertInt(startYear, sY);


            //년
            if(!CommonUtil.isNull(name1)){
	            html = "<select name='"+name1+"' "+script1+">\n";
	            if(bAddDefault){
	            	html += "<option value=''>년도</option>\n";
	            }
	            if(!CommonUtil.isNull(startYear)){
		            for(int i=cY+yP; i>= sy; i--){
		            	html += "<option value='"+i+"'"+(i==sY ? " selected" : "")+">"+i+"</option>\n";
		            }
	            }else{
		            for(int i=cY+yP; i >=cY-yM; i--){
		            	html += "<option value='"+i+"'"+(i==sY ? " selected" : "")+">"+i+"</option>\n";
		            }
	            }
	            html += "</select>";
	            if(bAddText) html += "년";
	            html += "\n";
            }
            //월
            if(!CommonUtil.isNull(name2)){
	            html += "<select name='"+name2+"' "+script2+">\n";
	            if(bAddDefault){
	            	html += "<option value=''>월</option>\n";
	            }
	            for(int i=1; i<=12; i++){
	            	html += "<option value='"+CommonUtil.formatNumber(i,"00")+"'"+(i==sM ? " selected" : "")+">"+CommonUtil.formatNumber(i,"00")+"</option>\n";
	            }
	            html += "</select>";
	            if(bAddText) html += "월";
	            html += "\n";
            }
            //일
            if(!CommonUtil.isNull(name3)){
	            html += "<select name='"+name3+"' "+script3+">\n";
	            if(bAddDefault){
	            	html += "<option value=''>일</option>\n";
	            }
	            for(int i=1; i<=maxDate; i++){
	            	html += "<option value='"+CommonUtil.formatNumber(i,"00")+"'"+(i==sD ? " selected" : "")+">"+CommonUtil.formatNumber(i,"00")+"</option>\n";
	            }
	            html += "";
	            html += "</select>";
	            if(bAddText) html += "일";
	            html += "\n";
            }
            out.print(html);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return (SKIP_BODY);
	}


	/**
	 * 년도 태그명
	 * @param name1
	 */
	public  void setName1(String name1){
		this.name1 = name1;
	}
	/**
	 * 월 태그명
	 * @param name2
	 */
	public  void setName2(String name2){
		this.name2 = name2;
	}
	/**
	 * 일 태그명
	 * @param name3
	 */
	public  void setName3(String name3){
		this.name3 = name3;
	}
	/**
	 * 년도 태그 추가스타일
	 * @param script1
	 */
	public  void setScript1(String script1){
		this.script1 = script1;
	}
	/**
	 * 월 태그 추가스타일
	 * @param script2
	 */
	public  void setScript2(String script2){
		this.script2 = script2;
	}
	/**
	 * 일 태그 추가스타일
	 * @param script3
	 */
	public  void setScript3(String script3){
		this.script3 = script3;
	}
	/**
	 * 선택년월일
	 * @param selDt yyyymmdd
	 */
	public void setSelDt(String selDt) {
		this.selDt = selDt;
	}

	/**
	 * 년도 범위 -년도
	 * @param yearM
	 */
	public void setYearM(String yearM) {
		this.yearM = yearM;
	}

	/**
	 * 년도 범위 +년도
	 * @param yearP
	 */
	public void setYearP(String yearP) {
		this.yearP = yearP;
	}
	/**
	 * 시작년도
	 * @return
	 */
	public String getStartYear() {
		return startYear;
	}

	/**
	 * 시작년도 설정
	 * @param startYear
	 */
	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}

	/**
	 * 디폴트 빈 선태값 추가여부
	 * @param addDfault
	 */
	public void setAddDefault(String addDefault) {
		this.addDefault = addDefault;
	}
	/**
	 * 텍스트를 붙일지 여부
	 * @param addText
	 */
	public void setAddText(String addText) {
		this.addText = addText;
	}


}
