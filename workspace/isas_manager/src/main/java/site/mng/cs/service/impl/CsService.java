package site.mng.cs.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import site.comm.service.impl.CommProcedureService;
import site.comm.service.impl.CommService;
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
	
	

	public List<?> calendarList(UnCamelMap<String, Object> paramMap) throws Exception {
        return csDAO.calendarList(paramMap);
	}


	public List<?> ascodeList(UnCamelMap<String, Object> paramMap)  throws Exception {
        return csDAO.ascodeList(paramMap);
	}


	public String tserviceSave(UnCamelMap<String, Object> param) throws Exception {
		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		String MODEL = param.getString("MODEL");
		String ASCODE_LEV1 = param.getString("ASCODE_LEV1");
		String ASCODE_LEV2 = param.getString("ASCODE_LEV2");
		String COMMENT = param.getString("COMMENT");

		String MBR_MOBILE = param.getString("MBR_MOBILE");

		String MBR_ZIPCODE = param.getString("MBR_ZIPCODE");
		String MBR_ADDR = param.getString("MBR_ADDR");
		String MBR_ADDR_DTL = param.getString("MBR_ADDR_DTL");
		String BOOKING_DT = param.getString("BOOKING_DT");

		String csNo = param.getString("CS_NO");
		
		String asTempNo = param.getString("AS_TEMP_NO");
		
		String statBc = param.getString("STAT_BC");

		UnCamelMap<String, Object> tserviceMap = new UnCamelMap<>();

		tserviceMap.put("AS_TEMP_NO", asTempNo);
		tserviceMap.put("CS_NO", csNo);
		tserviceMap.put("MODEL", MODEL);
		tserviceMap.put("ASCODE_LEV1", ASCODE_LEV1);
		tserviceMap.put("ASCODE_LEV2", ASCODE_LEV2);
		tserviceMap.put("COMMENT", COMMENT);
		tserviceMap.put("BOOKING_DT", BOOKING_DT);
		tserviceMap.put("CS_TYPE", param.getString("CS_TYPE"));
		tserviceMap.put("INP_BC", param.getString("INP_BC"));
		tserviceMap.put("STAT_BC", statBc);
		tserviceMap.put("MODEL_ITEM_CD", param.getString("MODEL_ITEM_CD"));
		tserviceMap.put("CS_NM", param.getString("T_NM"));
		tserviceMap.put("TEL", param.getString("TEL"));
		tserviceMap.put("HP", MBR_MOBILE);
		tserviceMap.put("ZIP_CD", MBR_ZIPCODE);
		tserviceMap.put("ADDR", MBR_ADDR);
		tserviceMap.put("ADDR2", MBR_ADDR_DTL);
		tserviceMap.put("ITM_ID", MODEL);
		tserviceMap.put("RE_AREA", param.getString("RE_AREA"));
		tserviceMap.put("CUST_CD", param.getString("CUST_CD"));
		tserviceMap.put("AS_ADV", param.getString("AS_ADV"));
		tserviceMap.put("OEM_BC", param.getString("OEM_BC"));
		tserviceMap.put("RE_TY", param.getString("RE_TY"));
		
		if(!param.getString("CS_TIME_SEQ").equals("")){
			tserviceMap.put("CS_TIME_SEQ", param.getString("CS_TIME_SEQ"));
		}

		String asNo = "";
		
		if(!statBc.equals("0") && param.getString("AS_NO").equals("")){
			asNo = csDAO.asNoSearchForAsa200();
		}else{
			asNo = param.getString("AS_NO");
		}
		tserviceMap.put("AS_NO", asNo);
		
		whereColumName = new String[]{"AS_TEMP_NO"};
		commService.tableSaveData("ASW_CS_MST", tserviceMap, null, whereColumName , null, null);
		commService.setGdataModHis("ASW_CS_MST", tserviceMap.get("AS_TEMP_NO"), tserviceMap, "U");

		  SimpleDateFormat sdf = new SimpleDateFormat ( "yyyy-MM-dd" );
		 
		if(!statBc.equals("0")){
			Map<String, Object> asa200Map = new HashMap<>();
			asa200Map.put("as_no", asNo);
			asa200Map.put("oem_bc", param.getString("OEM_BC"));
			asa200Map.put("cs_no", csNo);
			asa200Map.put("cs_no_new", csNo);
			asa200Map.put("bs_cd", "01");
			asa200Map.put("cs_chk", "1");
			// 20190430 itm_id[품목코드]에서 itm_id_j[접수품목코드]로 변경
			// asa200Map.put("itm_id", MODEL);
			asa200Map.put("itm_id_j", MODEL);
			asa200Map.put("cs_nm", param.getString("T_NM"));
			asa200Map.put("tel", param.getString("TEL"));
			asa200Map.put("hp", MBR_MOBILE);
			asa200Map.put("zip_cd", MBR_ZIPCODE);
			asa200Map.put("addr", MBR_ADDR);
			asa200Map.put("addr2", MBR_ADDR_DTL);
			asa200Map.put("re_bc", ASCODE_LEV1);
			asa200Map.put("re2_bc", ASCODE_LEV2);
			asa200Map.put("re_nm", COMMENT);
			asa200Map.put("itm_gubun", param.getString("ITM_GUBUN"));
			asa200Map.put("re_ty", param.getString("RE_TY"));
			asa200Map.put("re_area", param.getString("RE_AREA")); 
			asa200Map.put("cust_cd", param.getString("CUST_CD")); //지정대리점
			asa200Map.put("act_dt", param.getString("BOOKING_DT")); //방문예약일자
			asa200Map.put("as_adv", param.getString("AS_ADV")); //접수상담내역
			asa200Map.put("stat_bc", statBc);
			asa200Map.put("inp_bc", param.getString("INP_BC"));
//			asa200Map.put("rec_dt", "3000-01-01");
			asa200Map.put("rec_dt", sdf.format(new Date()));
			
			matchingColumName.put("mdt", "$udate");
			matchingColumName.put("cdt", "$idate");

			whereColumName = new String[]{"as_no","oem_bc"};
			commService.tableSaveData("ASA200", asa200Map, matchingColumName, whereColumName , null, null);
			commService.setGdataModHis("ASA200", asa200Map.get("as_no"), asa200Map, "U");
			
			
			// 20200601 ryul SMS 전송 파라미터
			if(param.getString("SMS_DYN").equals("Y")){
			//if (param.getString("SMS_DYN").equals("Y") || param.getString("SMS_CYN").equals("Y")) {
			UnCamelMap<String, Object> modelInfoMap = new UnCamelMap<>();
			modelInfoMap.put("ITM_GUBUN",param.getString("ITM_GUBUN"));
			modelInfoMap.put("MODEL",param.getString("MODEL"));
//			Map<String, Object> modelInfo = csDAO.modelInfo(modelInfoMap);

			CamelMap<String, Object> modelInfo = csDAO.modelInfo(modelInfoMap);
			CamelMap<String, Object> custInfo = csDAO.custInfo(param.getString("CUST_CD"));
			

			String MBR_NM = param.getString("T_NM");

				if(custInfo != null){
					csDAO.asa200_new_work(asNo,MBR_NM,MBR_MOBILE,custInfo.getString("drvNm"),custInfo.getString("hp"));
					csDAO.asa200_new_work_cs(asNo,MBR_NM,MBR_MOBILE,param.getString("TEL"),MBR_ADDR +' '+MBR_ADDR_DTL,modelInfo.getString("itmCd"),modelInfo.getString("itmNm"),COMMENT,custInfo.getString("hp"));
				}
			
			
			//commProcedureService.getProcedureToObject("asa200_new_work",asNo,MBR_NM,MBR_MOBILE,"","","");
			//commProcedureService.getProcedureToObject("asa200_new_work_cs",asNo,MBR_NM,MBR_MOBILE,param.getString("TEL"),MBR_ADDR+" "+MBR_ADDR_DTL,modelInfo.get("itmCd"),modelInfo.get("itmNm"),COMMENT,"010-2156-6534");

			}
		}
		

		return asTempNo;
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


	public List<?> csInfoList(UnCamelMap<String, Object> paramMap) throws Exception {
		return csDAO.csInfoList(paramMap);
	}


	public int csInfoListCount(UnCamelMap<String, Object> paramMap) {
		return csDAO.csInfoListCount(paramMap);
	}


	public List<?> modelList(UnCamelMap<String, Object> paramMap) throws Exception {
        return csDAO.modelList(paramMap);
	}


	public List<?> custCdList(UnCamelMap<String, Object> paramMap) throws Exception {
        return csDAO.custCdList(paramMap);
	}


	public List<?> csFileList(UnCamelMap<String, Object> paramMap) throws Exception {
		return csDAO.csFileList(paramMap);
	}


	public List<?> itmGubunList(UnCamelMap<String, Object> paramMap) throws Exception {
		return csDAO.itmGubunList(paramMap);
	}


}
