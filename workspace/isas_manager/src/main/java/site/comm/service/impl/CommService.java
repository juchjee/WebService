package site.comm.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.ExcelFileParser;
import egovframework.cmmn.util.ExcelUtil;
import egovframework.cmmn.util.Net;
import egovframework.cmmn.vo.MatchingVO;
import egovframework.cmmn.vo.TableColumnVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

/**
 * 공통 Service
 * @author vary
 *
 */
@Service("CommService")
public class CommService extends EgovAbstractServiceImpl{

	protected static final Logger logger = LoggerFactory.getLogger("CommService");

	/** 공통 Procedure 서비스 */
	@Resource(name = "CommProcedureService")
	protected CommProcedureService commProcedureService;


	/** CommDAO */
	@Resource(name = "CommDAO")
	private CommDAO commDAO;

	/**
	 * 데이터 베이스의 오늘 날짜를 가지고 온다
	 * @return Object
	 * @throws Exception
	 */
	public String getToday() throws Exception{
		return CommonUtil.nvl(commDAO.getToday());
	}

	/**
	 * 해댱 권한에 대한 Menu Category list를 가지고 온다
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public List<?> getCategoryList(String key) throws Exception{
    	return CommStatic.getCategoryList(key, commDAO);
    }

	public void getResetCategoryList() throws Exception{
		CommStatic.getResetCategoryList();
	}

	/**
     * 외부 연동 키를 가지고 온다
     * @param key
     * @param value
     * @return
     * @throws Exception
     */
    public CamelMap<String, Object> getGSiteCode(String key, String value) throws Exception{
    	Map<String, Object> params = new HashMap<String, Object>();
    	params.put(key, value);
    	return commDAO.getGSiteCode(params);
    }

	/**
     * Create getMaxNumber
     * @param TABLE_NM
     * @param COLUMN_NM
     * @param WHERE
     * @return
     * @throws Exception
     */
    public Object getMaxNumbers(String tableNm, String columnNm, String strWhereQuery) throws Exception{
    	HashMap<String, Object> params = new HashMap<String, Object>();
    	params.put("commTableNm", tableNm);
    	params.put("commColumnNm", columnNm);
    	params.put("commWhere", strWhereQuery);
    	return commDAO.getMaxNumber(params);
    }

    public void downLoadXlsFile(HttpServletResponse response, Map<String, Object> params) throws Exception {
		String excelName = CommonUtil.nvlStrArrVal(params.get("EXCEL_NAME"), 0);
		if("".equals(excelName)){
   			excelName = "ExelFile";
   		}
		String[] header = CommonUtil.nvlStrArrVal(params.get("COL_TEXTS"), 0).split("▤");
		String[] colNames = CommonUtil.nvlStrArrVal(params.get("COL_NAMES"), 0).split("▤");
		String[] colTypes = CommonUtil.nvlStrArrVal(params.get("COL_TYPES"), 0).split("▤");
		String[] cellsFormats = CommonUtil.nvlStrArrVal(params.get("CELLS_FORMATS"), 0).split("▤", colNames.length);
		String[] content = CommonUtil.nvlStrArrVal(params.get("CONTENT"), 0).split("▥");

		if(content != null){
			for(int i=0;i<content.length;i++){
				content[i] = CommonUtil.getHtmlStrCnvr(content[i]);
			}
		}

		String[] cellSaligns = CommonUtil.nvlStrArrVal(params.get("CELL_SALIGN"), 0).split("▤");//Horizontal
		ExcelUtil excelUtil = new ExcelUtil(excelName, header, colNames, colTypes);
		excelUtil.createTitle();
		excelUtil.createHeader();
		excelUtil.createContent(content, cellSaligns, cellsFormats);
		excelUtil.outExcel(response);
   	}

    /**
	 * ※ 엑셀파일 업로드

	 * @param paramMap(Map<String, Object>): setAttachFlieUpload(파일업로드)메소드 호출 이후 리턴되는 파라미터 데이터
	 * @param uploadName(String) : input type file 객체의 name
	 * @param tableName(String) : table 이름
	 * @param whereColumName(String[]) : where의 조건 컬럼 이름, 값은 엑셀파일의 컬럼명에 해당하는 cell값을 참조 한다.
     * @return
	 */
	public List<Map<String, List<?>>> upLoadXlsFile(Map<String, Object> paramMap, String uploadName) throws Exception{
		ExcelFileParser excelFileParser = new ExcelFileParser(paramMap, uploadName);
		return excelFileParser.xmlParsing();
	}

