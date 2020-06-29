package site.front.cs.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import site.comm.service.impl.CommProcedureService;
import site.comm.service.impl.CommService;
import site.front.mm.service.impl.MmService;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Service("CsService")
public class CsService extends EgovAbstractServiceImpl{

	/** CsDao */
	@Resource(name = "CsDAO")
	private CsDAO csDAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	/** 공통 프로시저 서비스 */
	@Resource(name = "CommProcedureService")
    protected CommProcedureService commProcedureService;


	/** 회원관리 서비스 */
	@Resource(name = "MmService")
    protected MmService mmService;

	public List<?> calendarList(UnCamelMap<String, Object> paramMap) throws Exception {
        return csDAO.calendarList(paramMap);
	}


	public List<?> ascodeList(UnCamelMap<String, Object> paramMap)  throws Exception {
        return csDAO.ascodeList(paramMap);
	}


	public List<?> modelList(UnCamelMap<String, Object> paramMap) throws Exception {
        return csDAO.modelList(paramMap);
	}


	@SuppressWarnings("unchecked")
	public String tserviceSave(UnCamelMap<String, Object> param, FileUpLoad fileUpLoad, String savePath, String[] uploadName, boolean isLogin) throws Exception {
		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		String MODEL = param.getString("MODEL");
		String MODEL_NAME = param.getString("MODEL_NM");
		String ASCODE_LEV1 = param.getString("ASCODE_LEV1");
		String ASCODE_LEV2 = param.getString("ASCODE_LEV2");
		String COMMENT = param.getString("COMMENT");
		String MBR_NM = param.getString("MBR_NM");

		String MBR_MOBILE1 = param.getString("MBR_MOBILE1");
		String MBR_MOBILE2 = param.getString("MBR_MOBILE2");
		String MBR_MOBILE3 = param.getString("MBR_MOBILE3");

		String MBR_ZIPCODE = param.getString("MBR_ZIPCODE");
		String MBR_ADDR = param.getString("MBR_ADDR");
		String MBR_ADDR_DTL = param.getString("MBR_ADDR_DTL");
		String BOOKING_DT = param.getString("BOOKING_DT");
		String MBR_DI =  param.getString("MBR_DI");
		String MBR_MOBILE = MBR_MOBILE1 + "-" + MBR_MOBILE2 + "-" + MBR_MOBILE3;

		Map<String, Object> csNoMap = new HashMap<String, Object>();
		String csNo = "";
		if(isLogin){
			String MBR_ID = EgovUserDetailsHelper.getMbrId();
			csNoMap.put("MBR_ID", MBR_ID);
			 csNo = csDAO.mbrDiSearchForAsa010(csNoMap);
		}else{
			csNoMap.put("MBR_DI", MBR_DI);
			 csNo = csDAO.mbrDiSearchForAsa010(csNoMap);
		}

		if(CommonUtil.nvl(csNo).equals("")){

			Map<String, Object> asa010Map = new HashMap<>();
			asa010Map.put("cs_nm", MBR_NM);
			asa010Map.put("tel", param.getString("TEL"));
			asa010Map.put("hp", MBR_MOBILE);
			asa010Map.put("zip_cd", MBR_ZIPCODE);
			asa010Map.put("addr",  MBR_ADDR);
			asa010Map.put("addr2", MBR_ADDR_DTL);
			asa010Map.put("mbr_di", MBR_DI);
			asa010Map.put("MBR_DI", MBR_DI);

			String csNoSearch = mmService.csNoSearch(asa010Map);
			if(CommonUtil.nvl(csNoSearch).equals("")){
				csNo =  mmService.selectMaxMbrSeq();
				asa010Map.put("cs_no", csNo);

				matchingColumName.put("cdt", "$iui");

				whereColumName = new String[]{"cs_no"};
				commService.tableSaveData("asa010", asa010Map, matchingColumName, whereColumName, null, null);
				commService.setGdataModHis("asa010", asa010Map.get("cs_no"), asa010Map, "I");
				matchingColumName.clear();
			}

		}
		UnCamelMap<String, Object> tserviceMap = new UnCamelMap<>();

		String rejectMsg = "";

		int cuntCount = 0;
		String custCd = "";

		int reAreaCount = 0;
		String reArea = "";

		int ASZ200BkYnCount = 0;

		UnCamelMap<String, Object> autoReceiptMap = new UnCamelMap<>();
		autoReceiptMap.put("ZIP_CODE",param.getString("MBR_ZIPCODE"));
		autoReceiptMap.put("MODEL_ITEM_CD",param.getString("MODEL_ITEM_CD"));
		autoReceiptMap.put("MODEL",MODEL);
		autoReceiptMap.put("ITM_GUBUN",param.getString("ITM_GUBUN"));


		if(param.getString("MODEL_ITEM_CD").equals("0") || param.getString("MODEL_ITEM_CD").equals("1")){

			ASZ200BkYnCount = csDAO.ASZ200BkYnCount(autoReceiptMap);

			cuntCount = csDAO.autoReceiptCustCdCount(autoReceiptMap);
			if(cuntCount == 1){
			custCd = csDAO.autoReceiptCustCdSearch(autoReceiptMap);

				if(!"".equals(CommonUtil.nvl(custCd))){
				tserviceMap.put("CUST_CD", custCd);
				}else{
					rejectMsg += "해당 우편번호에 대리점이 존재하지않은 자동 접수 불가구역입니다..\n";
				}
			}else{
				if(cuntCount > 1){
					rejectMsg += "해당 우편번호에 "+cuntCount+"개의 대리점이 존재합니다.\n";
				}

				if(cuntCount == 0){
					rejectMsg += "해당 우편번호에 대리점이 존재하지 않습니다.\n";
				}
			}

			reAreaCount = csDAO.autoReceiptReAreaCount(autoReceiptMap);
			if(reAreaCount == 1){
				reArea = csDAO.autoReceiptReAreaSearch(autoReceiptMap);

				if(!"".equals(CommonUtil.nvl(reArea))){
					tserviceMap.put("RE_AREA", reArea);
					}else{
						rejectMsg += "해당 우편번호에 구역이 존재하지않은 자동 접수 불가구역입니다..\n";
					}


				}else{
					if(reAreaCount > 1){
						rejectMsg += "해당 우편번호에 "+cuntCount+"개의 구역이 존재합니다.\n";
					}

					if(reAreaCount == 0){
						rejectMsg += "해당 우편번호에 구역이 존재하지 않습니다.\n";
					}
				}
		}

		if(param.getString("MODEL_ITEM_CD").equals("1")){
			rejectMsg += "품목이 비데만 자동 접수가 가능합니다.\n";
		}


		if(ASZ200BkYnCount > 0){
		if(rejectMsg == "" && param.getString("CS_TYPE").equals("SER")){
			  SimpleDateFormat sdf = new SimpleDateFormat ( "yyyy-MM-dd" );
			  String asNo = csDAO.asNoSearchForAsa200();
			Map<String, Object> asa200Map = new HashMap<>();
			asa200Map.put("as_no", asNo);
			asa200Map.put("oem_bc", "AS100100"); //OEM구분 이수스로 기본 셋팅
			asa200Map.put("cs_no", csNo);
			asa200Map.put("cs_no_new", csNo);
			asa200Map.put("bs_cd", "01");
			asa200Map.put("cs_chk", "1");
				// asa200Map.put("itm_id", MODEL);
			asa200Map.put("itm_id_j", MODEL); // 20190507 접수품목코드로 변경
			asa200Map.put("cs_nm", MBR_NM);
			asa200Map.put("tel", param.getString("TEL"));
			asa200Map.put("hp", MBR_MOBILE);
			asa200Map.put("zip_cd", MBR_ZIPCODE);
			asa200Map.put("addr", MBR_ADDR);
			asa200Map.put("addr2", MBR_ADDR_DTL);
			asa200Map.put("re_bc", ASCODE_LEV1);
			asa200Map.put("re2_bc", ASCODE_LEV2);
			asa200Map.put("re_nm", COMMENT);
			asa200Map.put("itm_gubun", param.getString("ITM_GUBUN"));
			asa200Map.put("re_ty", "AS200200"); //접수유형 A/S처리로 셋팅
			asa200Map.put("re_area", reArea);
			asa200Map.put("cust_cd", custCd); //지정대리점
			asa200Map.put("act_dt", BOOKING_DT); //방문예약일자
			asa200Map.put("as_adv", "접수조건 충족으로 자동접수"); //접수상담내역
			asa200Map.put("stat_bc", "AS204100");//진행상태 접수로 셋팅
			asa200Map.put("inp_bc", param.getString("INP_BC"));
			asa200Map.put("rec_dt", sdf.format(new Date()));
//			asa200Map.put("rec_dt", "3000-01-01");

			matchingColumName.put("mdt", "$udate");
			matchingColumName.put("cdt", "$idate");

			whereColumName = new String[]{"as_no","oem_bc"};
				commService.tableSaveData("ASA200", asa200Map, matchingColumName, whereColumName, null, null);
				commService.setGdataModHis("ASA200", asa200Map.get("as_no"), asa200Map, "U");
			matchingColumName.clear();
			//자동접수일때 ASW_CS_MST 추가 정보 등록
			tserviceMap.put("AS_NO", asNo);
			tserviceMap.put("OEM_BC", "AS100100"); //OEM구분 이수스로 기본 셋팅
			tserviceMap.put("RE_TY", "AS200200"); //접수유형 A/S처리로 셋팅
			tserviceMap.put("STAT_BC", "AS204100");//진행상태 접수로 셋팅
			tserviceMap.put("REJECT_MSG", "자동접수되었습니다."); //지정대리점

			UnCamelMap<String, Object> modelInfoMap = new UnCamelMap<>();
			modelInfoMap.put("ITM_GUBUN",param.getString("ITM_GUBUN"));
			modelInfoMap.put("MODEL",param.getString("MODEL"));

			CamelMap<String, Object> modelInfo = csDAO.modelInfo(modelInfoMap);
			CamelMap<String, Object> custInfo = csDAO.custInfo(custCd);
				if(custInfo != null){
					csDAO.asa200_new_work(asNo,MBR_NM,MBR_MOBILE,custInfo.getString("drvNm"),custInfo.getString("hp"));
					csDAO.asa200_new_work_cs(asNo,MBR_NM,MBR_MOBILE,param.getString("TEL"),MBR_ADDR +' '+MBR_ADDR_DTL,modelInfo.getString("itmCd"),modelInfo.getString("itmNm"),COMMENT,custInfo.getString("hp"));

					//knits 휴대폰번호로 sms를 날린다.
					csDAO.sendSmsUser(MBR_NM,MBR_MOBILE);
					csDAO.sendSmsCs(MBR_NM,MBR_MOBILE,MBR_ADDR +' '+MBR_ADDR_DTL,modelInfo.getString("itmNm"),COMMENT,custInfo.getString("hp"));
				}

			}else{
				tserviceMap.put("REJECT_MSG", rejectMsg);
			}
		}else{
			tserviceMap.put("REJECT_MSG", "자동 접수 대상 품목이 아닙니다.");
		}

		tserviceMap.put("AS_TEMP_NO", commService.getPrSeq("ASW_CS_MST"));
		tserviceMap.put("CS_NO", csNo);
		tserviceMap.put("MODEL", MODEL);
		tserviceMap.put("ASCODE_LEV1", ASCODE_LEV1);
		tserviceMap.put("ASCODE_LEV2", ASCODE_LEV2);
		tserviceMap.put("COMMENT", COMMENT);
		tserviceMap.put("BOOKING_DT", BOOKING_DT);
		tserviceMap.put("REG_IP", param.getString("REG_IP"));
		tserviceMap.put("REG_AGENT", param.getString("REG_AGENT"));
		tserviceMap.put("CS_TYPE", param.getString("CS_TYPE"));
		tserviceMap.put("INP_BC", param.getString("INP_BC"));
		tserviceMap.put("MODEL_ITEM_CD", param.getString("MODEL_ITEM_CD"));
		tserviceMap.put("ITM_GUBUN", param.getString("ITM_GUBUN"));
		tserviceMap.put("CS_NM", MBR_NM);
		tserviceMap.put("ITM_ID", MODEL);
		tserviceMap.put("HP", MBR_MOBILE);
		tserviceMap.put("TEL", param.getString("TEL"));
		tserviceMap.put("ZIP_CD", MBR_ZIPCODE);
		tserviceMap.put("ADDR", MBR_ADDR);
		tserviceMap.put("ADDR2", MBR_ADDR_DTL);

		if(!param.getString("CS_TIME_SEQ").equals("")){
			tserviceMap.put("CS_TIME_SEQ", param.getString("CS_TIME_SEQ"));
		}

		matchingColumName.put("REG_DT", "$idate");
		whereColumName = new String[]{"AS_TEMP_NO"};
		commService.tableSaveData("ASW_CS_MST", tserviceMap, matchingColumName, whereColumName, null, null);
		commService.setGdataModHis("ASW_CS_MST", tserviceMap.get("AS_TEMP_NO"), tserviceMap, "I");
		matchingColumName.clear();

		if(param.getArray("DTL_IMG_PATH_LIST") != null){
			int[] imageArr = new int[]{500000}; //사진크기조절 픽셀
			List<?> list = (List<?>) param.get("DTL_IMG_PATH_LIST");

			for (int i = 0; i < list.size(); i++) {
				Map<String, String> fileMap = (Map<String, String>) list.get(i);
				List<UnCamelMap<String, Object>> fileMaplist = fileUpLoad.setImageSize(fileMap, imageArr);
				if(imageArr.length > 0){
					for(UnCamelMap<String, Object> ImgAttMap : fileMaplist){
						UnCamelMap<String, Object> ImgMap = new UnCamelMap<>();
						ImgMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCodMany("CSA")));
						ImgMap.put("ATTCH_ID", savePath);
						ImgMap.put("ATTCH_FILE_NM", ImgAttMap.get("ATTCH_FILE_NM"));
						ImgMap.put("ATTCH_REAL_FILE_NM", ImgAttMap.get("ATTCH_REAL_FILE_NM"));
						ImgMap.put("ATTCH_FILE_PATH", ImgAttMap.get("ATTCH_FILE_PATH"));
						ImgMap.put("ATTCH_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_ABSOLUTE_PATH"));
						ImgMap.put("ATTCH_REAL_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
						whereColumName = new String[]{"ATTCH_CD"};
						commService.tableSaveData("ASW_G_ATTCH", ImgMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_G_ATTCH", ImgMap.getString("ATTCH_CD"), ImgMap, "U");
						UnCamelMap<String, Object> dltImgMap = new UnCamelMap<>();
						dltImgMap.put("ATTCH_CD", ImgMap.getString("ATTCH_CD"));
						dltImgMap.put("AS_TEMP_NO", tserviceMap.getString("AS_TEMP_NO"));
						whereColumName = new String[]{"ATTCH_CD","AS_TEMP_NO"};
						commService.tableSaveData("ASW_CS_ATTCH", dltImgMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_CS_ATTCH", dltImgMap.get("AS_TEMP_NO"), ImgAttMap, "U");
					}
				}
			}
		}
		return tserviceMap.getString("AS_TEMP_NO");
	}

	public List<?> csTimeTableList()  throws Exception {
        return csDAO.csTimeTableList();
	}


	public List<?> csTimeMpgList(UnCamelMap<String, Object> paramMap) throws Exception {
        return csDAO.csTimeMpgList(paramMap);
	}


	public Map<String,Object> csInfo(UnCamelMap<String, Object> paramMap) throws Exception {
		return csDAO.csInfo(paramMap);
	}

	public List<?> csFileList(UnCamelMap<String, Object> paramMap) throws Exception {
		return csDAO.csFileList(paramMap);
	}



	public List<?> csInfoList(UnCamelMap<String, Object> paramMap) throws Exception {
		return csDAO.csInfoList(paramMap);
	}


	public int csInfoListCount(UnCamelMap<String, Object> paramMap) {
		return csDAO.csInfoListCount(paramMap);
	}

	public List<?> itmGubunList(UnCamelMap<String, Object> paramMap)  throws Exception {
        return csDAO.itmGubunList(paramMap);
	}

}
