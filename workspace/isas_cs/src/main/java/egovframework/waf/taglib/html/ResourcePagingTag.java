package egovframework.waf.taglib.html;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.waf.taglib.DefaultTagSupport;

/**
 * 페이징 태그
 * @author seominho
 *
 */
public class ResourcePagingTag extends DefaultTagSupport {

    
    private static final long serialVersionUID = -6420080584917643106L;

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private String width;
    private String height;
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
    
    private String space = "&nbsp;";
    private String left02Img = null;
    private String left01Img = "../images/ico/blet_prew.gif";
    private String right02Img = null;
    private String right01Img = "../images/ico/blet_next.gif";
    private String imageBar = "/";
    private String imageAlign = "align=\"absbottom\"";
    
    
    public int doStartTag() throws JspException {
        return (SKIP_BODY);
    }


    public int doEndTag() throws JspException {
        try {
            
            if ("A".equals(style)) {
            	left02Img = "/images/common/btn/btn_paging01.gif";
                left01Img = "/images/common/btn/btn_paging02.gif";
                right02Img = "/images/common/btn/btn_paging04.gif";
                right01Img = "/images/common/btn/btn_paging03.gif";
                imageBar = "<img src='/images/common/etc/bar_paging.gif' align='absmiddle' hspace=10 />";
                imageAlign = "";
                space="";
                
            }
            
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
            html.append("<!--b:paging-->\n");
            html.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"").append(width).append("\">");
            if (height != null) {
                html.append("<tr height=\"").append(height).append("\">");
            } else {
                html.append("<tr>");    
            }
            
            
            if (uri == null) {
                uri = request.getRequestURI();    
            }
            
            html.append("<td align=\"center\">");
            html.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
            html.append("<tr>");

            html.append("<td align=\"center\" width=\"14\">");
            if (cPage > 1) {
                html.append("<a href=\"").append(uri).append("?cPage=").append("1").append(parameters).append("\">");
            }
            if(left02Img != null){
            	html.append("<img src=\"").append(left02Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"처음\" hspace='2' />");
            }
            if (cPage > 1) {
                html.append("</a>");
            }
            html.append("</td>");
            
            html.append("<td align=\"center\" width=\"14\">");
            if (prePageSet > 0) {
                html.append("<a href=\"").append(uri).append("?cPage=").append(prePageSet).append(parameters).append("\">");
            }
            html.append("<img src=\"").append(left01Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"이전\" hspace='2'>");
            if (prePageSet > 0) {
                html.append("</a>");
            }
            html.append("</td>");
            
            html.append("<td align=\"center\"><nobr>&nbsp;");
            for (int i = startPage; i <= endPage; i++) {
                if ( i > startPage) {
                    html.append(imageBar).append(space);
                } else {
                    html.append(space);
                }
                if (i == cPage) {
                    html.append("<b>").append(i).append("</b>");
                } else {
                    //html.append("<a href=\"").append(uri).append("?cPage=").append(i).append(parameters).append("\">");
                	html.append("<a href=\"javascript:goPage(\'").append(i).append("\');\">");
                    html.append(i);
                    html.append("</a>");
                }
                html.append(space);
            }
            html.append("&nbsp;");
            html.append("</nobr></td>");
            
            html.append("<td align=\"center\" width=\"14\">");
            if (nextPageSet <= totalPage ) {
                html.append("<a href=\"").append(uri).append("?cPage=").append(nextPageSet).append(parameters).append("\">");
            }
            html.append("<img src=\"").append(right01Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"다음\" hspace='2'>");
            if (nextPageSet <= totalPage ) {
                html.append("</a>");
            }
            html.append("</td>");
            
            html.append("<td align=\"center\" width=\"14\">");
            if (cPage < totalPage ) {
                html.append("<a href=\"").append(uri).append("?cPage=").append(totalPage).append(parameters).append("\">");
            }
            if(right02Img != null){
            	html.append("<img src=\"").append(right02Img).append("\" border=\"0\" ").append(imageAlign).append(" alt=\"마지막\" hspace='2'>");
            }
            if (cPage < totalPage ) {
                html.append("</a>");
            }
            html.append("</td>");
            
            
            html.append("</tr>");
            html.append("</table>");
            html.append("</td>");
            
            html.append("</tr></table>\n");
            html.append("<!--e:paging-->\n");
            
            
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
     * @param height The height to set.
     */
    public void setHeight(String height) {
        this.height = height;
    }


    /**
     * @param imgType The imgType to set.
     */
    public void setStyle(String imgType) {
        this.style = imgType;
    }
    
    
    
    
}
