package site.front.repair.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import site.comm.service.impl.CommService;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Service("RepairService")
public class RepairService extends EgovAbstractServiceImpl {

	/** 공통 서비스 */
	@Resource(name = "CommService")
	protected CommService commService;

	/** ViewDAO */
	@Resource(name = "RepairDAO")
	private RepairDAO repairDAO;

	public List<?> getPartItemList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.getPartItemList(paramMap);
	}

	public List<?> repairStateList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.repairStateList(paramMap);
	}

	public int totalListCount(Map<String, Object> paramMap) throws Exception {

		return repairDAO.totalListCount(paramMap);
	}

	public Object repairStateView(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.repairStateView(paramMap);
	}

	public Object getCodeInfo(String mainCd) throws Exception {

		return repairDAO.getCodeInfo(mainCd, null);
	}

	public Object getCodeInfo(String mainCd, String subCd) throws Exception {

		return repairDAO.getCodeInfo(mainCd, subCd);
	}

	public Object ascodeList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.ascodeList(paramMap);
	}

	@SuppressWarnings("unchecked")
	public String repairSave(UnCamelMap<String, Object> param, FileUpLoad fileUpLoad, String savePath, String[] uploadName) throws Exception {

		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		String asNo = param.getString("AS_NO");
		//수리등록
		Map<String, Object> asa210Map = new HashMap<>();
		//			csNo =  mmService.selectMaxMbrSeq();

		asa210Map.put("as_no", asNo);
		asa210Map.put("req_dt", sdf.format(new Date()));
		asa210Map.put("oem_bc", param.getString("OEM_BC"));
		asa210Map.put("lot_no", param.getString("LOT_NO"));
		asa210Map.put("buy_dt", param.getString("BUY_DT") + "-01");
		asa210Map.put("as_ty", param.getString("AS_TY"));
		asa210Map.put("as1_bc", param.getString("AS1BC"));
		asa210Map.put("as2_bc", param.getString("AS2BC"));
		asa210Map.put("act_bc", param.getString("ACT_BC"));
		asa210Map.put("amt_ty", param.getString("AMT_TY"));

		asa210Map.put("rep_amt", param.getString("REP_AMT"));
		asa210Map.put("bt_amt", param.getString("BT_AMT"));
		asa210Map.put("ins_amt", param.getString("INS_AMT"));

		// 지역 출장비 추가 - ksh 2018.06.11
		asa210Map.put("reg_amt", param.getString("REG_AMT"));

		asa210Map.put("rmks", param.getString("RMKS"));
		asa210Map.put("part_bc", param.getString("PART_BC"));
		asa210Map.put("part2_bc", param.getString("PART_BC2"));

		asa210Map.put("rmks", param.getString("RMKS"));

		asa210Map.put("drv_no", param.getString("DRV_NO"));
		asa210Map.put("req_yn", "1");

		SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		asa210Map.put("cid", param.getString("DRV_NO"));
		matchingColumName.put("cdt", "$idate");
		asa210Map.put("mid", param.getString("DRV_NO"));
		asa210Map.put("mdt", today.format(new Date()));

		whereColumName = new String[] { "as_no", "oem_bc" };
		commService.tableSaveData("asa210", asa210Map, matchingColumName, whereColumName, null, null);
		commService.setGdataModHis("asa210", asa210Map.get("as_no"), asa210Map, "I");
		matchingColumName.clear();

		UnCamelMap<String, Object> asSignMap = new UnCamelMap<>();

		asSignMap.put("AS_NO", asNo);
		asSignMap.put("AS_SIGN", param.getString("SIGN_DATA"));

		whereColumName = new String[] { "AS_NO" };
		commService.tableSaveData("ASW_AS_SIGN", asSignMap, null, whereColumName, null, null);
		commService.setGdataModHis("ASW_AS_SIGN", asSignMap.get("AS_NO"), asSignMap, "I");

		//자제등록
		if (param.getArray("ITM_CID") != null) {
			String[] itmCidArr = param.getArray("ITM_CID");

			commService.tableDelete("ASA220", null, "and as_no ='" + asNo + "' and oem_bc ='" + param.getString("OEM_BC") + "'");

			for (int i = 0; i < itmCidArr.length; i++) {
				Map<String, Object> addInfoMap = new HashMap<>();

				addInfoMap.put("as_no", asNo);

				addInfoMap.put("req_dt", sdf.format(new Date()));
				addInfoMap.put("oem_bc", param.getString("OEM_BC"));
				addInfoMap.put("itm_id", itmCidArr[i]);
				//					addInfoMap.put("itm_id", 0);
				addInfoMap.put("amt_ty", param.getString("AMT_TY"));
				addInfoMap.put("qty", param.getString("EA" + itmCidArr[i]));
				//20191107 김경률 기존에 화면에 있는 소비자가가 ASA220 테이블에 cust_amt로 들어갔는데 이건 대리점가이므로 두개가 서로 바뀜
				//해당 부분을 다시 바꾸어서 저장하도록 소스 수정
				//addInfoMap.put("cust_amt", param.getString("CS_UP" + itmCidArr[i]));
				//addInfoMap.put("cs_amt", param.getString("UP" + itmCidArr[i]));
				addInfoMap.put("cs_amt", param.getString("CS_UP" + itmCidArr[i]));
				addInfoMap.put("cust_amt", param.getString("UP" + itmCidArr[i]));
				//					addInfoMap.put("out_no", null);
				//					addInfoMap.put("out_sq", null);
				addInfoMap.put("sq_no", "(select (isnull(MAX(sq_no),0))+1 FROM ASA220 where as_no ='" + asNo + "'and oem_bc ='" + param.getString("OEM_BC") + "')");

				commService.tableInatall("ASA220", addInfoMap, null, null);
				addInfoMap.put("sq_no", "");
				commService.setGdataModHis("ASA220", asNo, addInfoMap, "I");

				addInfoMap.clear();
			}
		}

		if (param.get("DTL_IMG_PATH_LIST") != null) {
			int[] imageArr = new int[] { 500000 }; //사진크기조절 픽셀
			List<?> list = (List<?>) param.get("DTL_IMG_PATH_LIST");

			commService.tableDelete("ASW_AS_ATTCH", null, "and AS_NO ='" + asNo + "'");
			for (int i = 0; i < list.size(); i++) {
				Map<String, String> fileMap = (Map<String, String>) list.get(i);
				List<UnCamelMap<String, Object>> fileMaplist = fileUpLoad.setImageSize(fileMap, imageArr);
				if (imageArr.length > 0) {
					for (UnCamelMap<String, Object> ImgAttMap : fileMaplist) {
						UnCamelMap<String, Object> ImgMap = new UnCamelMap<>();
						ImgMap.put("ATTCH_CD", CommonUtil.nvl(commService.getPrCodMany("ASA")));
						ImgMap.put("ATTCH_ID", savePath);
						ImgMap.put("ATTCH_FILE_NM", ImgAttMap.get("ATTCH_FILE_NM"));
						ImgMap.put("ATTCH_REAL_FILE_NM", ImgAttMap.get("ATTCH_REAL_FILE_NM"));
						ImgMap.put("ATTCH_FILE_PATH", ImgAttMap.get("ATTCH_FILE_PATH"));
						ImgMap.put("ATTCH_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_ABSOLUTE_PATH"));
						ImgMap.put("ATTCH_REAL_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
						whereColumName = new String[] { "ATTCH_CD" };
						commService.tableSaveData("ASW_G_ATTCH", ImgMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_G_ATTCH", ImgMap.getString("ATTCH_CD"), ImgMap, "U");
						UnCamelMap<String, Object> dltImgMap = new UnCamelMap<>();
						dltImgMap.put("ATTCH_CD", ImgMap.getString("ATTCH_CD"));
						dltImgMap.put("AS_NO", asNo);
						whereColumName = new String[] { "ATTCH_CD", "AS_NO" };
						commService.tableSaveData("ASW_AS_ATTCH", dltImgMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_AS_ATTCH", dltImgMap.get("AS_NO"), ImgAttMap, "U");
					}
				}
			}
		}

		Map<String, Object> asa200Map = new HashMap<>();
		asa200Map.put("as_no", asNo);
		asa200Map.put("drv_no", param.getString("DRV_NO"));
		asa200Map.put("stat_bc", param.getString("STAT_BC"));
		asa200Map.put("act_dt", param.getString("ACT_DT"));
		asa200Map.put("itm_id", param.getString("MODEL"));		//20190509 모델이 등록되면 품목코드로 그대로 입력진행
		//asa200Map.put("itm_id_j", param.getString("MODEL"));	//20190507 품목코드는 접수품목코드로 변경 - 변경없음
		asa200Map.put("itm_gubun", param.getString("ITM_GUBUN"));

		asa200Map.put("mid", param.getString("DRV_NO"));
		matchingColumName.put("mdt", "$udate");

		whereColumName = new String[] { "as_no" };
		commService.tableSaveData("ASA200", asa200Map, matchingColumName, whereColumName, null, null);
		commService.setGdataModHis("ASA200", asa200Map.get("as_no"), asa200Map, "U");

		if (asNo.startsWith("APP")) {
			Map<String, Object> tserviceMap = new HashMap<>();
			tserviceMap.put("AS_NO", asNo);
			tserviceMap.put("STAT_BC", param.getString("STAT_BC"));
			tserviceMap.put("BOOKING_DT", param.getString("ACT_DT"));

			whereColumName = new String[] { "AS_NO" };
			commService.tableSaveData("ASW_CS_MST", tserviceMap, null, whereColumName, null, null);
			commService.setGdataModHis("ASW_CS_MST", tserviceMap.get("AS_NO"), tserviceMap, "I");
		}
		//		}

		return asNo;
	}

	@SuppressWarnings("unchecked")
	public String installSave(UnCamelMap<String, Object> param, FileUpLoad fileUpLoad, String savePath, String[] uploadName) throws Exception {

		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		String insNo = param.getString("INS_NO");
		//수리등록
		Map<String, Object> asa415Map = new HashMap<>();
		//			csNo =  mmService.selectMaxMbrSeq();

		asa415Map.put("ins_no", insNo);
		asa415Map.put("ins_number", param.getString("INS_NUMBER"));
		asa415Map.put("ins_ym", param.getString("INS_YM"));
		asa415Map.put("ins_ymd", param.getString("INS_YMD"));
		asa415Map.put("ins_state_cd", param.getString("INS_STATE_CD"));

		asa415Map.put("rmks", param.getString("RMKS"));

		whereColumName = new String[] { "ins_no" };
		commService.tableSaveData("asa415", asa415Map, matchingColumName, whereColumName, null, null);
		commService.setGdataModHis("asa415", asa415Map.get("ins_no"), asa415Map, "I");
		matchingColumName.clear();

		if (!param.getString("SIGN_DATA").equals("")) {
			UnCamelMap<String, Object> asSignMap = new UnCamelMap<>();

			asSignMap.put("AS_NO", insNo);
			asSignMap.put("AS_SIGN", param.getString("SIGN_DATA"));

			whereColumName = new String[] { "AS_NO" };
			commService.tableSaveData("ASW_AS_SIGN", asSignMap, null, whereColumName, null, null);
			commService.setGdataModHis("ASW_AS_SIGN", asSignMap.get("AS_NO"), asSignMap, "I");
		}

		if (param.get("DTL_IMG_PATH_LIST") != null) {
			int[] imageArr = new int[] { 500000 }; //사진크기조절 픽셀
			List<?> list = (List<?>) param.get("DTL_IMG_PATH_LIST");

			commService.tableDelete("ASW_AS_ATTCH", null, "and AS_NO ='" + insNo + "'");
			for (int i = 0; i < list.size(); i++) {
				Map<String, String> fileMap = (Map<String, String>) list.get(i);
				List<UnCamelMap<String, Object>> fileMaplist = fileUpLoad.setImageSize(fileMap, imageArr);
				if (imageArr.length > 0) {
					for (UnCamelMap<String, Object> ImgAttMap : fileMaplist) {
						UnCamelMap<String, Object> ImgMap = new UnCamelMap<>();
						ImgMap.put("ATTCH_CD", CommonUtil.nvl(commService.getPrCodMany("ASA")));
						ImgMap.put("ATTCH_ID", savePath);
						ImgMap.put("ATTCH_FILE_NM", ImgAttMap.get("ATTCH_FILE_NM"));
						ImgMap.put("ATTCH_REAL_FILE_NM", ImgAttMap.get("ATTCH_REAL_FILE_NM"));
						ImgMap.put("ATTCH_FILE_PATH", ImgAttMap.get("ATTCH_FILE_PATH"));
						ImgMap.put("ATTCH_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_ABSOLUTE_PATH"));
						ImgMap.put("ATTCH_REAL_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
						whereColumName = new String[] { "ATTCH_CD" };
						commService.tableSaveData("ASW_G_ATTCH", ImgMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_G_ATTCH", ImgMap.getString("ATTCH_CD"), ImgMap, "U");
						UnCamelMap<String, Object> dltImgMap = new UnCamelMap<>();
						dltImgMap.put("ATTCH_CD", ImgMap.getString("ATTCH_CD"));
						dltImgMap.put("AS_NO", insNo);
						whereColumName = new String[] { "ATTCH_CD", "AS_NO" };
						commService.tableSaveData("ASW_AS_ATTCH", dltImgMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_AS_ATTCH", dltImgMap.get("AS_NO"), ImgAttMap, "U");
					}
				}
			}
		}

		return insNo;
	}

	public List<?> repairStateFinishList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.repairStateFinishList(paramMap);
	}

	public int repairStateFinishListCount(Map<String, Object> paramMap) throws Exception {

		return repairDAO.repairStateFinishListCount(paramMap);
	}

	public List<?> handlingList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.handlingList(paramMap);
	}

	public int handlingListCount(Map<String, Object> paramMap) throws Exception {

		return repairDAO.handlingListCount(paramMap);
	}

	public List<?> repairPartList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.repairPartList(paramMap);
	}

	public List<?> repairFileList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.repairFileList(paramMap);
	}

	public Object asSign(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.asSign(paramMap);
	}

	public List<?> repairStateHistoyList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.repairStateHistoyList(paramMap);
	}

	public int repairStateHistoyListCount(Map<String, Object> params) throws Exception {

		return repairDAO.repairStateHistoyListCount(params);
	}

	public String repairThisHistoyNm(Map<String, Object> params) throws Exception {

		return repairDAO.repairThisHistoyNm(params);
	}

	public List<?> installAcceptList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.installAcceptList(paramMap);
	}

	public Object installAcceptView(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.installAcceptView(paramMap);
	}

	public int installAcceptListCount(Map<String, Object> params) throws Exception {

		return repairDAO.installAcceptListCount(params);
	}

	public String getAsz120Pay(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.getAsz120Pay(paramMap);
	}

	public String getActDt(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.getActDt(paramMap);
	}

	public List<?> modelList(UnCamelMap<String, Object> paramMap) throws Exception {

		return repairDAO.modelList(paramMap);
	}

	public List<?> itmList(UnCamelMap<String, Object> paramMap) throws Exception {
		return repairDAO.itmList(paramMap);
	}

	public String smsSend(UnCamelMap<String, Object> paramMap) {

		try {
			repairDAO.smsSend(paramMap);

			return "OK";
		}
		catch (Exception e) {
			return "NG";
		}
	}

}
