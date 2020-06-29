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
public class PagingTag extends DefaultTagSupport {

    
    private static final long serialVersionUID = -6420080584917643106L;

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private String width;
    private String uri;
    private String parameters;
    private String numOfRows;
    private String numOfPages;
    private String startPage;
    private String endPage;
    private String totalPage;
    private String cPage;
    private String total;
    
    private String style;
    
    private String space = "";
    private String left02Img = "../img/common/btn_first.gif";
    private String left01Img = "../img/common/btn_prev.gif";
    private String right01Img = "../img/common/btn_next.gif";
    private String right02Img = "../img/common/btn_last.gif";
    private String imageBar = " ";
    private String imageAlign = "align=\"absmiddle\"";
    
    
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

            
            if (uri == null) {
            	if(request.getAttribute("requestURI") != null) //.do
                	uri = (String)request.getAttribute("requestURI");
                else{
                    uri = request.getRequestURI();
                }
            }
            
            
            if("A".equals(style)){ //관리자
            	
                left01Img = "/strmctm/images/button/b_first.gif";
                left02Img = "/strmctm/images/button/b_prev.gif";
                right01Img = "/strmctm/images/button/b_next.gif";
                right02Img = "/strmctm/images/button/b_end.gif";
                imageBar = " ";
                imageAlign = "align='absmiddle'";
                space="";
                
	            
	            
	            html.append("<ul>\n");
	            //처음
	            html.append("<li class='prev'>");
	            if(left02Img != null){
		            if (cPage > 1) {
	                	html.append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\">\n");
		            }
	            	html.append("<img src=\"").append(left01Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"처음\">\n");
		            if (cPage > 1) {
		                html.append("</a>");
		            }
	            }
	            
	            //이전
	            if (prePageSet > 0) {
                	html.append("<a href=\"").append(uri).append("?cPage=").append(prePageSet).append(parameters).append("\">");
	            }
            	html.append("<img src=\"").append(left02Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"이전\">");
	
	            if (prePageSet > 0) {
	                html.append("</a>");
	            }
	            html.append("</li>\n");
	            
	            
	            
	            //페이징
            	html.append("<li class='num'>");

            	for (int i = startPage; i <= endPage; i++) {
	                if ( i > startPage) {
	                    html.append(imageBar).append(space);
	                } else {
	                    html.append(space);
	                }
	                if (i == cPage) { //현재페이지
	                	html.append("<a href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\" class=\"now\">");
	                    html.append(i);
                		html.append("</a>\n");
	                } else {
                		html.append("<a href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\">");
	                    html.append(i);
                		html.append("</a>\n");
	                }
	                html.append(space);
	            }
            	html.append("</li>\n");
	            
            	//다음
	            html.append("<li class='next'>");
	            if (nextPageSet <= totalPage ) {
            		html.append("<a href=\"").append(uri).append("?cPage=").append(nextPageSet).append(parameters).append("\">\n");
	            }
            	html.append("<img src=\"").append(right01Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"다음\">\n");
	            if (nextPageSet <= totalPage ) {
	                html.append("</a>");
	            }
	            