    /**
	 * @설명 : 해당 테이블의 컬럼 목록을 반환
	 * @param commTableNm
	 * @return
     * @throws Exception
	 */
	public List<?> getTableList(String tableNm, Map<String, Object> whereMap, String strQuery) throws Exception{
		Map<String, Object> whereParam = new HashMap<String, Object>();
    	List<Map<String, Object>> whereColumList = null;
    	if (whereMap != null && whereMap.size() > 0) {
    		whereColumList = new ArrayList<Map<String, Object>>();
    		for( Map.Entry<String, Object> elem : whereMap.entrySet()){
    			Map<String, Object> itemParam = new HashMap<String, Object>();
    			itemParam.put("name", elem.getKey());
    			itemParam.put("value", elem.getValue());
    			whereColumList.add(itemParam);
    		}
		}
		if(CommonUtil.getSize(whereColumList) > 0){
    		whereParam.put("whereColumList", whereColumList);
    	}
		if(!"".equals(CommonUtil.nvl(strQuery))){
			whereParam.put("strQuery", strQuery);
    	}
		return commDAO.getTableList(tableNm, whereParam);
	}

	/**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramList 데이터가 들어 있는 List
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, List<Map<String, Object>> paramList, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery) throws Exception{
    	tableSaveData(commTableNm, paramList, matchingColumName, whereColumName, whereValueParamMapName, strQuery, "null");
    }

    /**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramList 데이터가 들어 있는 List
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @param strNull NULL 대신 쓸 값
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, List<Map<String, Object>> paramList, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery, String strNull) throws Exception{
    	tableSaveData(commTableNm, paramList, matchingColumName, whereColumName, whereValueParamMapName, strQuery,strNull, false);
    }

    /**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramList 데이터가 들어 있는 List
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @param strNull NULL 대신 쓸 값
     * @param deleteFlag 로우가 존재할 경우 지울지 업데이트를 할지 여부
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, List<Map<String, Object>> paramList, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery, String strNull, boolean deleteFlag) throws Exception{
    	if(CommonUtil.getSize(paramList) == 0) return;
    	for(Map<String, Object> paramMap : paramList){
    		int count = 0;
    		Map<String, Object> whereParam = null;
        	List<Map<String, Object>> whereColumList = null;
        	if(whereColumName != null && whereColumName.length > 0){
        		whereColumList = new ArrayList<Map<String, Object>>();
        		whereParam = new HashMap<String, Object>();
        		for (int i = 0, _Len = whereColumName.length; i < _Len; i++) {
        			Map<String, Object> itemParam = new HashMap<String, Object>();
        			itemParam.put("name", whereColumName[i]);
        			if(whereValueParamMapName == null){
        				itemParam.put("value", paramMap.get(whereColumName[i]));
        			}else{
        				String tempValue = CommonUtil.nvl(whereValueParamMapName.get(whereColumName[i]));
        				if("".equals(tempValue)){
        					itemParam.put("value", paramMap.get(whereColumName[i]));
        				}else{
        					itemParam.put("value", paramMap.get(tempValue));
        				}
        			}
        			whereColumList.add(itemParam);
    			}
        	}
        	if(whereParam != null){
        		if(CommonUtil.getSize(whereColumList) > 0){
            		whereParam.put("whereColumList", whereColumList);
            	}
        		if(strQuery != null && !"".equals(strQuery)){
        			whereParam.put("strQuery", strQuery);
            	}
        	}else if(strQuery != null && !"".equals(strQuery)){
        		whereParam = new HashMap<String, Object>();
        		whereParam.put("strQuery", strQuery);
        	}
        	if(whereParam != null){
        		count = getRowCount(commTableNm, whereParam);
        	}
        	if(count == 0){
        		tableInatall(commTableNm, paramMap, matchingColumName, strNull);
        	}else if(count > 0){
        		Map<String, Object> matchingColumNameRe = null;
        		if(matchingColumName != null){
        			matchingColumNameRe = new HashMap<String, Object>();
        			for(Entry<String, Object> entry:matchingColumName.entrySet()){
        				if("$udate".equals(entry.getValue()) || "$idate".equals(entry.getValue()) || "$iui".equals(entry.getValue()) || "$uui".equals(entry.getValue())){
        					matchingColumNameRe.put(entry.getKey(), entry.getValue());
        				}else{
        					matchingColumNameRe.put(CommonUtil.nvl(entry.getValue()), entry.getKey());
        				}
        			}
        		}
        		if(deleteFlag == false){
        			tableUpdate(commTableNm, paramMap, matchingColumNameRe, whereColumList, strQuery, strNull);
        		}else if(deleteFlag == true){
        			tableDelete(commTableNm,whereColumList, strQuery);
        		}
        	}
		}
    }

    /**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramMap 데이터가 들어 있는 Map
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @param strNull NULL 대신 쓸 값
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery) throws Exception{
    	tableSaveData(commTableNm, paramMap, matchingColumName, whereColumName, whereValueParamMapName, strQuery, "null");
    }

    public void tableSaveData(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName) throws Exception{
    	tableSaveData(commTableNm, paramMap, matchingColumName, whereColumName, whereValueParamMapName, null, "null");
    }

    public void tableSaveData(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
    		String[] whereColumName) throws Exception{
    	tableSaveData(commTableNm, paramMap, matchingColumName, whereColumName, null, null, "null");
    }

    /**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramMap 데이터가 들어 있는 Map
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @param strNull NULL 대신 쓸 값
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery, String strNull) throws Exception{
    	tableSaveData(commTableNm, paramMap, matchingColumName, whereColumName, whereValueParamMapName, strQuery,strNull, false);
	}

    /**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramMap 데이터가 들어 있는 Map
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @param deleteFlag 로우가 존재할 경우 지울지 업데이트를 할지 여부
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery,  boolean deleteFlag) throws Exception{
		tableSaveData(commTableNm, paramMap, matchingColumName, whereColumName, whereValueParamMapName, strQuery,"null", deleteFlag);
	}

    /**
     * 디비 테이블에 동적 insert or update
     * @param commTableNm table 이름
     * @param paramMap 데이터가 들어 있는 Map
     * @param matchingColumName {컬럼이름 : $idate, 컬럼이름 : $udate} 이면 GETDATE()로 값을 넣는다. $idate는 인서트일때, $udate는 업데이트일때
     * 		  컬럼이름 : input name과 같으면 머지를 한다. 컬럼이름 : $iui, 컬럼이름 : $uui는 로그인한 사람의 아이디를 넣는다. $iui는 인서트일때, $uui는 업데이트일때
     * @param whereColumName where의 조건 컬럼 이름, 값은 paramMap을 참조 한다.
     * 		  paramMap key 와 조건 컬럼 이름이 일치하지 않을 경우 컬럼이름 paramMap key를 whereValueParamMapName에 넣어주면 된다.
     * @param whereValueParamMapName 조건절 커스텀 쿼리 {컬럼이름 : parmamMap의 key}
     * @param strQuery 조건절 커스텀 쿼리
     * @param strNull NULL 대신 쓸 값
     * @param deleteFlag 로우가 존재할 경우 지울지 업데이트를 할지 여부
     * @throws Exception
     */
    public void tableSaveData(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
    		String[] whereColumName, Map<String, Object> whereValueParamMapName, String strQuery, String strNull, boolean deleteFlag) throws Exception{
    	int count = 0;
    	Map<String, Object> whereParam = null;
    	List<Map<String, Object>> whereColumList = null;
    	if(whereColumName != null && whereColumName.length > 0){
    		whereColumList = new ArrayList<Map<String, Object>>();
    		whereParam = new HashMap<String, Object>();
    		for (int i = 0, _Len = whereColumName.length; i < _Len; i++) {
    			Map<String, Object> itemParam = new HashMap<String, Object>();
    			itemParam.put("name", whereColumName[i]);
    			if(whereValueParamMapName == null){
    				itemParam.put("value", paramMap.get(whereColumName[i]));
    			}else{
    				String tempValue = CommonUtil.nvl(whereValueParamMapName.get(whereColumName[i]));
    				if("".equals(tempValue)){
    					itemParam.put("value", paramMap.get(whereColumName[i]));
    				}else{
    					itemParam.put("value", paramMap.get(tempValue));
    				}
    			}
    			whereColumList.add(itemParam);
			}
    	}
    	if(whereParam != null){
    		if(CommonUtil.getSize(whereColumList) > 0){
        		whereParam.put("whereColumList", whereColumList);
        	}
    		if(strQuery != null && !"".equals(strQuery)){
    			whereParam.put("strQuery", strQuery);
        	}
    	}else if(strQuery != null && !"".equals(strQuery)){
    		whereParam = new HashMap<String, Object>();
    		whereParam.put("strQuery", strQuery);
    	}
    	if(whereParam != null){
    		count = getRowCount(commTableNm, whereParam);
    	}
    	if(count == 0){
    		tableInatall(commTableNm, paramMap, matchingColumName, strNull);
    	}else if(count > 0){
    		Map<String, Object> matchingColumNameRe = null;
    		if(matchingColumName != null){
    			matchingColumNameRe = new HashMap<String, Object>();
    			for(Entry<String, Object> entry : matchingColumName.entrySet()){
    				if("$udate".equals(entry.getValue()) || "$idate".equals(entry.getValue()) || "$iui".equals(entry.getValue()) || "$uui".equals(entry.getValue())){
    					matchingColumNameRe.put(entry.getKey(), entry.getValue());
    				}else{
    					matchingColumNameRe.put(CommonUtil.nvl(entry.getValue()), entry.getKey());
    				}
    			}
    		}
    		if(deleteFlag == false){
    			tableUpdate(commTableNm, paramMap, matchingColumNameRe, whereColumList, strQuery, strNull);
    		}else if(deleteFlag == true){
    			tableDelete(commTableNm, whereColumList, strQuery);
    		}
    	}
    }

