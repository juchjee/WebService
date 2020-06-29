package site.mng.sa.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;
import egovframework.cmmn.util.EgovNumberUtil;
import egovframework.cmmn.util.EgovStringUtil;
import egovframework.cmmn.vo.LoginVO;
import site.mng.sa.service.EgovFileScrty;

@Service("SaService")
public class SaService extends BaseService {
	/** SaDAO */
	@Resource(name = "SaDAO")
	private SaDAO saDAO;

	/**
	 * 일반 로그인을 처리한다
	 *
	 * @param vo
	 *            LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */

	public LoginVO actionLogin(LoginVO vo) throws Exception {
		String admId = vo.getAdmId();
		String admPw = vo.getAdmPw();
		if(admId == null || admPw == null) return null;
		// 1. 입력한 비밀번호를 암호화한다.
		String enAdmPw = EgovFileScrty.encryptPassword(admId + admPw, admId);
		vo.setAdmPw(enAdmPw);

		// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
		LoginVO loginVO = saDAO.actionLogin(vo);

		// 3. 결과를 리턴한다.
		if (loginVO != null && !loginVO.getAdmId().equals("") && !loginVO.getAdmAuthCd().equals("")) {
			return loginVO;
		} else {
			loginVO = new LoginVO();
		}

		return loginVO;
	}
	
	public LoginVO actionCrmLogin(LoginVO vo) throws Exception {
		
		// 2. 아이디가 DB와 일치하는지 확인한다.
		LoginVO loginVO = saDAO.actionCrmLogin(vo);
		// 3. 결과를 리턴한다.
		if (loginVO != null && !loginVO.getAdmId().equals("") && !loginVO.getAdmAuthCd().equals("")) {
			return loginVO;
		} else {
			loginVO = new LoginVO();
		}
		return loginVO;
	}

	/**
	 * 인증서 로그인을 처리한다
	 *
	 * @param vo
	 *            LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */

	public LoginVO actionCrtfctLogin(LoginVO vo) throws Exception {

		// 1. DN값으로 ID, PW를 조회한다.
		LoginVO loginVO = saDAO.actionCrtfctLogin(vo);

		// 3. 결과를 리턴한다.
		if (loginVO != null && !loginVO.getAdmId().equals("") && !loginVO.getAdmPw().equals("")) {
			return loginVO;
		} else {
			loginVO = new LoginVO();
		}

		return loginVO;
	}

	/**
	 * 아이디를 찾는다.
	 *
	 * @param vo
	 *            LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	public LoginVO searchId(LoginVO vo) throws Exception {

		// 1. 이름, 이메일주소가 DB와 일치하는 사용자 ID를 조회한다.
		LoginVO loginVO = saDAO.searchId(vo);

		// 2. 결과를 리턴한다.
		if (loginVO != null && !loginVO.getAdmId().equals("")) {
			return loginVO;
		} else {
			loginVO = new LoginVO();
		}

		return loginVO;
	}

	/**
	 * 비밀번호를 찾는다.
	 *
	 * @param vo
	 *            LoginVO
	 * @return boolean
	 * @exception Exception
	 */
	public boolean searchAdmPw(LoginVO vo) throws Exception {

		boolean result = true;

		// 1. 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답이 DB와 일치하는 사용자 ADM_PW를 조회한다.
		LoginVO loginVO = saDAO.searchADM_PW(vo);
		if (loginVO == null || loginVO.getAdmPw() == null || loginVO.getAdmPw().equals("")) {
			return false;
		}

		// 2. 임시 비밀번호를 생성한다.(영+영+숫+영+영+숫+영+영=8자리)
		String newADM_PW = "";
		for (int i = 1; i <= 8; i++) {
			// 영자
			if (i % 3 != 0) {
				newADM_PW += EgovStringUtil.getRandomStr('a', 'z');
				// 숫자
			} else {
				newADM_PW += EgovNumberUtil.getRandomNum(0, 9);
			}
		}

		// 3. 임시 비밀번호를 암호화하여 DB에 저장한다.
		LoginVO pwVO = new LoginVO();
		String enADM_PW = EgovFileScrty.encryptPassword(newADM_PW, vo.getAdmId());
		pwVO.setAdmId(vo.getAdmId());
		pwVO.setAdmPw(enADM_PW);
		// pwVO.setUserSe(vo.getUserSe());
		saDAO.updateADM_PW(pwVO);

		// 4. 임시 비밀번호를 이메일 발송한다.(메일연동솔루션 활용)
		/*
		 * SndngMailVO sndngMailVO = new SndngMailVO();
		 * sndngMailVO.setDsptchPerson("webmaster");
		 * sndngMailVO.setRecptnPerson(vo.getEmail());
		 * sndngMailVO.setSj("[MOPAS] 임시 비밀번호를 발송했습니다.");
		 * sndngMailVO.setEmailCn("고객님의 임시 비밀번호는 " + newADM_PW + " 입니다.");
		 * sndngMailVO.setAtchFileId("");
		 *
		 * result = sndngMailRegistService.insertSndngMail(sndngMailVO);
		 */

		return result;
	}

}
