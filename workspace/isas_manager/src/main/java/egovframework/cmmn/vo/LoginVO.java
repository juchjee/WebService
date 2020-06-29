package egovframework.cmmn.vo;

import java.io.Serializable;

/**
 * @Class Name : LoginVO.java
 * @Description : Login VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 *
 *  @author 공통서비스 개발팀 박지욱
 *  @since 2009.03.03
 *  @version 1.0
 *  @see
 *
 */
public class LoginVO implements Serializable{

	private static final long serialVersionUID = -8274004534207618049L;

	/** 아이디 */
	private String admId;
	/** 비밀번호 */
	private String admPw;
	/** 이름 */
	private String admName;
	/** 전화번호 */
	private String admTel;
	/** 입사일 */
	private String admJobDt;
	/** 등록일 */
	private String admRegDt;
	/** 이메일주소 */
	private String admEmail;
	/** 권한코드 */
	private String admAuthCd;
	/** 직급코드 */
	private String admPosition;
	/** 사용여부 */
	private String useFlagYn;
	/** 권한명 */
	private String admAuthNm;
	/** 사용자 IP정보 */
	private String admLoginIp;
	/** 사용자 로그인 정보 */
	private String logInDate;

	/**
	 * @return the admId
	 */
	public String getAdmId() {
		return admId;
	}
	/**
	 * @param admId the admId to set
	 */
	public void setAdmId(String admId) {
		this.admId = admId;
	}
	/**
	 * @return the admPw
	 */
	public String getAdmPw() {
		return admPw;
	}
	/**
	 * @param admPw the admPw to set
	 */
	public void setAdmPw(String admPw) {
		this.admPw = admPw;
	}
	/**
	 * @return the admName
	 */
	public String getAdmName() {
		return admName;
	}
	/**
	 * @param admName the admName to set
	 */
	public void setAdmName(String admName) {
		this.admName = admName;
	}
	/**
	 * @return the admTel
	 */
	public String getAdmTel() {
		return admTel;
	}
	/**
	 * @param admTel the admTel to set
	 */
	public void setAdmTel(String admTel) {
		this.admTel = admTel;
	}
	/**
	 * @return the admJobDt
	 */
	public String getAdmJobDt() {
		return admJobDt;
	}
	/**
	 * @param admJobDt the admJobDt to set
	 */
	public void setAdmJobDt(String admJobDt) {
		this.admJobDt = admJobDt;
	}
	/**
	 * @return the admRegDt
	 */
	public String getAdmRegDt() {
		return admRegDt;
	}
	/**
	 * @param admRegDt the admRegDt to set
	 */
	public void setAdmRegDt(String admRegDt) {
		this.admRegDt = admRegDt;
	}
	/**
	 * @return the admEmail
	 */
	public String getAdmEmail() {
		return admEmail;
	}
	/**
	 * @param admEmail the admEmail to set
	 */
	public void setAdmEmail(String admEmail) {
		this.admEmail = admEmail;
	}
	/**
	 * @return the admAuthCd
	 */
	public String getAdmAuthCd() {
		return admAuthCd;
	}
	/**
	 * @param admAuthCd the admAuthCd to set
	 */
	public void setAdmAuthCd(String admAuthCd) {
		this.admAuthCd = admAuthCd;
	}
	/**
	 * @return the admPosition
	 */
	public String getAdmPosition() {
		return admPosition;
	}
	/**
	 * @param admPosition the admPosition to set
	 */
	public void setAdmPosition(String admPosition) {
		this.admPosition = admPosition;
	}
	/**
	 * @return the useFlagYn
	 */
	public String getUseFlagYn() {
		return useFlagYn;
	}
	/**
	 * @param useFlagYn the useFlagYn to set
	 */
	public void setUseFlagYn(String useFlagYn) {
		this.useFlagYn = useFlagYn;
	}
	/**
	 * @return the admAuthNm
	 */
	public String getAdmAuthNm() {
		return admAuthNm;
	}
	/**
	 * @param admAuthNm the admAuthNm to set
	 */
	public void setAdmAuthNm(String admAuthNm) {
		this.admAuthNm = admAuthNm;
	}
	/**
	 * @return the admLoginIp
	 */
	public String getAdmLoginIp() {
		return admLoginIp;
	}
	/**
	 * @param admLoginIp the ip admLoginIp set
	 */
	public void setAdmLoginIp(String admLoginIp) {
		this.admLoginIp = admLoginIp;
	}
	/**
	 * @return the logInDate
	 */
	public String getLogInDate() {
		return logInDate;
	}
	/**
	 * @param logInDate the logInDate to set
	 */
	public void setLogInDate(String logInDate) {
		this.logInDate = logInDate;
	}
}