    public int tableUpdate(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName,
    		List<Map<String, Object>> whereColumList, String strQuery, String strNull) throws Exception{
    	HashMap<String, TableColumnVO> matchingColumMap = new HashMap<String, TableColumnVO>();
    	for (TableColumnVO tableColumnVO : getTableColumnList(commTableNm)) {
    		matchingColumMap.put(tableColumnVO.getNAME(), tableColumnVO);
		}
    	List<MatchingVO> matchingList = new ArrayList<MatchingVO>();
    	for(Entry<String, Object> entry:paramMap.entrySet()){
    		TableColumnVO tableColumnVO = matchingColumMap.get(entry.getKey());
    		if(tableColumnVO == null){
    			if(matchingColumName != null){
    				if(matchingColumName.containsKey(entry.getKey())){
    					String nextValue = CommonUtil.nvl(matchingColumName.get(entry.getKey()));
    					tableColumnVO = matchingColumMap.get(nextValue);
    					if(tableColumnVO != null){
    						String _value = CommonUtil.nvl(entry.getValue());
    						if("$udate".equals(_value) || "$idate".equals(_value) || "$uui".equals(_value) || "$iui".equals(_value)){
    	    					continue;
    	    				}else{
    	    					MatchingVO tempMatchingVO = new MatchingVO();
    							Object tempValue = paramMap.get(entry.getKey());
    							tempMatchingVO.setName(nextValue);
    							if(tempValue == null || "".equals(tempValue)){
    								if(tableColumnVO.getTYPE() == TableColumnVO.STRING){
    									tempMatchingVO.setValue(strNull);
    								}else if(tableColumnVO.getTYPE() == TableColumnVO.DATE){
    									tempMatchingVO.setValue(strNull);
    								}else if(tableColumnVO.getTYPE() == TableColumnVO.NUMBER){
    									if(tempValue == null || "".equals(tempValue)){
    										tempMatchingVO.setValue(0);
    									}else{
    										tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
    									}
    								}else{
    									tempMatchingVO.setValue("null");
    								}
    							}else{
    								if(tableColumnVO.getTYPE() == TableColumnVO.STRING || tableColumnVO.getTYPE() == TableColumnVO.DATE){
    									tempMatchingVO.setValue("'" + tempValue + "'");
    								}else if(tableColumnVO.getTYPE() == TableColumnVO.NUMBER){
    									if(tempValue == null || "".equals(tempValue)){
    										tempMatchingVO.setValue(0);
    									}else{
    										tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
    									}
    								}else{
    									if(tempValue == null || "".equals(tempValue)){
    										tempMatchingVO.setValue("null");
    									}else{
    										tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
    									}
    								}
    							}
    							matchingList.add(tempMatchingVO);
    						}
    					}
    				}
    			}
    		}else{
    			MatchingVO tempMatchingVO = new MatchingVO();
    			tempMatchingVO.setName(entry.getKey());
    			Object tempValue = entry.getValue();
    			if(tableColumnVO.getTYPE() == TableColumnVO.STRING){
    				if(tempValue == null || "null".equals(tempValue) || "".equals(tempValue)){
    					tempMatchingVO.setValue(strNull);
    				}else{
    					tempMatchingVO.setValue("'" + tempValue + "'");
    				}
    			}else if(tableColumnVO.getTYPE() ==  TableColumnVO.DATE){
    				if(tempValue == null || "".equals(tempValue)){
    					tempMatchingVO.setValue(strNull);
    				}else{
    					tempMatchingVO.setValue("'" + tempValue + "'");
    				}
    			}else if(tableColumnVO.getTYPE() == TableColumnVO.NUMBER){
					if(tempValue == null || "".equals(tempValue)){
						tempMatchingVO.setValue(0);
					}else{
						tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
					}
				}else{
					if(tempValue == null || "".equals(tempValue)){
						tempMatchingVO.setValue("null");
					}else{
						tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
					}
				}
    			matchingList.add(tempMatchingVO);
    		}
    	}
    	matchingColumNameChk(matchingColumName, matchingList, "'" + EgovUserDetailsHelper.getAdmId() + "'", "$u");
    	int lSize = matchingList.size();
    	Map<String, Object> newParams = new HashMap<String, Object>();
    	newParams.put("commTableNm", commTableNm);
    	if(lSize <= 0){
    		return -1;
    	}else{
    		List<Map<String, Object>> columList = new ArrayList<Map<String,Object>>();
    		for(MatchingVO matchingVO : matchingList){
    			Map<String, Object> tempMap = new HashMap<String, Object>();
    			tempMap.put("name", matchingVO.getName());
    			tempMap.put("value", matchingVO.getValue());
    			columList.add(tempMap);
			}
    		newParams.put("columList", columList);
    		newParams.put("whereColumList", whereColumList);
    		newParams.put("strQuery", strQuery);
    		return commDAO.tableUpdate(newParams);
    	}
    }

