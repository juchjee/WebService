package com.ubi.erp.custCard.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("CustCardVO")
public class CustCardVO implements Serializable {

	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	private String mainCd;

	private String sdFrDt;

	private String sdToDt;

	private String empNo;

	private String custNm;

	private String surveyDt;

	private String callDt;

	private String callStat;

	private String custCd;

	private String id;

	private String saleCode;

	private String setCustCd;

	private String sdDt;

	private String empNm;

	private String custGubun;

	private String sdGubun;

	private String sdGubunEtc;

	public String getSdGubunEtc() {
		return sdGubunEtc;
	}

	public void setSdGubunEtc(String sdGubunEtc) {
		this.sdGubunEtc = sdGubunEtc;
	}

	private String custTel;

	private String custAddr;

	private String siteType;

	private String siteTypeEtc;

	private String siteElevator;

	private String typeChk1;

	private String typeChk2;

	private String typeChk3;

	private String typeChk4;

	private String typeChk5;

	private String preBathQty;

	private String preBathType1;

	private String preBathType2;

	private String preBathType3;

	private String preBathType4;

	private String preBathType5;

	private String preBathType6;

	private String reqBathQty;

	private String reqBathType1;

	private String reqBathType2;

	private String reqBathType3;

	private String reqBathType4;

	private String reqBathType5;

	private String reqBathType5Nm;

	public String getReqBathType5Nm() {
		return reqBathType5Nm;
	}

	public void setReqBathType5Nm(String reqBathType5Nm) {
		this.reqBathType5Nm = reqBathType5Nm;
	}

	public String getReqBathType5() {
		return reqBathType5;
	}

	public void setReqBathType5(String reqBathType5) {
		this.reqBathType5 = reqBathType5;
	}

	private String reqBathTypeEtc;

	private String inputRoute;

	private String interestProduct1;

	private String interestProduct2;

	private String interestProduct3;

	private String interestProduct4;

	private String interestProduct5;

	private String visitCnt;

	private String costType1;

	private String costType2;

	private String bathStyle1;

	private String bathStyle2;

	private String surveyHour;

	private String surveyMin;

	private String sigongDt;

	private String reservYn;

	private String saleName;

	private String consultCont1;

	private String consultCont2;

	private String regId;

	private String tableNm;

	private String ordNo;

	private int ordCnt;

	private String val;

	public int getOrdCnt() {
		return ordCnt;
	}

