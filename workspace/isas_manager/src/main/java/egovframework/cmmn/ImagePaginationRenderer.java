package egovframework.cmmn;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	@SuppressWarnings("unused")
	private ServletContext servletContext;

	public ImagePaginationRenderer() {

	}

	public void initVariables(){
		firstPageLabel    = "<a class=\"btn_first\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a>&#160;";
		previousPageLabel = "<a class=\"btn_prev\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a>&#160;";
		currentPageLabel  = "<a class=\"num on\" href=\"#\" onclick=\"return false; \">{0}</a>&#160;";
		otherPageLabel    = "<a class=\"num\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a>&#160;";
		nextPageLabel     = "<a class=\"btn_next\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a>&#160;";
		lastPageLabel     = "<a class=\"btn_last\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a>&#160;";
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