    public void tableDelete(String commTableNm, List<Map<String, Object>> whereColumList, String strQuery) throws Exception{
    	Map<String, Object> newParams = new HashMap<String, Object>();
    	newParams.put("commTableNm", commTableNm);
    		newParams.put("whereColumList", whereColumList);
    		newParams.put("strQuery", strQuery);
    		commDAO.tableDelete(newParams);
    }

    public void tableInatall(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName) throws Exception{
    	tableInatall(commTableNm, paramMap, matchingColumName, null);
    }

    public void tableInatall(String commTableNm, Map<String, Object> paramMap, Map<String, Object> matchingColumName, String strNull) throws Exception{
    	List<MatchingVO> matchingList = new ArrayList<MatchingVO>();
    	for (TableColumnVO tcvo : getTableColumnList(commTableNm)) {
    		String tempValue = CommonUtil.nvlTrim(paramMap.get(tcvo.getNAME()));
			//if(!"".equals(tempValue)){
			if(paramMap.get(tcvo.getNAME()) == null){
				if(matchingColumName != null){
					if(matchingColumName.containsKey(tcvo.getNAME())){
						Object nextValue = matchingColumName.get(tcvo.getNAME());
						if("$udate".equals(nextValue) || "$idate".equals(nextValue) || "$uui".equals(nextValue) || "$iui".equals(nextValue)){
	    					continue;
	    				}else{
							tempValue = CommonUtil.nvlTrim(paramMap.get(nextValue));
							if(paramMap.get(nextValue) != null){
								MatchingVO tempMatchingVO = new MatchingVO();
								tempMatchingVO.setName(tcvo.getNAME());
								if (tempValue instanceof String) {
									if("".equals(tempValue)){
										tempMatchingVO.setValue(strNull);
									}else{
										tempMatchingVO.setValue("'" + tempValue + "'");
									}
								}else{
									tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
								}
								matchingList.add(tempMatchingVO);
							}else if("NO".equals(tcvo.getISNULL()) && tcvo.getDEFAULTVAL() == null){
								MatchingVO tempMatchingVO = new MatchingVO();
								tempMatchingVO.setName(tcvo.getNAME());
								if(tcvo.getTYPE() == TableColumnVO.STRING ){
									tempMatchingVO.setValue(strNull);
								}else if(tcvo.getTYPE() == TableColumnVO.DATE){
									if(IConstants.DB_TYPE == IConstants.MSSQL) tempMatchingVO.setValue("GETDATE()");
									else tempMatchingVO.setValue("SYSDATE");
								}else if(tcvo.getTYPE() == TableColumnVO.NUMBER){
									tempMatchingVO.setValue(0);
								}else{
									tempMatchingVO.setValue("null");
								}
							}
						}
					}
				}else if("NO".equals(tcvo.getISNULL()) && tcvo.getDEFAULTVAL() == null){
					MatchingVO tempMatchingVO = new MatchingVO();
					tempMatchingVO.setName(tcvo.getNAME());
					if(tcvo.getTYPE() == TableColumnVO.STRING ){
						tempMatchingVO.setValue(strNull);
					}else if(tcvo.getTYPE() == TableColumnVO.DATE){
						if(IConstants.DB_TYPE == IConstants.MSSQL) tempMatchingVO.setValue("GETDATE()");
						else tempMatchingVO.setValue("SYSDATE");
					}else if(tcvo.getTYPE() == TableColumnVO.NUMBER){
						tempMatchingVO.setValue(0);
					}else{
						tempMatchingVO.setValue("null");
					}
				}
			}else{
				MatchingVO tempMatchingVO = new MatchingVO();
				tempMatchingVO.setName(tcvo.getNAME());
				if(tcvo.getTYPE() == TableColumnVO.STRING || tcvo.getTYPE() == TableColumnVO.DATE){
					if(tempValue == null || "".equals(tempValue)){
    					tempMatchingVO.setValue(strNull);
    				}else{
    					tempMatchingVO.setValue("'" + tempValue + "'");
    				}
				}else if(tcvo.getTYPE() == TableColumnVO.NUMBER){
					if(tempValue == null || "".equals(tempValue)){
						tempMatchingVO.setValue(0);
					}else{
						tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
					}
				}else{
					if("".equals(tempValue)){
						tempMatchingVO.setValue(strNull);
					}else{
						tempMatchingVO.setValue(CommonUtil.nvl(tempValue));
					}
				}
				matchingList.add(tempMatchingVO);
			}
		}
    	matchingColumNameChk(matchingColumName, matchingList, "'" + EgovUserDetailsHelper.getAdmId() + "'", "$i");
    	int lSize = matchingList.size();
    	Map<String, Object> newParams = new HashMap<String, Object>();
    	newParams.put("commTableNm", commTableNm);
    	if(lSize <= 0){
    		return;
    	}else{
    		String[] columName = new String[lSize];
    		Object[] columValue = new Object[lSize];
    		int i = 0;
    		for(MatchingVO matchingVO : matchingList){
    			columName[i] = matchingVO.getName();
    			columValue[i++] = matchingVO.getValue();
			}
    		newParams.put("columName", columName);
    		newParams.put("columValue", columValue);
    	}
    	commDAO.tableInsert(newParams);
    }

