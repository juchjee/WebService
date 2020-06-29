package com.ubi.erp.shipment.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("ShipmentVO")
public class ShipmentVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String coCd; // 법인

	private String custCd; // 거래처코드

	private String custNm; // 거래처명

	private String fldCd; // 현장코드

	private String fldNm; // 현장명

	private String transNo; // 운송번호

	private String tcustCd; // 운송사-거래처

	private String tcustNm; // 운송사-거래처명

	private String carNo; // 차량번호

	private String drvNm; // 운전기사

	private double outQty; // 수량

	private double weightTot; // 중량

	private String outDt; // 출하일자

	private String facCd;	//출하공장
	
	private String salBc;	//수주구분
	
	private String salBcNm;	//수주구분명
	
	private String custCd2;	//매출거래처코드
	
	private String custNm2;	//매출거래처명
	
	private String itmId;	//품목id

	private String itmCd;	//품목코드
	
	private String itmNm;	//품목명

	private String spec;	//품목-규격
	
	private double outUp;	//단가
	
	private double outAmt;	//출고-금액
	
	private double weightUp; // 출고-단가(톤당)
	
	private double mUp;	//출고-M당단가
	
	private double jointUp;	//출고-joint당 단가
	
	private double plateUp;	//출고-보강판단가
	
	private double outTamt; // 합계

	private String nm; // 담당자

	private String grp1Cd; // 대분류코드

	private String grp1Nm; // 대분류명

	private String grp2Cd; // 중분류코드

	private String grp2Nm; // 중분류명

	private String grp3Cd; // 소분류코드

	private String grp3Nm; // 소분류명

	private String tcolor; // 타일-색상

	private String tcolorNm;

	private String tsize; // 타일-사이즈

	private String tsizeNm;

	private String tgrade; // 타일-등급

	private String tgradeNm;

	private String mTime; // 출발시간

	private String whCd; // 출하창고

	private String whNm; // 출하창고명

	private String outBc; // 출고유형

	private String outBcNm; // 출고유형명

	private String outNo; // 출고번호

	private int outSq; // 순번

	private String umBc; // 단위

	private String umBcNm; // 단위명

	private String mngNo;	//LOT
	
	private String entBc;	//입력경로
	
	private String movNo;	//출하이동번호
	
	private String partCode;	//거래처품번
	
	private String modelCd;	//차종
	
	private String itmBc; // 구분
	
	private String itmBcNm; // 품목구분명
	
	private String spec1;	//color
	
	private String rcarNo; // 차량번호2
	
	private String mnm; // 등록자
	
	private String mdt; // 등록일
	
	private int drvCount; // count

	private String regId; // 사용자등록ID

	private String outDtFr; // 출하기간(from)

	private String outDtTo; // 출하기간(to)

	private String orderBy; // 순서

	private String nowDate;

	private String deptCd; // 부서코드

	private int no; // NO

	private String val; // 쿼리 조회용 [LEM100-movNo, LEM200-transNo]

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getUmBcNm() {
		return umBcNm;
	}

	public void setUmBcNm(String umBcNm) {
		this.umBcNm = umBcNm;
	}

	public String getDeptCd() {
		return deptCd;
	}

	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}

	public String getNowDate() {
		return nowDate;
	}

	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOutDtFr() {
		return outDtFr;
	}

	public void setOutDtFr(String outDtFr) {
		this.outDtFr = outDtFr;
	}

	public String getOutDtTo() {
		return outDtTo;
	}

	public void setOutDtTo(String outDtTo) {
		this.outDtTo = outDtTo;
	}

	public String getCoCd() {
		return coCd;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public void setCoCd(String coCd) {
		this.coCd = coCd;
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

	public String getTransNo() {
		return transNo;
	}

	public void setTransNo(String transNo) {
		this.transNo = transNo;
	}

	public String getTcustCd() {
		return tcustCd;
	}

	public void setTcustCd(String tcustCd) {
		this.tcustCd = tcustCd;
	}

	public String getTcustNm() {
		return tcustNm;
	}

	public void setTcustNm(String tcustNm) {
		this.tcustNm = tcustNm;
	}

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

	public double getOutQty() {
		return outQty;
	}

	public void setOutQty(double outQty) {
		this.outQty = outQty;
	}

	public double getWeightTot() {
		return weightTot;
	}

	public void setWeightTot(double weightTot) {
		this.weightTot = weightTot;
	}

	public String getOutDt() {
		return outDt;
	}

	public void setOutDt(String outDt) {
		this.outDt = outDt;
	}

	public String getFacCd() {
		return facCd;
	}

	public void setFacCd(String facCd) {
		this.facCd = facCd;
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

	public String getCustCd2() {
		return custCd2;
	}

	public void setCustCd2(String custCd2) {
		this.custCd2 = custCd2;
	}

	public String getCustNm2() {
		return custNm2;
	}

	public void setCustNm2(String custNm2) {
		this.custNm2 = custNm2;
	}

	public String getItmId() {
		return itmId;
	}

	public void setItmId(String itmId) {
		this.itmId = itmId;
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

	public double getOutUp() {
		return outUp;
	}

	public void setOutUp(double outUp) {
		this.outUp = outUp;
	}

	public double getOutAmt() {
		return outAmt;
	}

	public void setOutAmt(double outAmt) {
		this.outAmt = outAmt;
	}

	public double getmUp() {
		return mUp;
	}

	public void setmUp(double mUp) {
		this.mUp = mUp;
	}

	public double getJointUp() {
		return jointUp;
	}

	public void setJointUp(double jointUp) {
		this.jointUp = jointUp;
	}

	public double getPlateUp() {
		return plateUp;
	}

	public void setPlateUp(double plateUp) {
		this.plateUp = plateUp;
	}

	public double getOutTamt() {
		return outTamt;
	}

	public void setOutTamt(double outTamt) {
		this.outTamt = outTamt;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public String getGrp1Cd() {
		return grp1Cd;
	}

	public void setGrp1Cd(String grp1Cd) {
		this.grp1Cd = grp1Cd;
	}

	public String getGrp1Nm() {
		return grp1Nm;
	}

	public void setGrp1Nm(String grp1Nm) {
		this.grp1Nm = grp1Nm;
	}

	public String getGrp2Cd() {
		return grp2Cd;
	}

	public void setGrp2Cd(String grp2Cd) {
		this.grp2Cd = grp2Cd;
	}

	public String getGrp2Nm() {
		return grp2Nm;
	}

	public void setGrp2Nm(String grp2Nm) {
		this.grp2Nm = grp2Nm;
	}

	public String getGrp3Cd() {
		return grp3Cd;
	}

	public void setGrp3Cd(String grp3Cd) {
		this.grp3Cd = grp3Cd;
	}

	public String getGrp3Nm() {
		return grp3Nm;
	}

	public void setGrp3Nm(String grp3Nm) {
		this.grp3Nm = grp3Nm;
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

	public String getWhCd() {
		return whCd;
	}

	public void setWhCd(String whCd) {
		this.whCd = whCd;
	}

	public String getWhNm() {
		return whNm;
	}

	public void setWhNm(String whNm) {
		this.whNm = whNm;
	}

	public String getOutBc() {
		return outBc;
	}

	public void setOutBc(String outBc) {
		this.outBc = outBc;
	}

	public String getOutBcNm() {
		return outBcNm;
	}

	public void setOutBcNm(String outBcNm) {
		this.outBcNm = outBcNm;
	}

	public String getOutNo() {
		return outNo;
	}

	public void setOutNo(String outNo) {
		this.outNo = outNo;
	}

	public int getOutSq() {
		return outSq;
	}

	public void setOutSq(int outSq) {
		this.outSq = outSq;
	}

	public String getUmBc() {
		return umBc;
	}

	public void setUmBc(String umBc) {
		this.umBc = umBc;
	}

	public String getMngNo() {
		return mngNo;
	}

	public void setMngNo(String mngNo) {
		this.mngNo = mngNo;
	}

	public String getEntBc() {
		return entBc;
	}

	public void setEntBc(String entBc) {
		this.entBc = entBc;
	}

	public String getMovNo() {
		return movNo;
	}

	public void setMovNo(String movNo) {
		this.movNo = movNo;
	}

	public String getPartCode() {
		return partCode;
	}

	public void setPartCode(String partCode) {
		this.partCode = partCode;
	}

	public String getModelCd() {
		return modelCd;
	}

	public void setModelCd(String modelCd) {
		this.modelCd = modelCd;
	}

	public String getmTime() {
		return mTime;
	}

	public void setmTime(String mTime) {
		this.mTime = mTime;
	}

	public String getItmBc() {
		return itmBc;
	}

	public void setItmBc(String itmBc) {
		this.itmBc = itmBc;
	}

	public String getItmBcNm() {
		return itmBcNm;
	}

	public void setItmBcNm(String itmBcNm) {
		this.itmBcNm = itmBcNm;
	}

	public String getSpec1() {
		return spec1;
	}

	public void setSpec1(String spec1) {
		this.spec1 = spec1;
	}

	public String getRcarNo() {
		return rcarNo;
	}

	public void setRcarNo(String rcarNo) {
		this.rcarNo = rcarNo;
	}

	public String getMnm() {
		return mnm;
	}

	public void setMnm(String mnm) {
		this.mnm = mnm;
	}

	public String getMdt() {
		return mdt;
	}

	public void setMdt(String mdt) {
		this.mdt = mdt;
	}

	public int getDrvCount() {
		return drvCount;
	}

	public void setDrvCount(int drvCount) {
		this.drvCount = drvCount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public double getWeightUp() {
		return weightUp;
	}

	public void setWeightUp(double weightUp) {
		this.weightUp = weightUp;
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

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}
	
	private String bizArea; // 사업군

	private String bizNo; // 사업자등록번호

	private String ceoNm; // 대표자성명

	private String bizPnm; // 사업자명

	private String bizTel; // 전화번호(동서)

	private String bizAddr; // 사업장주소

	private String custAddr; // 주소(거래처)

	private String custTel; // 거래처전화번호

	private String cust2Tel; // 거래처 담당자 전화번호

	private String driver; // 운전자

	private String drvTel; // 운전자연락처

	private String frTm; // 납품시각

	private String chulDt; // 납품시각

	private double qty; // 수량

	private String rmks; // 비고

	private String empNm; // 담당자명

	private double wgt; // 단위중량(PC부재)

	private double totWgt; // 중량(PC부재)

	private double ex1; // 체적(PC부재)

	private String gateYn; // 정문제출용 송장 출력여부

	private String fldRmks;

	private String extRmks; // ext비고

	private String pileGangdo;

	private String flyAsh;

	private String blastSlag;

	private String matlMix;

	private String mixMatlGubun;

	private String waterQty;

	private String waterWithQty;

	private String aggregateQty;

	private String ksChk;

	private int waterBack;

	private String clsScd;

	private String chulYy;

	private String chulMm;

	private String chulDd;

	private String chulHh;

	private String chulBb;

	private String spec2;

	private String spec3;

	private String chulNm;

	private int carCnt;

	private int fCnt;

	private String c1;

	private String c2;

	private String c3;

	private String g1;

	private String g2;

	private String s1;

	private String s2;

	private String ad1;

	private String ad2;

	private String ad3;

	private String leftCarno;

	private String specChk;

	private double totQty;

	private String cntNo;

	public String getCntNo() {
		return cntNo;
	}

	public void setCntNo(String cntNo) {
		this.cntNo = cntNo;
	}

	public double getTotQty() {
		return totQty;
	}

	public void setTotQty(double totQty) {
		this.totQty = totQty;
	}

	public String getChulYy() {
		return chulYy;
	}

	public void setChulYy(String chulYy) {
		this.chulYy = chulYy;
	}

	public String getChulMm() {
		return chulMm;
	}

	public void setChulMm(String chulMm) {
		this.chulMm = chulMm;
	}

	public String getChulDd() {
		return chulDd;
	}

	public void setChulDd(String chulDd) {
		this.chulDd = chulDd;
	}

	public String getChulHh() {
		return chulHh;
	}

	public void setChulHh(String chulHh) {
		this.chulHh = chulHh;
	}

	public String getChulBb() {
		return chulBb;
	}

	public void setChulBb(String chulBb) {
		this.chulBb = chulBb;
	}

	public String getSpec2() {
		return spec2;
	}

	public void setSpec2(String spec2) {
		this.spec2 = spec2;
	}

	public String getSpec3() {
		return spec3;
	}

	public void setSpec3(String spec3) {
		this.spec3 = spec3;
	}

	public String getChulNm() {
		return chulNm;
	}

	public void setChulNm(String chulNm) {
		this.chulNm = chulNm;
	}

	public int getCarCnt() {
		return carCnt;
	}

	public void setCarCnt(int carCnt) {
		this.carCnt = carCnt;
	}

	public int getfCnt() {
		return fCnt;
	}

	public void setfCnt(int fCnt) {
		this.fCnt = fCnt;
	}

	public String getC1() {
		return c1;
	}

	public void setC1(String c1) {
		this.c1 = c1;
	}

	public String getC2() {
		return c2;
	}

	public void setC2(String c2) {
		this.c2 = c2;
	}

	public String getC3() {
		return c3;
	}

	public void setC3(String c3) {
		this.c3 = c3;
	}

	public String getG1() {
		return g1;
	}

	public void setG1(String g1) {
		this.g1 = g1;
	}

	public String getG2() {
		return g2;
	}

	public void setG2(String g2) {
		this.g2 = g2;
	}

	public String getS1() {
		return s1;
	}

	public void setS1(String s1) {
		this.s1 = s1;
	}

	public String getS2() {
		return s2;
	}

	public void setS2(String s2) {
		this.s2 = s2;
	}

	public String getAd1() {
		return ad1;
	}

	public void setAd1(String ad1) {
		this.ad1 = ad1;
	}

	public String getAd2() {
		return ad2;
	}

	public void setAd2(String ad2) {
		this.ad2 = ad2;
	}

	public String getAd3() {
		return ad3;
	}

	public void setAd3(String ad3) {
		this.ad3 = ad3;
	}

	public String getLeftCarno() {
		return leftCarno;
	}

	public void setLeftCarno(String leftCarno) {
		this.leftCarno = leftCarno;
	}

	public String getSpecChk() {
		return specChk;
	}

	public void setSpecChk(String specChk) {
		this.specChk = specChk;
	}

	public String getBizArea() {
		return bizArea;
	}

	public void setBizArea(String bizArea) {
		this.bizArea = bizArea;
	}

	public String getBizNo() {
		return bizNo;
	}

	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}

	public String getCeoNm() {
		return ceoNm;
	}

	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}

	public String getBizPnm() {
		return bizPnm;
	}

	public void setBizPnm(String bizPnm) {
		this.bizPnm = bizPnm;
	}

	public String getBizTel() {
		return bizTel;
	}

	public void setBizTel(String bizTel) {
		this.bizTel = bizTel;
	}

	public String getBizAddr() {
		return bizAddr;
	}

	public void setBizAddr(String bizAddr) {
		this.bizAddr = bizAddr;
	}

	public String getCustAddr() {
		return custAddr;
	}

	public void setCustAddr(String custAddr) {
		this.custAddr = custAddr;
	}

	public String getCustTel() {
		return custTel;
	}

	public void setCustTel(String custTel) {
		this.custTel = custTel;
	}

	public String getCust2Tel() {
		return cust2Tel;
	}

	public void setCust2Tel(String cust2Tel) {
		this.cust2Tel = cust2Tel;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getDrvTel() {
		return drvTel;
	}

	public void setDrvTel(String drvTel) {
		this.drvTel = drvTel;
	}

	public String getFrTm() {
		return frTm;
	}

	public void setFrTm(String frTm) {
		this.frTm = frTm;
	}

	public String getChulDt() {
		return chulDt;
	}

	public void setChulDt(String chulDt) {
		this.chulDt = chulDt;
	}

	public double getQty() {
		return qty;
	}

	public void setQty(double qty) {
		this.qty = qty;
	}

	public String getRmks() {
		return rmks;
	}

	public void setRmks(String rmks) {
		this.rmks = rmks;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public double getWgt() {
		return wgt;
	}

	public void setWgt(double wgt) {
		this.wgt = wgt;
	}

	public double getTotWgt() {
		return totWgt;
	}

	public void setTotWgt(double totWgt) {
		this.totWgt = totWgt;
	}

	public double getEx1() {
		return ex1;
	}

	public void setEx1(double ex1) {
		this.ex1 = ex1;
	}

	public String getGateYn() {
		return gateYn;
	}

	public void setGateYn(String gateYn) {
		this.gateYn = gateYn;
	}

	public String getFldRmks() {
		return fldRmks;
	}

	public void setFldRmks(String fldRmks) {
		this.fldRmks = fldRmks;
	}

	public String getExtRmks() {
		return extRmks;
	}

	public void setExtRmks(String extRmks) {
		this.extRmks = extRmks;
	}

	public String getPileGangdo() {
		return pileGangdo;
	}

	public void setPileGangdo(String pileGangdo) {
		this.pileGangdo = pileGangdo;
	}

	public String getFlyAsh() {
		return flyAsh;
	}

	public void setFlyAsh(String flyAsh) {
		this.flyAsh = flyAsh;
	}

	public String getBlastSlag() {
		return blastSlag;
	}

	public void setBlastSlag(String blastSlag) {
		this.blastSlag = blastSlag;
	}

	public String getMatlMix() {
		return matlMix;
	}

	public void setMatlMix(String matlMix) {
		this.matlMix = matlMix;
	}

	public String getMixMatlGubun() {
		return mixMatlGubun;
	}

	public void setMixMatlGubun(String mixMatlGubun) {
		this.mixMatlGubun = mixMatlGubun;
	}

	public String getWaterQty() {
		return waterQty;
	}

	public void setWaterQty(String waterQty) {
		this.waterQty = waterQty;
	}

	public String getWaterWithQty() {
		return waterWithQty;
	}

	public void setWaterWithQty(String waterWithQty) {
		this.waterWithQty = waterWithQty;
	}

	public String getAggregateQty() {
		return aggregateQty;
	}

	public void setAggregateQty(String aggregateQty) {
		this.aggregateQty = aggregateQty;
	}

	public String getKsChk() {
		return ksChk;
	}

	public void setKsChk(String ksChk) {
		this.ksChk = ksChk;
	}

	public int getWaterBack() {
		return waterBack;
	}

	public void setWaterBack(int waterBack) {
		this.waterBack = waterBack;
	}

	public String getClsScd() {
		return clsScd;
	}

	public void setClsScd(String clsScd) {
		this.clsScd = clsScd;
	}
	
	
	/* 출하처리 start */
	private int cid; // 생성자

	private int mid; // 수정자

	private int movSq; // 순번

	private int soSq; // 순번

	private int ordSq; // 정렬순번

	private int outPsq; // 출고계획순번

	private int reqSq; // 요청순

	private int toItmId; // 변경품목ID

	private double engAmt; // 기술료

	private double m1; // 관리1

	private double movAmt; // 출하금액

	private double movQty; // 출하수량

	private double remQty; // 출하잔량

	private double soQty; // 요청수량

	private double soVat; // 부가세

	private double totWeight; // 총중량

	private double weight; // 중량
	
	private String cdt; // 생성일자

	private String curyBc; // 수주통화

	private String dlvCustnm; // 고객명

	private String dlvDt; // 요청일자

	private String dlvTel; // 고객전화번호

	private String dlvYard; // 납품장소

	private String fkind; // 파일종류

	private String movUp; // 출하단가

	private String soNo; // 수주번호

	private String ordNo; // 주문번호

	private String outPno; // 출고계획번호

	private String outQtyInput; // 출하수량 입력용

	private String reqNo; // 출하요청

	private String salBs; // 매출사업장

	private String soDt; // 요청일자

	private String soFac; // 수주공장

	private String soNm; // 담당자

	private String statBc; // 상태구분

	private String statBcNm; // 상태구분명

	private String toMngNo; // 변경품목lotno

	private String woNo; // 작업지시번호

	private String reqDtFr;

	private String reqDtTo;

	private String id;

	private String stdUm;

	private String stdUmNm;

	public String getStdUm() {
		return stdUm;
	}

	public void setStdUm(String stdUm) {
		this.stdUm = stdUm;
	}

	public String getStdUmNm() {
		return stdUmNm;
	}

	public void setStdUmNm(String stdUmNm) {
		this.stdUmNm = stdUmNm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReqDtFr() {
		return reqDtFr;
	}

	public void setReqDtFr(String reqDtFr) {
		this.reqDtFr = reqDtFr;
	}

	public String getReqDtTo() {
		return reqDtTo;
	}

	public void setReqDtTo(String reqDtTo) {
		this.reqDtTo = reqDtTo;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public int getMovSq() {
		return movSq;
	}

	public void setMovSq(int movSq) {
		this.movSq = movSq;
	}

	public int getSoSq() {
		return soSq;
	}

	public void setSoSq(int soSq) {
		this.soSq = soSq;
	}

	public int getOrdSq() {
		return ordSq;
	}

	public void setOrdSq(int ordSq) {
		this.ordSq = ordSq;
	}

	public int getOutPsq() {
		return outPsq;
	}

	public void setOutPsq(int outPsq) {
		this.outPsq = outPsq;
	}

	public int getReqSq() {
		return reqSq;
	}

	public void setReqSq(int reqSq) {
		this.reqSq = reqSq;
	}

	public int getToItmId() {
		return toItmId;
	}

	public void setToItmId(int toItmId) {
		this.toItmId = toItmId;
	}

	public double getEngAmt() {
		return engAmt;
	}

	public void setEngAmt(double engAmt) {
		this.engAmt = engAmt;
	}

	public double getM1() {
		return m1;
	}

	public void setM1(double m1) {
		this.m1 = m1;
	}

	public double getMovAmt() {
		return movAmt;
	}

	public void setMovAmt(double movAmt) {
		this.movAmt = movAmt;
	}

	public double getMovQty() {
		return movQty;
	}

	public void setMovQty(double movQty) {
		this.movQty = movQty;
	}

	public double getRemQty() {
		return remQty;
	}

	public void setRemQty(double remQty) {
		this.remQty = remQty;
	}

	public double getSoQty() {
		return soQty;
	}

	public void setSoQty(double soQty) {
		this.soQty = soQty;
	}

	public double getSoVat() {
		return soVat;
	}

	public void setSoVat(double soVat) {
		this.soVat = soVat;
	}

	public double getTotWeight() {
		return totWeight;
	}

	public void setTotWeight(double totWeight) {
		this.totWeight = totWeight;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public String getCdt() {
		return cdt;
	}

	public void setCdt(String cdt) {
		this.cdt = cdt;
	}

	public String getCuryBc() {
		return curyBc;
	}

	public void setCuryBc(String curyBc) {
		this.curyBc = curyBc;
	}

	public String getDlvCustnm() {
		return dlvCustnm;
	}

	public void setDlvCustnm(String dlvCustnm) {
		this.dlvCustnm = dlvCustnm;
	}

	public String getDlvDt() {
		return dlvDt;
	}

	public void setDlvDt(String dlvDt) {
		this.dlvDt = dlvDt;
	}

	public String getDlvTel() {
		return dlvTel;
	}

	public void setDlvTel(String dlvTel) {
		this.dlvTel = dlvTel;
	}

	public String getDlvYard() {
		return dlvYard;
	}

	public void setDlvYard(String dlvYard) {
		this.dlvYard = dlvYard;
	}

	public String getFkind() {
		return fkind;
	}

	public void setFkind(String fkind) {
		this.fkind = fkind;
	}

	public String getMovUp() {
		return movUp;
	}

	public void setMovUp(String movUp) {
		this.movUp = movUp;
	}

	public String getSoNo() {
		return soNo;
	}

	public void setSoNo(String soNo) {
		this.soNo = soNo;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String getOutPno() {
		return outPno;
	}

	public void setOutPno(String outPno) {
		this.outPno = outPno;
	}

	public String getOutQtyInput() {
		return outQtyInput;
	}

	public void setOutQtyInput(String outQtyInput) {
		this.outQtyInput = outQtyInput;
	}

	public String getReqNo() {
		return reqNo;
	}

	public void setReqNo(String reqNo) {
		this.reqNo = reqNo;
	}

	public String getSalBs() {
		return salBs;
	}

	public void setSalBs(String salBs) {
		this.salBs = salBs;
	}

	public String getSoDt() {
		return soDt;
	}

	public void setSoDt(String soDt) {
		this.soDt = soDt;
	}

	public String getSoFac() {
		return soFac;
	}

	public void setSoFac(String soFac) {
		this.soFac = soFac;
	}

	public String getSoNm() {
		return soNm;
	}

	public void setSoNm(String soNm) {
		this.soNm = soNm;
	}

	public String getStatBc() {
		return statBc;
	}

	public void setStatBc(String statBc) {
		this.statBc = statBc;
	}

	public String getStatBcNm() {
		return statBcNm;
	}

	public void setStatBcNm(String statBcNm) {
		this.statBcNm = statBcNm;
	}

	public String getToMngNo() {
		return toMngNo;
	}

	public void setToMngNo(String toMngNo) {
		this.toMngNo = toMngNo;
	}

	public String getWoNo() {
		return woNo;
	}

	public void setWoNo(String woNo) {
		this.woNo = woNo;
	}

	/* 출하처리 end */

	/* 출고사업장코드 조회 START */
	private String bsCd;

	private String bsNm;

	public String getBsCd() {
		return bsCd;
	}

	public void setBsCd(String bsCd) {
		this.bsCd = bsCd;
	}

	public String getBsNm() {
		return bsNm;
	}

	public void setBsNm(String bsNm) {
		this.bsNm = bsNm;
	}
	/* 출고사업장코드 조회 END */

	/* 일일회전수 Popup START */
	private String carSeq;

	private int cnt;

	public String getCarSeq() {
		return carSeq;
	}

	public void setCarSeq(String carSeq) {
		this.carSeq = carSeq;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	/* 일일회전수 Popup END */

	/* 차량정보 Popup START */
	private String seq;

	private String drvHp;

	private String carKd; // 차량종류

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getDrvHp() {
		return drvHp;
	}

	public void setDrvHp(String drvHp) {
		this.drvHp = drvHp;
	}

	public String getCarKd() {
		return carKd;
	}

	public void setCarKd(String carKd) {
		this.carKd = carKd;
	}
	/* 차량정보 Popup END */

	private String tableNm;

	public String getTableNm() {
		return tableNm;
	}

	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}
}
