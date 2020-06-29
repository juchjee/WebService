package site.front.mm.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.EgovFileScrty;
import egovframework.cmmn.vo.LoginVO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("MmService")
public class MmService extends BaseService {
	/** MmDAO */
	@Resource(name = "MmDAO")
	private MmDAO mmDAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	/**
	 * 회원 정보를 가지고 온다
	 *
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	public LoginVO actionLogin(LoginVO vo) throws Exception {
		//입력한 비밀번호를 암호화한다.
		String enAdmPw = EgovFileScrty.encryptPassword(vo.getMbrId() + vo.getMbrPw(), vo.getMbrId());
		vo.setMbrPw(enAdmPw);

		LoginVO loginVO = mmDAO.actionLogin(vo);
		if (loginVO != null && !loginVO.getMbrId().equals("") && !loginVO.getMbrId().equals("")) {
			return loginVO;
		} else {
			return new LoginVO();
		}
	}

	/**
	 * 회원 정보를 찾는다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public CamelMap<String, String> searchId(Map<String, ?> param) throws Exception {
		return mmDAO.searchId(param);
	}

	/**
	 * 회원번호 생성
	 * @param paramMap
	 * @return
	 */
	public String selectMaxMbrSeq() {
		return mmDAO.selectMaxMbrSeq();
	}

	/**
	 * 회원번호 조회
	 * @param paramMap
	 * @return
	 */
	public int selectMbrSeq(Map<String, Object> paramMap) {
		return mmDAO.selectMbrSeq(paramMap);
	}

	/**
	 * 회원가입 데이터 저장
	 * @param paramMap
	 * @throws Exception
	 */
	public void joinI(String MBR_ID, UnCamelMap<String, Object> paramMap) throws Exception {

		Map<String, Object> paramMapMst = new HashMap<String, Object>();

		String MBR_PHONE1 = paramMap.getString("MBR_PHONE1");
		String MBR_PHONE2 = paramMap.getString("MBR_PHONE2");
		String MBR_PHONE3 = paramMap.getString("MBR_PHONE3");
		String MBR_MOBILE1 = paramMap.getString("MBR_MOBILE1");
		String MBR_MOBILE2 = paramMap.getString("MBR_MOBILE2");
		String MBR_MOBILE3 = paramMap.getString("MBR_MOBILE3");
		if(!"".equals(MBR_PHONE1) && !"".equals(MBR_PHONE2) && !"".equals(MBR_PHONE3)){
			paramMapMst.put("tel", MBR_PHONE1 + "-" + MBR_PHONE2 + "-" + MBR_PHONE3);
		}
		if(!"".equals(MBR_MOBILE1) && !"".equals(MBR_MOBILE2) && !"".equals(MBR_MOBILE3)){
			paramMapMst.put("hp", MBR_MOBILE1 + "-" + MBR_MOBILE2 + "-" + MBR_MOBILE3);
		}
		paramMap.put("mbrPw", EgovFileScrty.encryptPassword(MBR_ID + paramMap.getString("MBR_PW"), MBR_ID));
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		String MBR_SEQ = "";
		String csNoSearch = csNoSearch(paramMap);
		if(CommonUtil.nvl(csNoSearch).equals("")){
			 MBR_SEQ = selectMaxMbrSeq();
		}else{
			 MBR_SEQ = csNoSearch;
		}
		paramMap.put("MBR_SEQ", MBR_SEQ);
		commService.tableInatall("ASW_M_MBR_LOGIN", paramMap, matchingColumName);

		paramMapMst.put("cs_no", MBR_SEQ);
		paramMapMst.put("cs_nm", paramMap.getString("MBR_NM"));
		paramMapMst.put("e_mail", paramMap.getString("MBR_EMAIL"));
		paramMapMst.put("addr", paramMap.getString("MBR_ADDR"));
		paramMapMst.put("zip_cd", paramMap.getString("MBR_ZIPCODE"));
		if(!paramMap.getString("MBR_ADDR_DTL").equals("")){
		paramMapMst.put("addr2", paramMap.getString("MBR_ADDR_DTL"));
		}else{
			paramMapMst.put("addr2", "");
		}
		paramMapMst.put("use_yn", "Y");
		paramMapMst.put("mbr_id", paramMap.getString("MBR_ID"));
		paramMapMst.put("mbr_di", paramMap.getString("MBR_DI"));

		matchingColumName.put("cdt", "$idate");
		String[] whereColumName = null;
		whereColumName = new String[]{"cs_no"};
		commService.tableSaveData("ASA010", paramMapMst, matchingColumName, whereColumName , null, null);
	}



	public int getLoginCnt(Map<String, Object> paramMap) throws Exception {
		return mmDAO.getLoginCnt(paramMap);
	}

	public int guestCheck(Map<String, Object> params) throws Exception {
		return mmDAO.guestCheck(params);
	}

	public String csNoSearch(Map<String, Object> paramMap) throws Exception {
		return mmDAO.csNoSearch(paramMap);
	}


}