    /**
	 * @설명 : 해당 테이블의 컬럼 목록을 반환
	 * @param commTableNm
	 * @return
     * @throws Exception
	 */
	public List<TableColumnVO> getTableColumnList(String tableNm) throws Exception{
		return CommStatic.getDbTable(tableNm, commDAO);
	}

	/**
	 * insert or update에서  matchingColumName 안의 내용 확인
	 * @param matchingColumName
	 * @param matchingList
	 * @param ui
	 * @param type
	 */
	public void matchingColumNameChk(Map<String, Object> matchingColumName, List<MatchingVO> matchingList, String ui, String type){
		String _date = type + "date";
		String _ui = type + "ui";
		String _date_n = "";
		String _ui_n = "";
		if("$i".equals(type)){
			_date_n = "$udate";
			_ui_n = "$uui";
		}else{
			_date_n = "$idate";
			_ui_n = "$iui";
		}
    	if(matchingColumName == null){
    		return;
    	}
		for(Entry<String, Object> entry:matchingColumName.entrySet()){
			if(_date.equals(entry.getValue())){
				boolean isIn = false;
				for (MatchingVO matchingVO : matchingList) {
					isIn = (entry.getKey()).equals(matchingVO.getName());
					if(isIn){
						if(IConstants.DB_TYPE == IConstants.MSSQL) matchingVO.setValue("GETDATE()");
						else matchingVO.setValue("SYSDATE");
						break;
					}
				}
				if(!isIn){
					MatchingVO tempMatchingVO = new MatchingVO();
					tempMatchingVO.setName(entry.getKey());
					if(IConstants.DB_TYPE == IConstants.MSSQL) tempMatchingVO.setValue("GETDATE()");
					else tempMatchingVO.setValue("SYSDATE");
					matchingList.add(tempMatchingVO);
				}
			}else if(_ui.equals(entry.getValue())){
				boolean isIn = false;
				for (MatchingVO matchingVO : matchingList) {
					isIn = (entry.getKey()).equals(matchingVO.getName());
					if(isIn){
						matchingVO.setValue(ui);
						break;
					}
				}
				if(!isIn){
					MatchingVO tempMatchingVO = new MatchingVO();
					tempMatchingVO.setName(entry.getKey());
					tempMatchingVO.setValue(ui);
					matchingList.add(tempMatchingVO);
				}
			}else if(_date_n.equals(entry.getValue())){
				boolean isIn = false;
				for (MatchingVO matchingVO : matchingList) {
					isIn = (entry.getKey()).equals(matchingVO.getName());
					if(isIn){
						matchingList.remove(matchingVO);
						break;
					}
				}
			}else if(_ui_n.equals(entry.getValue())){
				boolean isIn = false;
				for (MatchingVO matchingVO : matchingList) {
					isIn = (entry.getKey()).equals(matchingVO.getName());
					if(isIn){
						matchingList.remove(matchingVO);
						break;
					}
				}
			}
		}
    }

