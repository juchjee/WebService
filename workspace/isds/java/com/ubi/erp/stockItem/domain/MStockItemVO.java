package com.ubi.erp.stockItem.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("MStockItemVO")
public class MStockItemVO implements Serializable {

	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	private String stdDt;

	private String itmCd;

	private String chkEnd;

	private String chkEndNm;

	public String getChkEndNm() {
		return chkEndNm;
	}

	public void setChkEndNm(String chkEndNm) {
		this.chkEndNm = chkEndNm;
	}

	public String getChkEnd() {
		return chkEnd;
	}

	public void setChkEnd(String chkEnd) {
		this.chkEnd = chkEnd;
	}

	private String itmInfo;

	private String facCd;

	private String id;

	private String value;

	private String bizArea;

	private String itmId;

	private String grp3Cd;

	private String itmBc;

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

	public String getBizArea() {
		return bizArea;
	}

	public void setBizArea(String bizArea) {
		this.bizArea = bizArea;
	}

	public String getItmId() {
		return itmId;
	}

	public void setItmId(String itmId) {
		this.itmId = itmId;
	}

	public String getGrp3Cd() {
		return grp3Cd;
	}

	public void setGrp3Cd(String grp3Cd) {
		this.grp3Cd = grp3Cd;
	}

	public String getItmBc() {
		return itmBc;
	}

	public void setItmBc(String itmBc) {
		this.itmBc = itmBc;
	}

	public String getStdDt() {
		return stdDt;
	}

	public void setStdDt(String stdDt) {
		this.stdDt = stdDt;
	}

	public String getItmCd() {
		return itmCd;
	}

	public void setItmCd(String itmCd) {
		this.itmCd = itmCd;
	}

	public String getItmInfo() {
		return itmInfo;
	}

	public void setItmInfo(String itmInfo) {
		this.itmInfo = itmInfo;
	}

	public String getFacCd() {
		return facCd;
	}

	public void setFacCd(String facCd) {
		this.facCd = facCd;
	}

	public String getTot() {
		return tot;
	}

	public void setTot(String tot) {
		this.tot = tot;
	}

	public String getWhCd() {
		return whCd;
	}

	public void setWhCd(String whCd) {
		this.whCd = whCd;
	}

	public String getItmNm() {
		return itmNm;
	}

	public void setItmNm(String itmNm) {
		this.itmNm = itmNm;
	}

	private String tot;

	private String whCd;

	private String itmNm;

	private String bizAreaNm;

	private String spec;

	private String itmBcNm;

	private int bQty;

	private int cQty;

	private int jQty;

	private int yQty;

	private int lQty;

	private int eQty;

	private int pQty;

	public int getpQty() {
		return pQty;
	}

	public void setpQty(int pQty) {
		this.pQty = pQty;
	}

	public String getBizAreaNm() {
		return bizAreaNm;
	}

