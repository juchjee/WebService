/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.62
 * Generated at: 2018-11-29 07:37:58 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.mobile.scm.stockItem;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class mStockItemGrdDtlR_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=UTF-8");
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
      out.write("<style>\r\n");
      out.write(".dhx_loading_overlay{\r\n");
      out.write("\twidth:100%;\r\n");
      out.write("\theight:100%;\r\n");
      out.write("\tbackground-color:#D6D6D6;\r\n");
      out.write("\topacity:0.5;\r\n");
      out.write("\tbackground-image:url(/component/dxTouch/codebase/imgs/loading.png);\r\n");
      out.write("\tbackground-repeat:no-repeat;\r\n");
      out.write("\tbackground-position:center;\r\n");
      out.write("};\r\n");
      out.write(".dhx_form{\r\n");
      out.write("background: #FFFFFF;\r\n");
      out.write("};\r\n");
      out.write("</style>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("var w = $(window).width(); \r\n");
      out.write("var h = $(window).height();\r\n");
      out.write("var h = h-175;\r\n");
      out.write("var date = dateformat(new Date());\r\n");
      out.write("var fullDate = new Date();\r\n");
      out.write("var hour = fullDate.getHours()+'';\r\n");
      out.write("var minute = fullDate.getMinutes();\r\n");
      out.write("if(minute <= 9){\r\n");
      out.write("\tminute = '0'+minute;\r\n");
      out.write("}\r\n");
      out.write("var form = { id: 'app', view: 'layout',\r\n");
      out.write("\t\trows: [\r\n");
      out.write("\t\t\t\t{ view: 'layout', type: 'wide',\r\n");
      out.write("\t\t\t\t\trows: [\r\n");
      out.write("\t\t\t\t\t\t{   type: \"clean\", height: 45,\r\n");
      out.write("\t\t\t\t\t        cols: [\r\n");
      out.write("\t\t\t\t\t          { view: \"button\", type: \"round\", label: \"돌아가기\", click: \"fn_back();\" }, \r\n");
      out.write("\t\t\t\t\t          { view: \"button\", type: \"round\", label: \"조회\", click: \"fn_search();\" }, \r\n");
      out.write("\t\t\t\t\t\t    ]\r\n");
      out.write("\t\t\t\t\t    },\r\n");
      out.write("\t\t\t\t\t\t{ view: 'form', scroll: false, height : 130,\r\n");
      out.write("\t\t\t\t\t\t\telements: [\r\n");
      out.write("\t\t\t\t\t\t\t\t{ view: 'text', label: '기준일자', id: 'stdDt', value:date, readonly:true},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ view: \"text\", label: '품목코드', id: \"itmCd\", readonly:true},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ view: \"text\", label: '품목명', id: \"itmNm\", readonly:true},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ view: \"text\", label: '공장코드', id: \"facCd\", readonly:true},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ view: \"text\", label: '품목정보', id: \"itmInfo\", readonly:true},\r\n");
      out.write("\t\t\t\t\t\t\t], id: 'frmMain'\r\n");
      out.write("\t\t\t\t\t\t},\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t{ view: 'grid', datatype: 'json', id:'gridMain', select: true, scroll: \"xy\", height : h,\r\n");
      out.write("\t\t\t\t\t\t\tfields: [\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ view:\"combo\", label:'창고정보', template : function(obj) {\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar whCd = fn_baseCdSrch(\"whCd\", obj.whCd);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn whNm;\r\n");
      out.write("// \t\t\t\t\t\t\t\t}, type: 'custom', align: 'left'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 60 , label: '구분'\t, template: function(obj) {\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar itmBc = fn_baseCdSrch(\"itmBc\", obj.itmBc);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn itmBcNm;\r\n");
      out.write("// \t\t\t\t\t\t\t\t}, type: 'custom', align: 'center'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 60\t, label: '규격'\t, template: '#stdNm#'\t, type: 'custom', align: 'center'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 60\t, label: '색상'\t, template: function(obj) {\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar tcolor = fn_baseCdSrch(\"color\", obj.tcolor);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn tcolorNm;\r\n");
      out.write("// \t\t\t\t\t\t\t\t} , type: 'custom', align: 'center'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 70\t, label: '사이즈'\t, template: function(obj) {\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar tsize = fn_baseCdSrch(\"size\", obj.tsize);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn tsizeNm;\r\n");
      out.write("// \t\t\t\t\t\t\t\t} , type: 'custom', align: 'center'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 70\t, label: '등급'\t, template: function(obj) {\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar tgrade = fn_baseCdSrch(\"grade\", obj.tgrade);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn tgradeNm;\r\n");
      out.write("// \t\t\t\t\t\t\t\t} , type: 'custom', align: 'center'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ view:\"combo\", label:'창고정보', template : '#whNm#', type: 'custom', align: 'left'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ width: 60\t, label: '색상'\t, template: '#tcolorNm#' , type: 'custom', align: 'center'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ width: 70\t, label: '사이즈'\t, template: '#tsizeNm#' , type: 'custom', align: 'center'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ width: 70\t, label: '등급'\t, template: '#tgradeNm#' , type: 'custom', align: 'center'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 60\t, label: '기초'\t, template: function(obj){\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar basQty = addComma(obj.basQty);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn basQty;\r\n");
      out.write("// \t\t\t\t\t\t\t\t}, type: 'custom', align: 'right'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 60\t, label: '입고'\t, template: function(obj){\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar inQty = addComma(obj.inQty);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn inQty;\r\n");
      out.write("// \t\t\t\t\t\t\t\t}, type: 'custom', align: 'right'},\r\n");
      out.write("// \t\t\t\t\t\t\t\t{ width: 60\t, label: '출고'\t, template: function(obj){\r\n");
      out.write("// \t\t\t\t\t\t\t\t\tvar outQty = addComma(obj.outQty);\r\n");
      out.write("// \t\t\t\t\t\t\t\t\treturn outQty;\r\n");
      out.write("// \t\t\t\t\t\t\t\t}, type: 'custom', align: 'right'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ width: 60\t, label: '재고'\t, template: function(obj){\r\n");
      out.write("\t\t\t\t\t\t\t\t\tvar endQty = addComma(obj.endQty);\r\n");
      out.write("\t\t\t\t\t\t\t\t\treturn endQty;\r\n");
      out.write("\t\t\t\t\t\t\t\t}, type: 'custom', align: 'right'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ width: 60 , label: '구분'\t, template: '#itmBcNm#', type: 'custom', align: 'center'},\r\n");
      out.write("\t\t\t\t\t\t\t\t{ width: 60\t, label: '규격'\t, template: '#stdNm#'\t, type: 'custom', align: 'center'},\r\n");
      out.write("\t\t\t\t\t\t\t], header: true,\r\n");
      out.write("\t\t\t\t\t\t},\r\n");
      out.write("\t\t\t\t\t], id: 'stockItem'\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t]\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("var loginView = {\r\n");
      out.write("    type: \"clean\",\r\n");
      out.write("    css: \"layout\",\r\n");
      out.write("    rows: [toolbar, {gravity: 1}, { type: \"clean\", cols: [{ width: 15 }, form, {width: 15}]}, {gravity: 2}]\r\n");
      out.write("};\r\n");
      out.write("\r\n");
      out.write("var search = \"\";\r\n");
      out.write("dhx.ready(function() {\r\n");
      out.write("\tdhx.ui.fullScreen();\r\n");
      out.write("    dhx.ui(form); \r\n");
      out.write("    \r\n");
      out.write("    search = window.location.search;\r\n");
      out.write("    if(search) {\r\n");
      out.write("    \tif(fn_setParam(search)) {\r\n");
      out.write("    \t\tfn_search();\r\n");
      out.write("    \t}\r\n");
      out.write("\t}\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function fn_setParam(search) {\r\n");
      out.write("\tvar vb = true;\r\n");
      out.write("\tvar uri = decodeURI(search);\r\n");
      out.write("\t\r\n");
      out.write("\tif(uri != \"\" || uri != null || uri != undefined) {\r\n");
      out.write("\t\turi = uri.slice(1, uri.length);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar param = uri.split('?');\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfor(var i=0; i < param.length; i++) {\r\n");
      out.write("\t\t\tvar devide = param[i].split('=');\r\n");
      out.write("\t\t\t$$(devide[0]).setValue(devide[1]);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\tvb = false;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\treturn vb;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function fn_back() {\r\n");
      out.write("\tlocation.assign(\"/mobile/scm/stockItem/mStockItemR.do\" + \"?stdDt=\" + $$('stdDt').getValue() + \"?facCd=\" + $$('facCd').getValue() + \"?itmInfo=\" + $$('itmInfo').getValue());\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function fn_search(){\r\n");
      out.write("\tvar gridMain = $$('gridMain');\r\n");
      out.write("\tdhx.extend(gridMain, dhx.OverlayBox);\r\n");
      out.write("\tgridMain.showOverlay();\r\n");
      out.write("\r\n");
      out.write("\tvar obj = {};\r\n");
      out.write("\tobj.stdDt = searchDate($$('stdDt').wg,\"-\");\r\n");
      out.write("\tobj.facCd = $$('facCd').getValue();\r\n");
      out.write("\tobj.itmCd = $$('itmCd').getValue();\r\n");
      out.write("\t\r\n");
      out.write("\tmobileAjax(\"/mobile/scm/stockItem/stockItemGrdDtlR/list\",obj,function(data){\r\n");
      out.write("\t\tsearch = \"\";\r\n");
      out.write("\t\tgridMain.clearAll();\r\n");
      out.write("\t\tgridMain.define('datatype', 'json');\r\n");
      out.write("\t\tgridMain.define('data', data);\r\n");
      out.write("\t\tgridMain.adjust();\r\n");
      out.write("\t\tfn_searchCB();\r\n");
      out.write("\t\tgridMain.refresh();\r\n");
      out.write("\t\tgridMain.hideOverlay();\r\n");
      out.write("\t});\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("var tcolorNm = \"\";\r\n");
      out.write("var tsizeNm = \"\";\r\n");
      out.write("var tgradeNm = \"\";\r\n");
      out.write("var whNm = \"\";\r\n");
      out.write("var itmBcNm = \"\";\r\n");
      out.write("function fn_baseCdSrch(div, cd){\r\n");
      out.write("\ttcolorNm = \"\";\r\n");
      out.write("\ttsizeNm = \"\";\r\n");
      out.write("\ttgradeNm = \"\";\r\n");
      out.write("\twhNm = \"\";\r\n");
      out.write("\titmBcNm = \"\";\r\n");
      out.write("\t\r\n");
      out.write("\tvar obj = {};\r\n");
      out.write("\t\r\n");
      out.write("\tif(\"whCd\"==div) {\r\n");
      out.write("\t\tobj.whCd = cd;\r\n");
      out.write("\t\tmobileAjax(\"/mobile/scm/stockItem/stockItemGrdDtlR/listWhNm\",obj,function(data){\r\n");
      out.write("\t\t\t\twhNm = data[0].whNm;\r\n");
      out.write("\t\t});\t\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\tobj.baseCd = cd;\r\n");
      out.write("\t\tmobileAjax(\"/mobile/scm/stockItem/stockItemGrdDtlR/listBaseNm\",obj,function(data){\r\n");
      out.write("\t\t\tif(\"color\"==div) {\r\n");
      out.write("\t\t\t\ttcolorNm = data[0].title;\r\n");
      out.write("\t\t\t} else if (\"size\"==div) {\r\n");
      out.write("\t\t\t\ttsizeNm = data[0].title;\r\n");
      out.write("\t\t\t} else if(\"grade\"==div) {\r\n");
      out.write("\t\t\t\ttgradeNm = data[0].title;\r\n");
      out.write("\t\t\t} else if(\"itmBc\"==div) {\r\n");
      out.write("\t\t\t\titmBcNm = data[0].title;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function fn_searchCB() {\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function addComma(num) {\r\n");
      out.write("  var regexp = /\\B(?=(\\d{3})+(?!\\d))/g;\r\n");
      out.write("//   return parseInt(num.toString().replace(regexp, ','));\r\n");
      out.write("  return parseInt(num).toString().replace(regexp,',');\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("<form id=\"pForm\" name=\"pForm\">\r\n");
      out.write("<input type=\"hidden\" id=\"gridId\" name=\"gridId\">\r\n");
      out.write("</form>");
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
