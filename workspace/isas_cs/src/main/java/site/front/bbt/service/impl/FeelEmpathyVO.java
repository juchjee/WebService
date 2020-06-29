package site.front.bbt.service.impl;

/*
SR_20170202_OMT PHC 공감 기능, 최신순, 공감순, 만족도순 이미지 후기, 텍스트 후기, 검색기능
*/
public class FeelEmpathyVO {
	private int likeCount;
	private boolean likeStatus;

	/**
	 * @return the likeStatus
	 */
	public boolean isLikeStatus() {
		return likeStatus;
	}
	/**
	 * @param likeStatus the likeStatus to set
	 */
	public void setLikeStatus(boolean likeStatus) {
		this.likeStatus = likeStatus;
	}

	/**
	 * @return the likeCount
	 */
	public int getLikeCount() {
		return likeCount;
	}
	/**
	 * @param likeCount the likeCount to set
	 */
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

}
