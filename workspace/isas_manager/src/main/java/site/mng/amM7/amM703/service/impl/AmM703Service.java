package site.mng.amM7.amM703.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Service("AmM703Service")
public class AmM703Service extends BaseService {

	@Resource(name = "AmM703DAO")
	private AmM703DAO amM703DAO;

	/** FRONT 메뉴관리 : 1차 메뉴 조회 **/
	public List<?> amM703L(Map<String, Object> params) throws Exception {
		return amM703DAO.amM703L(params);
    }

	/** FRONT 메뉴관리 : sort 조회 **/
	public int amM703Count(Map<String, Object> params) throws Exception {
		return amM703DAO.amM703Count(params);
	}

	/** FRONT 메뉴관리 : 삭제 기준 sort리스트 **/
	public List<?> amM703SList(Map<String, Object> params) throws Exception {
		return amM703DAO.amM703SList(params);
    }

	/** FRONT 메뉴관리 : 순서이동 처리 **/
	public String sortMod(Map<String, Object> params) throws Exception {
		String  returnStatus = "";
		String selectRow = (String) params.get("SELECT_ROW");
		String sortType = (String) params.get("SORT_TYPE");
		String totRow = (String) params.get("TOT_ROW");

		if(selectRow.equals("1")&&totRow.equals("1")){
			if(sortType.equals("sortDown")){
				returnStatus = "lastData";
				return returnStatus;
			}else{
				returnStatus = "firstData";
				return returnStatus;
			}
		}else if(selectRow.equals("1")&&sortType.equals("sortUp")){
			returnStatus = "firstData";
			return returnStatus;
		}else if(selectRow.equals(totRow)&&sortType.equals("sortDown")){
			returnStatus = "lastData";
			return returnStatus;
		} else {
			int udpCount = amM703DAO.sortMod(params);

			if(udpCount != 0){
				returnStatus = "ok";
			}else{
				returnStatus = "ng";
			}
		}
		return returnStatus;
	}

	/** FRONT 메뉴관리 : 삭제 후 순서수정 **/
	public void amM703SU(Map<String, Object> params) throws Exception {
		amM703DAO.amM703SU(params);
	}

	public List<?> bbsProgList(UnCamelMap<String, Object> paramMap) {
		return amM703DAO.bbsProgList(paramMap);
	}

	public List<?> frontAllList() {
		return amM703DAO.frontAllList();
	}

}