	            //마지막
	            if(right02Img != null){
		            if (cPage < totalPage ) {
	            		html.append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\">");
		            }
	            	html.append("<img src=\"").append(right02Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"마지막\">");
		            if (cPage < totalPage ) {
		                html.append("</a>");
		            }
	            }
	            html.append("</li>\n");
	            html.append(cPage).append(" / ").append(totalPage);
	            html.append("</ul>");
            	
            }else if("B".equals(style)){ //홈빌더
            	
                left01Img = "/homebuilder/images/btn/btn_first.gif";
                left02Img = "/homebuilder/images/btn/btn_preview.gif";
                right01Img = "/homebuilder/images/btn/btn_next.gif";
                right02Img = "/homebuilder/images/btn/btn_last.gif";
                imageBar = " ";
                imageAlign = "align='absmiddle'";
                space="";
                
	              
	            
	            
	            if(left02Img != null){
		            if (cPage > 1) {
	                	html.append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\">\n");
		            }
	            	html.append("<img src=\"").append(left01Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"처음\">\n");
		            if (cPage > 1) {
		                html.append("</a>");
		            }
	            }
	            
	            //이전
	            if (prePageSet > 0) {
                	html.append("<a href=\"").append(uri).append("?cPage=").append(prePageSet).append(parameters).append("\">");
	            }
            	html.append("<img src=\"").append(left02Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"이전\">");
	
	            if (prePageSet > 0) {
	                html.append("</a>");
	            }

	            
	            
	            

            	for (int i = startPage; i <= endPage; i++) {
	                /*if ( i > startPage) {
	                    html.append(imageBar).append(space);
	                } else {
	                	 html.append(imageBar).append(space);
	                }*/
            		html.append(imageBar).append(space);
	                if (i == cPage) { //현재페이지
	                	html.append("<a href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\" class=\"now\">");
	                    html.append("<span class=\"pagingOn\">"+i+"</span>\n");
                		html.append("</a>\n");
	                } else {
                		html.append("<a href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\">");
	                    html.append(i);
                		html.append("</a>\n");
	                }
	                html.append(space);
	            }

	            
            	//다음
	            if (nextPageSet <= totalPage ) {
            		html.append("<a href=\"").append(uri).append("?cPage=").append(nextPageSet).append(parameters).append("\">\n");
	            }
            	html.append("<img src=\"").append(right01Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"다음\">\n");
	            if (nextPageSet <= totalPage ) {
	                html.append("</a>");
	            }
	            
	            //마지막
	            if(right02Img != null){
		            if (cPage < totalPage ) {
	            		html.append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\">");
		            }
	            	html.append("<img src=\"").append(right02Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"마지막\">");
		            if (cPage < totalPage ) {
		                html.append("</a>");
		            }
	            }
            	
            } else{ //사용자 
        	
            		
        		left01Img = "/images/common/board/btnPrevPage.gif";
                left02Img = "/images/common/board/btnFirstPage.gif";
                right01Img = "/images/common/board/btnNextPage.gif";
                right02Img = "/images/common/board/btnLastPage.gif";
            	
            	
                imageBar = " ";
                imageAlign = "";
                space=" ";
                
	            
	            
	            //처음
	            if (cPage > 1) {
                	html.append("<span class=\"").append("firstPage\">").append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\" title=\"첫 페이지\">\n");
                	html.append("&lt;&lt;");
	                html.append("</a>").append("</span>");
	            }else{
	            	html.append("<span class=\"").append("firstPage\">");
	            	html.append("&lt;&lt;");
	            	html.append("</span>");
	            }
	            html.append(space);
	            //이전
	            if (prePageSet > 0) {
                	html.append("<span class=\"").append("prevPage\">").append("<a href=\"").append(uri).append("?cPage=").append(prePageSet).append(parameters).append("\" title=\"이전 페이지\">");
                	html.append("&lt;");
	                html.append("</a>").append("</span>");
	            }else{
	            	html.append("<span class=\"").append("prevPage\">");
	            	html.append("&lt;");
	            	html.append("</span>");
	            }
	            
	            html.append("\n");
	            
	            //페이징

            	for (int i = startPage; i <= endPage; i++) {
	                if ( i > startPage) {
	                    html.append(imageBar).append(space);
	                } else {
	                    html.append(space);
	                }
	                if (i == cPage) { //현재페이지
	                	html.append("<span class=\"").append("now\" title=\"").append("현재페이지\">");
	                    html.append(i);
                		html.append("</span>\n");
	                } else {
                		html.append("<a href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\" title=\"").append(i).append("페이지로\">");
	                    html.append(i);
                		html.append("</a>\n");
	                }
	                html.append(space);
	            }
	            
            	//다음
	            if (nextPageSet <= totalPage ) {
            		html.append("<span class=\"").append("nextPage\">").append("<a href=\"").append(uri).append("?cPage=").append(nextPageSet).append(parameters).append("\" title=\"다음 페이지\">\n");
            		html.append("&gt;");
	            	html.append("</a>").append("</span>");
	            }else{
	            	html.append("<span class=\"").append("nextPage\">");
	            	html.append("&gt;");
	            	html.append("</span>");
	            }
	            html.append(space);
	            //마지막
		            if (cPage < totalPage ) {
	            		html.append("<span class=\"").append("lastPage\">").append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\" title=\"").append("마지막 페이지\">");
	            		html.append("&gt;&gt;");
		            	html.append("</a>").append("</span>");
		            }else{
		            	html.append("<span class=\"").append("lastPage\">");
		            	html.append("&gt;&gt;");
		            	html.append("</span>");
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
