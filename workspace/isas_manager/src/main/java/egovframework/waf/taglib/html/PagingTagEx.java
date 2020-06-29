package egovframework.waf.taglib.html;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;
/**
 * <pre><xmp>
 * 게시물 페이징
 * ex)
 * 	<html:pagingEx parameters='${parameters}' left02Img="" left01Img="" right01Img="" right02Img=""/>
 * </xmp></pre>
 * @author vary
 *
 */
public class PagingTagEx extends DefaultTagSupport {


    private static final long serialVersionUID = -6420080584917643106L;

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    private String uri;
    private String parameters;
    private String numOfRows;
    private String numOfPages;
    private String startPage;
    private String endPage;
    private String totalPage;
    private String cPage;
    private String total;

    private String left02Img = "";
    private String left01Img = "";
    private String right01Img = "";
    private String right02Img = "";

    public int doStartTag() throws JspException {
        return (SKIP_BODY);
    }

    private boolean isEmpty(String s){
    	return s==null || "".equals(s) ? true : false;
    }

    public int doEndTag() throws JspException {
        try {
            HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
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

            int numOfRows = CommonUtil.convertInt(getParsedValue(this.numOfRows, "numOfRows"), 10);
            int numOfPages = CommonUtil.convertInt(getParsedValue(this.numOfPages, "numOfPages"), 10);
            int startPage = CommonUtil.convertInt(getParsedValue(this.startPage, "startPage"), 1);
            int endPage = CommonUtil.convertInt(getParsedValue(this.endPage, "endPage"), 1);
            int totalPage = CommonUtil.convertInt(getParsedValue(this.totalPage, "totalPage"), -1);
            int cPage = CommonUtil.convertInt(getParsedValue(this.cPage, "cPage"), 1);
            int total = CommonUtil.convertInt(getParsedValue(this.total, "total"), 0);
            if (totalPage < 0) {
                totalPage = total / numOfRows;
            }

            int prePageSet = (cPage - 1) / numOfPages * numOfPages;
            int nextPageSet = (cPage + numOfPages - 1) / numOfPages * numOfPages + 1;

            StringBuffer html = new StringBuffer();


            if (isEmpty(uri)) {
            	if(request.getAttribute("requestURI") != null) //.do
                	uri = (String)request.getAttribute("requestURI");
                else{
                    uri = request.getRequestURI();
                }
            }
            html.append("<ul>\n");
            html.append("<li class=\"btn_a\">\n");
            //처음
            if(!isEmpty(left02Img)){
	            //if (cPage > 1) {
            	//html.append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\" class='btn'").append("\" title='첫 페이지' >");
                html.append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\" class='btn'").append(" title='첫 페이지' >");//(vary)
	            //}
            	html.append("<img src=\"").append(left02Img).append("\" border=\"0\" ").append(" alt=\"첫 페이지\" />");
	            //if (cPage > 1) {
	                html.append("</a>\n");
	            //}
            }

            if (prePageSet == 0) prePageSet = 1;

            //이전
            //if (prePageSet > 0) {
            	html.append("<a href=\"").append(uri).append("?cPage=").append(prePageSet).append(parameters).append("\" class='btn'").append(" title=\"이전 ").append(numOfPages).append(" 페이지\" >");
            //}
        	html.append("<img src=\"").append(left01Img).append("\" border=\"0\" ").append(" alt=\"이전 ").append(numOfPages).append("페이지\" />");

            //if (prePageSet > 0) {
                html.append("</a>\n");
            //}
            html.append("</li>\n");

            //페이징
        	for (int i = startPage; i <= endPage; i++) {

        		html.append("<li class=\"");
        		if (i == startPage) html.append(" fir");
        		else if (i == endPage) html.append(" last");
        		if (i == cPage) html.append(" selected");
        		html.append("\">\n");

                if (i == cPage) { //현재페이지
            		html.append("<a title='현재 페이지' href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\">");
                    html.append("["+i+"]");
            		html.append("</a>");
                } else {
            		html.append("<a title='"+i+"' href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\">");
            		html.append("["+i+"]");
            		html.append("</a>\n");
                }
                html.append("</li>\n");
            }

        	if (nextPageSet > totalPage ) nextPageSet = totalPage;

        	html.append("<li class=\"btn_a\">\n");
        	//다음
            //if (nextPageSet <= totalPage ) {
        		html.append("<a href=\"").append(uri).append("?cPage=").append(nextPageSet).append(parameters).append("\" class='btn'").append(" title=\"다음 ").append(numOfPages).append(" 페이지\" >");
            //}
        	html.append("<img src=\"").append(right01Img).append("\" border=\"0\" ").append(" alt=\"다음 ").append(numOfPages).append("페이지\" />");
            //if (nextPageSet <= totalPage ) {
                html.append("</a>\n");
            //}

            //마지막
            if(!isEmpty(right02Img)){
	            //if (cPage < totalPage ) {
        		//html.append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\" class='btn'").append("\" title='마지막 페이지' >");
            	html.append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\" class='btn'").append(" title='마지막 페이지' >");//(vary)
	            //}
            	html.append("<img src=\"").append(right02Img).append("\" border=\"0\" ").append(" alt=\"마지막 페이지\" />");
	            //if (cPage < totalPage ) {
	                html.append("</a>");
	            //}
            }
            html.append("</li>\n");
            html.append("</ul>");


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
     * @param endPage The endPage to set.
     */
    public void setEndPage(String endPage) {
        this.endPage = endPage;
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
     * @param startPage The startPage to set.
     */
    public void setStartPage(String startPage) {
        this.startPage = startPage;
    }
    /**
     * @param total The total to set.
     */
    public void setTotal(String total) {
        this.total = total;
    }

    /**
     * @param uri The uri to set.
     */
    public void setUri(String uri) {
        this.uri = uri;
    }


	public void setLeft01Img(String left01Img) {
		this.left01Img = left01Img;
	}


	public void setLeft02Img(String left02Img) {
		this.left02Img = left02Img;
	}


	public void setRight01Img(String right01Img) {
		this.right01Img = right01Img;
	}


	public void setRight02Img(String right02Img) {
		this.right02Img = right02Img;
	}




}