	public void setBizAreaNm(String bizAreaNm) {
		this.bizAreaNm = bizAreaNm;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getItmBcNm() {
		return itmBcNm;
	}

	public void setItmBcNm(String itmBcNm) {
		this.itmBcNm = itmBcNm;
	}

	public int getbQty() {
		return bQty;
	}

	public void setbQty(int bQty) {
		this.bQty = bQty;
	}

	public int getcQty() {
		return cQty;
	}

	public void setcQty(int cQty) {
		this.cQty = cQty;
	}

	public int getjQty() {
		return jQty;
	}

	public void setjQty(int jQty) {
		this.jQty = jQty;
	}

	public int getyQty() {
		return yQty;
	}

	public void setyQty(int yQty) {
		this.yQty = yQty;
	}

	public int getlQty() {
		return lQty;
	}

	public void setlQty(int lQty) {
		this.lQty = lQty;
	}

	public int geteQty() {
		return eQty;
	}

	public void seteQty(int eQty) {
		this.eQty = eQty;
	}

	private int qty;

	private String whNm;

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public String getWhNm() {
		return whNm;
	}

	public void setWhNm(String whNm) {
		this.whNm = whNm;
	}

	private String frDt;

	private String toDt;

	private String bsCd;

	private String grp1Cd;

	private String grp2Cd;

	private String modelCd;

	private String spec1;

	private String chkIo;

	private String chkLot;

	private String mngNo;

	private String tcolor;

	private String tsize;

	private String tgrade;

	private String basQty;

	private String inQty;

	private String outQty;

	private String endQty;

	private String tcolorNm;

	private String tsizeNm;

	private String tgradeNm;

	private String stdNm;

	private String umBc;

	private String umBcNm;

	private String gubunCode;

	private String baseCd;

	private String title;

	public String getBaseCd() {
		return baseCd;
	}

	public void setBaseCd(String baseCd) {
		this.baseCd = baseCd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getBsCd() {
		return bsCd;
	}

	public void setBsCd(String bsCd) {
		this.bsCd = bsCd;
	}

	public String getGrp1Cd() {
		return grp1Cd;
	}

	public void setGrp1Cd(String grp1Cd) {
		this.grp1Cd = grp1Cd;
	}

	public String getGrp2Cd() {
		return grp2Cd;
	}

	public void setGrp2Cd(String grp2Cd) {
		this.grp2Cd = grp2Cd;
	}

	public String getModelCd() {
		return modelCd;
	}

	public void setModelCd(String modelCd) {
		this.modelCd = modelCd;
	}

	public String getSpec1() {
		return spec1;
	}

	public void setSpec1(String spec1) {
		this.spec1 = spec1;
	}

	public String getChkIo() {
		return chkIo;
	}

	public void setChkIo(String chkIo) {
		this.chkIo = chkIo;
	}

	public String getChkLot() {
		return chkLot;
	}

	public void setChkLot(String chkLot) {
		this.chkLot = chkLot;
	}

	public String getMngNo() {
		return mngNo;
	}

	public void setMngNo(String mngNo) {
		this.mngNo = mngNo;
	}

	public String getTcolor() {
		return tcolor;
	}

	public void setTcolor(String tcolor) {
		this.tcolor = tcolor;
	}

	public String getTsize() {
		return tsize;
	}

	public void setTsize(String tsize) {
		this.tsize = tsize;
	}

	public String getTgrade() {
		return tgrade;
	}

	public void setTgrade(String tgrade) {
		this.tgrade = tgrade;
	}

	public String getBasQty() {
		return basQty;
	}

	public void setBasQty(String basQty) {
		this.basQty = basQty;
	}

	public String getInQty() {
		return inQty;
	}

	public void setInQty(String inQty) {
		this.inQty = inQty;
	}

	public String getOutQty() {
		return outQty;
	}

	public void setOutQty(String outQty) {
		this.outQty = outQty;
	}

	public String getEndQty() {
		return endQty;
	}

	public void setEndQty(String endQty) {
		this.endQty = endQty;
	}

	public String getTcolorNm() {
		return tcolorNm;
	}

	public void setTcolorNm(String tcolorNm) {
		this.tcolorNm = tcolorNm;
	}

	public String getTsizeNm() {
		return tsizeNm;
	}

	public void setTsizeNm(String tsizeNm) {
		this.tsizeNm = tsizeNm;
	}

	public String getTgradeNm() {
		return tgradeNm;
	}

	public void setTgradeNm(String tgradeNm) {
		this.tgradeNm = tgradeNm;
	}

	public String getStdNm() {
		return stdNm;
	}

	public void setStdNm(String stdNm) {
		this.stdNm = stdNm;
	}

	public String getUmBc() {
		return umBc;
	}

	public void setUmBc(String umBc) {
		this.umBc = umBc;
	}

	public String getUmBcNm() {
		return umBcNm;
	}

	public void setUmBcNm(String umBcNm) {
		this.umBcNm = umBcNm;
	}

	public String getGubunCode() {
		return gubunCode;
	}

	public void setGubunCode(String gubunCode) {
		this.gubunCode = gubunCode;
	}

}
