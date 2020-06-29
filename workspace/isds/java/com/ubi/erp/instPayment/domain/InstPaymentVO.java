package com.ubi.erp.instPayment.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("InstPaymentVO")
public class InstPaymentVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String no;

	private String cudKey;

	private String chk;

	private String id;

	private String hadocontNo; // 하도계약번호

	private String siteCd; // 현장코드

	private int sqSn; // 실행차수

	private String workYm; // 기성년월

	private String actureYn; // 현행구분

	private String costId; // 공종코드ID

	private String itemDs; // 품목설명

	private String sizeSz; // 규격

	private String unitDs; // 단위

	private double dokubQn; // 도급수량

	private double dokubUp; // 도급단가

	private double dokubAm; // 도급금약

	private double silhengQn; // 실행수량

	private double silhengUp; // 실행단가

	private double silhengAm; // 실행금액

	private double hadoQn; // 하도수량

	private double hadoUp; // 하도단가

	private double hadoAm; // 하도금액

	private String econtYn; // 전자계약여부

	private double dokubgsQn; // 도급기성수량

	private double dokubgsAm; // 도급기성금액

	private double silhenggsQn; // 실행기성수량

	private double silhenggsAm; // 실행기성금액

	private double hadogsQn; // 하도기성수량

	private double hadogsAm; // 하도기성금액

	private String reqCon; // 확정여부

	private int reqConId; // 확정자

	private String costCd; // 공종 코드

	private double silhengbsQn; // 실행수량(기본형)

	private double silhengbsUp; // 실행단가(기본형)

	private double silhengbsAm; // 실행금액(기본형)

	private double silhengbsmmUp; // 실행단가(기본형:재료비)

	private double silhengbsmmAm; // 실행금액(기본형:재료비)

	private double silhengbslaUp; // 실행단가(기본형:노무비)

	private double silhengbslaAm; // 실행금액(기본형:노무비)

	private double silhengbssmUp; // 실행단가(기본형:외주비)

	private double silhengbssmAm; // 실행금액(기본형:외주비)

	private double silhengbseqUp; // 실행단가(기본형:장비비)

	private double silhengbseqAm; // 실행금액(기본형:장비비)

	private double silhengbsfaUp; // 실행단가(기본형:경비)

	private double silhengbsfaAm; // 실행금액(기본형:경비)

	private double silhengmmUp; // 실행단가(재료비)

	private double silhengmmAm; // 실행금액(재료비)

	private double silhenglaUp; // 실행단가(노무비)

	private double silhenglaAm; // 실행금액(노무비)

	private double silhengsmUp; // 실행금액(외주비)

	private double silhengsmAm; // 실행단가(외주비)

	private double silhengeqUp; // 실행단가(장비비)

	private double silhengeqAm; // 실행금액(장비비)

	private double silhengfaUp; // 실행단가(경비)

	private double silhengfaAm; // 실행금액(경비)

	private String rmksDs; // 비고

	private String exeexpBs; // 집행비목코드

	private String itemCd; // 자재품목코드

	private String extendYn; // 확장공종유무

	private String constructYn; // 공사비 유무

	private String directYn; // 직접공사비유므

	private int grpcostId; // 그룹공종ID

	private String ordDs; // 정렬순서

	private String approveId; // 승인자

	private String approveChk; // 승인여부

	private String approveDt; // 승인일자

	private String stateChk; // 등록 상태

	private double hadogspQn; // 전월 누게 기성 하도 단가

	private double hadogspAm; // 전월누계 기성 하도 금액

	private double hadogstQn; // 누게 기성 하도 단가

	private double hadogstAm; // 누계 기성 하도 금액

	private String hadocontDs; // 하도계약명

	private String hdFd; // 구분 이름

	private String filePath; // 파일경로

	private String fileNm; // 파일이름

	private String realFileName; // 실제 파일 이름

	private int fileSize; // 파일크기

	private String rmks; // 첨부파일 비고

	private String fileId; // 파일 아이디

	private String uploadFile; // 임시 업로드 파일 tag name

	private String fileDown;// img 보여줄 컬럼

	private String flag; // 구분값

	private String upcostId;

	private String costYn;

	private String costGr;

	private double hadogsmQn;

	private double hadogsmAm;

	private double hadoSum;

	private double hadogspSum;

	private double hadogsSum;

	private double hadogstSum;

	private double hadogsmSum;

	private String custCd;

	private int cnt;

	private double scmHadogsQn; // 외주입력하도기성수량

	private String conKind; // 확정구분

	private String conRmk; // 반려비고

	private String conKindNm; // 확정구분 이름

	private String controlSdt;

	private String controlEdt;

	private String nowDate;

	private double janQn;

	private double janAm;

	public double getJanQn() {
		return janQn;
	}

	public void setJanQn(double janQn) {
		this.janQn = janQn;
	}

	public double getJanAm() {
		return janAm;
	}

	public void setJanAm(double janAm) {
		this.janAm = janAm;
	}

	public String getNowDate() {
		return nowDate;
	}

	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}

	public String getControlSdt() {
		return controlSdt;
	}

	public void setControlSdt(String controlSdt) {
		this.controlSdt = controlSdt;
	}

	public String getControlEdt() {
		return controlEdt;
	}

	public void setControlEdt(String controlEdt) {
		this.controlEdt = controlEdt;
	}

	public String getConKindNm() {
		return conKindNm;
	}

	public void setConKindNm(String conKindNm) {
		this.conKindNm = conKindNm;
	}

	public double getScmHadogsQn() {
		return scmHadogsQn;
	}

	public void setScmHadogsQn(double scmHadogsQn) {
		this.scmHadogsQn = scmHadogsQn;
	}

	public String getConKind() {
		return conKind;
	}

	public void setConKind(String conKind) {
		this.conKind = conKind;
	}

	public String getConRmk() {
		return conRmk;
	}

	public void setConRmk(String conRmk) {
		this.conRmk = conRmk;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getCustCd() {
		return custCd;
	}

	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	public double getHadoSum() {
		return hadoSum;
	}

	public void setHadoSum(double hadoSum) {
		this.hadoSum = hadoSum;
	}

	public double getHadogspSum() {
		return hadogspSum;
	}

	public void setHadogspSum(double hadogspSum) {
		this.hadogspSum = hadogspSum;
	}

	public double getHadogsSum() {
		return hadogsSum;
	}

	public void setHadogsSum(double hadogsSum) {
		this.hadogsSum = hadogsSum;
	}

	public double getHadogstSum() {
		return hadogstSum;
	}

	public void setHadogstSum(double hadogstSum) {
		this.hadogstSum = hadogstSum;
	}

	public double getHadogsmSum() {
		return hadogsmSum;
	}

	public void setHadogsmSum(double hadogsmSum) {
		this.hadogsmSum = hadogsmSum;
	}

	public String getUpcostId() {
		return upcostId;
	}

	public void setUpcostId(String upcostId) {
		this.upcostId = upcostId;
	}

	public String getCostYn() {
		return costYn;
	}

	public void setCostYn(String costYn) {
		this.costYn = costYn;
	}

	public String getCostGr() {
		return costGr;
	}

	public void setCostGr(String costGr) {
		this.costGr = costGr;
	}

	public double getHadogsmQn() {
		return hadogsmQn;
	}

	public void setHadogsmQn(double hadogsmQn) {
		this.hadogsmQn = hadogsmQn;
	}

	public double getHadogsmAm() {
		return hadogsmAm;
	}

	public void setHadogsmAm(double hadogsmAm) {
		this.hadogsmAm = hadogsmAm;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getFileDown() {
		return fileDown;
	}

	public void setFileDown(String fileDown) {
		this.fileDown = fileDown;
	}

	public String getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getRealFileName() {
		return realFileName;
	}

	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public String getRmks() {
		return rmks;
	}

	public void setRmks(String rmks) {
		this.rmks = rmks;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getHdFd() {
		return hdFd;
	}

	public void setHdFd(String hdFd) {
		this.hdFd = hdFd;
	}

	public String getHadocontDs() {
		return hadocontDs;
	}

	public void setHadocontDs(String hadocontDs) {
		this.hadocontDs = hadocontDs;
	}

	public double getHadogspQn() {
		return hadogspQn;
	}

	public void setHadogspQn(double hadogspQn) {
		this.hadogspQn = hadogspQn;
	}

	public double getHadogspAm() {
		return hadogspAm;
	}

	public void setHadogspAm(double hadogspAm) {
		this.hadogspAm = hadogspAm;
	}

	public double getHadogstQn() {
		return hadogstQn;
	}

	public void setHadogstQn(double hadogstQn) {
		this.hadogstQn = hadogstQn;
	}

	public double getHadogstAm() {
		return hadogstAm;
	}

	public void setHadogstAm(double hadogstAm) {
		this.hadogstAm = hadogstAm;
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

	public String getChk() {
		return chk;
	}

	public void setChk(String chk) {
		this.chk = chk;
	}

	public String getHadocontNo() {
		return hadocontNo;
	}

	public void setHadocontNo(String hadocontNo) {
		this.hadocontNo = hadocontNo;
	}

	public String getSiteCd() {
		return siteCd;
	}

	public void setSiteCd(String siteCd) {
		this.siteCd = siteCd;
	}

	public int getSqSn() {
		return sqSn;
	}

	public void setSqSn(int sqSn) {
		this.sqSn = sqSn;
	}

	public String getWorkYm() {
		return workYm;
	}

	public void setWorkYm(String workYm) {
		this.workYm = workYm;
	}

	public String getActureYn() {
		return actureYn;
	}

	public void setActureYn(String actureYn) {
		this.actureYn = actureYn;
	}

	/**
	 * @return the costId
	 */
	public String getCostId() {
		return costId;
	}

	/**
	 * @param costId the costId to set
	 */
	public void setCostId(String costId) {
		this.costId = costId;
	}

	public String getItemDs() {
		return itemDs;
	}

	public void setItemDs(String itemDs) {
		this.itemDs = itemDs;
	}

	public String getSizeSz() {
		return sizeSz;
	}

	public void setSizeSz(String sizeSz) {
		this.sizeSz = sizeSz;
	}

	public String getUnitDs() {
		return unitDs;
	}

	public void setUnitDs(String unitDs) {
		this.unitDs = unitDs;
	}

	public double getDokubQn() {
		return dokubQn;
	}

	public void setDokubQn(double dokubQn) {
		this.dokubQn = dokubQn;
	}

	public double getDokubUp() {
		return dokubUp;
	}

	public void setDokubUp(double dokubUp) {
		this.dokubUp = dokubUp;
	}

	public double getDokubAm() {
		return dokubAm;
	}

	public void setDokubAm(double dokubAm) {
		this.dokubAm = dokubAm;
	}

	public double getSilhengQn() {
		return silhengQn;
	}

	public void setSilhengQn(double silhengQn) {
		this.silhengQn = silhengQn;
	}

	public double getSilhengUp() {
		return silhengUp;
	}

	public void setSilhengUp(double silhengUp) {
		this.silhengUp = silhengUp;
	}

	public double getSilhengAm() {
		return silhengAm;
	}

	public void setSilhengAm(double silhengAm) {
		this.silhengAm = silhengAm;
	}

	public double getHadoQn() {
		return hadoQn;
	}

	public void setHadoQn(double hadoQn) {
		this.hadoQn = hadoQn;
	}

	public double getHadoUp() {
		return hadoUp;
	}

	public void setHadoUp(double hadoUp) {
		this.hadoUp = hadoUp;
	}

	public double getHadoAm() {
		return hadoAm;
	}

	public void setHadoAm(double hadoAm) {
		this.hadoAm = hadoAm;
	}

	public String getEcontYn() {
		return econtYn;
	}

	public void setEcontYn(String econtYn) {
		this.econtYn = econtYn;
	}

	public double getDokubgsQn() {
		return dokubgsQn;
	}

	public void setDokubgsQn(double dokubgsQn) {
		this.dokubgsQn = dokubgsQn;
	}

	public double getDokubgsAm() {
		return dokubgsAm;
	}

	public void setDokubgsAm(double dokubgsAm) {
		this.dokubgsAm = dokubgsAm;
	}

	public double getSilhenggsQn() {
		return silhenggsQn;
	}

	public void setSilhenggsQn(double silhenggsQn) {
		this.silhenggsQn = silhenggsQn;
	}

	public double getSilhenggsAm() {
		return silhenggsAm;
	}

	public void setSilhenggsAm(double silhenggsAm) {
		this.silhenggsAm = silhenggsAm;
	}

	public double getHadogsQn() {
		return hadogsQn;
	}

	public void setHadogsQn(double hadogsQn) {
		this.hadogsQn = hadogsQn;
	}

	public double getHadogsAm() {
		return hadogsAm;
	}

	public void setHadogsAm(double hadogsAm) {
		this.hadogsAm = hadogsAm;
	}

	public String getReqCon() {
		return reqCon;
	}

	public void setReqCon(String reqCon) {
		this.reqCon = reqCon;
	}

	public int getReqConId() {
		return reqConId;
	}

	public void setReqConId(int reqConId) {
		this.reqConId = reqConId;
	}

	public String getCostCd() {
		return costCd;
	}

	public void setCostCd(String costCd) {
		this.costCd = costCd;
	}

	public double getSilhengbsQn() {
		return silhengbsQn;
	}

	public void setSilhengbsQn(double silhengbsQn) {
		this.silhengbsQn = silhengbsQn;
	}

	public double getSilhengbsUp() {
		return silhengbsUp;
	}

	public void setSilhengbsUp(double silhengbsUp) {
		this.silhengbsUp = silhengbsUp;
	}

	public double getSilhengbsAm() {
		return silhengbsAm;
	}

	public void setSilhengbsAm(double silhengbsAm) {
		this.silhengbsAm = silhengbsAm;
	}

	public double getSilhengbsmmUp() {
		return silhengbsmmUp;
	}

	public void setSilhengbsmmUp(double silhengbsmmUp) {
		this.silhengbsmmUp = silhengbsmmUp;
	}

	public double getSilhengbsmmAm() {
		return silhengbsmmAm;
	}

	public void setSilhengbsmmAm(double silhengbsmmAm) {
		this.silhengbsmmAm = silhengbsmmAm;
	}

	public double getSilhengbslaUp() {
		return silhengbslaUp;
	}

	public void setSilhengbslaUp(double silhengbslaUp) {
		this.silhengbslaUp = silhengbslaUp;
	}

	public double getSilhengbslaAm() {
		return silhengbslaAm;
	}

	public void setSilhengbslaAm(double silhengbslaAm) {
		this.silhengbslaAm = silhengbslaAm;
	}

	public double getSilhengbssmUp() {
		return silhengbssmUp;
	}

	public void setSilhengbssmUp(double silhengbssmUp) {
		this.silhengbssmUp = silhengbssmUp;
	}

	public double getSilhengbssmAm() {
		return silhengbssmAm;
	}

	public void setSilhengbssmAm(double silhengbssmAm) {
		this.silhengbssmAm = silhengbssmAm;
	}

	public double getSilhengbseqUp() {
		return silhengbseqUp;
	}

	public void setSilhengbseqUp(double silhengbseqUp) {
		this.silhengbseqUp = silhengbseqUp;
	}

	public double getSilhengbseqAm() {
		return silhengbseqAm;
	}

	public void setSilhengbseqAm(double silhengbseqAm) {
		this.silhengbseqAm = silhengbseqAm;
	}

	public double getSilhengbsfaUp() {
		return silhengbsfaUp;
	}

	public void setSilhengbsfaUp(double silhengbsfaUp) {
		this.silhengbsfaUp = silhengbsfaUp;
	}

	public double getSilhengbsfaAm() {
		return silhengbsfaAm;
	}

	public void setSilhengbsfaAm(double silhengbsfaAm) {
		this.silhengbsfaAm = silhengbsfaAm;
	}

	public double getSilhengmmUp() {
		return silhengmmUp;
	}

	public void setSilhengmmUp(double silhengmmUp) {
		this.silhengmmUp = silhengmmUp;
	}

	public double getSilhengmmAm() {
		return silhengmmAm;
	}

	public void setSilhengmmAm(double silhengmmAm) {
		this.silhengmmAm = silhengmmAm;
	}

	public double getSilhenglaUp() {
		return silhenglaUp;
	}

	public void setSilhenglaUp(double silhenglaUp) {
		this.silhenglaUp = silhenglaUp;
	}

	public double getSilhenglaAm() {
		return silhenglaAm;
	}

	public void setSilhenglaAm(double silhenglaAm) {
		this.silhenglaAm = silhenglaAm;
	}

	public double getSilhengsmUp() {
		return silhengsmUp;
	}

	public void setSilhengsmUp(double silhengsmUp) {
		this.silhengsmUp = silhengsmUp;
	}

	public double getSilhengsmAm() {
		return silhengsmAm;
	}

	public void setSilhengsmAm(double silhengsmAm) {
		this.silhengsmAm = silhengsmAm;
	}

	public double getSilhengeqUp() {
		return silhengeqUp;
	}

	public void setSilhengeqUp(double silhengeqUp) {
		this.silhengeqUp = silhengeqUp;
	}

	public double getSilhengeqAm() {
		return silhengeqAm;
	}

	public void setSilhengeqAm(double silhengeqAm) {
		this.silhengeqAm = silhengeqAm;
	}

	public double getSilhengfaUp() {
		return silhengfaUp;
	}

	public void setSilhengfaUp(double silhengfaUp) {
		this.silhengfaUp = silhengfaUp;
	}

	public double getSilhengfaAm() {
		return silhengfaAm;
	}

	public void setSilhengfaAm(double silhengfaAm) {
		this.silhengfaAm = silhengfaAm;
	}

	public String getRmksDs() {
		return rmksDs;
	}

	public void setRmksDs(String rmksDs) {
		this.rmksDs = rmksDs;
	}

	public String getExeexpBs() {
		return exeexpBs;
	}

	public void setExeexpBs(String exeexpBs) {
		this.exeexpBs = exeexpBs;
	}

	public String getItemCd() {
		return itemCd;
	}

	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}

	public String getExtendYn() {
		return extendYn;
	}

	public void setExtendYn(String extendYn) {
		this.extendYn = extendYn;
	}

	public String getConstructYn() {
		return constructYn;
	}

	public void setConstructYn(String constructYn) {
		this.constructYn = constructYn;
	}

	public String getDirectYn() {
		return directYn;
	}

	public void setDirectYn(String directYn) {
		this.directYn = directYn;
	}

	public int getGrpcostId() {
		return grpcostId;
	}

	public void setGrpcostId(int grpcostId) {
		this.grpcostId = grpcostId;
	}

	public String getOrdDs() {
		return ordDs;
	}

	public void setOrdDs(String ordDs) {
		this.ordDs = ordDs;
	}

	public String getApproveId() {
		return approveId;
	}

	public void setApproveId(String approveId) {
		this.approveId = approveId;
	}

	public String getApproveChk() {
		return approveChk;
	}

	public void setApproveChk(String approveChk) {
		this.approveChk = approveChk;
	}

	public String getApproveDt() {
		return approveDt;
	}

	public void setApproveDt(String approveDt) {
		this.approveDt = approveDt;
	}

	public String getStateChk() {
		return stateChk;
	}

	public void setStateChk(String stateChk) {
		this.stateChk = stateChk;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
