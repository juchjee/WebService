package site.front.bbt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("BbtDAO")
public class BbtDAO extends EgovAbstractDAO {

	public List<?> selectAuthorList() throws Exception {
        return list("BbtDAO.selectAuthorList", null);
    }

	/**
	 * 분류 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> cateList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.cateList", params);
	}

	public String mstCdMenuNm(String params) throws Exception {
		return (String) select("BbtDAO.mstCdMenuNm", params);
	}

	public List<?> mstTpBoard(Map<String, Object> params) throws Exception {
		return list("BbtDAO.mstTpBoard", params);
	}

	/**
	 * 게시판 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> bbtList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbtList", params);
	}

	public int allListCount(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.allListCount", params);
	}

	/**
	 * 전체 리스트 카운트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int totalListCount(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.totalListCount", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00001V(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00001V", params);
    }

	public List<?> bbt00001F(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00001F", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00001PV(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00001PV", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00001NV(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00001NV", params);
    }

	public int bbtHitCnt(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbtHitCnt", params);
	}

	public List<?> bbt2MList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt2MList", params);
	}

	public int bbt2MCount(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbt2MCount", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt2View(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt2View", params);
    }

	public int bbt26Count(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbt26Count", params);
	}

	public List<?> bbt26List(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt26List", params);
	}

	public List<?> cate26List(Map<String, Object> params) throws Exception {
		return list("BbtDAO.cate26List", params);
	}

	public int bbt3Count(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbt3Count", params);
	}

	public List<?> bbt3List(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt3List", params);
	}

	public int bbtAccessStatus(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbtAccessStatus", params);
	}

	public int bbtMyCount(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbtMyCount", params);
	}

	public List<?> bbtMyList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbtMyList", params);
	}

	public List<?> bbtNmList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbtNmList", params);
	}

	public int duoNewCount(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.duoNewCount", params);
	}

	public List<?> duoNewList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.duoNewList", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> duoNewView(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) select("BbtDAO.duoNewView", params);
	}

	public int payProdCount(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.payProdCount", params);
	}

	public List<?> payProdList(Map<String, Object> params) throws Exception {
		return list("BbtDAO.payProdList", params);
	}

	public void addMyFeelEmpathy(Map<String, Object> params) {
		insert("BbtDAO.addMyFeelEmpathy", params);
	}
	public void delMyFeelEmpathy(Map<String, Object> params) {
		delete("BbtDAO.delMyFeelEmpathy", params);
	}

	public List<?> bbt7List(Map<String, Object> params)  throws Exception {
		return list("BbtDAO.bbt7List", params);
	}

	public List<?> bbt10List(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt10List", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00010V(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00010V", params);
    }

	public List<?> bbt9List(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt9List", params);
	}

	public List<?> bbt8List(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt8List", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00008TP(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00008TP", params);
    }

}
