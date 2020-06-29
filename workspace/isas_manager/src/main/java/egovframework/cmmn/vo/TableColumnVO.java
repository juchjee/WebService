package egovframework.cmmn.vo;

/**
 * 테이블 컬럼 정보  vo
 * @author vary
 *
 */
public class TableColumnVO {

	public static int STRING = 0;
	public static int NUMBER = 1;
	public static int DATE = 2;

	private String NAME, ISNULL, DEFAULTVAL;
	private int TYPE = TableColumnVO.STRING;//0:string, 1:number, 2:date
	/**
	 * @return the name
	 */
	public String getNAME() {
		return NAME;
	}

	/**
	 * @param name the name to set
	 */
	public void setNAME(String nAME) {
		NAME = nAME;
	}

	/**
	 * @return the type
	 */
	public int getTYPE() {
		return TYPE;
	}

	/**
	 * @param type the type to set
	 */
	public void setTYPE(String tYPE) {
		String uType = tYPE.toUpperCase();
		if(uType.indexOf("DATE") >= 0){
			TYPE = TableColumnVO.DATE;
		}else if(uType.indexOf("NUM") >= 0 || uType.indexOf("MON") >= 0 || uType.indexOf("INT") >= 0){
			TYPE = TableColumnVO.NUMBER;
		}
	}

	/**
	 * @return the isnull
	 */
	public String getISNULL() {
		return ISNULL;
	}

	/**
	 * @param isnull the isnull to set
	 */
	public void setISNULL(String iSNULL) {
		ISNULL = iSNULL;
	}

	/**
	 * @return the defaultval
	 */
	public String getDEFAULTVAL() {
		return DEFAULTVAL;
	}

	/**
	 * @param defaultval the defaultval to set
	 */
	public void setDEFAULTVAL(String dEFAULTVAL) {
		DEFAULTVAL = dEFAULTVAL;
	}

}
