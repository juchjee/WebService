package site.mng.sa.service;

import java.io.Serializable;

public class SaVO implements Serializable{

	private static final long serialVersionUID = -8274004534207618049L;

	/** 아이디 */
	private String ADM_ID;
	/** 비밀번호 */
	private String ADM_PW;
	/** 이름 */
	private String ADM_NAME;
	/** 전화번호 */
	private String ADM_TEL;
	/** 이메일주소 */
	private String ADM_EMAIL;
	/** 부서코드 */
	private String ADM_DEPT_CD;
	/** 직급코드 */
	private String ADM_POSITION;
	/** 사용여부 */
	private String USE_FLAG_YN;
	/** 사용자 IP정보 */
	private String USE_IP;

	public String getADM_ID() {
		return ADM_ID;
	}
	public void setADM_ID(String aDM_ID) {
		ADM_ID = aDM_ID;
	}
	public String getADM_PW() {
		return ADM_PW;
	}
	public void setADM_PW(String aDM_PW) {
		ADM_PW = aDM_PW;
	}
	public String getADM_NAME() {
		return ADM_NAME;
	}
	public void setADM_NAME(String aDM_NAME) {
		ADM_NAME = aDM_NAME;
	}
	public String getADM_TEL() {
		return ADM_TEL;
	}
	public void setADM_TEL(String aDM_TEL) {
		ADM_TEL = aDM_TEL;
	}
	public String getADM_EMAIL() {
		return ADM_EMAIL;
	}
	public void setADM_EMAIL(String aDM_EMAIL) {
		ADM_EMAIL = aDM_EMAIL;
	}
	public String getADM_DEPT_CD() {
		return ADM_DEPT_CD;
	}
	public void setADM_DEPT_CD(String aDM_DEPT_CD) {
		ADM_DEPT_CD = aDM_DEPT_CD;
	}
	public String getADM_POSITION() {
		return ADM_POSITION;
	}
	public void setADM_POSITION(String aDM_POSITION) {
		ADM_POSITION = aDM_POSITION;
	}
	public String getUSE_FLAG_YN() {
		return USE_FLAG_YN;
	}
	public void setUSE_FLAG_YN(String uSE_FLAG_YN) {
		USE_FLAG_YN = uSE_FLAG_YN;
	}
	public String getUSE_IP() {
		return USE_IP;
	}
	public void setUSE_IP(String uSE_IP) {
		USE_IP = uSE_IP;
	}

}
