package egovframework.cmmn.util;

import egovframework.cmmn.EgovProperties;

public class PagingUtil {

	private int PAGE_SIZE = EgovProperties.getSitePropertyInt("pageSize");;
	private int MAP_PAGE_SIZE = EgovProperties.getSitePropertyInt("mapPageSize");;
	private int BLOCK_SIZE = EgovProperties.getSitePropertyInt("pageUnit");
	private int totalCount;
	private int currentPageNum;

	public PagingUtil(int totalCount, int currentPageNum) {
		this.totalCount = totalCount;
		this.currentPageNum = currentPageNum;
	}

	public void setPageSize(int pageSize){
		this.PAGE_SIZE = pageSize;
	}

	public int getPageSize(){
		return PAGE_SIZE;
	}

	public void setBlockSize(int blockSize){
		this.BLOCK_SIZE = blockSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getCurrentPageNum() {
		return currentPageNum;
	}

	public int getTotalPages() {
		return (int) Math.ceil((double) totalCount / PAGE_SIZE);
	}

	public int getStartPageNumForBoard() {
		return getStartPageNum() - 1 <= 0 ? 0 : getStartPageNum() - 1;
	}

	public int getStartPageNum() {
		return totalCount == 0 ? 0 : ((currentPageNum - 1) * PAGE_SIZE) + 1;
	}

	public int getEndPageNum() {
		return (getStartPageNum() + PAGE_SIZE - 1) > totalCount ? totalCount
				: (getStartPageNum() + PAGE_SIZE - 1);
	}

	public int getPrePageNum() {
		return (currentPageNum - 1) <= 0 ? 1 : (currentPageNum - 1);
	}

	public int getNextPageNum() {
		return (currentPageNum + 1) > getTotalPages() ? getTotalPages()
				: (currentPageNum + 1);
	}

	public int getRealStartPageNum() {
		return (totalCount - ((currentPageNum - 1) * PAGE_SIZE));
	}

	public int getRealEndPageNum() {
		return getRealStartPageNum() - PAGE_SIZE + 1 < 0 ? 1
				: getRealStartPageNum() - PAGE_SIZE + 1;
	}

	public int getPreviousBlock() {
		return getStartBlock() - 1 <= 1 ? 1 : getStartBlock() - 1;
	}

	public int getNextBlock() {
		return getEndBlock() + 1 > getTotalPages() ? getTotalPages()
				: getEndBlock() + 1;
	}

	public int getCurrentBlock() {
		return (int) Math.ceil((double) ((getCurrentPageNum() - 1) / BLOCK_SIZE)) + 1;
	}

	public int getStartBlock() {
		return ((getCurrentBlock() - 1) * BLOCK_SIZE) + 1;
	}

	public int getEndBlock() {
		return (getStartBlock() + BLOCK_SIZE - 1) > getTotalPages() ? getTotalPages() : (getStartBlock() + BLOCK_SIZE - 1);
	}

	public String getPagesStrTag() {
		String html = "";
		if(getStartBlock() <= getEndBlock()){
			StringBuffer htmlSB = new StringBuffer();
			htmlSB.append("<div class='boardBttm'><div id='pagingNavi' class='paging'>");
			htmlSB.append("<span class='first'>	<a href='javascript:;' onClick=\"doPage('" + this.getPreviousBlock() + "')\">처음페이지 이동</a></span>");
			htmlSB.append("<span class='prev'><a href='javascript:;' onClick=\"doPage('" + this.getPrePageNum() + "')\">이전페이지 이동</a></span>");
			for (int i = getStartBlock(); i <= getEndBlock(); i++) {
				if(this.getCurrentPageNum() == i){
					htmlSB.append("<a class='current' href='javascript:;' onClick=\"doPage('" + i + "')\">"+i+"</a>");
				}else{
					htmlSB.append("<a href='javascript:;' onClick=\"doPage('" + i + "')\">"+i+"</a>");
				}
			}
			htmlSB.append("<span class='next'><a href='javascript:;' onClick=\"doPage('" + this.getNextPageNum() + "')\">다음페이지 이동</a></span>");
			htmlSB.append("<span class='last'><a href='javascript:;' onClick=\"doPage('" + this.getNextBlock() + "')\">마지막페이지 이동</a></span>");
			htmlSB.append("</div></div>");
			htmlSB.trimToSize();
			html = htmlSB.toString();
		}


		return html;
	}

	//Map Paging

	public int getMAP_PAGE_SIZE() {
		return MAP_PAGE_SIZE;
	}

	public void setMAP_PAGE_SIZE(int mAP_PAGE_SIZE) {
		MAP_PAGE_SIZE = mAP_PAGE_SIZE;
	}

	public int getTotalPagePages() {
		return (int) Math.ceil((double) totalCount / MAP_PAGE_SIZE);
	}

	public int getStartMapPageNum() {
		return totalCount == 0 ? 0 : ((currentPageNum - 1) * MAP_PAGE_SIZE) + 1;
	}

	public int getEndMapPageNum() {
		return (getStartMapPageNum() + MAP_PAGE_SIZE - 1) > totalCount ? totalCount
				: (getStartMapPageNum() + MAP_PAGE_SIZE - 1);
	}

	public int getCurrentMapBlock() {
		return (int) Math.ceil((double) ((getCurrentPageNum() - 1) / BLOCK_SIZE)) + 1;
	}

	public int getStartMapBlock() {
		return ((getCurrentBlock() - 1) * BLOCK_SIZE) + 1;
	}

	public int getEndMapBlock() {
		return (getStartMapBlock() + BLOCK_SIZE - 1) > getTotalPagePages() ? getTotalPagePages() : (getStartMapBlock() + BLOCK_SIZE - 1);
	}
	
	public int getMapNextPageNum() {
		return (currentPageNum + 1) > getTotalPagePages() ? getTotalPagePages()
				: (currentPageNum + 1);
	}
	
	public int getMapNextBlock() {
		return getEndMapBlock() + 1 > getTotalPagePages() ? getTotalPagePages()
				: getEndMapBlock() + 1;
	}

	public String getMapPagesStrTag() {
		String html = "";
		if(getStartMapBlock() <= getEndMapBlock()){
			StringBuffer htmlSB = new StringBuffer();
			htmlSB.append("<div class='boardBttm'>");
			htmlSB.append("<div id='pagingNavi' class='paging al pl40'>");
			htmlSB.append("<span class='first'><a href='javascript:;' onClick=\"doPage('" + this.getPreviousBlock() + "')\">&lt;&lt;</a></span>");
			htmlSB.append("<span class='prev'><a href='javascript:;' onClick=\"doPage('" + this.getPrePageNum() + "')\">&lt;</a></span>");
			for (int i = getStartMapBlock(); i <= getEndMapBlock(); i++) {
				if(this.getCurrentPageNum() == i){
					htmlSB.append("<a class='current' href='javascript:;' onClick=\"doPage('" + i + "')\">"+i+"</a>");
				}else{
					htmlSB.append("<a href='javascript:;' onClick=\"doPage('" + i + "')\">"+i+"</a>");
				}
			}
			htmlSB.append("<span class='next'><a href='javascript:;' onClick=\"doPage('" + this.getMapNextPageNum() + "')\">&gt;</a></span>");
			htmlSB.append("<span class='last'><a href='javascript:;' onClick=\"doPage('" + this.getMapNextBlock() + "')\">&gt;&gt;</a></span>");
			htmlSB.append("</div>");
			htmlSB.append("</div>");
			html = htmlSB.toString();
		}


		return html;
	}


}