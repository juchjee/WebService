/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.62
 * Generated at: 2019-03-14 02:20:21 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.site.mng.amM7.amM705;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class amM705_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/tld/html.tld", Long.valueOf(1541752522000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.release();
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
      out.write("\t");
      if (_jspx_meth_c_005fimport_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t<!-- 설정관리 : 부서별 권한설정 -->\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javaScript\" defer=\"defer\">\r\n");
      out.write("\r\n");
      out.write("\tvar contUrl = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${rootUri}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${conUrl}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("amM705\";\r\n");
      out.write("\t/*----------------------------------------------------------------------------------------------\r\n");
      out.write("\t * 화면 load시 실행 함수 (onload)\r\n");
      out.write("\t *----------------------------------------------------------------------------------------------*/\r\n");
      out.write("\tfunction init(){\r\n");
      out.write("\t\t// 초기 그리드셋팅\r\n");
      out.write("\t\tfnSearchInit();\r\n");
      out.write("\t\t// 초기 데이터 셋팅 (1차 메뉴)\r\n");
      out.write("\t\tfnSearch('');\r\n");
      out.write("\t \t// 이벤트\r\n");
      out.write("\t\tfnEvent();\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar _columns1 = [{ text: '권한명', datafield: 'admAuthNm', cellclassname: cellclass, width: '100%', cellsalign: 'center', align: 'center'},\r\n");
      out.write("\t                 { text: '권한여부', datafield: 'useFlagYn', hidden: true, cellclassname: cellclass, cellsalign: 'center', align: 'center'},\r\n");
      out.write("\t                 { text: '', datafield: 'admAuthCd', cellclassname: cellclass, cellsalign: 'center', align: 'center', hidden: true}];\r\n");
      out.write("\tvar _datafields1 = [{ name: 'admAuthNm', type: 'string'},\r\n");
      out.write("\t                    { name: 'useFlagYn', type: 'string'},\r\n");
      out.write("\t                    { name: 'admAuthCd', type: 'string'}];\r\n");
      out.write("\r\n");
      out.write("\tvar _columns2 = [{ text: '메뉴명', datafield: 'admMenuNm', width: '100%', align: 'center'},\r\n");
      out.write("\t                 { text: '그룹코드', datafield: 'admMenuGroup', hidden: true,  align: 'center'},\r\n");
      out.write("\t                 { text: '메뉴코드', datafield: 'admMenuCd', hidden: true,  align: 'center'},\r\n");
      out.write("\t                 { text: '권한별코드', datafield: 'admAuthMenuCd', hidden: true,  align: 'center'}];\r\n");
      out.write("\tvar _datafields2 = [{ name: 'admMenuNm', type: 'string'},\r\n");
      out.write("\t                    { name: 'admMenuGroup', type: 'string'},\r\n");
      out.write("\t                    { name: 'admMenuCd', type: 'string'},\r\n");
      out.write("\t                    { name: 'admAuthMenuCd', type: 'string'}];\r\n");
      out.write("\r\n");
      out.write("\tfunction fnSearchInit(){\r\n");
      out.write("\t\tfnGridOption('authList1',{\r\n");
      out.write("\t\t\teditable: true\r\n");
      out.write("\t\t\t,editmode: 'dblclick'\r\n");
      out.write("\t\t\t,selectionmode: 'singlecell'\r\n");
      out.write("\t        ,columns: _columns1\r\n");
      out.write("\t        ,pageable: false\r\n");
      out.write("\t        ,sortable : false\r\n");
      out.write("    \t    ,altrows : true\r\n");
      out.write("\t        ,height : 250\r\n");
      out.write("\t    });\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\tvar treeSizeHeight = ($( window ).height() - 250);\r\n");
      out.write("\r\n");
      out.write("\t    if(treeSizeHeight <= 150){\r\n");
      out.write("\t    \ttreeSizeHeight = 150;\r\n");
      out.write("\t    }\r\n");
      out.write("\t\t\t$(\"#authList2\").jqxTreeGrid(\r\n");
      out.write("\t\t        {\r\n");
      out.write("\t\t            hierarchicalCheckboxes: true\r\n");
      out.write("\t\t            ,checkboxes: true\r\n");
      out.write("\t\t            ,columns: _columns2\r\n");
      out.write("\t\t            ,height: treeSizeHeight\r\n");
      out.write("\t\t            ,editable: true\r\n");
      out.write("\t\t        });\r\n");
      out.write("\r\n");
      out.write("\t\t\t$( window ).resize(function() {\r\n");
      out.write("\t\t        var treeResizeHeight = $( window ).height() -250;\r\n");
      out.write("\r\n");
      out.write("\t\t           if(treeResizeHeight > 150){\r\n");
      out.write("\t\t        \t$(\"#authList2\").jqxTreeGrid('height', treeResizeHeight);\r\n");
      out.write("\t\t           }else{\r\n");
      out.write("\t\t\t        \t$(\"#authList2\").jqxTreeGrid('height', 150);\r\n");
      out.write("\t\t           }\r\n");
      out.write("\t\t    \t});\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction fnSearch(admAuthCd){\r\n");
      out.write("\t\tvar dataAdapter1 = new $.jqx.dataAdapter({\r\n");
      out.write("\t\t\tdatatype: \"json\",\r\n");
      out.write("            datafields: _datafields1,\r\n");
      out.write("            url: contUrl + \".action\"\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t$(\"#authList1\").jqxGrid({ source: dataAdapter1 });\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction fnSearch2(admAuthCd){\r\n");
      out.write("\t\tif(admAuthCd!=\"\"){\r\n");
      out.write("\t\t\tvar dataAdapter2 = new $.jqx.dataAdapter({\r\n");
      out.write("\t\t\t\tdatatype: \"json\",\r\n");
      out.write("\t            datafields: _datafields2,\r\n");
      out.write("\t            url: contUrl + \"ML.action\",\r\n");
      out.write("\t            data : {\"admAuthCd\" : admAuthCd},\r\n");
      out.write("\t            hierarchy:\r\n");
      out.write("\t            { keyDataField: { name: 'admMenuCd' }, parentDataField: { name: 'admMenuGroup' } }\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t$(\"#authList2\").jqxTreeGrid({ source: dataAdapter2 });\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction fnEvent(){\r\n");
      out.write("\r\n");
      out.write("\t\t$('#authList2').on('bindingComplete', function (event) {\r\n");
      out.write("\r\n");
      out.write("\t\t\t$(\"#authList2\").jqxTreeGrid('expandAll');\r\n");
      out.write("\r\n");
      out.write("\t\t\tvar rows = $(\"#authList2\").jqxTreeGrid('getRows');\r\n");
      out.write("\t\t\tvar idx = 1;\r\n");
      out.write("\t\t\tvar traverseTree = function(rows)\r\n");
      out.write("\t\t      {\r\n");
      out.write("\t\t\t\t for(var i = 0; i < rows.length; i++)\r\n");
      out.write("\t\t          {\r\n");
      out.write("\t\t\t\t\t  if(rows[i].admAuthMenuCd != \"\"){\r\n");
      out.write("\t\t        \t      $(\"#authList2\").jqxTreeGrid('checkRow',idx);\r\n");
      out.write("\t\t        \t  }\r\n");
      out.write("\t\t              if (rows[i].records)\r\n");
      out.write("\t\t              {\r\n");
      out.write("\t\t                  traverseTree(rows[i].records);\r\n");
      out.write("\t\t              }\r\n");
      out.write("\t\t              idx++\r\n");
      out.write("\t\t          }\r\n");
      out.write("\t\t      };\r\n");
      out.write("\t\t      traverseTree(rows);\r\n");
      out.write("\t     });\r\n");
      out.write("\r\n");
      out.write("\t\t$(\"#authList1\").on('cellselect', function (event)\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\tvar cell = $(\"#authList1\").jqxGrid('getselectedcell');\r\n");
      out.write("\t\t\tvar datarow = $(\"#authList1\").jqxGrid('getrowdata', cell.rowindex);\r\n");
      out.write("\t\t\tfnSearch2(datarow.admAuthCd);\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\t$(\".saveBtn\").click(function(){\r\n");
      out.write("\t\t\tvar action =  \"amM705IUD.action\";\r\n");
      out.write("\t\t\tvar gridId = \"authList1\";\r\n");
      out.write("\t\t\tvar fnSaveSuccess =  function(data, dataType){\r\n");
      out.write("\t\t\t\tvar data = data.replace(/\\s/gi,'');\r\n");
      out.write("\t\t\t\tvar returnData = \"\";\r\n");
      out.write("\t\t\t\tif(data == \"ng\"){\r\n");
      out.write("\t\t\t\t\talert(\"저장에 실패하였습니다.\");\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}else if(data == \"ok\"){\r\n");
      out.write("\t\t\t\t\talert(\"정상적으로 저장되었습니다.\");\r\n");
      out.write("\t\t\t\t\tlocation.reload();\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t};\r\n");
      out.write("\t\t\tfnSaveConfirm(action, gridId,fnSaveSuccess);\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\t$(\".saveAuth\").click(function(){\r\n");
      out.write("\t\t\tvar cell = $('#authList1').jqxGrid('getselectedcell');\r\n");
      out.write("\t\t\tvar datarow = $(\"#authList1\").jqxGrid('getrowdata', cell.rowindex);\r\n");
      out.write("\r\n");
      out.write("\t\t\tif(cell==null){\r\n");
      out.write("\t\t\t\talert(\"권한명을 선택해주세요.\");\r\n");
      out.write("\t\t\t\treturn false;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\t\tvar fnIconAddSuccess =  function(data, dataType){\r\n");
      out.write("\t\t\t\tvar data = data.replace(/\\s/gi,'');\r\n");
      out.write("\t\t\t\tvar returnData = \"\";\r\n");
      out.write("\t\t\t\tif(data == \"ng\"){\r\n");
      out.write("\t\t\t\t\talert(\"저장에 실패하였습니다.\");\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}else if(data == \"ok\"){\r\n");
      out.write("\t\t\t\t\talert(\"정상적으로 저장 되었습니다.\");\r\n");
      out.write("\t\t\t\t\tfnSearch('');\r\n");
      out.write("\t\t\t\t\tif(confirm(\"현재페이지를 새로고침 하시겠습니까?\")){\r\n");
      out.write("\t\t\t\t\t\tlocation.reload();\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t};\r\n");
      out.write("\r\n");
      out.write("\t\t\tvar postData = new Array();\r\n");
      out.write("\t\t\tvar checkedRows = $(\"#authList2\").jqxTreeGrid('getCheckedRows');\r\n");
      out.write("\t\t\tfor (var i = 0; i < checkedRows.length; i++) {\r\n");
      out.write("\t\t\t\tpostData.push({admMenuCd:checkedRows[i].admMenuCd,admMenuGroup:checkedRows[i].admMenuGroup});\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tvar editedRowsJson = JSON.stringify(postData);\r\n");
      out.write("\t\t\tfnAjax(\"amM705MIU.action\", {data : editedRowsJson, admAuthCd : datarow.admAuthCd}, fnIconAddSuccess, \"post\", \"text\", \"false\");\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\t$(\".btnAddNew\").click(function(){\r\n");
      out.write("\t\t\tfnbtnAddNew();\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t$(\".delBtn\").click(function(){\r\n");
      out.write("\t\t\t\tvar cell = $('#authList1').jqxGrid('getselectedcell');\r\n");
      out.write("\t\t\t\tif(cell==null){\r\n");
      out.write("\t\t\t\t\talert(\"권한명을 선택해주세요.\");\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tvar fnDeleteSuccess =  function(data, dataType){\r\n");
      out.write("\t\t\t\t\tvar data = data.replace(/\\s/gi,'');\r\n");
      out.write("\t\t\t\t\tvar returnData = \"\";\r\n");
      out.write("\t\t\t\t\tif(data == \"ng\"){\r\n");
      out.write("\t\t\t\t\t\talert(\"삭제에 실패하였습니다.\");\r\n");
      out.write("\t\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t\t}else if(data == \"ok\"){\r\n");
      out.write("\t\t\t\t\t\talert(\"정상적으로 삭제되었습니다.\");\r\n");
      out.write("\t\t\t\t\t\tlocation.reload();\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t};\r\n");
      out.write("\t\t\t\tfnDeleteConfirm(\"amM705IUD.action?type=del\",\"authList1\",\"admAuthCd\",fnDeleteSuccess);\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction fnbtnAddNew(){\r\n");
      out.write("\t\t$(\"#authList1\").jqxGrid('addrow', null, {});\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<div class=\"pageContScroll_st2\">\r\n");
      out.write("\t<div class=\"multi_table_area\">\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<div style=\"text-align:right\">\r\n");
      out.write("\t\t\t\t\t<a class=\"btnAddNew btn_type1\" href=\"#\">추가</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"saveBtn btn_type1\" href=\"#\">저장</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"delBtn btn_type1\" href=\"#\">삭제</a>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div style=\"text-align:right\">\r\n");
      out.write("\t\t\t<div  style=\"margin-top:5px;\">\r\n");
      out.write("\t\t\t\t<div id=\"authList1\" class=\"authList\"></div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<!-- // -->\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<div style=\"text-align:right\">\r\n");
      out.write("\t\t\t\t\t<a class=\"saveAuth btn_type1\" href=\"#\">권한 저장</a>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div style=\"text-align:right\">\r\n");
      out.write("\t\t\t<div  style=\"margin-top:5px;\">\r\n");
      out.write("\t\t\t\t<div id=\"authList2\" class=\"authList\"></div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
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

  private boolean _jspx_meth_c_005fimport_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:import
    org.apache.taglibs.standard.tag.rt.core.ImportTag _jspx_th_c_005fimport_005f0 = (org.apache.taglibs.standard.tag.rt.core.ImportTag) _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.ImportTag.class);
    _jspx_th_c_005fimport_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fimport_005f0.setParent(null);
    // /WEB-INF/jsp/site/mng/amM7/amM705/amM705.jsp(8,1) name = url type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fimport_005f0.setUrl("/WEB-INF/jsp/general/lib_jqx_core.jsp");
    int[] _jspx_push_body_count_c_005fimport_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fimport_005f0 = _jspx_th_c_005fimport_005f0.doStartTag();
      if (_jspx_th_c_005fimport_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fimport_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fimport_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fimport_005f0.doFinally();
      _005fjspx_005ftagPool_005fc_005fimport_0026_005furl_005fnobody.reuse(_jspx_th_c_005fimport_005f0);
    }
    return false;
  }
}
