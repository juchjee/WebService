package site.front.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("MainService")
public class MainService extends BaseService{

	/** MmDAO */
	@Resource(name = "MainDAO")
	private MainDAO mainDAO;

	/**
	 * @param paramMap
	 * @return
	 */

	public List<?> popupList(String popupSeq) {
		return mainDAO.popupList(popupSeq);
	}

	public Map<?,?> popupView(String popupSeq) {
		return (Map<?, ?>) mainDAO.popupView(popupSeq);
	}

	public List<?> eBannerList() throws Exception {
		return mainDAO.eBannerList();
	}


	public List<?> getMainNoticeList() throws Exception {
		return mainDAO.getMainNoticeList();
	}

	public List<?> getMainFaqList() throws Exception {
		return mainDAO.getMainFaqList();
	}

	public Map<?,?> getWorkCount(String custCd) {
		return (Map<?, ?>) mainDAO.getWorkCount(custCd);
	}
}
