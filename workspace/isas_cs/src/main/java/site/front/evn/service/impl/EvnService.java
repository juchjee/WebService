package site.front.evn.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.CamelMap;

@Service("EvnService")
public class EvnService extends EgovAbstractServiceImpl{

	/** EtcDAO */
	@Resource(name = "EvnDAO")
	private EvnDAO evnDAO;

	public List<?> selectAuthorList() throws Exception {
        return evnDAO.selectAuthorList();
    }

	/**
	 * 진행중인 이벤트 조회
	 * @param paramMap
	 * @return
	 */
	public List<?> selectEventList(Map<String, Object> params) throws Exception {
        return evnDAO.selectEventList(params);
    }

	/**
	 * 지난 이벤트 조회
	 * @param paramMap
	 * @return
	 */
	public List<?> selectEventPastList(Map<String, Object> params) throws Exception {
        return evnDAO.selectEventPastList(params);
    }

	public int selectEventListCount() throws Exception {
        return evnDAO.selectEventListCount();
    }
	public int selectEventPastListCount() throws Exception {
        return evnDAO.selectEventPastListCount();
    }

	/**
	 * 해당 이벤트 상세조회
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> selectEventDetail(Map<String, Object> paramMap) {
		return evnDAO.selectEventDetail(paramMap);
	}

	/* 퀴즈 이벤트 조회 */
	public Map<String, Object> selectQuizList(Map<String, Object> params) throws Exception {
        return evnDAO.selectQuizList(params);
    }

	/* 퀴즈가 객관식인경우 문항 조회 */
	public List<?> selectQuizChoiceList(Map<String, Object> params) throws Exception {
        return evnDAO.selectQuizChoiceList(params);
    }

	/* 쿠폰 다운로드 이벤트 조회 */
	public List<?> selectCopnDownList(Map<String, Object> params) throws Exception {
        return evnDAO.selectCopnDownList(params);
    }

	/* 이벤트 코드 리스트 */
	public List<?> selectEventCodeList() throws Exception {
        return evnDAO.selectEventCodeList();
    }

	/* 당첨자 조회 */
	public Map<String, Object> selectWinnersDetail(Map<String, Object> paramMap) {
		return evnDAO.selectWinnersDetail(paramMap);
	}

	/* 당첨자조회 조회 수 증가 */
	public int updateWinnersHit(Map<String, Object> paramMap){
		return evnDAO.updateWinnersHit(paramMap);
	}

	/* 기존 퀴즈이벤트 응모여부 확인 */
	public int selectAlreadyQuizPart(Map<String, Object> paramMap) {
		return evnDAO.selectAlreadyQuizPart(paramMap);
	}
	/* 기존 응모이벤트 응모여부 확인 */
	public int selectAlreadyAppPart(Map<String, Object> paramMap) {
		return evnDAO.selectAlreadyAppPart(paramMap);
	}
	/* 응모가능 회원등급 여부 확인용 레벨값 조회 */
	public int selectMbrLev(Map<String, Object> paramMap) {
		return evnDAO.selectMbrLev(paramMap);
	}
	/* 진행중인 이벤트인지 판단 1=진행중 0=완료 */
	public int selectEventProceed(Map<String, Object> paramMap) {
		return evnDAO.selectEventProceed(paramMap);
	}

	public Map<String, Object> eBannerTopDetail() throws Exception {
		return evnDAO.eBannerTopDetail();
	}

	public CamelMap<String, Object> selecUseCpon(Map<String, Object> paramMap) {
		return evnDAO.selecUseCpon(paramMap);
	}
}