	public void setOrdCnt(int ordCnt) {
		this.ordCnt = ordCnt;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getMainCd() {
		return mainCd;
	}

	public void setMainCd(String mainCd) {
		this.mainCd = mainCd;
	}

	public String getSdFrDt() {
		return sdFrDt;
	}

	public void setSdFrDt(String sdFrDt) {
		this.sdFrDt = sdFrDt;
	}

	public String getSdToDt() {
		return sdToDt;
	}

	public void setSdToDt(String sdToDt) {
		this.sdToDt = sdToDt;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getCustNm() {
		return custNm;
	}

	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	public String getSurveyDt() {
		return surveyDt;
	}

	public void setSurveyDt(String surveyDt) {
		this.surveyDt = surveyDt;
	}

	public String getCallDt() {
		return callDt;
	}

	public void setCallDt(String callDt) {
		this.callDt = callDt;
	}

	public String getCallStat() {
		return callStat;
	}

	public void setCallStat(String callStat) {
		this.callStat = callStat;
	}

	public String getCustCd() {
		return custCd;
	}

	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSaleCode() {
		return saleCode;
	}

	public void setSaleCode(String saleCode) {
		this.saleCode = saleCode;
	}

	public String getSetCustCd() {
		return setCustCd;
	}

	public void setSetCustCd(String setCustCd) {
		this.setCustCd = setCustCd;
	}

	public String getSdDt() {
		return sdDt;
	}

	public void setSdDt(String sdDt) {
		this.sdDt = sdDt;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getCustGubun() {
		return custGubun;
	}

	public void setCustGubun(String custGubun) {
		this.custGubun = custGubun;
	}

	public String getSdGubun() {
		return sdGubun;
	}

	public void setSdGubun(String sdGubun) {
		this.sdGubun = sdGubun;
	}

	public String getCustTel() {
		return custTel;
	}

	public void setCustTel(String custTel) {
		this.custTel = custTel;
	}

	public String getCustAddr() {
		return custAddr;
	}

	public void setCustAddr(String custAddr) {
		this.custAddr = custAddr;
	}

	public String getSiteType() {
		return siteType;
	}

	public void setSiteType(String siteType) {
		this.siteType = siteType;
	}

	public String getSiteTypeEtc() {
		return siteTypeEtc;
	}

	public void setSiteTypeEtc(String siteTypeEtc) {
		this.siteTypeEtc = siteTypeEtc;
	}

	public String getSiteElevator() {
		return siteElevator;
	}

	public void setSiteElevator(String siteElevator) {
		this.siteElevator = siteElevator;
	}

	public String getTypeChk1() {
		return typeChk1;
	}

	public void setTypeChk1(String typeChk1) {
		this.typeChk1 = typeChk1;
	}

	public String getTypeChk2() {
		return typeChk2;
	}

	public void setTypeChk2(String typeChk2) {
		this.typeChk2 = typeChk2;
	}

	public String getTypeChk3() {
		return typeChk3;
	}

	public void setTypeChk3(String typeChk3) {
		this.typeChk3 = typeChk3;
	}

	public String getTypeChk4() {
		return typeChk4;
	}

	public void setTypeChk4(String typeChk4) {
		this.typeChk4 = typeChk4;
	}

	public String getTypeChk5() {
		return typeChk5;
	}

	public void setTypeChk5(String typeChk5) {
		this.typeChk5 = typeChk5;
	}

	public String getPreBathQty() {
		return preBathQty;
	}

	public void setPreBathQty(String preBathQty) {
		this.preBathQty = preBathQty;
	}

	public String getPreBathType1() {
		return preBathType1;
	}

	public void setPreBathType1(String preBathType1) {
		this.preBathType1 = preBathType1;
	}

	public String getPreBathType2() {
		return preBathType2;
	}

	public void setPreBathType2(String preBathType2) {
		this.preBathType2 = preBathType2;
	}

	public String getPreBathType3() {
		return preBathType3;
	}

	public void setPreBathType3(String preBathType3) {
		this.preBathType3 = preBathType3;
	}

	public String getPreBathType4() {
		return preBathType4;
	}

	public void setPreBathType4(String preBathType4) {
		this.preBathType4 = preBathType4;
	}

	public String getPreBathType5() {
		return preBathType5;
	}

	public void setPreBathType5(String preBathType5) {
		this.preBathType5 = preBathType5;
	}

	public String getPreBathType6() {
		return preBathType6;
	}

	public void setPreBathType6(String preBathType6) {
		this.preBathType6 = preBathType6;
	}

	public String getReqBathQty() {
		return reqBathQty;
	}

	public void setReqBathQty(String reqBathQty) {
		this.reqBathQty = reqBathQty;
	}

	public String getReqBathType1() {
		return reqBathType1;
	}

	public void setReqBathType1(String reqBathType1) {
		this.reqBathType1 = reqBathType1;
	}

	public String getReqBathType2() {
		return reqBathType2;
	}

	public void setReqBathType2(String reqBathType2) {
		this.reqBathType2 = reqBathType2;
	}

	public String getReqBathType3() {
		return reqBathType3;
	}

	public void setReqBathType3(String reqBathType3) {
		this.reqBathType3 = reqBathType3;
	}

	public String getReqBathType4() {
		return reqBathType4;
	}

	public void setReqBathType4(String reqBathType4) {
		this.reqBathType4 = reqBathType4;
	}

	public String getReqBathTypeEtc() {
		return reqBathTypeEtc;
	}

	public void setReqBathTypeEtc(String reqBathTypeEtc) {
		this.reqBathTypeEtc = reqBathTypeEtc;
	}

	public String getInputRoute() {
		return inputRoute;
	}

	public void setInputRoute(String inputRoute) {
		this.inputRoute = inputRoute;
	}

	public String getInterestProduct1() {
		return interestProduct1;
	}

	public void setInterestProduct1(String interestProduct1) {
		this.interestProduct1 = interestProduct1;
	}

	public String getInterestProduct2() {
		return interestProduct2;
	}

	public void setInterestProduct2(String interestProduct2) {
		this.interestProduct2 = interestProduct2;
	}

	public String getInterestProduct3() {
		return interestProduct3;
	}

	public void setInterestProduct3(String interestProduct3) {
		this.interestProduct3 = interestProduct3;
	}

	public String getInterestProduct4() {
		return interestProduct4;
	}

	public void setInterestProduct4(String interestProduct4) {
		this.interestProduct4 = interestProduct4;
	}

	public String getInterestProduct5() {
		return interestProduct5;
	}

	public void setInterestProduct5(String interestProduct5) {
		this.interestProduct5 = interestProduct5;
	}

	public String getVisitCnt() {
		return visitCnt;
	}

	public void setVisitCnt(String visitCnt) {
		this.visitCnt = visitCnt;
	}

	public String getCostType1() {
		return costType1;
	}

	public void setCostType1(String costType1) {
		this.costType1 = costType1;
	}

	public String getCostType2() {
		return costType2;
	}

	public void setCostType2(String costType2) {
		this.costType2 = costType2;
	}

	public String getBathStyle1() {
		return bathStyle1;
	}

	public void setBathStyle1(String bathStyle1) {
		this.bathStyle1 = bathStyle1;
	}

	public String getBathStyle2() {
		return bathStyle2;
	}

	public void setBathStyle2(String bathStyle2) {
		this.bathStyle2 = bathStyle2;
	}

	public String getSurveyHour() {
		return surveyHour;
	}

	public void setSurveyHour(String surveyHour) {
		this.surveyHour = surveyHour;
	}

	public String getSurveyMin() {
		return surveyMin;
	}

	public void setSurveyMin(String surveyMin) {
		this.surveyMin = surveyMin;
	}

	public String getSigongDt() {
		return sigongDt;
	}

	public void setSigongDt(String sigongDt) {
		this.sigongDt = sigongDt;
	}

	public String getReservYn() {
		return reservYn;
	}

	public void setReservYn(String reservYn) {
		this.reservYn = reservYn;
	}

	public String getSaleName() {
		return saleName;
	}

	public void setSaleName(String saleName) {
		this.saleName = saleName;
	}

	public String getConsultCont1() {
		return consultCont1;
	}

	public void setConsultCont1(String consultCont1) {
		this.consultCont1 = consultCont1;
	}

	public String getConsultCont2() {
		return consultCont2;
	}

	public void setConsultCont2(String consultCont2) {
		this.consultCont2 = consultCont2;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getTableNm() {
		return tableNm;
	}

	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

    private String GubunNm;
    private String bunNm;
    private String TypeNm;
    private String siteElevatorNm;
    private String callStatNm;
    private String surveyTime;
    private String typeChk1Nm;
    private String typeChk2Nm;
    private String typeChk3Nm;
    private String typeChk4Nm;

	public String getGubunNm() {
		return GubunNm;
	}

	public void setGubunNm(String gubunNm) {
		GubunNm = gubunNm;
	}

	public String getBunNm() {
		return bunNm;
	}

	public void setBunNm(String bunNm) {
		this.bunNm = bunNm;
	}

	public String getTypeNm() {
		return TypeNm;
	}

	public void setTypeNm(String typeNm) {
		TypeNm = typeNm;
	}

	public String getSiteElevatorNm() {
		return siteElevatorNm;
	}

	public void setSiteElevatorNm(String siteElevatorNm) {
		this.siteElevatorNm = siteElevatorNm;
	}

	public String getCallStatNm() {
		return callStatNm;
	}

	public void setCallStatNm(String callStatNm) {
		this.callStatNm = callStatNm;
	}

	public String getSurveyTime() {
		return surveyTime;
	}

	public void setSurveyTime(String surveyTime) {
		this.surveyTime = surveyTime;
	}

	public String getTypeChk1Nm() {
		return typeChk1Nm;
	}

	public void setTypeChk1Nm(String typeChk1Nm) {
		this.typeChk1Nm = typeChk1Nm;
	}

	public String getTypeChk2Nm() {
		return typeChk2Nm;
	}

	public void setTypeChk2Nm(String typeChk2Nm) {
		this.typeChk2Nm = typeChk2Nm;
	}

	public String getTypeChk3Nm() {
		return typeChk3Nm;
	}

	public void setTypeChk3Nm(String typeChk3Nm) {
		this.typeChk3Nm = typeChk3Nm;
	}

	public String getTypeChk4Nm() {
		return typeChk4Nm;
	}

	public void setTypeChk4Nm(String typeChk4Nm) {
		this.typeChk4Nm = typeChk4Nm;
	}

	public String getTypeChk5Nm() {
		return typeChk5Nm;
	}

	public void setTypeChk5Nm(String typeChk5Nm) {
		this.typeChk5Nm = typeChk5Nm;
	}

	public String getPreBathQtyNm() {
		return preBathQtyNm;
	}

	public void setPreBathQtyNm(String preBathQtyNm) {
		this.preBathQtyNm = preBathQtyNm;
	}

	public String getPreBathType1Nm() {
		return preBathType1Nm;
	}

	public void setPreBathType1Nm(String preBathType1Nm) {
		this.preBathType1Nm = preBathType1Nm;
	}

	public String getPreBathType2Nm() {
		return preBathType2Nm;
	}

	public void setPreBathType2Nm(String preBathType2Nm) {
		this.preBathType2Nm = preBathType2Nm;
	}

	public String getPreBathType3Nm() {
		return preBathType3Nm;
	}

	public void setPreBathType3Nm(String preBathType3Nm) {
		this.preBathType3Nm = preBathType3Nm;
	}

	public String getPreBathType4Nm() {
		return preBathType4Nm;
	}

	public void setPreBathType4Nm(String preBathType4Nm) {
		this.preBathType4Nm = preBathType4Nm;
	}

	public String getPreBathType5Nm() {
		return preBathType5Nm;
	}

	public void setPreBathType5Nm(String preBathType5Nm) {
		this.preBathType5Nm = preBathType5Nm;
	}

	public String getPreBathType6Nm() {
		return preBathType6Nm;
	}

	public void setPreBathType6Nm(String preBathType6Nm) {
		this.preBathType6Nm = preBathType6Nm;
	}

	public String getReqBathQtyNm() {
		return reqBathQtyNm;
	}

	public void setReqBathQtyNm(String reqBathQtyNm) {
		this.reqBathQtyNm = reqBathQtyNm;
	}

	public String getReqBathType1Nm() {
		return reqBathType1Nm;
	}

	public void setReqBathType1Nm(String reqBathType1Nm) {
		this.reqBathType1Nm = reqBathType1Nm;
	}

	public String getReqBathType2Nm() {
		return reqBathType2Nm;
	}

	public void setReqBathType2Nm(String reqBathType2Nm) {
		this.reqBathType2Nm = reqBathType2Nm;
	}

	public String getReqBathType3Nm() {
		return reqBathType3Nm;
	}

	public void setReqBathType3Nm(String reqBathType3Nm) {
		this.reqBathType3Nm = reqBathType3Nm;
	}

	public String getReqBathType4Nm() {
		return reqBathType4Nm;
	}

	public void setReqBathType4Nm(String reqBathType4Nm) {
		this.reqBathType4Nm = reqBathType4Nm;
	}

	public String getInputRouteNm() {
		return inputRouteNm;
	}

	public void setInputRouteNm(String inputRouteNm) {
		this.inputRouteNm = inputRouteNm;
	}

	public String getRestProduct1Nm() {
		return restProduct1Nm;
	}

	public void setRestProduct1Nm(String restProduct1Nm) {
		this.restProduct1Nm = restProduct1Nm;
	}

	public String getInterestProduct2Nm() {
		return interestProduct2Nm;
	}

	public void setInterestProduct2Nm(String interestProduct2Nm) {
		this.interestProduct2Nm = interestProduct2Nm;
	}

	public String getInterestProduct3Nm() {
		return interestProduct3Nm;
	}

	public void setInterestProduct3Nm(String interestProduct3Nm) {
		this.interestProduct3Nm = interestProduct3Nm;
	}

	public String getInterestProduct4Nm() {
		return interestProduct4Nm;
	}

	public void setInterestProduct4Nm(String interestProduct4Nm) {
		this.interestProduct4Nm = interestProduct4Nm;
	}

	public String getInterestProduct5Nm() {
		return interestProduct5Nm;
	}

	public void setInterestProduct5Nm(String interestProduct5Nm) {
		this.interestProduct5Nm = interestProduct5Nm;
	}

	public String getVisitCntNm() {
		return visitCntNm;
	}

	public void setVisitCntNm(String visitCntNm) {
		this.visitCntNm = visitCntNm;
	}

	public String getCostType1Nm() {
		return costType1Nm;
	}

	public void setCostType1Nm(String costType1Nm) {
		this.costType1Nm = costType1Nm;
	}

	public String getCostType2Nm() {
		return costType2Nm;
	}

	public void setCostType2Nm(String costType2Nm) {
		this.costType2Nm = costType2Nm;
	}

	public String getBathStyle1Nm() {
		return bathStyle1Nm;
	}

	public void setBathStyle1Nm(String bathStyle1Nm) {
		this.bathStyle1Nm = bathStyle1Nm;
	}

	public String getBathStyle2Nm() {
		return bathStyle2Nm;
	}

	public void setBathStyle2Nm(String bathStyle2Nm) {
		this.bathStyle2Nm = bathStyle2Nm;
	}

	private String typeChk5Nm;
    private String preBathQtyNm;
    private String preBathType1Nm;	
    private String preBathType2Nm;	
    private String preBathType3Nm;	
    private String preBathType4Nm;	
    private String preBathType5Nm;	
    private String preBathType6Nm;	
    private String reqBathQtyNm;
    private String reqBathType1Nm;	
    private String reqBathType2Nm;	
    private String reqBathType3Nm;	
    private String reqBathType4Nm;	

	private String inputRouteNm;
    private String restProduct1Nm;
    private String interestProduct2Nm;
    private String interestProduct3Nm;
    private String interestProduct4Nm;
    private String interestProduct5Nm;

	private String visitCntNm;

	private String costType1Nm;
    private String costType2Nm;
    private String bathStyle1Nm;
    private String bathStyle2Nm;

	private String workYn;

	public String getWorkYn() {
		return workYn;
	}

	public void setWorkYn(String workYn) {
		this.workYn = workYn;
	}

	private String nempNo;

	public String getNempNo() {
		return nempNo;
	}

	public void setNempNo(String nempNo) {
		this.nempNo = nempNo;
	}

	public String getCustSalNm() {
		return custSalNm;
	}

	public void setCustSalNm(String custSalNm) {
		this.custSalNm = custSalNm;
	}

	private String custSalNm;

	private String baseCd;

	private String subCd;

	private String useYn;

	private String typechk3;

	private String siteTypeNm;

	private String custGubunNm;

	private String sdGubunNm;

	private String typeChk;

	private String preBathType;

	private String reqBathQty_nm;

	private String reqBathType;

	private String interestProduct;

	public String getBaseCd() {
		return baseCd;
	}

	public void setBaseCd(String baseCd) {
		this.baseCd = baseCd;
	}

	public String getSubCd() {
		return subCd;
	}

	public void setSubCd(String subCd) {
		this.subCd = subCd;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getTypechk3() {
		return typechk3;
	}

	public void setTypechk3(String typechk3) {
		this.typechk3 = typechk3;
	}

	public String getSiteTypeNm() {
		return siteTypeNm;
	}

	public void setSiteTypeNm(String siteTypeNm) {
		this.siteTypeNm = siteTypeNm;
	}

	public String getCustGubunNm() {
		return custGubunNm;
	}

	public void setCustGubunNm(String custGubunNm) {
		this.custGubunNm = custGubunNm;
	}

	public String getSdGubunNm() {
		return sdGubunNm;
	}

	public void setSdGubunNm(String sdGubunNm) {
		this.sdGubunNm = sdGubunNm;
	}

	public String getTypeChk() {
		return typeChk;
	}

	public void setTypeChk(String typeChk) {
		this.typeChk = typeChk;
	}

	public String getPreBathType() {
		return preBathType;
	}

	public void setPreBathType(String preBathType) {
		this.preBathType = preBathType;
	}

	public String getReqBathQty_nm() {
		return reqBathQty_nm;
	}

	public void setReqBathQty_nm(String reqBathQty_nm) {
		this.reqBathQty_nm = reqBathQty_nm;
	}

	public String getReqBathType() {
		return reqBathType;
	}

	public void setReqBathType(String reqBathType) {
		this.reqBathType = reqBathType;
	}

	public String getInterestProduct() {
		return interestProduct;
	}

	public void setInterestProduct(String interestProduct) {
		this.interestProduct = interestProduct;
	}

	public String getReservYnNm() {
		return reservYnNm;
	}

	public void setReservYnNm(String reservYnNm) {
		this.reservYnNm = reservYnNm;
	}

	private String reservYnNm;

	private String deptCd;

	private String deptNm;

	private String seq;

	private String taxBcNm;

	private String natNm;

	private String deBcNm;

	private String bizNo;

	private String ceoNm;

	private String curyNm;

	private String salCustNm;

	private String rptNm;

	private String grId;

	private String menucd;

	public String getMenucd() {
		return menucd;
	}

	public void setMenucd(String menucd) {
		this.menucd = menucd;
	}

	public String getGrId() {
		return grId;
	}

	public void setGrId(String grId) {
		this.grId = grId;
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

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getTaxBcNm() {
		return taxBcNm;
	}

	public void setTaxBcNm(String taxBcNm) {
		this.taxBcNm = taxBcNm;
	}

	public String getNatNm() {
		return natNm;
	}

	public void setNatNm(String natNm) {
		this.natNm = natNm;
	}

	public String getDeBcNm() {
		return deBcNm;
	}

	public void setDeBcNm(String deBcNm) {
		this.deBcNm = deBcNm;
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

	public String getCuryNm() {
		return curyNm;
	}

	public void setCuryNm(String curyNm) {
		this.curyNm = curyNm;
	}

	public String getSalCustNm() {
		return salCustNm;
	}

	public void setSalCustNm(String salCustNm) {
		this.salCustNm = salCustNm;
	}

	public String getRptNm() {
		return rptNm;
	}

	public void setRptNm(String rptNm) {
		this.rptNm = rptNm;
	}

	public String getCreditNm() {
		return creditNm;
	}

	public void setCreditNm(String creditNm) {
		this.creditNm = creditNm;
	}

	private String creditNm;

	private String title;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	/* 세트 - START */
	private String constructType;

	private String constructTypeNm;

	private String typeChkNm;

	private String preBathTypeEtc;

	private String custStat;

	private String custStatNm;

	private String requestDt;

	private String requestTimeDiv;

	private String requestTimeDivNm;

	private String requestHour;

	private String requestMin;

	private String requestTime;

	private String lifeType;

	private String lifeTypeNm;

	private String lifeTypeEtc;

	private String infoAgreYn;

	private String infoAgreYnNm;

	private String consultCont;

	/* 세트 - END */
	/* 단품 - START */

	private String consultProduct1;

	private String consultProduct1Nm;

	private String consultProduct2;

	private String consultProduct2Nm;

	private String consultProduct3;

	private String consultProduct3Nm;

	private String consultProduct4;

	private String consultProduct4Nm;

	private String consultProductEtc;

	private String consultProductNm;

	public String getConsultProductNm() {
		return consultProductNm;
	}

	public void setConsultProductNm(String consultProductNm) {
		this.consultProductNm = consultProductNm;
	}

	private String deliveryDt;

	private String sigongYn;

	private String sigongYnNm;

	private String sigongPayYn;

	private String sigongPayYnNm;

	private String gubun;

	/* 단품 - END */

	public String getConstructType() {
		return constructType;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public void setConstructType(String constructType) {
		this.constructType = constructType;
	}

	public String getConstructTypeNm() {
		return constructTypeNm;
	}

	public void setConstructTypeNm(String constructTypeNm) {
		this.constructTypeNm = constructTypeNm;
	}

	public String getTypeChkNm() {
		return typeChkNm;
	}

	public void setTypeChkNm(String typeChkNm) {
		this.typeChkNm = typeChkNm;
	}

	public String getPreBathTypeEtc() {
		return preBathTypeEtc;
	}

	public void setPreBathTypeEtc(String preBathTypeEtc) {
		this.preBathTypeEtc = preBathTypeEtc;
	}

	public String getCustStat() {
		return custStat;
	}

	public void setCustStat(String custStat) {
		this.custStat = custStat;
	}

	public String getCustStatNm() {
		return custStatNm;
	}

	public void setCustStatNm(String custStatNm) {
		this.custStatNm = custStatNm;
	}

	public String getRequestDt() {
		return requestDt;
	}

	public void setRequestDt(String requestDt) {
		this.requestDt = requestDt;
	}

	public String getRequestTimeDiv() {
		return requestTimeDiv;
	}

	public void setRequestTimeDiv(String requestTimeDiv) {
		this.requestTimeDiv = requestTimeDiv;
	}

	public String getRequestTimeDivNm() {
		return requestTimeDivNm;
	}

	public void setRequestTimeDivNm(String requestTimeDivNm) {
		this.requestTimeDivNm = requestTimeDivNm;
	}

	public String getRequestHour() {
		return requestHour;
	}

	public void setRequestHour(String requestHour) {
		this.requestHour = requestHour;
	}

	public String getRequestMin() {
		return requestMin;
	}

	public void setRequestMin(String requestMin) {
		this.requestMin = requestMin;
	}

	public String getRequestTime() {
		return requestTime;
	}

	public void setRequestTime(String requestTime) {
		this.requestTime = requestTime;
	}

	public String getLifeType() {
		return lifeType;
	}

	public void setLifeType(String lifeType) {
		this.lifeType = lifeType;
	}

	public String getLifeTypeNm() {
		return lifeTypeNm;
	}

	public void setLifeTypeNm(String lifeTypeNm) {
		this.lifeTypeNm = lifeTypeNm;
	}

	public String getLifeTypeEtc() {
		return lifeTypeEtc;
	}

	public void setLifeTypeEtc(String lifeTypeEtc) {
		this.lifeTypeEtc = lifeTypeEtc;
	}

	public String getInfoAgreYn() {
		return infoAgreYn;
	}

	public void setInfoAgreYn(String infoAgreYn) {
		this.infoAgreYn = infoAgreYn;
	}

	public String getInfoAgreYnNm() {
		return infoAgreYnNm;
	}

	public void setInfoAgreYnNm(String infoAgreYnNm) {
		this.infoAgreYnNm = infoAgreYnNm;
	}

	public String getConsultCont() {
		return consultCont;
	}

	public void setConsultCont(String consultCont) {
		this.consultCont = consultCont;
	}

	public String getConsultProduct1() {
		return consultProduct1;
	}

	public void setConsultProduct1(String consultProduct1) {
		this.consultProduct1 = consultProduct1;
	}

	public String getConsultProduct1Nm() {
		return consultProduct1Nm;
	}

	public void setConsultProduct1Nm(String consultProduct1Nm) {
		this.consultProduct1Nm = consultProduct1Nm;
	}

	public String getConsultProduct2() {
		return consultProduct2;
	}

	public void setConsultProduct2(String consultProduct2) {
		this.consultProduct2 = consultProduct2;
	}

	public String getConsultProduct2Nm() {
		return consultProduct2Nm;
	}

	public void setConsultProduct2Nm(String consultProduct2Nm) {
		this.consultProduct2Nm = consultProduct2Nm;
	}

	public String getConsultProduct3() {
		return consultProduct3;
	}

	public void setConsultProduct3(String consultProduct3) {
		this.consultProduct3 = consultProduct3;
	}

	public String getConsultProduct3Nm() {
		return consultProduct3Nm;
	}

	public void setConsultProduct3Nm(String consultProduct3Nm) {
		this.consultProduct3Nm = consultProduct3Nm;
	}

	public String getConsultProduct4() {
		return consultProduct4;
	}

	public void setConsultProduct4(String consultProduct4) {
		this.consultProduct4 = consultProduct4;
	}

	public String getConsultProduct4Nm() {
		return consultProduct4Nm;
	}

	public void setConsultProduct4Nm(String consultProduct4Nm) {
		this.consultProduct4Nm = consultProduct4Nm;
	}

	public String getConsultProductEtc() {
		return consultProductEtc;
	}

	public void setConsultProductEtc(String consultProductEtc) {
		this.consultProductEtc = consultProductEtc;
	}

	public String getDeliveryDt() {
		return deliveryDt;
	}

	public void setDeliveryDt(String deliveryDt) {
		this.deliveryDt = deliveryDt;
	}

	public String getSigongYn() {
		return sigongYn;
	}

	public void setSigongYn(String sigongYn) {
		this.sigongYn = sigongYn;
	}

	public String getSigongYnNm() {
		return sigongYnNm;
	}

	public void setSigongYnNm(String sigongYnNm) {
		this.sigongYnNm = sigongYnNm;
	}

	public String getSigongPayYn() {
		return sigongPayYn;
	}

	public void setSigongPayYn(String sigongPayYn) {
		this.sigongPayYn = sigongPayYn;
	}

	public String getSigongPayYnNm() {
		return sigongPayYnNm;
	}

	public void setSigongPayYnNm(String sigongPayYnNm) {
		this.sigongPayYnNm = sigongPayYnNm;
	}

}
