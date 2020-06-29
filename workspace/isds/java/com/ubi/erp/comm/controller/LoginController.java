package com.ubi.erp.comm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ubi.erp.comm.domain.LoginVO;
import com.ubi.erp.comm.service.LoginService;

@RestController
public class LoginController {

	@Autowired
	private LoginService loginService;

	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public LoginVO loginProc(HttpServletRequest request, HttpServletResponse response, LoginVO loginVO) {

		LoginVO loginVO2 = loginService.selLoginCheck(loginVO);

		if (loginVO2 != null) {

			HttpSession session = request.getSession(false);

			if (session != null) {
				session.invalidate();
			}
			List<LoginVO> loginSiteCd = loginService.selLoginSiteCd(loginVO);

			session = request.getSession(true);
			session.setAttribute("id", loginVO2.getId()); // 아이디
			session.setAttribute("pw", loginVO2.getPw()); // 패스워드
			session.setAttribute("bsCd", loginVO2.getBsCd()); // 사업장코드
			session.setAttribute("facCd", loginVO2.getFacCd()); // 공장코드
			session.setAttribute("custCd", loginVO2.getCustCd()); // 업체코드
			session.setAttribute("custNm", loginVO2.getCustNm()); // 업체명
			session.setAttribute("kind", loginVO2.getKind()); // 구분
			session.setAttribute("mngYn", loginVO2.getMngYn()); // 관리자 구분
			session.setAttribute("userNm", loginVO2.getUserNm()); // 로그인자
			session.setAttribute("bizNo", loginVO2.getBizNo()); // 사업자
			session.setAttribute("custNm", loginVO2.getCustNm()); // 거래처명
			session.setAttribute("workYn", loginVO2.getWorkYn()); // 재직여부
			session.setAttribute("useYn", loginVO2.getUseYn()); // 사용여부
			session.setAttribute("deptCd", loginVO2.getDeptCd()); // 부서코드
			session.setAttribute("grId", loginVO2.getGrId()); // 부서코드
			session.setAttribute("erpCustCd", loginVO2.getErpCustCd()); // erp 시스템의 cust_cd [SCU100]
			session.setAttribute("erpCustNm", loginVO2.getErpCustNm()); // erp 시스템의 cust_nm
			if (loginSiteCd.size() == 1) {
				session.setAttribute("siteCd", loginSiteCd.get(0).getSiteCd()); // 현장코드
				session.setAttribute("siteNm", loginSiteCd.get(0).getSiteNm()); // 현장코드
			}

		} else {
			loginVO2 = new LoginVO();
		}
		return loginVO2;
	};

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
	};

	@RequestMapping(value = "/chageCheck", method = RequestMethod.POST)
	public int selChangeCheck(HttpServletRequest request, HttpServletResponse response, LoginVO loginVO) {
		return loginService.selChangeCheck(loginVO);
	}

	@RequestMapping(value = "/passwordSave", method = RequestMethod.POST)
	public void prcsChangePassWord(HttpServletRequest request, HttpServletResponse response, LoginVO loginVO) {
		loginService.prcsChangePassWord(loginVO);
	};

}