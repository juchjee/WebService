package egovframework.waf.taglib.html;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;
/**
 * 게시물 페이징
 * @author vary
 *
 */
public class PagingTagPhoto extends DefaultTagSupport {


    private static final long serialVersionUID = -6420080584917643106L;

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    private String width;
    private String uri;
    private String parameters;
    private String numOfRows;
    private String numOfPages;
    private String totalPage;
    private String cPage;
    private String total;

    private String style;

    private String left02Img = "../img/common/btn_first.gif";
    private String left01Img = "../img/common/btn_prev.gif";
    private String right01Img = "../img/common/btn_next.gif";
    private String right02Img = "../img/common/btn_last.gif";

    public int doStartTag() throws JspException {
        return (SKIP_BODY);
    }


    public int doEndTag() throws JspException {
        try {
            HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
            if (width == null) {
                width = "100%";
            }
            if (parameters == null) {
                Object objParam = request.getAttribute("parameters");
                parameters = (objParam != null) ? String.valueOf(objParam) : "";
            } else {
                parameters = getParsedValue(parameters);
            }
            if(parameters != null){
            	parameters = CommonUtil.replaceAll(parameters, "&", "&amp;");
            }else{
            	parameters = "";
            }

            int numOfRows = CommonUtil.convertInt(getParsedValue(this.numOfRows, "numOfRows"), 5);
            int numOfPages = CommonUtil.convertInt(getParsedValue(this.numOfPages, "numOfPages"), 1);
            int totalPage = CommonUtil.convertInt(getParsedValue(this.totalPage, "totalPage"), -1);
            int cPage = CommonUtil.convertInt(getParsedValue(this.cPage, "cPage"), 1);
            int total = CommonUtil.convertInt(getParsedValue(this.total, "total"), 0);
            if (totalPage < 0) {
                totalPage = total / numOfRows;
            }

            int prePageSet = (cPage - 1) / numOfPages * numOfPages;
            int nextPageSet = (cPage + numOfPages - 1) / numOfPages * numOfPages + 1;

            StringBuffer html = new StringBuffer();

            if (uri == null) {
            	if(request.getAttribute("requestURI") != null) //.do
                	uri = (String)request.getAttribute("requestURI");
                else{
                    uri = request.getRequestURI();
                }
            }

    		left01Img = "../images/common/board/btnPrevPtPage.gif";
            left02Img = "../images/common/board/btnFirstPtPage.gif";
            right01Img = "../images/common/board/btnNextPtPage.gif";
            right02Img = "../images/common/board/btnLastPtPage.gif";

            if("PhotoL".equals(style)){ //포토형 게시판  페이징 왼쪽

                //처음
	            if(left02Img != null){
		            if (cPage > 1) {
	                	html.append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\">\n");
		            }
	            	html.append("<img class='btn' src=\"").append(left02Img).append("\" ").append(" alt=\"첫페이지\" />\n");
		            if (cPage > 1) {
		                html.append("</a>");
		            }
	            }

	            //이전
	            if (prePageSet > 0) {
                	html.append("<a href=\"").append(uri).append("?cPage=").append(prePageSet).append(parameters).append("\">");
	            }
            	html.append("<img class='btn' src=\"").append(left01Img).append("\" ").append(" alt=\"이전페이지\" />");

	            if (prePageSet > 0) {
	                html.append("</a>");
	            }

	            html.append("\n");

            } else if("PhotoR".equals(style)){//포토형 게시판 오른쪽 페이징 버튼

            	//다음
	            if (nextPageSet <= totalPage ) {
            		html.append("<a href=\"").append(uri).append("?cPage=").append(nextPageSet).append(parameters).append("\">\n");
	            }
            	html.append("<img class='btn' src=\"").append(right01Img).append("\" ").append(" alt=\"다음페이지\" />\n");
	            if (nextPageSet <= totalPage ) {
	                html.append("</a>");
	            }

	            //마지막
	            if(right02Img != null){
		            if (cPage < totalPage ) {
	            		html.append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\">");
		            }
	            	html.append("<img class='btn'src=\"").append(right02Img).append("\" ").append(" alt=\"마지막페이지\" />");
		            if (cPage < totalPage ) {
		                html.append("</a>");
		            }
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
     * @param parameters The parameters to set.
     */
    public void setParameters(String parameters) {
        this.parameters = parameters;
    }



    /**
     * @param totalPage The totalPage to set.
     */
    public void setTotalPage(String totalPage) {
        this.totalPage = totalPage;
    }


    /**
     * @param page The cPage to set.
     */
    public void setCPage(String page) {
        cPage = page;
    }
    /**
     * @param nextPageSet The nextPageSet to set.
     */
    public void setNumOfPages(String nextPageSet) {
        this.numOfPages = nextPageSet;
    }
    /**
     * @param prePageSet The prePageSet to set.
     */
    public void setNumOfRows(String prePageSet) {
        this.numOfRows = prePageSet;
    }
    /**
     * @param total The total to set.
     */
    public void setTotal(String total) {
        this.total = total;
    }
    /**
     * @param width The width to set.
     */
    public void setWidth(String width) {
        this.width = width;
    }


    /**
     * @param uri The uri to set.
     */
    public void setUri(String uri) {
        this.uri = uri;
    }

    /**
     * @param imgType The imgType to set.
     */
    public void setStyle(String imgType) {
        this.style = imgType;
    }




}
