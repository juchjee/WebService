package site.comm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

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
	 * MSSQL 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getProcedureToList(String... strings) throws Exception {
		Map<String, Object> params = getMapFromArray(strings);
		List<EgovMap> list = commDAO.getProcedureToList(params);
		return list;
	}

	/**
	 * MSSQL 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getProcedureToList(Object... objects) throws Exception {
		Map<String, Object> params = getMapFromArray(objects);
		List<EgovMap> list = commDAO.getProcedureToList(params);
		return list;
	}

	/**
	 * MSSQL 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return Object
	 * @throws Exception
	 */
	public Object getProcedureToObject(String... strings) throws Exception {
		Object obj = null;
		if(IConstants.DB_TYPE == IConstants.MSSQL){
			Map<String, Object> params = getMapFromArray(strings);
			obj = commDAO.getProcedureToObject(params);
		}else{
			Map<String, Object> params = new HashMap<String, Object>(2);
			params.put("inParam", strings[1]);
			obj = commDAO.getProcedureToObject(strings[0], params);
		}
		return obj;
	}

	/**
	 * 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return Object
	 * @throws Exception
	 */
	public Object getProcedureToObject(Object... objects) throws Exception {
		Object obj = null;
		if(IConstants.DB_TYPE == IConstants.MSSQL){
			Map<String, Object> params = getMapFromArray(objects);
			obj = commDAO.getProcedureToObject(params);
		}else{
			Map<String, Object> params = new HashMap<String, Object>(2);
			params.put("inParam", objects[1]);
			obj = commDAO.getProcedureToObject(objects[0], params);
		}
		return obj;
	}

	/**
	 * MSSQL 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject getProcedureToJsonObj(String... strings) throws Exception {
		Object map = getProcedureToObject(strings);
		return new JSONObject(map);
	}

	/**
	 * MSSQL 동적 Procedure 실행
	 * @param strings strings[0] 프로시저 이름, 그외는 param
	 * @return JSONArray
	 * @throws Exception
	 */
	public JSONArray getProcedureToJsonArray(String... strings) throws Exception {
		List<EgovMap> list = getProcedureToList(strings);
		return new JSONArray(list);
	}

}
