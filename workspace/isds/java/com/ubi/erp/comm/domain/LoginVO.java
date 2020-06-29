package com.ubi.erp.comm.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("LoginVO")
public class LoginVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;

	private String pw;

	private String bsCd;

	private String siteCd;

	private String facCd;

	private String custCd;

	private String kind;

	private String confirmYn;

	private String useYn;

	private String mngYn;

	private String userNm;

	private String bizNo;

	private int cnt;

	private String custNm;

	private String siteNm;

	private String workYn;

	private String deptCd;

	private String deptNm;

	private String grId;
	
	private String erpCustCd;

	private String erpCustNm;

	public String getErpCustCd() {
		return erpCustCd;
	}

	public String getErpCustNm() {
		return erpCustNm;
	}

	public void setErpCustNm(String erpCustNm) {
		this.erpCustNm = erpCustNm;
	}

	public void setErpCustCd(String erpCustCd) {
		this.erpCustCd = erpCustCd;
	}

	public String getGrId() {
		return grId;
	}

	public void setGrId(String grId) {
		this.grId = grId;
	}

	public String getSiteNm() {
		return siteNm;
	}

	public String getWorkYn() {
		return workYn;
	}

	public void setWorkYn(String workYn) {
		this.workYn = workYn;
	}

	public void setSiteNm(String siteNm) {
		this.siteNm = siteNm;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getBizNo() {
		return bizNo;
	}

	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getBsCd() {
		return bsCd;
	}

	public void setBsCd(String bsCd) {
		this.bsCd = bsCd;
	}

	public String getSiteCd() {
		return siteCd;
	}

	public void setSiteCd(String siteCd) {
		this.siteCd = siteCd;
	}

	public String getFacCd() {
		return facCd;
	}

	public void setFacCd(String facCd) {
		this.facCd = facCd;
	}

	public String getCustCd() {
		return custCd;
	}

	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getConfirmYn() {
		return confirmYn;
	}

	public void setConfirmYn(String confirmYn) {
		this.confirmYn = confirmYn;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getMngYn() {
		return mngYn;
	}

	public void setMngYn(String mngYn) {
		this.mngYn = mngYn;
	}

	public String getDeptCd() {
		return deptCd;
	}

	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