	/**
	 * 해당테이블의 row수를 가지고 온다.
	 * @param commTableNm
	 * @return
	 */
	public int getRowCount(String commTableNm, Map<String, Object> whereParam) {
		return commDAO.getRowCount(commTableNm, whereParam);
	}

	/**
	 * Front Category Cache를 지우고 다시 생성 하도록 한다
	 */
	public void resetFrontCategory(){
		Net net = new Net();
		net.sendMessage(null, "resetCategoryList");
	}

	public Object getGAttch(Map<String, Object> params) throws Exception {
		return commDAO.getGAttch(params);
	}

	/**
	 * 데이터 수정 이력을 샀는다.
	 * @param dataModTbl 수정테이블 이름
	 * @param dataModTblKey 수정테이블키
	 * @param dataModInfo 수정정보
	 * @return
	 * @throws Exception
	 */
	public void setGdataModHis(String dataModTbl, Object dataModTblKey, String dataModInfo, String dataModTp) throws Exception{
		setGdataModHis(dataModTbl, CommonUtil.nvl(dataModTblKey), dataModInfo, dataModTp);
	}

	/**
	 * 데이터 수정 이력을 샀는다.
	 * @param dataModTbl 수정테이블 이름
	 * @param dataModTblKey 수정테이블키
	 * @param dataModInfo 수정정보
	 * @return
	 * @throws Exception
	 */
	public void setGdataModHis(String dataModTbl, Object dataModTblKey, Map<String, Object> dataModInfo, String dataModTp) throws Exception{
		setGdataModHis(dataModTbl, CommonUtil.nvl(dataModTblKey), CommonUtil.mapToJsonString(dataModInfo), dataModTp);
	}

	public void setGdataModHis(String dataModTbl, Object dataModTblKey, Map<String, Object> dataModInfo, String dataModTp, String dataInfo) throws Exception{
		setGdataModHis(dataModTbl, CommonUtil.nvl(dataModTblKey), CommonUtil.mapToJsonString(dataModInfo), dataModTp, dataInfo);
	}

