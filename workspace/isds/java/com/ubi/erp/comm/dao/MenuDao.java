package com.ubi.erp.comm.dao;

import java.util.List;
import java.util.Map;

import com.ubi.erp.comm.domain.MenuVO;

public interface MenuDao {

	public List<MenuVO> selMenuList(MenuVO menuVO);

	MenuVO getPermission(Map<String, Object> map);

}
