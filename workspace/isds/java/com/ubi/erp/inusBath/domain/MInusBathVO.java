package com.ubi.erp.inusBath.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("MInusBathVO")
public class MInusBathVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String saleGubun;
	
	private String saleGubunNm;

	private String chk;
	
	private String endChk;
	
	private String endChkNm;

	private String conPic;
	
	private String endPic;

	private String saleEndChk;

	private String custCd;

	private String custNm;

	private String custInfo;

	private String sigongEnd;

	private String checkEnd;

	private String fldNm;

	private String fldAddr;

	private int cnt;

	private String itmCd;

	private String itmNm;

	private String spec;

	private int outQty;

	public String getItmCd() {
		return itmCd;
	}

	public void setItmCd(String itmCd) {
		this.itmCd = itmCd;
	}

	public String getItmNm() {
		return itmNm;
	}

	public void setItmNm(String itmNm) {
		this.itmNm = itmNm;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public int getOutQty() {
		return outQty;
	}

	public void setOutQty(int outQty) {
		this.outQty = outQty;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	private String saleLevel;

	private String saleLevelNm;

	private String cusName;

	private String visitDt;

	private String workFrdt;

	private String workTodt;

	private String gongDay;

	private String estNo;

	private int buyAmt;

	private String expBcText;

	private String siEndText;

	private String visitChk;

	private String inNo;

	private String saleEmp;

	private String saleType;

	private String serveyCust;

	private String frDt;

	private String toDt;

	private String cusInfo;

	private String regId;

	private int basicAmt;

	private String mainNm;

	private String clhNm;

	private String prcNm;

	private String bigo;

	private String mainCd;

	private String clhCd;

	private String prcCd;

	private String id;

	private String value;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getMainNm() {
		return mainNm;
	}

	public void setMainNm(String mainNm) {
		this.mainNm = mainNm;
	}

	public String getClhNm() {
		return clhNm;
	}

	public void setClhNm(String clhNm) {
		this.clhNm = clhNm;
	}

	public String getPrcNm() {
		return prcNm;
	}

	public void setPrcNm(String prcNm) {
		this.prcNm = prcNm;
	}

	public String getBigo() {
		return bigo;
	}

	public void setBigo(String bigo) {
		this.bigo = bigo;
	}

	public String getMainCd() {
		return mainCd;
	}

	public void setMainCd(String mainCd) {
		this.mainCd = mainCd;
	}

	public String getClhCd() {
		return clhCd;
	}

	public void setClhCd(String clhCd) {
		this.clhCd = clhCd;
	}

	public String getPrcCd() {
		return prcCd;
	}

	public void setPrcCd(String prcCd) {
		this.prcCd = prcCd;
	}

	public int getBasicAmt() {
		return basicAmt;
	}

	public void setBasicAmt(int basicAmt) {
		this.basicAmt = basicAmt;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getFrDt() {
		return frDt;
	}

	public void setFrDt(String frDt) {
		this.frDt = frDt;
	}

	public String getToDt() {
		return toDt;
	}

	public void setToDt(String toDt) {
		this.toDt = toDt;
	}

	public String getCusInfo() {
		return cusInfo;
	}

	public void setCusInfo(String cusInfo) {
		this.cusInfo = cusInfo;
	}

	public String getSaleGubun() {
		return saleGubun;
	}

	public void setSaleGubun(String saleGubun) {
		this.saleGubun = saleGubun;
	}

	public String getSaleGubunNm() {
		return saleGubunNm;
	}

	public void setSaleGubunNm(String saleGubunNm) {
		this.saleGubunNm = saleGubunNm;
	}

	public String getChk() {
		return chk;
	}

	public void setChk(String chk) {
		this.chk = chk;
	}

	public String getEndChk() {
		return endChk;
	}

	public void setEndChk(String endChk) {
		this.endChk = endChk;
	}

	public String getEndChkNm() {
		return endChkNm;
	}

	public void setEndChkNm(String endChkNm) {
		this.endChkNm = endChkNm;
	}

	public String getConPic() {
		return conPic;
	}

	public void setConPic(String conPic) {
		this.conPic = conPic;
	}

	public String getEndPic() {
		return endPic;
	}

	public void setEndPic(String endPic) {
		this.endPic = endPic;
	}

	public String getSaleEndChk() {
		return saleEndChk;
	}

	public void setSaleEndChk(String saleEndChk) {
		this.saleEndChk = saleEndChk;
	}

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

	public String getCustInfo() {
		return custInfo;
	}

	public void setCustInfo(String custInfo) {
		this.custInfo = custInfo;
	}

	public String getSigongEnd() {
		return sigongEnd;
	}

	public void setSigongEnd(String sigongEnd) {
		this.sigongEnd = sigongEnd;
	}

	public String getCheckEnd() {
		return checkEnd;
	}

	public void setCheckEnd(String checkEnd) {
		this.checkEnd = checkEnd;
	}

	public String getFldNm() {
		return fldNm;
	}

	public void setFldNm(String fldNm) {
		this.fldNm = fldNm;
	}

	public String getFldAddr() {
		return fldAddr;
	}

	public void setFldAddr(String fldAddr) {
		this.fldAddr = fldAddr;
	}

	public String getSaleLevel() {
		return saleLevel;
	}

	public void setSaleLevel(String saleLevel) {
		this.saleLevel = saleLevel;
	}

	public String getSaleLevelNm() {
		return saleLevelNm;
	}

	public void setSaleLevelNm(String saleLevelNm) {
		this.saleLevelNm = saleLevelNm;
	}

	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}

	public String getVisitDt() {
		return visitDt;
	}

	public void setVisitDt(String visitDt) {
		this.visitDt = visitDt;
	}

	public String getWorkFrdt() {
		return workFrdt;
	}

	public void setWorkFrdt(String workFrdt) {
		this.workFrdt = workFrdt;
	}

	public String getWorkTodt() {
		return workTodt;
	}

	public void setWorkTodt(String workTodt) {
		this.workTodt = workTodt;
	}

	public String getGongDay() {
		return gongDay;
	}

	public void setGongDay(String gongDay) {
		this.gongDay = gongDay;
	}

	public String getEstNo() {
		return estNo;
	}

	public void setEstNo(String estNo) {
		this.estNo = estNo;
	}

	public int getBuyAmt() {
		return buyAmt;
	}

	public void setBuyAmt(int buyAmt) {
		this.buyAmt = buyAmt;
	}

	public String getExpBcText() {
		return expBcText;
	}

	public void setExpBcText(String expBcText) {
		this.expBcText = expBcText;
	}

	public String getSiEndText() {
		return siEndText;
	}

	public void setSiEndText(String siEndText) {
		this.siEndText = siEndText;
	}

	public String getVisitChk() {
		return visitChk;
	}

	public void setVisitChk(String visitChk) {
		this.visitChk = visitChk;
	}

	public String getInNo() {
		return inNo;
	}

	public void setInNo(String inNo) {
		this.inNo = inNo;
	}

	public String getSaleEmp() {
		return saleEmp;
	}

	public void setSaleEmp(String saleEmp) {
		this.saleEmp = saleEmp;
	}

	public String getSaleType() {
		return saleType;
	}

	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}

	public String getServeyCust() {
		return serveyCust;
	}

	public void setServeyCust(String serveyCust) {
		this.serveyCust = serveyCust;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
