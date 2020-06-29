package site.mng.crm.map.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;
import egovframework.cmmn.util.CommonUtil;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("MapService")
public class MapService extends BaseService {
	/** MemberDAO */
	@Resource(name = "MapDAO")
	private MapDAO mapDAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
	protected CommService commService;

	public List<?> selectMapList(Map<String,Object> params) throws Exception {
        return mapDAO.selectMapList(params);
    }

	public void mergeStore(Map<String, Object> map) throws Exception {
		mapDAO.mergeStore(map);
	}

	public List<?> zipcodeSearchLev1() throws Exception {
        return mapDAO.zipcodeSearchLev1();
	}
	public List<?> zipcodeSearchLev2(UnCamelMap<String, Object> paramMap) throws Exception {
        return mapDAO.zipcodeSearchLev2(paramMap);
	}

	public void mapSave(UnCamelMap<String, Object> paramMap) throws Exception {
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		String[] whereColumName = null;
		String mainTransTp = "";
		if(paramMap.getString("MAP_STORE_ID").equals("")){
			paramMap.put("MAP_STORE_ID", CommonUtil.nvl(commService.getPrCode("AMS")));
			mainTransTp = "I";
		}else{
			paramMap.put("MAP_STORE_ID", paramMap.getString("MAP_STORE_ID"));
			
			commService.tableDelete("ASW_M_STORE_CATE_MPG", null, "AND MAP_STORE_ID = '"+paramMap.getString("MAP_STORE_ID")+"'");
			commService.setGdataModHis("ASW_M_STORE_CATE_MPG", paramMap.get("MAP_STORE_ID"), paramMap, "D");
			mainTransTp = "U";
		}
	
			paramMap.put("MAP_STORE_TITLE", paramMap.getString("MAP_STORE_TITLE"));
			paramMap.put("MAP_STORE_PHONE", paramMap.getString("MAP_STORE_PHONE"));
			paramMap.put("MAP_STORE_ADDR", paramMap.getString("MAP_STORE_ADDR"));
			paramMap.put("MAP_ETC", paramMap.getString("MAP_ETC"));
			paramMap.put("POINT_X", paramMap.getString("POINT_X"));
			paramMap.put("POINT_Y", paramMap.getString("POINT_Y"));
			paramMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
		
			matchingColumName.put("REG_ID", "$iui");
			matchingColumName.put("REG_DT", "$idate");
			
			
			String[] zcArr = paramMap.getArray("ADDRESS_LEV_ARR");
			if(zcArr!=null){
				UnCamelMap<String, Object> zcMap = new UnCamelMap<>();
				for(String zcArrMpg : zcArr){
					String[] zcArrMpgs = zcArrMpg.split(",");
					zcMap.put("MAP_STORE_ID", paramMap.getString("MAP_STORE_ID"));
					zcMap.put("ADDRESS_LEV_1", zcArrMpgs[0]);
					zcMap.put("ADDRESS_LEV_2", zcArrMpgs[1]);
					commService.tableSaveData("ASW_M_STORE_ZC_MPG", zcMap, null, whereColumName, null, null);
					commService.setGdataModHis("ASW_M_STORE_ZC_MPG", paramMap.get("MAP_STORE_ID"), paramMap, "I");
				}
			}
			
			String[] cateArr = paramMap.getArray("MAP_STORE_ITEM");
			if(cateArr!=null){
				UnCamelMap<String, Object> cateMap = new UnCamelMap<>();
				for(String cateArrMpg : cateArr){
					cateMap.put("MAP_STORE_ID", paramMap.getString("MAP_STORE_ID"));
					cateMap.put("BOARD_CATE_SEQ", cateArrMpg);
					commService.tableSaveData("ASW_M_STORE_CATE_MPG", cateMap, null, whereColumName, null, null);
					commService.setGdataModHis("ASW_M_STORE_ZC_MPG", paramMap.get("MAP_STORE_ID"), paramMap, "I");
				}
			}
		
		
		whereColumName = new String[]{"MAP_STORE_ID"};
		commService.tableSaveData("ASW_M_STORE_MAP", paramMap, matchingColumName, whereColumName, null, null);
		commService.setGdataModHis("ASW_M_STORE_MAP", paramMap.get("MAP_STORE_ID"), paramMap, mainTransTp);
	}

	public Map<String, String> selectMapObj(UnCamelMap<String, Object> paramMap) {
        return mapDAO.selectMapObj(paramMap);
	}

	public List<?> addressmpgList(UnCamelMap<String, Object> paramMap) {
        return mapDAO.addressmpgList(paramMap);
	}

	public List<?> storeCateList(UnCamelMap<String, Object> paramMap) {
        return mapDAO.storeCateList(paramMap);
	}

}