	/**
	 * 데이터 수정 이력을 샀는다.
	 * @param dataModTbl 수정테이블 이름
	 * @param dataModTblKey 수정테이블키
	 * @param dataModInfo 수정정보
	 * @return
	 * @throws Exception
	 */
	public void setGdataModHis(String dataModTbl, String dataModTblKey, String dataModInfo, String dataModTp) throws Exception {
		setGdataModHis(dataModTbl, dataModTblKey, dataModInfo, dataModTp, null);
	}

	/**
	 * 데이터 수정 이력을 샀는다.
	 * @param dataModTbl 수정테이블 이름
	 * @param dataModTblKey 수정테이블키
	 * @param dataModInfo 수정정보
	 * @return
	 * @throws Exception
	 */
	public void setGdataModHis(String dataModTbl, String dataModTblKey, String dataModInfo, String dataModTp, String dataInfo) throws Exception {
		String commTableNm = "ASW_G_DATA_MOD_HIS";
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("DATA_MOD_TBL", dataModTbl);
		paramMap.put("DATA_MOD_TBL_KEY", dataModTblKey);
		paramMap.put("DATA_USER_TP_MA", "A");
		paramMap.put("DATA_MOD_INFO", dataModInfo);
		paramMap.put("DATA_MOD_TP", dataModTp);
		paramMap.put("DATA_MOD_IP", EgovUserDetailsHelper.getAdmLoginIp());
		paramMap.put("DATA_INFO", dataInfo);
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("DATA_MOD_ID", "$iui");
		matchingColumName.put("DATA_MOD_DT", "$idate");

		tableInatall(commTableNm, paramMap, matchingColumName);
	}
	/**
	 * CODE 시퀀스 받아 오기
	 * @param codeName
	 * @return
	 * @throws Exception
	 */
	public Object getPrCode(String codeName) throws Exception{
		return commProcedureService.getProcedureToObject("PR_CODE", codeName);
	}
	
	/**
	 * CODE 시퀀스 받아 오기 (13자리)
	 * @param codeName
	 * @return
	 * @throws Exception
	 */
	public Object getPrCodMany(String codeName) throws Exception{
		return commProcedureService.getProcedureToObject("PR_CODE_MANY", codeName);
	}
	

	public String getStrPrCode(String codeName) throws Exception{
		return CommonUtil.nvl(getPrCode(codeName));
	}

	/**
	 * 주문번호 받아 오기
	 * @param copnCd
	 * @return
	 * @throws Exception
	 */
	public String getPrOrderNo() throws Exception{
		return (String) commProcedureService.getProcedureToObject("PR_ORDER_NO");
	}

	/**
	 *  시퀀스 받아 오기
	 * @param seqName
	 * @return
	 * @throws Exception
	 */
	public Object getPrSeq(String seqName) throws Exception{
		return commProcedureService.getProcedureToObject("PR_SEQUENCE", seqName);
	}

	/**
	 * 쿠폰발행코드 받아 오기
	 * @param copnCd
	 * @return
	 * @throws Exception
	 */
	public Object getPrCopnIsuCode(String copnCd) throws Exception{
		return commProcedureService.getProcedureToObject("PR_COPN_ISU_CODE", copnCd);
	}

