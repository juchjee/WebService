/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.62
 * Generated at: 2019-03-14 02:11:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.site.mng.amM4.amM406;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class amM406_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/tld/html.tld", Long.valueOf(1541752522000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fselectList_0026_005fscript_005foptionValues_005foptionNames_005fname_005flistValue_005flistName_005flist_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fselectList_0026_005fscript_005foptionValues_005foptionNames_005fname_005flistValue_005flistName_005flist_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fselectList_0026_005fscript_005foptionValues_005foptionNames_005fname_005flistValue_005flistName_005flist_005fnobody.release();
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
      response.setContentType("text/html;charset=utf-8");
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("\t<style>\r\n");
      out.write("\t\tdiv.jqx-item{cursor:pointer;}\r\n");
      out.write("\t</style>\r\n");
      out.write("<script type=\"text/javaScript\" defer=\"defer\">\r\n");
      out.write("\tvar contUrl = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${rootUri}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${conUrl}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("amM406\";\r\n");
      out.write("\tfunction init(){\r\n");
      out.write("\t\tfnSearchInit();\r\n");
      out.write("\t\tfnSearch();\r\n");
      out.write("\t\tfnEvent();\r\n");
      out.write("\t}\r\n");
      out.write("\t/*----------------------------------------------------------------------------------------------\r\n");
      out.write("\t * Grid 초기값 셋팅\r\n");
      out.write("\t *----------------------------------------------------------------------------------------------*/\r\n");
      out.write("\tvar _columns = [\r\n");
      out.write("\t\t \t { text: '배너위치', datafield: 'bannerLocalNm',  width: '12%', cellsalign: 'left', align: 'center'}\r\n");
      out.write("\t\t\t,{ text: '배너제목', datafield: 'bannerTitle',  width: '40%', cellsalign: 'left', align: 'center'}\r\n");
      out.write("\t\t\t,{ text: '게시기간', datafield: 'bannerDt',  width: '16%', cellsalign: 'center', align: 'center'}\r\n");
      out.write("\t\t\t,{ text: '노출상태', datafield: 'bannerStatusNm',  width: '8%', cellsalign: 'center', align: 'center'}\r\n");
      out.write("\t\t\t,{ text: '등록자', datafield: 'regNm',  width: '8%', cellsalign: 'center', align: 'center'}\r\n");
      out.write("\t\t\t,{ text: '등록일', datafield: 'regDt',  width: '8%', cellsalign: 'center', align: 'center', cellsformat: 'yyyy-MM-dd'}\r\n");
      out.write("\t\t\t,{ text: '관리', datafield: 'popButton',  width: '8%', cellsalign: 'center', align: 'center',\r\n");
      out.write("\t\t\t\tcolumntype: 'button', cellsrenderer: function () {\r\n");
      out.write("\t                return \"수정\";\r\n");
      out.write("\t             }, buttonclick: function (row) {\r\n");
      out.write("\t                var dataRecord = $(\"#jqxgrid\").jqxGrid('getrowdata', row);\r\n");
      out.write("\r\n");
      out.write("\t            \t$.fancybox.open({\r\n");
      out.write("\t\t\t\t\t\thref: \"amM406P.action?bannerCd=\"+dataRecord.bannerCd,\r\n");
      out.write("\t\t\t\t\t\ttype: \"iframe\",\r\n");
      out.write("\t\t\t\t\t\tmaxWidth\t: 920,\r\n");
      out.write("\t\t\t\t\t\tmaxHeight\t: 665,\r\n");
      out.write("\t\t\t\t\t\twidth\t\t: 900,\r\n");
      out.write("\t\t\t\t\t\theight\t\t: 665,\r\n");
      out.write("\t\t\t\t\t\tautoSize\t: false\r\n");
      out.write("\t\t\t\t\t});\r\n");
      out.write("\t            }\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t,{ text: 'bannerCd', datafield: 'bannerCd', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'bannerLocalCd', datafield: 'bannerLocalCd', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'attchFilePath', datafield: 'attchFilePath', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'attchMobileFilePath', datafield: 'attchMobileFilePath', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'attchCd', datafield: 'attchCd', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'attchMobileCd', datafield: 'attchMobileCd', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'bannerLink', datafield: 'bannerLink', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'bannerStartDt', datafield: 'bannerStartDt', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'bannerEndDt', datafield: 'bannerEndDt', hidden:true}\r\n");
      out.write("\t\t\t,{ text: 'bannerWidthSize', datafield: 'bannerWidthSize', hidden:true }\r\n");
      out.write("\t\t\t,{ text: 'bannerHeightSize', datafield: 'bannerHeightSize', hidden:true }\r\n");
      out.write("\t\t\t,{ text: 'bannerMobileWidthSize', datafield: 'bannerMobileWidthSize', hidden:true }\r\n");
      out.write("\t\t\t,{ text: 'bannerMobileHeightSize', datafield: 'bannerMobileHeightSize', hidden:true }\r\n");
      out.write("\t\t\t,{ text: 'bannerStatus', datafield: 'bannerStatus', hidden:true }\r\n");
      out.write("\t\t\t,{ text: 'regId', datafield: 'regId', hidden:true }\r\n");
      out.write("\t\t\t,{ text: 'backgRoundColor', datafield: 'backgRoundColor', hidden:true }\r\n");
      out.write("\t\t];\r\n");
      out.write("\r\n");
      out.write("\tvar _datafields = [\r\n");
      out.write("\t\t\t { name: 'bannerLocalNm', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerTitle', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerDt', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerStatusNm', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'regNm', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'regDt', type: 'date'}\r\n");
      out.write("\t\t\t,{ name: 'bannerCd', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerLocalCd', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'attchFilePath', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'attchMobileFilePath', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'attchCd', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'attchMobileCd', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerLink', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerStartDt', type: 'date'}\r\n");
      out.write("\t\t\t,{ name: 'bannerEndDt', type: 'date'}\r\n");
      out.write("\t\t\t,{ name: 'bannerWidthSize', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerHeightSize', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerMobileWidthSize', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerMobileHeightSize', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'bannerStatus', type: 'string'}\r\n");
      out.write("\t\t\t,{ name: 'backgRoundColor', type: 'string'}\r\n");
      out.write("\t\t];\r\n");
      out.write("\r\n");
      out.write("\tfunction fnSearchInit(){\r\n");
      out.write("\t\tdateTimeInput(\"bannerDt\");\r\n");
      out.write("\t\tfnGridOption('jqxgrid',{\r\n");
      out.write("\t\t\theight:365\r\n");
      out.write("\t       ,columns: _columns\r\n");
      out.write("\t       ,selectionmode: 'none'\r\n");
      out.write("\t    });\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction fnSearch(){\r\n");
      out.write("\t\tvar data = {};\r\n");
      out.write("\t\t$(\"#searchForm\").serializeArray().map(function(x){data[x.name] = x.value;});\r\n");
      out.write("\t\tvar dataAdapter = new $.jqx.dataAdapter({\r\n");
      out.write("    \t\tdatatype: \"json\",\r\n");
      out.write("            datafields: _datafields,\r\n");
      out.write("            type: \"POST\",\r\n");
      out.write("            data: data,\r\n");
      out.write("            url: \"amM406.action\",\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\t$(\"#jqxgrid\").jqxGrid({source: dataAdapter});\r\n");
      out.write("\t\tfnResetGridEditData('jqxgrid');\r\n");
      out.write("\t\treturn false;\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar fancybox = {\r\n");
      out.write("\t\twidth\t\t: 900,\r\n");
      out.write("\t\theight\t\t: 600,\r\n");
      out.write("\t\tautoSize\t: false,\r\n");
      out.write("\t\thelpers\t: {\r\n");
      out.write("\t\t\ttitle\t: {\r\n");
      out.write("\t\t\t\ttype: 'outside'\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tthumbs\t: {\r\n");
      out.write("\t\t\t\twidth\t: 50,\r\n");
      out.write("\t\t\t\theight\t: 50\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t};\r\n");
      out.write("\r\n");
      out.write("\tfunction fnEvent(){\r\n");
      out.write("\t\t$(\"#btn_Search\").on('click', fnSearch);//검색\r\n");
      out.write("\t\t$(\"#jqxgrid\").on(\"celldoubleclick\", function (event){\r\n");
      out.write("\t\t\t$(\"#popGallery\").html(\"\");\r\n");
      out.write("\t\t\tvar args = event.args;\r\n");
      out.write("\t\t\tvar dataRecord = $(\"#jqxgrid\").jqxGrid('getrowdata', args.rowindex);\r\n");
      out.write("\t\t\tvar imgArr = [{href : dataRecord.attchFilePath, title : '[PC] ' + dataRecord.bannerTitle}];\r\n");
      out.write("\t\t\tif(dataRecord.attchMobileCd){\r\n");
      out.write("\t\t\t\timgArr[1] = {href : dataRecord.attchMobileFilePath, title : '[MOBILE] ' + dataRecord.bannerTitle}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tsetTimeout(function(){\r\n");
      out.write("\t\t\t$.fancybox(imgArr, fancybox);\r\n");
      out.write("\t\t\t},200);\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t$(\"#registBtn, #modifyBtn\").fancybox({\r\n");
      out.write("\t\t\ttype: \"iframe\",\r\n");
      out.write("\t\t\tmaxWidth\t: 920,\r\n");
      out.write("\t\t\tmaxHeight\t: 665,\r\n");
      out.write("\t\t\twidth\t\t: 900,\r\n");
      out.write("\t\t\theight\t\t: 665,\r\n");
      out.write("\t\t\tautoSize\t: false\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction fnFancyboxCloseHandler(){\r\n");
      out.write("\t\t$('a.fancybox-item.fancybox-close').click()\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<div class=\"pageContScroll_st2\">\r\n");
      out.write("\t\t<div class=\"top_box\">\r\n");
      out.write("\t\t\t<form name=\"searchForm\" id=\"searchForm\">\r\n");
      out.write("\t\t\t\t<div class=\"table_type\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t<caption>등록일 검색으로 구성된 팝업 목록에 대한 검색 테이블입니다.</caption>\r\n");
      out.write("\t\t\t\t\t\t<colgroup>\r\n");
      out.write("\t\t\t\t\t\t\t<col style=\"width: 135px;\" />\r\n");
      out.write("\t\t\t\t\t\t\t<col style=\"width: 35%;\" />\r\n");
      out.write("\t\t\t\t\t\t\t<col style=\"width: 135px;\" />\r\n");
      out.write("\t\t\t\t\t\t\t<col style=\"width: *\" />\r\n");
      out.write("\t\t\t\t\t\t</colgroup>\r\n");
      out.write("\t\t\t\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<th scope=\"row\">게시기간</th>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"min-width: 370px\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id='bannerDt' name=\"bannerDt\"></div>\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<th scope=\"row\">배너명</th>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><input name=\"bannerTitle\" type=\"text\" style=\"width: 200px;\" /></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<th scope=\"row\">배너위치</th>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      if (_jspx_meth_html_005fselectList_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<th scope=\"row\">노출상태</th>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td><select name='bannerStatus' style=\"width: 120px;\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<option value=''>전체</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<option value='Y' selected=\"selected\">노출</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<option value='N'>비노출</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t</select></td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t</tbody>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</form>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<!-- // top_box -->\r\n");
      out.write("\t\t\t<div class=\"btn_area marB35\" >\r\n");
      out.write("\t\t\t<div class=\"center\">\r\n");
      out.write("\t\t\t\t<a id=\"btn_Search\" class=\"btn_blue_line2\" href=\"javascript:;\">검색</a>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div class=\"right\" style=\"line-height:40px;\">\r\n");
      out.write("\t\t\t\t<a id=\"registBtn\" class=\"btn_type2\" data-fancybox-type=\"iframe\" href=\"amM406P.action\">신규등록</a>\r\n");
      out.write("\t\t\t<a class=\"btn_type2 btn_icon5\" id=\"btnExcel\" style=\"margin-left:0px;\"  href=\"javascript:;\" onclick=\"grideExportExcel('jqxgrid','배너관리목록');\">엑셀다운로드</a>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t<!-- // top_box -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<div class=\"grid_type1\">\r\n");
      out.write("\t\t\t<div id=\"jqxgrid\"></div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>");
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

  private boolean _jspx_meth_html_005fselectList_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  html:selectList
    egovframework.waf.taglib.html.SelectListTag _jspx_th_html_005fselectList_005f0 = (egovframework.waf.taglib.html.SelectListTag) _005fjspx_005ftagPool_005fhtml_005fselectList_0026_005fscript_005foptionValues_005foptionNames_005fname_005flistValue_005flistName_005flist_005fnobody.get(egovframework.waf.taglib.html.SelectListTag.class);
    _jspx_th_html_005fselectList_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fselectList_005f0.setParent(null);
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setName("bannerLocalCd");
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = optionNames type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setOptionNames("전체");
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = optionValues type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setOptionValues("");
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = list type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setList((java.util.List) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${eBanner}", java.util.List.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = listValue type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setListValue("bannerLocalCd");
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = listName type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setListName("bannerLocalNm");
    // /WEB-INF/jsp/site/mng/amM4/amM406/amM406.jsp(182,9) name = script type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselectList_005f0.setScript("style=\"width: 120px;\"");
    int _jspx_eval_html_005fselectList_005f0 = _jspx_th_html_005fselectList_005f0.doStartTag();
    if (_jspx_th_html_005fselectList_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fselectList_0026_005fscript_005foptionValues_005foptionNames_005fname_005flistValue_005flistName_005flist_005fnobody.reuse(_jspx_th_html_005fselectList_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fselectList_0026_005fscript_005foptionValues_005foptionNames_005fname_005flistValue_005flistName_005flist_005fnobody.reuse(_jspx_th_html_005fselectList_005f0);
    return false;
  }
}
