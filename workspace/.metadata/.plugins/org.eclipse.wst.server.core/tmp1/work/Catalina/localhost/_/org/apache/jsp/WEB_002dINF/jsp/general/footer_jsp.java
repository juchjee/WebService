/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.62
 * Generated at: 2020-04-27 07:57:44 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.general;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class footer_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<footer class=\"footer\">\r\n");
      out.write("\t\t<div class=\"foot_bx\">\r\n");
      out.write("\t\t\t<div class=\"f_top\">\r\n");
      out.write("\t\t\t\t<ul class=\"fgnb\">\r\n");
      out.write("\t\t\t\t\t<li><a href=\"/ISDS/cs/termsRule.do\" class=\"gray\">이용약관</a></li>\r\n");
      out.write("\t\t\t\t\t<li><a href=\"/ISDS/cs/privateRule.do\" class=\"gray\">개인정보처리방침</a></li>\r\n");
      out.write("\t\t\t\t\t<li><a href=\"/ISDS/cs/emailRule.do\" class=\"gray\">이메일무단수집거부</a></li>\r\n");
      out.write("\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t<div class=\"sitelinks\">\r\n");
      out.write("\t\t\t\t\t<span class=\"sitelink\">\r\n");
      out.write("\t\t\t\t\t\t<button type=\"button\">Family site</button>\r\n");
      out.write("\t\t\t\t\t\t<span class=\"sublink\" >\r\n");
      out.write("\t\t\t\t\t\t\t<a href=\"http://www.inushaus.com/main/index.asp\" title=\"새창 열림\" target=\"_blank\" style=\"color:#fff\">이누스 하우스</a>\r\n");
      out.write("\t\t\t\t\t\t\t<a href=\"http://www.inusmall.com/shop/main/index.php\" title=\"새창 열림\" target=\"_blank\" style=\"color:#fff\">이누스 몰</a>\r\n");
      out.write("\t\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<!--// sitelinks -->\r\n");
      out.write("\t\t\t</div><!--// f_top -->\r\n");
      out.write("\t\t\t<div class=\"f_btm\">\r\n");
      out.write("\t\t\t\t<address>\r\n");
      out.write("\t\t\t\t<!-- 20200427 ryul 법인분할 본점 소재지 변경 -->\r\n");
      out.write("<!-- \t\t\t\t\t<span>서울특별시 강남구 영동대로 741(청담동) 은성빌딩</span> -->\r\n");
      out.write("<!-- \t\t\t\t\t<span>COPYRIGHT ⓒ 2017 IS DONGSEO. ALL RIGHTS RESERVED.</span> -->\r\n");
      out.write("\t\t\t\t\t<span>충청남도 아산시 탕정면 탕정면로 350-41</span>\r\n");
      out.write("\t\t\t\t\t<span>COPYRIGHT ⓒ 2020 INUS CO.,LTD  ALL RIGHTS RESERVED.</span>\r\n");
      out.write("\t\t\t\t</address>\r\n");
      out.write("\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t<li>대표전화 : 1588-8613</li>\r\n");
      out.write("<!-- \t\t\t\t\t<li class=\"fax\">Fax : 02-3445-1687</li> -->\r\n");
      out.write("\t\t\t\t\t<li class=\"fax\">Fax : 041-530-3701</li>\r\n");
      out.write("\t\t\t\t</ul>\r\n");
      out.write("\t\t\t</div><!--// f_btm -->\r\n");
      out.write("\t\t</div><!--// foot_bx -->\r\n");
      out.write("\t</footer>\r\n");
      out.write("\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
