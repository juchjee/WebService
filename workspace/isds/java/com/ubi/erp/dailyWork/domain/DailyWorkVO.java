package com.ubi.erp.dailyWork.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("DailyWorkVO")
public class DailyWorkVO extends ReportVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private int chk;// 체크값

	private String no; // 순번

	private String cudKey; // crudKey

	private String custDs;

	private String value;

	private String siteCd; // 현장코드

	private String custCd; // 거래처코드

	private String workDt; // 작업일자

	private String weatherBc; // 날씨코드

	private double weatherMn; // 최저기온

	private double weatherMx; // 최고기온

	private String weatherDs; // 날씨메모

	private String conSec; // 공사구간

	private String commgrpmCd; // 공종대분류

	private String commgrpsCd; // 공종코드

	private String commgrpdCd;// 세부공종

	private int perNum; // 작업인원

	private String workCon; // 작업내용

	private String workSeq; // 장비 순번

	private String itemCd; // 장비코드

	private String itemNm; // 장비명

	private String itemSpec; // 장비단위

	private String itemUnit; // 장비단위

	private double qty; // 수량

	private String perNo; // 근무자번호

	private String perNm; // 근무자 성명

	private String regiNo; // 주민번호

	private String foreNo; // 외국인 등록번호

	private String retireDiv; // 퇴직공제구분

	private String bank; // 급여이체은행

	private String account; // 급여이체계좌

	private String enterDt; // 입사일자

	private String retireDt; // 퇴사일자

	private String inTime; // 출근시간

	private String outTime; // 퇴근시간

	private String workKn; // 근태구분

	private double normal; // 정상

	private double extend; // 연장

	private double night; // 야근

	private double special; // 특근

	private double outside; // 외출

	private double early; // 조퇴

	private double late; // 지각

	private double total; // 총근무

	private String outCid; // 외주생성자

	private String outMid; // 외주 수정자

	private String id; // 로그인 아이디

	private String siteDs; // 현장명

	private String constructDs; // 현장명

	private int cnt; // 데이터 조회 수

	private String sdate; // 시작 날짜

	private String edate; // 종료 날짜

	private String workConScm; // 장비등록 작업내용

	private String title; // 공종코드 대분류 이름

	private String rmks; // 공종코드 대분류 비고

	private String commgrpsDs; // 공종코드 이름

	private String itemUnitNm; // 품명 단위 이름

	private String regBirth;

	private String password;

	private String fileSaveNm;

	private String fileNm;

	private String signImage;

	private String uploadFile;

	private String hpNo;

	private String kind;

	private String settKind;

	private String rmk;

	private String year;

	private String seq;

	private double accpMd;

	private String workCond;

	private String regEmp;

	private String regEmpName;

	private String regSett;

	private String regDt;

	private String reviewEmp;

	private String reviewEmpName;

	private String reviewSett;

	private String reviewDt;

	private String review2Emp;

	private String review2EmpName;

	private String review2Sett;

	private String review2Dt;

	private String confirmEmp;

	private String confirmEmpName;

	private String confirmSett;

	private String confirmDt;

	private String nextYn;

	private String itemName;

	private double inQty;

	private double buildQty;

	private double outQty;

	private String appvNextYn;

	private String kbigDs;

	private String kmidDs;

	private String ksmallDs;

	private String kitemDs;

	private String itemSz;

	private String itemUt;

	private double legQty;

	private double totQty;

	private int legPerNum;

	private int totPerNum;

	private double legInQty;

	private double totBuildQty;

	private double totOutQty;

	private String equipBc;

	private String pw;

	private String stndDt;

	private String perKind;

	private String perKindNm;

	private int tempMin; // 최저기온

	private int tempMax; // 최고기온

	private String workDesc; // 금익작업사항

	private String workNm; // 공사명

	private double preQty; // 전일누계

	private String printYn;// 발행여부

	private double amt;

	private String descCd;

	private String descNm;

	private String useYn;

	private String perKind2;

	private String workYn;

	public DailyWorkVO() {
		super();
	}

	public String getPerKind2() {
		return perKind2;
	}

	public void setPerKind2(String perKind2) {
		this.perKind2 = perKind2;
	}

	public String getWorkYn() {
		return workYn;
	}

	public void setWorkYn(String workYn) {
		this.workYn = workYn;
	}

	public String getDescCd() {
		return descCd;
	}

	public void setDescCd(String descCd) {
		this.descCd = descCd;
	}

	public String getDescNm() {
		return descNm;
	}

	public void setDescNm(String descNm) {
		this.descNm = descNm;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getPerKindNm() {
		return perKindNm;
	}

	public void setPerKindNm(String perKindNm) {
		this.perKindNm = perKindNm;
	}

	public int getTempMin() {
		return tempMin;
	}

	public void setTempMin(int tempMin) {
		this.tempMin = tempMin;
	}

	public int getTempMax() {
		return tempMax;
	}

	public void setTempMax(int tempMax) {
		this.tempMax = tempMax;
	}

	public String getWorkDesc() {
		return workDesc;
	}

	public void setWorkDesc(String workDesc) {
		this.workDesc = workDesc;
	}

	public String getWorkNm() {
		return workNm;
	}

	public void setWorkNm(String workNm) {
		this.workNm = workNm;
	}

	public double getPreQty() {
		return preQty;
	}

	public void setPreQty(double preQty) {
		this.preQty = preQty;
	}

	public String getPrintYn() {
		return printYn;
	}

	public void setPrintYn(String printYn) {
		this.printYn = printYn;
	}

	public double getAmt() {
		return amt;
	}

	public void setAmt(double amt) {
		this.amt = amt;
	}

	public String getReview2Emp() {
		return review2Emp;
	}

	public void setReview2Emp(String review2Emp) {
		this.review2Emp = review2Emp;
	}

	public String getReview2EmpName() {
		return review2EmpName;
	}

	public void setReview2EmpName(String review2EmpName) {
		this.review2EmpName = review2EmpName;
	}

	public String getReview2Sett() {
		return review2Sett;
	}

	public void setReview2Sett(String review2Sett) {
		this.review2Sett = review2Sett;
	}

	public String getReview2Dt() {
		return review2Dt;
	}

	public void setReview2Dt(String review2Dt) {
		this.review2Dt = review2Dt;
	}

	public String getPerKind() {
		return perKind;
	}

	public void setPerKind(String perKind) {
		this.perKind = perKind;
	}

	public String getStndDt() {
		return stndDt;
	}

	public void setStndDt(String stndDt) {
		this.stndDt = stndDt;
	}

	public String getCustDs() {
		return custDs;
	}

	public void setCustDs(String custDs) {
		this.custDs = custDs;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getEquipBc() {
		return equipBc;
	}

	public void setEquipBc(String equipBc) {
		this.equipBc = equipBc;
	}

	public double getLegQty() {
		return legQty;
	}

	public void setLegQty(double legQty) {
		this.legQty = legQty;
	}

	public double getTotQty() {
		return totQty;
	}

	public void setTotQty(double totQty) {
		this.totQty = totQty;
	}

	public int getLegPerNum() {
		return legPerNum;
	}

	public void setLegPerNum(int legPerNum) {
		this.legPerNum = legPerNum;
	}

	public int getTotPerNum() {
		return totPerNum;
	}

	public void setTotPerNum(int totPerNum) {
		this.totPerNum = totPerNum;
	}

	public double getLegInQty() {
		return legInQty;
	}

	public void setLegInQty(double legInQty) {
		this.legInQty = legInQty;
	}

	public double getTotBuildQty() {
		return totBuildQty;
	}

	public void setTotBuildQty(double totBuildQty) {
		this.totBuildQty = totBuildQty;
	}

	public double getTotOutQty() {
		return totOutQty;
	}

	public void setTotOutQty(double totOutQty) {
		this.totOutQty = totOutQty;
	}

	public String getKbigDs() {
		return kbigDs;
	}

	public void setKbigDs(String kbigDs) {
		this.kbigDs = kbigDs;
	}

	public String getKmidDs() {
		return kmidDs;
	}

	public void setKmidDs(String kmidDs) {
		this.kmidDs = kmidDs;
	}

	public String getKsmallDs() {
		return ksmallDs;
	}

	public void setKsmallDs(String ksmallDs) {
		this.ksmallDs = ksmallDs;
	}

	public String getKitemDs() {
		return kitemDs;
	}

	public void setKitemDs(String kitemDs) {
		this.kitemDs = kitemDs;
	}

	public String getItemSz() {
		return itemSz;
	}

	public void setItemSz(String itemSz) {
		this.itemSz = itemSz;
	}

	public String getItemUt() {
		return itemUt;
	}

	public void setItemUt(String itemUt) {
		this.itemUt = itemUt;
	}

	public String getAppvNextYn() {
		return appvNextYn;
	}

	public void setAppvNextYn(String appvNextYn) {
		this.appvNextYn = appvNextYn;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public double getInQty() {
		return inQty;
	}

	public void setInQty(double inQty) {
		this.inQty = inQty;
	}

	public double getBuildQty() {
		return buildQty;
	}

	public void setBuildQty(double buildQty) {
		this.buildQty = buildQty;
	}

	public double getOutQty() {
		return outQty;
	}

	public void setOutQty(double outQty) {
		this.outQty = outQty;
	}

	public double getAccpMd() {
		return accpMd;
	}

	public void setAccpMd(double accpMd) {
		this.accpMd = accpMd;
	}

	public String getWorkCond() {
		return workCond;
	}

	public void setWorkCond(String workCond) {
		this.workCond = workCond;
	}

	public String getRegEmp() {
		return regEmp;
	}

	public void setRegEmp(String regEmp) {
		this.regEmp = regEmp;
	}

	public String getRegEmpName() {
		return regEmpName;
	}

	public void setRegEmpName(String regEmpName) {
		this.regEmpName = regEmpName;
	}

	public String getRegSett() {
		return regSett;
	}

	public void setRegSett(String regSett) {
		this.regSett = regSett;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getReviewEmp() {
		return reviewEmp;
	}

	public void setReviewEmp(String reviewEmp) {
		this.reviewEmp = reviewEmp;
	}

	public String getReviewEmpName() {
		return reviewEmpName;
	}

	public void setReviewEmpName(String reviewEmpName) {
		this.reviewEmpName = reviewEmpName;
	}

	public String getReviewSett() {
		return reviewSett;
	}

	public void setReviewSett(String reviewSett) {
		this.reviewSett = reviewSett;
	}

	public String getReviewDt() {
		return reviewDt;
	}

	public void setReviewDt(String reviewDt) {
		this.reviewDt = reviewDt;
	}

	public String getConfirmEmp() {
		return confirmEmp;
	}

	public void setConfirmEmp(String confirmEmp) {
		this.confirmEmp = confirmEmp;
	}

	public String getConfirmEmpName() {
		return confirmEmpName;
	}

	public void setConfirmEmpName(String confirmEmpName) {
		this.confirmEmpName = confirmEmpName;
	}

	public String getConfirmSett() {
		return confirmSett;
	}

	public void setConfirmSett(String confirmSett) {
		this.confirmSett = confirmSett;
	}

	public String getConfirmDt() {
		return confirmDt;
	}

	public void setConfirmDt(String confirmDt) {
		this.confirmDt = confirmDt;
	}

	public String getNextYn() {
		return nextYn;
	}

	public void setNextYn(String nextYn) {
		this.nextYn = nextYn;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getSettKind() {
		return settKind;
	}

	public void setSettKind(String settKind) {
		this.settKind = settKind;
	}

	public String getRmk() {
		return rmk;
	}

	public void setRmk(String rmk) {
		this.rmk = rmk;
	}

	public String getHpNo() {
		return hpNo;
	}

	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}

	public String getSignImage() {
		return signImage;
	}

	public void setSignImage(String signImage) {
		this.signImage = signImage;
	}

	public String getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFileSaveNm() {
		return fileSaveNm;
	}

	public void setFileSaveNm(String fileSaveNm) {
		this.fileSaveNm = fileSaveNm;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public String getRegBirth() {
		return regBirth;
	}

	public void setRegBirth(String regBirth) {
		this.regBirth = regBirth;
	}

	public String getItemUnitNm() {
		return itemUnitNm;
	}

	public void setItemUnitNm(String itemUnitNm) {
		this.itemUnitNm = itemUnitNm;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public int getChk() {
		return chk;
	}

	public void setChk(int chk) {
		this.chk = chk;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRmks() {
		return rmks;
	}

	public void setRmks(String rmks) {
		this.rmks = rmks;
	}

	public String getCommgrpsDs() {
		return commgrpsDs;
	}

	public void setCommgrpsDs(String commgrpsDs) {
		this.commgrpsDs = commgrpsDs;
	}

	public String getWorkConScm() {
		return workConScm;
	}

	public void setWorkConScm(String workConScm) {
		this.workConScm = workConScm;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getSiteDs() {
		return siteDs;
	}

	public void setSiteDs(String siteDs) {
		this.siteDs = siteDs;
	}

	public String getConstructDs() {
		return constructDs;
	}

	public void setConstructDs(String constructDs) {
		this.constructDs = constructDs;
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

	public String getOutCid() {
		return outCid;
	}

	public void setOutCid(String outCid) {
		this.outCid = outCid;
	}

	public String getOutMid() {
		return outMid;
	}

	public void setOutMid(String outMid) {
		this.outMid = outMid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSiteCd() {
		return siteCd;
	}

	public void setSiteCd(String siteCd) {
		this.siteCd = siteCd;
	}

	public String getCustCd() {
		return custCd;
	}

	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	public String getWorkDt() {
		return workDt;
	}

	public void setWorkDt(String workDt) {
		this.workDt = workDt;
	}

	public String getWeatherBc() {
		return weatherBc;
	}

	public void setWeatherBc(String weatherBc) {
		this.weatherBc = weatherBc;
	}

	public double getWeatherMn() {
		return weatherMn;
	}

	public void setWeatherMn(double weatherMn) {
		this.weatherMn = weatherMn;
	}

	public double getWeatherMx() {
		return weatherMx;
	}

	public void setWeatherMx(double weatherMx) {
		this.weatherMx = weatherMx;
	}

	public String getWeatherDs() {
		return weatherDs;
	}

	public void setWeatherDs(String weatherDs) {
		this.weatherDs = weatherDs;
	}

	public String getConSec() {
		return conSec;
	}

	public void setConSec(String conSec) {
		this.conSec = conSec;
	}

	public String getCommgrpmCd() {
		return commgrpmCd;
	}

	public void setCommgrpmCd(String commgrpmCd) {
		this.commgrpmCd = commgrpmCd;
	}

	public String getCommgrpsCd() {
		return commgrpsCd;
	}

	public void setCommgrpsCd(String commgrpsCd) {
		this.commgrpsCd = commgrpsCd;
	}

	public String getCommgrpdCd() {
		return commgrpdCd;
	}

	public void setCommgrpdCd(String commgrpdCd) {
		this.commgrpdCd = commgrpdCd;
	}

	public int getPerNum() {
		return perNum;
	}

	public void setPerNum(int perNum) {
		this.perNum = perNum;
	}

	public String getWorkCon() {
		return workCon;
	}

	public void setWorkCon(String workCon) {
		this.workCon = workCon;
	}

	public String getItemCd() {
		return itemCd;
	}

	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}

	public String getWorkSeq() {
		return workSeq;
	}

	public void setWorkSeq(String workSeq) {
		this.workSeq = workSeq;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}

	public String getItemSpec() {
		return itemSpec;
	}

	public void setItemSpec(String itemSpec) {
		this.itemSpec = itemSpec;
	}

	public String getItemUnit() {
		return itemUnit;
	}

	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}

	public double getQty() {
		return qty;
	}

	public void setQty(double qty) {
		this.qty = qty;
	}

	public String getPerNo() {
		return perNo;
	}

	public void setPerNo(String perNo) {
		this.perNo = perNo;
	}

	public String getPerNm() {
		return perNm;
	}

	public void setPerNm(String perNm) {
		this.perNm = perNm;
	}

	public String getRegiNo() {
		return regiNo;
	}

	public void setRegiNo(String regiNo) {
		this.regiNo = regiNo;
	}

	public String getForeNo() {
		return foreNo;
	}

	public void setForeNo(String foreNo) {
		this.foreNo = foreNo;
	}

	public String getRetireDiv() {
		return retireDiv;
	}

	public void setRetireDiv(String retireDiv) {
		this.retireDiv = retireDiv;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getEnterDt() {
		return enterDt;
	}

	public void setEnterDt(String enterDt) {
		this.enterDt = enterDt;
	}

	public String getRetireDt() {
		return retireDt;
	}

	public void setRetireDt(String retireDt) {
		this.retireDt = retireDt;
	}

	public String getInTime() {
		return inTime;
	}

	public void setInTime(String inTime) {
		this.inTime = inTime;
	}

	public String getOutTime() {
		return outTime;
	}

	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}

	public String getWorkKn() {
		return workKn;
	}

	public void setWorkKn(String workKn) {
		this.workKn = workKn;
	}

	public double getNormal() {
		return normal;
	}

	public void setNormal(double normal) {
		this.normal = normal;
	}

	public double getExtend() {
		return extend;
	}

	public void setExtend(double extend) {
		this.extend = extend;
	}

	public double getNight() {
		return night;
	}

	public void setNight(double night) {
		this.night = night;
	}

	public double getSpecial() {
		return special;
	}

	public void setSpecial(double special) {
		this.special = special;
	}

	public double getOutside() {
		return outside;
	}

	public void setOutside(double outside) {
		this.outside = outside;
	}

	public double getEarly() {
		return early;
	}

	public void setEarly(double early) {
		this.early = early;
	}

	public double getLate() {
		return late;
	}

	public void setLate(double late) {
		this.late = late;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
