package com.ubi.erp.orderDelivery.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("OrderDeliveryVO")
public class OrderDeliveryVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String no;

	private String cudKey;

	private String siteCd; // 현장코드

	private String mrNo; // 청구서 번호

	private String inqNo; // 견적의뢰 번호

	private String poNo; // 발주서 번호

	private int costId; // 공종코드ID

	private String itemCd; // 품목코드

	private String itemBc; // 비목

	private double itemQn; // 발주수량

	private double itemUp; // 발주단가

	private double itemAm; // 발주금액

	private String deliveryDt; // 납기일자

	private double asgnQty; // 배정 누적수량

	private String bigCd; // 대코드

	private String midCd; // 중코드

	private String smallCd; // 소코드

	private String kitemDs; // 품목명(한글)

	private String eitemDs; // 품목명(영문)

	private String itemSz; // 규격

	private String itemUt; // 단위

	private String sqNo;// 발주차수

	private String custCd; // 거래처코드

	private String itemoutDt; // 반출일자

	private double dayuseAm; // 하루사용량

	private double checkQn; // 검수수량

	private double checkAm; // 검수금액

	private String balDt; // 발주일자

	private String balAsgnQty; // 발주배정수량

	private String outsCon; // 외주처확인

	private String outsConId;// 외주처 확인ID

	private String outsConDt; // 외주처확인일시

	private double deliQn; // 발주수량(?)

	private String id;

	private String itemUtNm; // 단위 한글

	private String rmks; // 비고

	private String siteDs; // 현장명

	private String locationAt; // 운송장소

	private String stBalDt; // 시작 조회조건

	private String edBalDt; // 종료 조회조건

	private String deliNo; // 납품번호

	private String deliDt; // 납품일자

	private String deliSeq; // 납품순번

	private String deliSubSeq; // 납품sub순번

	private double deliQty; // 납품수량

	private double miDeliQty; // 미납 수량

	private String masterKey; // 고유키

	private double oldDeliQty; // 임시 업데이트 발주수량

	private String rfidYn; // 레미콘 구분

	private String invoiceDt; // 송장 일자

	private String invoiceNo; // 송장번호

	private String rfidNo; // RFID 번호

	private String rfidNoOld; // RFID 번호 이전값

	private int rfidsqNo; // RFID 번호 순번

	private int rfidsqNoOld; // //RFID 번호 순번 이전값

	private String outputDt; // 입고예정일자

	private String invoicebc; // 송장종류

	private String invoiceIo; // 송장구분

	private String accountDt; // 회계일자

	private double invoiceAm; // 발행금액

	private String controlNo; // 관리번호

	private String inputYn; // 소비여부(RFID여부)

	private String inputBc; // 상태구분

	private String itemUc;

	private String stInvoiceDt; // 조회 시작날짜

	private String edInvoiceDt; // 조회 끝날짜

	private String custDs; // 거래처명

	private double itemVat; // 부가세

	private double itemSum; // 합계

	private String inputNm; // 접수상태

	private double inputQn; // 접수수량

	private double orderQn; // 발주수량

	private String inoutCd; // 입출현황

	private String carNo; // 차량번호

	private String rmks2; // 비고2

	private String instate; // 현황

	private String invoicechkNo; // 송장 체크번호

	private String faceimage; // 이미지

	private String faceimagelen; // 이미지 길이

	private String dateinDt; // 입출일자

	private String jungsanYn; // 정산여부

	private String scmYn; // scm여부

	private String telNo; // 전화번호

	private String chargeNm; // 담당자

	private String chargetelNo; // 담당자 전화번호

	private int cnt;// 검색조건

	private String inputcDt; // 입고시간

	private String outputcDt; // 출고시간

	private int deliSeqF;

	private String slipYn; // 구분

	private String invoicedelNo; // 송장삭제번호

	private String siteoutCd; // 출하현장

	private String siteoutDs;// 출하현장이름

	private String slipNo; // 전표번호

	private String invoiceNm; // 송장 타이틀

	private String nm; // 작성자명

	private String costCd; // 공종코드

	private String itemDs; // 공종명

	private String outsRmk;

	private String outsEndYn;

	private String cancelYn;

	private double invoiceQn;

	private double oldItemQn;

	private double miInvoiceQn;

	private String gubn;

	private String endYn;

	private String etcKind;

	private String etcKindNm;

	private String etcReqNo;

	private String etcCd;

	private String etcNm;

	private double etcUp;

	private double etcAm;

	private String etcSz;

	private String etcUt;

	private String useYn;

	private String nowDate;

	private String ceoNm;

	private String addr1;

	private String prtNm;

	private String bizNo;

	private String bizType;

	private String bizKind;

	private String compNo;

	private String coBnm;

	private String compCeoNm;

	private String addr;

	private String compBizType;

	private String compBizKind;

	/**
	 * @return the compNo
	 */
	public String getCompNo() {
		return compNo;
	}

	/**
	 * @param compNo the compNo to set
	 */
	public void setCompNo(String compNo) {
		this.compNo = compNo;
	}

	/**
	 * @return the coBnm
	 */
	public String getCoBnm() {
		return coBnm;
	}

	/**
	 * @param coBnm the coBnm to set
	 */
	public void setCoBnm(String coBnm) {
		this.coBnm = coBnm;
	}

	/**
	 * @return the compCeoNm
	 */
	public String getCompCeoNm() {
		return compCeoNm;
	}

	/**
	 * @param compCeoNm the compCeoNm to set
	 */
	public void setCompCeoNm(String compCeoNm) {
		this.compCeoNm = compCeoNm;
	}

	/**
	 * @return the addr
	 */
	public String getAddr() {
		return addr;
	}

	/**
	 * @param addr the addr to set
	 */
	public void setAddr(String addr) {
		this.addr = addr;
	}

	/**
	 * @return the compBizType
	 */
	public String getCompBizType() {
		return compBizType;
	}

	/**
	 * @param compBizType the compBizType to set
	 */
	public void setCompBizType(String compBizType) {
		this.compBizType = compBizType;
	}

	/**
	 * @return the compBizKind
	 */
	public String getCompBizKind() {
		return compBizKind;
	}

	/**
	 * @param compBizKind the compBizKind to set
	 */
	public void setCompBizKind(String compBizKind) {
		this.compBizKind = compBizKind;
	}

	/**
	 * @return the nowDate
	 */
	public String getNowDate() {
		return nowDate;
	}

	/**
	 * @param nowDate the nowDate to set
	 */
	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}

	/**
	 * @return the ceoNm
	 */
	public String getCeoNm() {
		return ceoNm;
	}

	/**
	 * @param ceoNm the ceoNm to set
	 */
	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}

	/**
	 * @return the addr1
	 */
	public String getAddr1() {
		return addr1;
	}

	/**
	 * @param addr1 the addr1 to set
	 */
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	/**
	 * @return the prtNm
	 */
	public String getPrtNm() {
		return prtNm;
	}

	/**
	 * @param prtNm the prtNm to set
	 */
	public void setPrtNm(String prtNm) {
		this.prtNm = prtNm;
	}

	/**
	 * @return the bizNo
	 */
	public String getBizNo() {
		return bizNo;
	}

	/**
	 * @param bizNo the bizNo to set
	 */
	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}

	/**
	 * @return the bizType
	 */
	public String getBizType() {
		return bizType;
	}

	/**
	 * @param bizType the bizType to set
	 */
	public void setBizType(String bizType) {
		this.bizType = bizType;
	}

	/**
	 * @return the bizKind
	 */
	public String getBizKind() {
		return bizKind;
	}

	/**
	 * @param bizKind the bizKind to set
	 */
	public void setBizKind(String bizKind) {
		this.bizKind = bizKind;
	}

	/**
	 * @return the rfidNoOld
	 */
	public String getRfidNoOld() {
		return rfidNoOld;
	}

	/**
	 * @param rfidNoOld the rfidNoOld to set
	 */
	public void setRfidNoOld(String rfidNoOld) {
		this.rfidNoOld = rfidNoOld;
	}

	/**
	 * @return the rfidsqNoOld
	 */
	public int getRfidsqNoOld() {
		return rfidsqNoOld;
	}

	/**
	 * @param rfidsqNoOld the rfidsqNoOld to set
	 */
	public void setRfidsqNoOld(int rfidsqNoOld) {
		this.rfidsqNoOld = rfidsqNoOld;
	}

	public String getEtcUt() {
		return etcUt;
	}

	public void setEtcUt(String etcUt) {
		this.etcUt = etcUt;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getEtcSz() {
		return etcSz;
	}

	public void setEtcSz(String etcSz) {
		this.etcSz = etcSz;
	}

	public String getEtcKindNm() {
		return etcKindNm;
	}

	public void setEtcKindNm(String etcKindNm) {
		this.etcKindNm = etcKindNm;
	}

	public double getEtcUp() {
		return etcUp;
	}

	public void setEtcUp(double etcUp) {
		this.etcUp = etcUp;
	}

	public double getEtcAm() {
		return etcAm;
	}

	public void setEtcAm(double etcAm) {
		this.etcAm = etcAm;
	}

	public String getEtcKind() {
		return etcKind;
	}

	public void setEtcKind(String etcKind) {
		this.etcKind = etcKind;
	}

	public String getEtcReqNo() {
		return etcReqNo;
	}

	public void setEtcReqNo(String etcReqNo) {
		this.etcReqNo = etcReqNo;
	}

	public String getEtcCd() {
		return etcCd;
	}

	public void setEtcCd(String etcCd) {
		this.etcCd = etcCd;
	}

	public String getEtcNm() {
		return etcNm;
	}

	public void setEtcNm(String etcNm) {
		this.etcNm = etcNm;
	}

	public String getEndYn() {
		return endYn;
	}

	public void setEndYn(String endYn) {
		this.endYn = endYn;
	}

	public String getGubn() {
		return gubn;
	}

	public void setGubn(String gubn) {
		this.gubn = gubn;
	}

	public double getMiInvoiceQn() {
		return miInvoiceQn;
	}

	public void setMiInvoiceQn(double miInvoiceQn) {
		this.miInvoiceQn = miInvoiceQn;
	}

	public double getOldItemQn() {
		return oldItemQn;
	}

	public void setOldItemQn(double oldItemQn) {
		this.oldItemQn = oldItemQn;
	}

	public int getRfidsqNo() {
		return rfidsqNo;
	}

	public void setRfidsqNo(int rfidsqNo) {
		this.rfidsqNo = rfidsqNo;
	}

	public double getInvoiceQn() {
		return invoiceQn;
	}

	public void setInvoiceQn(double invoiceQn) {
		this.invoiceQn = invoiceQn;
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

	public String getSiteoutCd() {
		return siteoutCd;
	}

	public void setSiteoutCd(String siteoutCd) {
		this.siteoutCd = siteoutCd;
	}

	public String getSiteoutDs() {
		return siteoutDs;
	}

	public void setSiteoutDs(String siteoutDs) {
		this.siteoutDs = siteoutDs;
	}

	public String getSlipNo() {
		return slipNo;
	}

	public void setSlipNo(String slipNo) {
		this.slipNo = slipNo;
	}

	public String getInvoiceNm() {
		return invoiceNm;
	}

	public void setInvoiceNm(String invoiceNm) {
		this.invoiceNm = invoiceNm;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public String getCostCd() {
		return costCd;
	}

	public void setCostCd(String costCd) {
		this.costCd = costCd;
	}

	public String getItemDs() {
		return itemDs;
	}

	public void setItemDs(String itemDs) {
		this.itemDs = itemDs;
	}

	public String getInvoicedelNo() {
		return invoicedelNo;
	}

	public void setInvoicedelNo(String invoicedelNo) {
		this.invoicedelNo = invoicedelNo;
	}

	public String getSlipYn() {
		return slipYn;
	}

	public void setSlipYn(String slipYn) {
		this.slipYn = slipYn;
	}

	public int getDeliSeqF() {
		return deliSeqF;
	}

	public void setDeliSeqF(int deliSeqF) {
		this.deliSeqF = deliSeqF;
	}

	public String getInputcDt() {
		return inputcDt;
	}

	public void setInputcDt(String inputcDt) {
		this.inputcDt = inputcDt;
	}

	public String getOutputcDt() {
		return outputcDt;
	}

	public void setOutputcDt(String outputcDt) {
		this.outputcDt = outputcDt;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getScmYn() {
		return scmYn;
	}

	public void setScmYn(String scmYn) {
		this.scmYn = scmYn;
	}

	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getChargeNm() {
		return chargeNm;
	}

	public void setChargeNm(String chargeNm) {
		this.chargeNm = chargeNm;
	}

	public String getChargetelNo() {
		return chargetelNo;
	}

	public void setChargetelNo(String chargetelNo) {
		this.chargetelNo = chargetelNo;
	}

	public double getOrderQn() {
		return orderQn;
	}

	public void setOrderQn(double orderQn) {
		this.orderQn = orderQn;
	}

	public String getInoutCd() {
		return inoutCd;
	}

	public void setInoutCd(String inoutCd) {
		this.inoutCd = inoutCd;
	}

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public String getRmks2() {
		return rmks2;
	}

	public void setRmks2(String rmks2) {
		this.rmks2 = rmks2;
	}

	public String getInstate() {
		return instate;
	}

	public void setInstate(String instate) {
		this.instate = instate;
	}

	public String getInvoicechkNo() {
		return invoicechkNo;
	}

	public void setInvoicechkNo(String invoicechkNo) {
		this.invoicechkNo = invoicechkNo;
	}

	public String getFaceimage() {
		return faceimage;
	}

	public void setFaceimage(String faceimage) {
		this.faceimage = faceimage;
	}

	public String getFaceimagelen() {
		return faceimagelen;
	}

	public void setFaceimagelen(String faceimagelen) {
		this.faceimagelen = faceimagelen;
	}

	public String getDateinDt() {
		return dateinDt;
	}

	public void setDateinDt(String dateinDt) {
		this.dateinDt = dateinDt;
	}

	public String getJungsanYn() {
		return jungsanYn;
	}

	public void setJungsanYn(String jungsanYn) {
		this.jungsanYn = jungsanYn;
	}

	public String getCustDs() {
		return custDs;
	}

	public void setCustDs(String custDs) {
		this.custDs = custDs;
	}

	public double getItemVat() {
		return itemVat;
	}

	public void setItemVat(double itemVat) {
		this.itemVat = itemVat;
	}

	public double getItemSum() {
		return itemSum;
	}

	public void setItemSum(double itemSum) {
		this.itemSum = itemSum;
	}

	public String getInputNm() {
		return inputNm;
	}

	public void setInputNm(String inputNm) {
		this.inputNm = inputNm;
	}

	public double getInputQn() {
		return inputQn;
	}

	public void setInputQn(double inputQn) {
		this.inputQn = inputQn;
	}

	public String getStInvoiceDt() {
		return stInvoiceDt;
	}

	public void setStInvoiceDt(String stInvoiceDt) {
		this.stInvoiceDt = stInvoiceDt;
	}

	public String getEdInvoiceDt() {
		return edInvoiceDt;
	}

	public void setEdInvoiceDt(String edInvoiceDt) {
		this.edInvoiceDt = edInvoiceDt;
	}

	public String getItemUc() {
		return itemUc;
	}

	public void setItemUc(String itemUc) {
		this.itemUc = itemUc;
	}

	public String getInvoiceDt() {
		return invoiceDt;
	}

	public void setInvoiceDt(String invoiceDt) {
		this.invoiceDt = invoiceDt;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getRfidNo() {
		return rfidNo;
	}

	public void setRfidNo(String rfidNo) {
		this.rfidNo = rfidNo;
	}

	public String getOutputDt() {
		return outputDt;
	}

	public void setOutputDt(String outputDt) {
		this.outputDt = outputDt;
	}

	public String getInvoicebc() {
		return invoicebc;
	}

	public void setInvoicebc(String invoicebc) {
		this.invoicebc = invoicebc;
	}

	public String getInvoiceIo() {
		return invoiceIo;
	}

	public void setInvoiceIo(String invoiceIo) {
		this.invoiceIo = invoiceIo;
	}

	public String getAccountDt() {
		return accountDt;
	}

	public void setAccountDt(String accountDt) {
		this.accountDt = accountDt;
	}

	public double getInvoiceAm() {
		return invoiceAm;
	}

	public void setInvoiceAm(double invoiceAm) {
		this.invoiceAm = invoiceAm;
	}

	public String getControlNo() {
		return controlNo;
	}

	public void setControlNo(String controlNo) {
		this.controlNo = controlNo;
	}

	public String getInputYn() {
		return inputYn;
	}

	public void setInputYn(String inputYn) {
		this.inputYn = inputYn;
	}

	public String getInputBc() {
		return inputBc;
	}

	public void setInputBc(String inputBc) {
		this.inputBc = inputBc;
	}

	public String getRfidYn() {
		return rfidYn;
	}

	public void setRfidYn(String rfidYn) {
		this.rfidYn = rfidYn;
	}

	public double getOldDeliQty() {
		return oldDeliQty;
	}

	public void setOldDeliQty(double oldDeliQty) {
		this.oldDeliQty = oldDeliQty;
	}

	public String getMasterKey() {
		return masterKey;
	}

	public void setMasterKey(String masterKey) {
		this.masterKey = masterKey;
	}

	public double getMiDeliQty() {
		return miDeliQty;
	}

	public void setMiDeliQty(double miDeliQty) {
		this.miDeliQty = miDeliQty;
	}

	public double getDeliQty() {
		return deliQty;
	}

	public void setDeliQty(double deliQty) {
		this.deliQty = deliQty;
	}

	public String getDeliNo() {
		return deliNo;
	}

	public void setDeliNo(String deliNo) {
		this.deliNo = deliNo;
	}

	public String getDeliDt() {
		return deliDt;
	}

	public void setDeliDt(String deliDt) {
		this.deliDt = deliDt;
	}

	public String getDeliSeq() {
		return deliSeq;
	}

	public void setDeliSeq(String deliSeq) {
		this.deliSeq = deliSeq;
	}

	public String getDeliSubSeq() {
		return deliSubSeq;
	}

	public void setDeliSubSeq(String deliSubSeq) {
		this.deliSubSeq = deliSubSeq;
	}

	public String getStBalDt() {
		return stBalDt;
	}

	public void setStBalDt(String stBalDt) {
		this.stBalDt = stBalDt;
	}

	public String getEdBalDt() {
		return edBalDt;
	}

	public void setEdBalDt(String edBalDt) {
		this.edBalDt = edBalDt;
	}

	public String getLocationAt() {
		return locationAt;
	}

	public void setLocationAt(String locationAt) {
		this.locationAt = locationAt;
	}

	public String getRmks() {
		return rmks;
	}

	public void setRmks(String rmks) {
		this.rmks = rmks;
	}

	public String getSiteDs() {
		return siteDs;
	}

	public void setSiteDs(String siteDs) {
		this.siteDs = siteDs;
	}

	public String getItemUtNm() {
		return itemUtNm;
	}

	public void setItemUtNm(String itemUtNm) {
		this.itemUtNm = itemUtNm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getMrNo() {
		return mrNo;
	}

	public void setMrNo(String mrNo) {
		this.mrNo = mrNo;
	}

	public String getInqNo() {
		return inqNo;
	}

	public void setInqNo(String inqNo) {
		this.inqNo = inqNo;
	}

	public String getPoNo() {
		return poNo;
	}

	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	public int getCostId() {
		return costId;
	}

	public void setCostId(int costId) {
		this.costId = costId;
	}

	public String getItemCd() {
		return itemCd;
	}

	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}

	public String getItemBc() {
		return itemBc;
	}

	public void setItemBc(String itemBc) {
		this.itemBc = itemBc;
	}

	public double getItemQn() {
		return itemQn;
	}

	public void setItemQn(double itemQn) {
		this.itemQn = itemQn;
	}

	public double getItemUp() {
		return itemUp;
	}

	public void setItemUp(double itemUp) {
		this.itemUp = itemUp;
	}

	public double getItemAm() {
		return itemAm;
	}

	public void setItemAm(double itemAm) {
		this.itemAm = itemAm;
	}

	public String getDeliveryDt() {
		return deliveryDt;
	}

	public void setDeliveryDt(String deliveryDt) {
		this.deliveryDt = deliveryDt;
	}

	public double getAsgnQty() {
		return asgnQty;
	}

	public void setAsgnQty(double asgnQty) {
		this.asgnQty = asgnQty;
	}

	public String getBigCd() {
		return bigCd;
	}

	public void setBigCd(String bigCd) {
		this.bigCd = bigCd;
	}

	public String getMidCd() {
		return midCd;
	}

	public void setMidCd(String midCd) {
		this.midCd = midCd;
	}

	public String getSmallCd() {
		return smallCd;
	}

	public void setSmallCd(String smallCd) {
		this.smallCd = smallCd;
	}

	public String getKitemDs() {
		return kitemDs;
	}

	public void setKitemDs(String kitemDs) {
		this.kitemDs = kitemDs;
	}

	public String getEitemDs() {
		return eitemDs;
	}

	public void setEitemDs(String eitemDs) {
		this.eitemDs = eitemDs;
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

	public String getSqNo() {
		return sqNo;
	}

	public void setSqNo(String sqNo) {
		this.sqNo = sqNo;
	}

	public String getCustCd() {
		return custCd;
	}

	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	public String getItemoutDt() {
		return itemoutDt;
	}

	public void setItemoutDt(String itemoutDt) {
		this.itemoutDt = itemoutDt;
	}

	public double getDayuseAm() {
		return dayuseAm;
	}

	public void setDayuseAm(double dayuseAm) {
		this.dayuseAm = dayuseAm;
	}

	public double getCheckQn() {
		return checkQn;
	}

	public void setCheckQn(double checkQn) {
		this.checkQn = checkQn;
	}

	public double getCheckAm() {
		return checkAm;
	}

	public void setCheckAm(double checkAm) {
		this.checkAm = checkAm;
	}

	public String getBalDt() {
		return balDt;
	}

	public void setBalDt(String balDt) {
		this.balDt = balDt;
	}

	public String getBalAsgnQty() {
		return balAsgnQty;
	}

	public void setBalAsgnQty(String balAsgnQty) {
		this.balAsgnQty = balAsgnQty;
	}

	public String getOutsCon() {
		return outsCon;
	}

	public void setOutsCon(String outsCon) {
		this.outsCon = outsCon;
	}

	public String getOutsConId() {
		return outsConId;
	}

	public void setOutsConId(String outsConId) {
		this.outsConId = outsConId;
	}

	public String getOutsConDt() {
		return outsConDt;
	}

	public void setOutsConDt(String outsConDt) {
		this.outsConDt = outsConDt;
	}

	public double getDeliQn() {
		return deliQn;
	}

	public void setDeliQn(double deliQn) {
		this.deliQn = deliQn;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
