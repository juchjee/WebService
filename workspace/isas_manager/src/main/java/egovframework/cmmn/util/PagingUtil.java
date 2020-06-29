package egovframework.cmmn.util;


public class PagingUtil {
	
	private int PAGE_SIZE = 3;
	private int BLOCK_SIZE = 10;
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
			htmlSB.append("<ul class='page'>");
			htmlSB.append("<li><a href='javascript:;' onClick=\"doPage('" + this.getPreviousBlock() + "')\">&lt;&lt;</a></li>");
			htmlSB.append("<li><a href='javascript:;' onClick=\"doPage('" + this.getPrePageNum() + "')\">&lt;</a></li>");
			for (int i = getStartBlock(); i <= getEndBlock(); i++) {
				if(this.getCurrentPageNum() == i){
					htmlSB.append("<li><a class='on' href='javascript:;' onClick=\"doPage('" + i + "')\">"+i+"</a></li>");
				}else{
					htmlSB.append("<li><a href='javascript:;' onClick=\"doPage('" + i + "')\">"+i+"</a></li>");
				}
			}
			htmlSB.append("<li><a href='javascript:;' onClick=\"doPage('" + this.getNextPageNum() + "')\">&gt;</a></li>");
			htmlSB.append("<li><a href='javascript:;' onClick=\"doPage('" + this.getNextBlock() + "')\">&gt;&gt;</a></li>");
			htmlSB.append("</ul>");
			htmlSB.trimToSize();
			html = htmlSB.toString();
		}
		return html;
	}
}