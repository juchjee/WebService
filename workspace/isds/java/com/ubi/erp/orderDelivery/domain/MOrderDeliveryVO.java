package com.ubi.erp.orderDelivery.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("MOrderDeliveryVO")
public class MOrderDeliveryVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String no;

	private String cudKey;

	private String siteCd; // 현장코드

	private String facCd;

	private String id;

	private String value;

	private String empNm;

	private String empNo;

	private String gununCode; // 독점구분[SB301]

	public String getGununCode() {
		return gununCode;
	}

	public void setGununCode(String gununCode) {
		this.gununCode = gununCode;
	}

	private String deptCd;

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getDeptCd() {
		return deptCd;
	}

	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}

	private String deliKey; // 납품번호

	private String deliDate; // 납품일자

	private String deliSeq; // 납품순번

	private String deliNo; // 납품no

	private String custCd; // 거래처코드

	private String poFac; // 발주공장

	private String inFac; // 입고공장

	private String inWh;// 입고창고

	private int itemId; // 품목Id

	private double deliQty; // 납품수량

	private double inQty; // 입고누계수량

	private String poNo; // 발주번호

	private int poSeq; // 발주순번

	private String poDt; // 발주일자

	private String dlvDt; // 납기일자

	private String poKd; // 발주유형-BC:MM101

	private String poBc; // 발주구분-BC:MM100

	private String urgBc; // 긴급구분-BC:MM105

	private String curyBc; // 통화구분-BC:BC400

	private String diBc; // 내외자구분-BC:MM060

	private String rmks;

	private int poSq; // 발주순번

	private int itmId; // 품목Id

	private double poQty; // 발주수량

	private double poUp; // 발주단가

	private double poAmt; // 발주금액

	private String dlvUm; // 남품단위구분

	private String facNm;// 공장명

	private String itmCd; // 품목코드

	private String itmNm; // 품목명

	private String spec; // 품목규격

	private String umBc; // 품목단위

	private String outsCon; // 확인 유뮤

	private String custNm; // 거래처명

	private String whNm; // 창고명

	private String umBcNm; // 단위 구분

	private String urgBcNm; // 긴급구분

	private String stPoDt; // 시작 발주일자

	private String edPoDt; // 종료 발주일자

	private double outsDeliQty;// 납품수량

	private double miDeliQty; // 미납품수량

	private String masterKey; // 고유구분값

	private double oldDeliQty; // 기존납품수량

	private String stDeliDate; // 시작납품일자

	private String edDeliDate; // 종료 납품일자

	private String inNo; // 입고번호

	private int inSq; // 입고순번

	private String inDt; // 입고일자

	private String itmBc; // 품목계정

	private double umQty; // 입고수량

	private double inUp; // 입고단가

	private double inAmt; // 입고금액

	private double etcAmt; // 운반단가

	private double etcTotAmt; // 운반비용

	private double carAmt; // 상차비용

	private int qcEmp; // 검수자

	private String qcNm; // 검수자명

	private String mnm; // 등록자

	private String stInDt; // 입고시작일짜

	private String edInDt; // 입고종료일자

	private String itmBcNm; // 품목계정이름

	private String outsRmk;

	private String outsEndYn;

	private String cancelYn;

	private String statBc;

	private String statBcNm;

	private String chk;

	private String gubn;

	private double miInQty;

	private String outsDeliDt;

	private String poStDt;

	private String poEdDt;

	public String getStatBcNm() {
		return statBcNm;
	}

	public void setStatBcNm(String statBcNm) {
		this.statBcNm = statBcNm;
	}

	public String getOutsDeliDt() {
		return outsDeliDt;
	}

	public void setOutsDeliDt(String outsDeliDt) {
		this.outsDeliDt = outsDeliDt;
	}

	public String getPoStDt() {
		return poStDt;
	}

	public void setPoStDt(String poStDt) {
		this.poStDt = poStDt;
	}

	public String getPoEdDt() {
		return poEdDt;
	}

	public void setPoEdDt(String poEdDt) {
		this.poEdDt = poEdDt;
	}

	public double getMiInQty() {
		return miInQty;
	}

	public void setMiInQty(double miInQty) {
		this.miInQty = miInQty;
	}

	public String getGubn() {
		return gubn;
	}

	public void setGubn(String gubn) {
		this.gubn = gubn;
	}

	public String getChk() {
		return chk;
	}

	public void setChk(String chk) {
		this.chk = chk;
	}

	public String getStatBc() {
		return statBc;
	}

	public void setStatBc(String statBc) {
		this.statBc = statBc;
	}

	public String getOutsEndYn() {
		return outsEndYn;
	}

	public void setOutsEndYn(String outsEndYn) {
		this.outsEndYn = outsEndYn;
	}

	public String getCancelYn() {
		return cancelYn;
	}

	public void setCancelYn(String cancelYn) {
		this.cancelYn = cancelYn;
	}

	public String getOutsRmk() {
		return outsRmk;
	}

	public void setOutsRmk(String outsRmk) {
		this.outsRmk = outsRmk;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getItmBcNm() {
		return itmBcNm;
	}

	public void setItmBcNm(String itmBcNm) {
		this.itmBcNm = itmBcNm;
	}

	public String getInNo() {
		return inNo;
	}

	public void setInNo(String inNo) {
		this.inNo = inNo;
	}

	public int getInSq() {
		return inSq;
	}

	public void setInSq(int inSq) {
		this.inSq = inSq;
	}

	public String getInDt() {
		return inDt;
	}

	public void setInDt(String inDt) {
		this.inDt = inDt;
	}

	public String getItmBc() {
		return itmBc;
	}

	public void setItmBc(String itmBc) {
		this.itmBc = itmBc;
	}

	public double getUmQty() {
		return umQty;
	}

	public void setUmQty(double umQty) {
		this.umQty = umQty;
	}

	public double getInUp() {
		return inUp;
	}

	public void setInUp(double inUp) {
		this.inUp = inUp;
	}

	public double getInAmt() {
		return inAmt;
	}

	public void setInAmt(double inAmt) {
		this.inAmt = inAmt;
	}

	public double getEtcAmt() {
		return etcAmt;
	}

	public void setEtcAmt(double etcAmt) {
		this.etcAmt = etcAmt;
	}

	public double getEtcTotAmt() {
		return etcTotAmt;
	}

	public void setEtcTotAmt(double etcTotAmt) {
		this.etcTotAmt = etcTotAmt;
	}

	public double getCarAmt() {
		return carAmt;
	}

	public void setCarAmt(double carAmt) {
		this.carAmt = carAmt;
	}

	public int getQcEmp() {
		return qcEmp;
	}

	public void setQcEmp(int qcEmp) {
		this.qcEmp = qcEmp;
	}

	public String getQcNm() {
		return qcNm;
	}

	public void setQcNm(String qcNm) {
		this.qcNm = qcNm;
	}

	public String getMnm() {
		return mnm;
	}

	public void setMnm(String mnm) {
		this.mnm = mnm;
	}

	public String getStInDt() {
		return stInDt;
	}

	public void setStInDt(String stInDt) {
		this.stInDt = stInDt;
	}

	public String getEdInDt() {
		return edInDt;
	}

	public void setEdInDt(String edInDt) {
		this.edInDt = edInDt;
	}

	public String getStDeliDate() {
		return stDeliDate;
	}

	public void setStDeliDate(String stDeliDate) {
		this.stDeliDate = stDeliDate;
	}

	public String getEdDeliDate() {
		return edDeliDate;
	}

	public void setEdDeliDate(String edDeliDate) {
		this.edDeliDate = edDeliDate;
	}

	public double getOutsDeliQty() {
		return outsDeliQty;
	}

	public void setOutsDeliQty(double outsDeliQty) {
		this.outsDeliQty = outsDeliQty;
	}

	public double getMiDeliQty() {
		return miDeliQty;
	}

	public void setMiDeliQty(double miDeliQty) {
		this.miDeliQty = miDeliQty;
	}

	public String getMasterKey() {
		return masterKey;
	}

	public void setMasterKey(String masterKey) {
		this.masterKey = masterKey;
	}

	public double getOldDeliQty() {
		return oldDeliQty;
	}

	public void setOldDeliQty(double oldDeliQty) {
		this.oldDeliQty = oldDeliQty;
	}

	public String getStPoDt() {
		return stPoDt;
	}

	public void setStPoDt(String stPoDt) {
		this.stPoDt = stPoDt;
	}

	public String getEdPoDt() {
		return edPoDt;
	}

	public void setEdPoDt(String edPoDt) {
		this.edPoDt = edPoDt;
	}

	public String getFacCd() {
		return facCd;
	}

	public void setFacCd(String facCd) {
		this.facCd = facCd;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getWhNm() {
		return whNm;
	}

	public void setWhNm(String whNm) {
		this.whNm = whNm;
	}

	public String getUmBcNm() {
		return umBcNm;
	}

	public void setUmBcNm(String umBcNm) {
		this.umBcNm = umBcNm;
	}

	public String getUrgBcNm() {
		return urgBcNm;
	}

	public void setUrgBcNm(String urgBcNm) {
		this.urgBcNm = urgBcNm;
	}

	public String getDlvDt() {
		return dlvDt;
	}

	public void setDlvDt(String dlvDt) {
		this.dlvDt = dlvDt;
	}

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

	public String getUmBc() {
		return umBc;
	}

	public void setUmBc(String umBc) {
		this.umBc = umBc;
	}

	public String getOutsCon() {
		return outsCon;
	}

	public void setOutsCon(String outsCon) {
		this.outsCon = outsCon;
	}

	public String getDlvUm() {
		return dlvUm;
	}

	public void setDlvUm(String dlvUm) {
		this.dlvUm = dlvUm;
	}

	public String getFacNm() {
		return facNm;
	}

	public void setFacNm(String facNm) {
		this.facNm = facNm;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getCudKey() {
		return cudKey;
	}

	public void setCudKey(String cudKey) {
		this.cudKey = cudKey;
	}

	public String getSiteCd() {
		return siteCd;
	}

	public void setSiteCd(String siteCd) {
		this.siteCd = siteCd;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDeliKey() {
		return deliKey;
	}

	public void setDeliKey(String deliKey) {
		this.deliKey = deliKey;
	}

	public String getDeliDate() {
		return deliDate;
	}

	public void setDeliDate(String deliDate) {
		this.deliDate = deliDate;
	}

	public String getDeliSeq() {
		return deliSeq;
	}

	public void setDeliSeq(String deliSeq) {
		this.deliSeq = deliSeq;
	}

	public String getDeliNo() {
		return deliNo;
	}

	public void setDeliNo(String deliNo) {
		this.deliNo = deliNo;
	}

	public String getCustCd() {
		return custCd;
	}

	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	public String getPoFac() {
		return poFac;
	}

	public void setPoFac(String poFac) {
		this.poFac = poFac;
	}

	public String getInFac() {
		return inFac;
	}

	public void setInFac(String inFac) {
		this.inFac = inFac;
	}

	public String getInWh() {
		return inWh;
	}

	public void setInWh(String inWh) {
		this.inWh = inWh;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public double getDeliQty() {
		return deliQty;
	}

	public void setDeliQty(double deliQty) {
		this.deliQty = deliQty;
	}

	public double getInQty() {
		return inQty;
	}

	public void setInQty(double inQty) {
		this.inQty = inQty;
	}

	public String getPoNo() {
		return poNo;
	}

	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	public int getPoSeq() {
		return poSeq;
	}

	public void setPoSeq(int poSeq) {
		this.poSeq = poSeq;
	}

	public String getPoDt() {
		return poDt;
	}

	public void setPoDt(String poDt) {
		this.poDt = poDt;
	}

	public String getPoKd() {
		return poKd;
	}

	public void setPoKd(String poKd) {
		this.poKd = poKd;
	}

	public String getPoBc() {
		return poBc;
	}

	public void setPoBc(String poBc) {
		this.poBc = poBc;
	}

	public String getUrgBc() {
		return urgBc;
	}

	public void setUrgBc(String urgBc) {
		this.urgBc = urgBc;
	}

	public String getCuryBc() {
		return curyBc;
	}

	public void setCuryBc(String curyBc) {
		this.curyBc = curyBc;
	}

	public String getDiBc() {
		return diBc;
	}

	public void setDiBc(String diBc) {
		this.diBc = diBc;
	}

	public String getRmks() {
		return rmks;
	}

	public void setRmks(String rmks) {
		this.rmks = rmks;
	}

	public int getPoSq() {
		return poSq;
	}

	public void setPoSq(int poSq) {
		this.poSq = poSq;
	}

	public int getItmId() {
		return itmId;
	}

	public void setItmId(int itmId) {
		this.itmId = itmId;
	}

	public double getPoQty() {
		return poQty;
	}

	public void setPoQty(double poQty) {
		this.poQty = poQty;
	}

	public double getPoUp() {
		return poUp;
	}

	public void setPoUp(double poUp) {
		this.poUp = poUp;
	}

	public double getPoAmt() {
		return poAmt;
	}

	public void setPoAmt(double poAmt) {
		this.poAmt = poAmt;
	}

	/* 출하현황(대리점용) */
	private String soNo;

	private String cust;

	private String outDt;

	private String nm; /* 영업사원 */

	private String salBc;

	private String salBcNm;

	private String tcolor;

	private String tcolorNm;

	private String tsize;

	private String tsizeNm;

	private String tgrade;

	private String tgradeNm;

	private String fldCd;

	private String fldNm;

	private String weightTot;

	private String outQty;

	private String dlvYard;

	private String outUp;

	private String outAmt;

	private String outBs;

	private String frDt;

	private String toDt;

	private String outNo;

	private String outSq;

	private String whCd;

	private String carNo;

	private String drvNm;

	private String mobile;

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public String getDrvNm() {
		return drvNm;
	}

	public void setDrvNm(String drvNm) {
		this.drvNm = drvNm;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getOutNo() {
		return outNo;
	}

	public void setOutNo(String outNo) {
		this.outNo = outNo;
	}

	public String getOutSq() {
		return outSq;
	}

	public void setOutSq(String outSq) {
		this.outSq = outSq;
	}

	public String getWhCd() {
		return whCd;
	}

	public void setWhCd(String whCd) {
		this.whCd = whCd;
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

	public String getSoNo() {
		return soNo;
	}

	public void setSoNo(String soNo) {
		this.soNo = soNo;
	}

	public String getCust() {
		return cust;
	}

	public void setCust(String cust) {
		this.cust = cust;
	}

	public String getOutDt() {
		return outDt;
	}

	public void setOutDt(String outDt) {
		this.outDt = outDt;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public String getSalBc() {
		return salBc;
	}

	public void setSalBc(String salBc) {
		this.salBc = salBc;
	}

	public String getSalBcNm() {
		return salBcNm;
	}

	public void setSalBcNm(String salBcNm) {
		this.salBcNm = salBcNm;
	}

	public String getTcolor() {
		return tcolor;
	}

	public void setTcolor(String tcolor) {
		this.tcolor = tcolor;
	}

	public String getTcolorNm() {
		return tcolorNm;
	}

	public void setTcolorNm(String tcolorNm) {
		this.tcolorNm = tcolorNm;
	}

	public String getTsize() {
		return tsize;
	}

	public void setTsize(String tsize) {
		this.tsize = tsize;
	}

	public String getTsizeNm() {
		return tsizeNm;
	}

	public void setTsizeNm(String tsizeNm) {
		this.tsizeNm = tsizeNm;
	}

	public String getTgrade() {
		return tgrade;
	}

	public void setTgrade(String tgrade) {
		this.tgrade = tgrade;
	}

	public String getTgradeNm() {
		return tgradeNm;
	}

	public void setTgradeNm(String tgradeNm) {
		this.tgradeNm = tgradeNm;
	}

	public String getFldCd() {
		return fldCd;
	}

	public void setFldCd(String fldCd) {
		this.fldCd = fldCd;
	}

	public String getFldNm() {
		return fldNm;
	}

	public void setFldNm(String fldNm) {
		this.fldNm = fldNm;
	}

	public String getWeightTot() {
		return weightTot;
	}

	public void setWeightTot(String weightTot) {
		this.weightTot = weightTot;
	}

	public String getOutQty() {
		return outQty;
	}

	public void setOutQty(String outQty) {
		this.outQty = outQty;
	}

	public String getDlvYard() {
		return dlvYard;
	}

	public void setDlvYard(String dlvYard) {
		this.dlvYard = dlvYard;
	}

	public String getOutUp() {
		return outUp;
	}

	public void setOutUp(String outUp) {
		this.outUp = outUp;
	}

	public String getOutAmt() {
		return outAmt;
	}

	public void setOutAmt(String outAmt) {
		this.outAmt = outAmt;
	}

	public String getOutBs() {
		return outBs;
	}

	public void setOutBs(String outBs) {
		this.outBs = outBs;
	}

	private String bsCd;

	public String getBsCd() {
		return bsCd;
	}

	public void setBsCd(String bsCd) {
		this.bsCd = bsCd;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


}
