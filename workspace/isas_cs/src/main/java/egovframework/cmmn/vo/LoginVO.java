package egovframework.cmmn.vo;

import java.io.Serializable;
import java.util.Date;

import egovframework.cmmn.util.CommonUtil;

/**
 * @author vary
 *
 */
public class LoginVO implements Serializable{

	private static final long serialVersionUID = -8274004534207618049L;
	
	/** 회원시퀀스 */
	private String mbrSeq;
	/** 회원아이디 */
	private String mbrId;
	/** 회원비밀번호 */
    private String mbrPw;
    /** 회원상태 */
    private String mbrLoginStatusYhn;

    /** 회원이름 */
    private String mbrNm;
    /** 성별(0-남성 1-여성) */
    private String mbrSexMw;

    /** 이메일 */
    private String mbrEmail;

    /** 우편번호 */
    private String mbrZipcode;
    /** 주소 */
    private String mbrAddr;
    /** 주소상세 */
    private String mbrAddrDtl;
    /** 전화번호 */
    private String mbrPhone;
    /** 휴대폰번호 */
    private String mbrMobile;

    /** 가입일 */
    private String mbrJoinDt;
    /** 등록자아이디 */
    private String mbrRegId;
    /** 접속일 */
    private Date mbrLoginDt;
    /** 접속IP */
    private String mbrLoginIp;
    /** 접속일 포맷 적용 */
    private String strLogInDate;
    /** 쿠키저장여부 */
    private String saveIdCookie;
    private String autoLoginCookie;
    /**
	 * @return the mbrSeq
	 */
	public String getMbrSeq() {
		return mbrSeq;
	}
	/**
	 * @param mbrSeq the mbrSeq to set
	 */
	public void setMbrSeq(String mbrSeq) {
		this.mbrSeq = mbrSeq;
	}
	/**
	 * @return the mbrId
	 */
	public String getMbrId() {
		return CommonUtil.nvl(mbrId);
	}
	/**
	 * @param mbrId the mbrId to set
	 */
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	/**
	 * @return the mbrPw
	 */
	public String getMbrPw() {
		return mbrPw;
	}
	/**
	 * @param mbrPw the mbrPw to set
	 */
	public void setMbrPw(String mbrPw) {
		this.mbrPw = mbrPw;
	}
	/**
	 * @return the mbrLoginStatusYhn
	 */
	public String getMbrLoginStatusYhn() {
		return mbrLoginStatusYhn;
	}
	/**
	 * @param mbrLoginStatusYhn the mbrLoginStatusYhn to set
	 */
	public void setMbrLoginStatusYhn(String mbrLoginStatusYhn) {
		this.mbrLoginStatusYhn = mbrLoginStatusYhn;
	}
	/**
	 * @return the mbrNm
	 */
	public String getMbrNm() {
		return mbrNm;
	}
	/**
	 * @param mbrNm the mbrNm to set
	 */
	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}
	/**
	 * @return the mbrSexMw
	 */
	public String getMbrSexMw() {
		return mbrSexMw;
	}
	/**
	 * @param mbrSexMw the mbrSexMw to set
	 */
	public void setMbrSexMw(String mbrSexMw) {
		this.mbrSexMw = mbrSexMw;
	}


	/**
	 * @return the mbrEmail
	 */
	public String getMbrEmail() {
		return mbrEmail;
	}
	/**
	 * @param mbrEmail the mbrEmail to set
	 */
	public void setMbrEmail(String mbrEmail) {
		this.mbrEmail = mbrEmail;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/**
	 * @return the mbrZipcode
	 */
	public String getMbrZipcode() {
		return mbrZipcode;
	}
	/**
	 * @param mbrZipcode the mbrZipcode to set
	 */
	public void setMbrZipcode(String mbrZipcode) {
		this.mbrZipcode = mbrZipcode;
	}
	/**
	 * @return the mbrAddr
	 */
	public String getMbrAddr() {
		return mbrAddr;
	}
	/**
	 * @param mbrAddr the mbrAddr to set
	 */
	public void setMbrAddr(String mbrAddr) {
		this.mbrAddr = mbrAddr;
	}
	/**
	 * @return the mbrAddrDtl
	 */
	public String getMbrAddrDtl() {
		return mbrAddrDtl;
	}
	/**
	 * @param mbrAddrDtl the mbrAddrDtl to set
	 */
	public void setMbrAddrDtl(String mbrAddrDtl) {
		this.mbrAddrDtl = mbrAddrDtl;
	}
	/**
	 * @return the mbrPhone
	 */
	public String getMbrPhone() {
		return mbrPhone;
	}
	/**
	 * @param mbrPhone the mbrPhone to set
	 */
	public void setMbrPhone(String mbrPhone) {
		this.mbrPhone = mbrPhone;
	}
	/**
	 * @return the mbrMobile
	 */
	public String getMbrMobile() {
		return mbrMobile;
	}
	/**
	 * @param mbrMobile the mbrMobile to set
	 */
	public void setMbrMobile(String mbrMobile) {
		this.mbrMobile = mbrMobile;
	}

	/**
	 * @return the mbrJoinDt
	 */
	public String getMbrJoinDt() {
		return mbrJoinDt;
	}
	/**
	 * @param mbrJoinDt the mbrJoinDt to set
	 */
	public void setMbrJoinDt(String mbrJoinDt) {
		this.mbrJoinDt = mbrJoinDt;
	}
	/**
	 * @return the mbrRegId
	 */
	public String getMbrRegId() {
		return mbrRegId;
	}
	/**
	 * @param mbrRegId the mbrRegId to set
	 */
	public void setMbrRegId(String mbrRegId) {
		this.mbrRegId = mbrRegId;
	}
	/**
	 * @return the mbrLoginDt
	 */
	public Date getMbrLoginDt() {
		return mbrLoginDt;
	}
	/**
	 * @param mbrLoginDt the mbrLoginDt to set
	 */
	public void setMbrLoginDt(Date mbrLoginDt) {
		this.mbrLoginDt = mbrLoginDt;
	}
	/**
	 * @return the mbrLoginIp
	 */
	public String getMbrLoginIp() {
		return mbrLoginIp;
	}
	/**
	 * @param mbrLoginIp the mbrLoginIp to set
	 */
	public void setMbrLoginIp(String mbrLoginIp) {
		this.mbrLoginIp = mbrLoginIp;
	}
	/**
	 * @return the strLogInDate
	 */
	public String getStrLogInDate() {
		if(strLogInDate == null){
			if(this.mbrLoginDt != null){
				strLogInDate = CommonUtil.getDateToStr("yyyy년 MM월 dd일 HH시 mm분 로그인", this.mbrLoginDt);
			}
		}
		return strLogInDate;
	}
	/**
	 * @return the saveIdCookie
	 */
	public String getSaveIdCookie() {
		return saveIdCookie;
	}
	/**
	 * @param saveIdCookie the saveIdCookie to set
	 */
	public void setSaveIdCookie(String saveIdCookie) {
		this.saveIdCookie = saveIdCookie;
	}
	/**
	 * @return the autoLoginCookie
	 */
	public String getAutoLoginCookie() {
		return autoLoginCookie;
	}
	/**
	 * @param autoLoginCookie the autoLoginCookie to set
	 */
	public void setAutoLoginCookie(String autoLoginCookie) {
		this.autoLoginCookie = autoLoginCookie;
	}

}
