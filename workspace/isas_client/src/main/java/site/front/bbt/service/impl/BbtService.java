package site.front.bbt.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import site.comm.service.impl.CommService;

@Service("BbtService")
public class BbtService extends EgovAbstractServiceImpl{

	/** EtcDAO */
	@Resource(name = "BbtDAO")
	private BbtDAO bbtDAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	public List<?> selectAuthorList() throws Exception {
        return bbtDAO.selectAuthorList();
    }

	/**
	 * 게시판 분류 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> cateList(Map<String, Object> params) throws Exception {
		return bbtDAO.cateList(params);
	}

	public String mstCdMenuNm(String params) throws Exception {
		return bbtDAO.mstCdMenuNm(params);
	}

	public List<?> mstTpBoard(Map<String, Object> params) throws Exception {
		return bbtDAO.mstTpBoard(params);
	}

	/**
	 * 게시판 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> bbtList(Map<String, Object> params) throws Exception {
		return bbtDAO.bbtList(params);
	}

	public int allListCount(Map<String, Object> params) throws Exception {
		return bbtDAO.allListCount(params);
	}

	/**
	 * 전체 리스트 카운트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int totalListCount(Map<String, Object> params) throws Exception {
		return bbtDAO.totalListCount(params);
	}

	public int bbtHitCnt(Map<String, Object> params) throws Exception {
		return bbtDAO.bbtHitCnt(params);
	}

	public Map<String, Object> bbt00001V(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001V(params);
	}

	public List<?> bbt00001F(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001F(params);
	}

	public Map<String, Object> bbt00001PV(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001PV(params);
	}

	public Map<String, Object> bbt00001NV(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001NV(params);
	}


	public List<?> bbt2MList(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt2MList(params);
	}

	public int bbt2MCount(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt2MCount(params);
	}

	public Map<String, Object> bbt2View(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt2View(params);
	}

	public int bbt26Count(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt26Count(params);
	}

	public List<?> bbt26List(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt26List(params);
	}

	public List<?> cate26List(Map<String, Object> params) throws Exception {
		return bbtDAO.cate26List(params);
	}

	public int bbt3Count(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt3Count(params);
	}

	public List<?> bbt3List(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt3List(params);
	}

	public int bbtAccessStatus(Map<String, Object> params) throws Exception {
		return bbtDAO.bbtAccessStatus(params);
	}

	public int bbtMyCount(Map<String, Object> params) throws Exception {
		return bbtDAO.bbtMyCount(params);
	}

	public List<?> bbtMyList(Map<String, Object> params) throws Exception {
		return bbtDAO.bbtMyList(params);
	}

	public List<?> bbtNmList(Map<String, Object> params) throws Exception {
		return bbtDAO.bbtNmList(params);
	}

	public int duoNewCount(Map<String, Object> params) throws Exception {
		return bbtDAO.duoNewCount(params);
	}

	public List<?> duoNewList(Map<String, Object> params) throws Exception {
		return bbtDAO.duoNewList(params);
	}

	public Map<String, Object> duoNewView(Map<String, Object> params) throws Exception {
		return bbtDAO.duoNewView(params);
	}

	public int payProdCount(Map<String, Object> params) throws Exception {
		return bbtDAO.payProdCount(params);
	}

	public List<?> payProdList(Map<String, Object> params) throws Exception {
		return bbtDAO.payProdList(params);
	}


	public List<?> bbt7List(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt7List(params);
	}

	public List<?> bbt10List(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt10List(params);
	}

	public Map<String, Object> bbt00010V(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00010V(params);
	}

	public List<?> bbt9List(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt9List(params);
	}

	public List<?> bbt8List(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt8List(params);
	}

	public Map<String, Object> bbt00008TP(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00008TP(params);
	}



}
