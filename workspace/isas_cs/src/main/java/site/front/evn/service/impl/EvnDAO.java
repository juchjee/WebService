package site.front.evn.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;

@Repository("EvnDAO")
public class EvnDAO extends EgovAbstractDAO {

	public List<?> selectAuthorList() throws Exception {
        return list("EvnDAO.selectAuthorList", null);
    }

	public List<?> selectEventList(Map<String, Object> params) throws Exception {
        return list("EvnDAO.selectEventList", params);
    }

	public List<?> selectEventPastList(Map<String, Object> params) throws Exception {
        return list("EvnDAO.selectEventPastList", params);
    }

	public int selectEventListCount() throws Exception {
        return (int) select("EvnDAO.selectEventListCount", null);
    }
	public int selectEventPastListCount() throws Exception {
        return (int) select("EvnDAO.selectEventPastListCount", null);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEventDetail(Map<String, Object> paramMap) {
		return (Map<String, Object>) select("EvnDAO.selectEventDetail",  paramMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectQuizList(Map<String, Object> params) throws Exception {
        return (Map<String, Object>)select("EvnDAO.selectQuizList", params);
    }

	public List<?> selectQuizChoiceList(Map<String, Object> params) throws Exception {
        return list("EvnDAO.selectQuizChoiceList", params);
    }

	public List<?> selectCopnDownList(Map<String, Object> params) throws Exception {
        return list("EvnDAO.selectCopnDonwList", params);
    }

	public List<?> selectEventCodeList() throws Exception {
        return list("EvnDAO.selectEventCodeList", null);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectWinnersDetail(Map<String, Object> paramMap) {
		return (Map<String, Object>) select("EvnDAO.selectWinnersDetail",  paramMap);
	}

	public int updateWinnersHit(Map<String, Object> paramMap){
		return update("EvnDAO.updateWinnersHit",  paramMap);
	}

	public int selectAlreadyQuizPart(Map<String, Object> paramMap){
        return (int) select("EvnDAO.selectAlreadyQuizPart", paramMap);
    }

	public int selectAlreadyAppPart(Map<String, Object> paramMap){
        return (int) select("EvnDAO.selectAlreadyAppPart", paramMap);
    }

	public int selectMbrLev(Map<String, Object> paramMap){
        return (int) select("EvnDAO.selectMbrLev", paramMap);
    }

	public int selectEventProceed(Map<String, Object> paramMap){
        return (int) select("EvnDAO.selectEventProceed", paramMap);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> eBannerTopDetail() throws Exception {
		return (Map<String, Object>) select("EvnDAO.eBannerTopDetail", null);
	}

	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> selecUseCpon(Map<String, Object> paramMap) {
        return (CamelMap<String, Object>) select("EvnDAO.selecUseCpon", paramMap);
	}
}
