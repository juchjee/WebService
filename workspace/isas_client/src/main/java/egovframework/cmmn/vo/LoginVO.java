package egovframework.cmmn.vo;

import java.io.Serializable;

/**
 * @author vary
 *
 */
public class LoginVO implements Serializable{

	private static final long serialVersionUID = -8274004534207618049L;

	private String custCd;
	private String custNm;
    private String drvNo;
    private String drvNm;
    private String hp;
    private String tel;
    private String addr;
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getDrvNo() {
		return drvNo;
	}
	public void setDrvNo(String drvNo) {
		this.drvNo = drvNo;
	}
	public String getDrvNm() {
		return drvNm;
	}
	public void setDrvNm(String drvNm) {
		this.drvNm = drvNm;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}

}
