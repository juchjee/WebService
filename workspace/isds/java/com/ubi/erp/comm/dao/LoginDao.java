package com.ubi.erp.comm.dao;

import java.util.List;

import com.ubi.erp.comm.domain.LoginVO;

public interface LoginDao {

	public LoginVO selLoginCheck(LoginVO loginVO);

	public int selChangeCheck(LoginVO loginVO);

	public void prcsChangePassWord(LoginVO loginVO);

	public List<LoginVO> selLoginSiteCd(LoginVO loginVO);
}
