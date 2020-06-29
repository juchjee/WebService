package site.mng.amM4.amM405.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("AmM405Service")
public class AmM405Service extends EgovAbstractServiceImpl implements IConstants{

	/** AmM405DAO */
	@Resource(name = "AmM405DAO")
	private AmM405DAO amM405DAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	@SuppressWarnings("unchecked")
	public void amM405Save(UnCamelMap<String, Object> param, String savePath, String[] uploadName) throws Exception {
		String transInfo = null;

		if(param.getString("POPUP_SEQ").equals("")){
			param.put("POPUP_SEQ", commService.getPrSeq("POPUP_SEQ"));
			transInfo = INSERT;
		}else{
			transInfo =UPDATE;
		}

		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		String popAttchCd = null;

		Map<String, Object> popMap = new HashMap<String, Object>();
		List<?> list = (List<?>) param.get("POP_HTML_PATH_LIST");
		if(list != null){
			popAttchCd = (String) commService.getPrCode("ATT");
			//파일정보 DB 등록
			Map<String, Object> fileMap = (Map<String, Object>) list.get(0);

			whereColumName = new String[]{"ATTCH_CD"};
			fileMap.put("ATTCH_CD", popAttchCd);
			fileMap.put("ATTCH_ID", savePath);
			commService.tableSaveData("ASW_G_ATTCH", fileMap, null, whereColumName , null, null);
			commService.setGdataModHis("ASW_G_ATTCH", param.getString("POPUP_SEQ"), fileMap, transInfo);
			fileMap.clear();
			matchingColumName.clear();
			popMap.put("ATTCH_CD", popAttchCd);
		}

		whereColumName = new String[]{"POPUP_SEQ"};
		popMap.put("POPUP_SEQ", param.getString("POPUP_SEQ"));
		popMap.put("POPUP_REG_TP_FE", param.getString("POPUP_REG_TP_FE"));
		popMap.put("POPUP_TITLE", param.getString("POPUP_TITLE"));
		popMap.put("POPUP_START_DT", param.getString("POPUP_START_DT"));
		popMap.put("POPUP_END_DT", param.getString("POPUP_END_DT"));
		popMap.put("POPUP_OPEN_TP_WLM", param.getString("POPUP_OPEN_TP_WLM"));
		popMap.put("POPUP_STATUS_YN", param.getString("POPUP_STATUS_YN"));
		popMap.put("POPUP_WIN_TOP", param.getString("POPUP_WIN_TOP"));
		popMap.put("POPUP_WIN_LEFT", param.getString("POPUP_WIN_LEFT"));
		popMap.put("POPUP_WIN_WIDTH", param.getString("POPUP_WIN_WIDTH"));
		popMap.put("POPUP_WIN_HEIGHT", param.getString("POPUP_WIN_HEIGHT"));
		popMap.put("POPUP_CONT", param.getString("POPUP_CONT"));
		if(!"".equals(param.getString("POPUP_CENTER_YES_NO"))){
			popMap.put("POPUP_CENTER_YES_NO", param.getString("POPUP_CENTER_YES_NO"));
		}
		if(!"".equals(param.getString("POPUP_CLOSE_DAY"))){
			popMap.put("POPUP_CLOSE_DAY", param.getString("POPUP_CLOSE_DAY"));
		}

		if(!"".equals(param.getString("POPUP_CLOSE_SIZE"))){
			popMap.put("POPUP_CLOSE_SIZE", param.getString("POPUP_CLOSE_SIZE"));
		}

		if(!"".equals(param.getString("POPUP_CLOSE_COLOR"))){
			popMap.put("POPUP_CLOSE_COLOR", param.getString("POPUP_CLOSE_COLOR"));
		}

		matchingColumName.put("REG_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");

		commService.tableSaveData("ASW_POPUP", popMap, matchingColumName, whereColumName , null, null);
		commService.setGdataModHis("ASW_POPUP", popMap.get("POPUP_SEQ"), popMap, transInfo);
	}

	public List<?> amM405Search(UnCamelMap<String, Object> paramMap) {
		return amM405DAO.amM405Search(paramMap);
	}

	public Object amM405View(UnCamelMap<String, Object> paramMap) {
		return amM405DAO.amM405View(paramMap);
	}
}