	/**
	 * 메시지변수 리스트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<?> msgVariableList(UnCamelMap<String, Object> paramMap) throws Exception {
        return commDAO.msgVariableList(paramMap);
	}


	public Map<String, Object> mbrMailCont(Map<String, Object> params) throws Exception {
		return commDAO.mbrMailCont(params);
	}

	public void mbrEmailSend(UnCamelMap<String, Object> paramMap){
		try {

			//String host = "58.229.234.98";
//			String host = "58.229.234.102";
			String host = "localhost";
			String from = "help@i6-shop.com";

	        int port=25;
	        String recipient = "";
	        String body = "";
	        try {
	        	if(!paramMap.getString("MAIL_CONT").equals("")){
			        if(!paramMap.getString("MBR_ID").equals("")){
			        	body = CommStatic.getHtmlStrCnvr(paramMap.getString("MAIL_CONT")) + CommStatic.getHtmlStrCnvr(paramMap.getString("MAIL_FOOTER_CONT"));
			        	CamelMap<String, Object> mbrInfoMap = commDAO.mbrInfoMap(paramMap);
			        	
			        		recipient = mbrInfoMap.getString("mbrEmail");
			        		
			        	
			        }else{
			        	boolean isRecipient = false;
			        	if(!"".equals(recipient)){
			        		isRecipient = CommonUtil.isEmail(recipient);
			        	}
			        	if(!isRecipient){
			        		return;
			        	}
			        	body = CommStatic.getHtmlStrCnvr(paramMap.getString("MAIL_CONT")) + CommStatic.getHtmlStrCnvr(paramMap.getString("MAIL_FOOTER_CONT"));
			        	
			        	if(body.contains("##가상계좌입금가능일##")){
			        		body = body.replace("##가상계좌입금가능일##", paramMap.getString("MONEY_DAY"));
			        	}
			        	if(body.contains("##입금가능월일##")){
			        		body = body.replace("##입금가능월일##", paramMap.getString("MONEY_DAY"));
			        	}
			        	if(body.contains("##비회원비밀번호##")){
			        		body = body.replace("##비회원비밀번호##", paramMap.getString("NON_MBR_PW"));
			        	}
			        }
			        // 이메일 양식 및 값 체크
			        if(CommonUtil.isEmail(recipient)){
				        String subject = CommStatic.getHtmlStrCnvr(paramMap.getString("MAIL_TITLE"));
						Properties props = System.getProperties();
						props.put("mail.transport.protocol", "smtp");
						props.put("mail.smtp.host", host);
						props.put("mail.smtp.port", port);
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.ssl.enable", "false");
						props.put("mail.smtp.ssl.trust", host);
						props.put("mail.smtp.starttls.enable", "true");
						Session session = Session.getDefaultInstance(props, null);
						session.setDebug(true); //for debug
						Message mimeMessage = new MimeMessage(session);
						mimeMessage.setFrom(new InternetAddress(from));
						mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
						mimeMessage.setSubject(subject);
						mimeMessage.setContent(body, "text/html; charset=UTF-8");
						Transport.send(mimeMessage);
			        }
	        	}
			} catch (MessagingException e) {
				logger.error("이메일 발신 에러.", e);
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		} catch (Exception e) {
			logger.error("메일 송신 에러.", e);
		}
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectIniStdMap(String orderNo) throws Exception {
		Map<String, Object> reMap = new HashMap<String, Object>();
		Map<String, String> selectMap = commDAO.selectIniStdMap(orderNo);
		String jsonStr = CommStatic.getString(selectMap.get("PROD_JSON_STR"));
		String cnvrStr = CommStatic.getHtmlStrCnvr(jsonStr);
		JSONParser jsonParser = new JSONParser();
		JSONObject reJson = (JSONObject) jsonParser.parse(cnvrStr);
		Set<String> keys = reJson.keySet();
		for (String key : keys) {
			reMap.put(key, reJson.get(key));
		}
		return reMap;
	}

	public Object mbrSmsCont(UnCamelMap<String, Object> params){
		try {
			CamelMap<String, Object> smsTemplate = commDAO.mbrSmsCont(params);

			UnCamelMap<String, Object> smsMap = new UnCamelMap<String, Object>();
			smsMap.put("tranCallback", IConstants.SMS_SEND_PHONE);
			smsMap.put("tranStatus", "1");
			String conText = smsTemplate.getString("smsCont");

				CamelMap<String, Object> mbrInfoMap = commDAO.mbrInfoMap(params);
				
				smsMap.put("tranPhone", mbrInfoMap.getString("mbrMobile"));
				smsMap.put("MBR_ID", params.get("MBR_ID"));

//		    	if(conText.contains("##가상계좌번호##")){
//		    		conText = conText.replace("##가상계좌번호##", params.getString("DEPOSIT_PAY_INFO"));
//		    	}
			// 회원가입 시 아이디 문자발송 (아이디는 변수에 없음)
			if(params.getString("MSG_ROLE_CD").equals("EMR00009")){
				smsMap.put("TRAN_MSG", conText+" id: "+params.getString("MBR_ID"));
			}else{
				smsMap.put("TRAN_MSG", conText);
			}
			return commDAO.mbrSmsSend(smsMap);
		} catch (Exception e) {
			logger.error("문자 발송 에러.", e);
		}
		return "";
	}

	/**
	 * 이니시스 결제를 테우기 위해서 파라메터를 임시로 저장 한다.
	 * @param orderNo
	 * @param params
	 * @throws Exception
	 */
	public void insertIniStdMap(String orderNo, Map<String, Object> params) throws Exception {
		String prodJsonStr = CommonUtil.mapToJsonString(params);
		String prodMapStr = "";
		if(prodJsonStr.length() > 2){
			prodMapStr = prodJsonStr.substring(1, prodJsonStr.length() - 1);
		}
		UnCamelMap<String, Object> map = new UnCamelMap<String, Object>();
		map.put("orderNo", orderNo);
		map.put("prodJsonStr", prodJsonStr);
		map.put("prodMapStr", prodMapStr.replaceAll("\"", ""));
		commDAO.insertIniStdMap(map);
	}


	/*public Object deleteIniStdMap(String orderNo) throws Exception {
		return commDAO.deleteIniStdMap(orderNo);
	}*/

	/**
	 * 발송(패킹완료) 문자발송
	 * @param params
	 * @return
	 */
	public Object smsSend(UnCamelMap<String, Object> params){
		try {
			return commDAO.mbrSmsSend(params);
		} catch (Exception e) {
			logger.error("문자 발송 에러.", e);
		}
		return "";
	}
}
