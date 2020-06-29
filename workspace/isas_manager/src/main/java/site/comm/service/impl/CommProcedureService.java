package site.comm.service.impl;

import egovframework.rte.psl.dataaccess.util.CamelMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("CommProcedureService")
public class CommProcedureService extends EgovAbstractServiceImpl{

	/** CommDAO */
	@Resource(name = "CommDAO")
	private CommDAO commDAO;

	/**
	 * String Array를 Procedure이름과 Parameter로 분리하여 Map으로 리턴
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return Procedure이름과 Parameter로 분리한 Map
	 * @throws Exception
	 */
	public Map<String, Object> getMapFromArray(String... strings) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		int len = strings.length;
		String[] stringParams = new String[len - 1];
		for( int i = 0; i < len; i++){
			if(i == 0){
				params.put("commProcedureName", strings[i]);
			}else{
				stringParams[i-1] = strings[i];
			}
	    }
		params.put("commParams", stringParams);
		return params;
	}

	/**
	 * String Array를 Procedure이름과 Parameter로 분리하여 Map으로 리턴
	 * @param objects objects[0] 프로시저 이름, 그외는 param
	 * @return Procedure이름과 Parameter로 분리한 Map
	 * @throws Exception
	 */
	public Map<String, Object> getMapFromArray(Object... objects) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		int len = objects.length;
		Object[] objectArr = new Object[len - 1];
		for( int i = 0; i < len; i++){
			if(i == 0){
				params.put("commProcedureName", objects[i]);
			}else{
				objectArr[i-1] = objects[i];
			}
		}
		params.put("commParams", objectArr);
		return params;
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return List<CamelMap>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CamelMap<String, Object>> getProcedureToList(String... strings) throws Exception {
		Map<String, Object> params = getMapFromArray(strings);
		return (List<CamelMap<String, Object>>) commDAO.getProcedureToList(params);
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return List<CamelMap>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CamelMap<String, Object>> getProcedureToList(Object... objects) throws Exception {
		Map<String, Object> params = getMapFromArray(objects);
		return (List<CamelMap<String, Object>>) commDAO.getProcedureToList(params);
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return Object
	 * @throws Exception
	 */
	public Object getProcedureToObject(String... strings) throws Exception {
		Map<String, Object> params = getMapFromArray(strings);
		return commDAO.getProcedureToObject(params);
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return Object
	 * @throws Exception
	 */
	public Object getProcedureToObject(Object... objects) throws Exception {
		Map<String, Object> params = getMapFromArray(objects);
		Object obj = commDAO.getProcedureToObject(params);
		return obj;
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getProcedureToJsonObj(String... strings) throws Exception {
		Object map = getProcedureToObject(strings);
		return new JSONObject(map);
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return JSONArray
	 * @throws Exception
	 */
	public JSONArray getProcedureToJsonArray(String... strings) throws Exception {
		List<CamelMap<String, Object>> list = getProcedureToList(strings);
		return new JSONArray(list);
	}

}
