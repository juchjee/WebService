package com.ubi.erp.comm.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.comm.dao.LoginDao;
import com.ubi.erp.comm.domain.LoginVO;

@Service
public class LoginService {
	private LoginDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(LoginDao.class);
	}

	public LoginVO selLoginCheck(LoginVO loginVO) {
		return dao.selLoginCheck(loginVO);
	}

	public int selChangeCheck(LoginVO loginVO) {
		return dao.selChangeCheck(loginVO);
	}

	public void prcsChangePassWord(LoginVO loginVO) {
		dao.prcsChangePassWord(loginVO);
	}

	public List<LoginVO> selLoginSiteCd(LoginVO loginVO) {
		return dao.selLoginSiteCd(loginVO);
	}
}
