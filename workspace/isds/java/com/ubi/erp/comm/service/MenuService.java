package com.ubi.erp.comm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.comm.dao.MenuDao;
import com.ubi.erp.comm.domain.MenuVO;

@Service
public class MenuService {
	private MenuDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(MenuDao.class);
	}

	public List<MenuVO> selMenuList(MenuVO menuVO) {
		return dao.selMenuList(menuVO);
	}

	public boolean getPermission(Map<String, Object> map) {
		boolean getPermission = false;
		String reqUri = (String) map.get("uri");
		String tempUri = reqUri.replace(".do", "").trim();
		String id = (String) map.get("id");
		String uri = tempUri.substring(0, 1).replace("/", "").trim() + tempUri.substring(1, tempUri.length()).trim();

		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("id", id);
		map2.put("uri", uri);

		MenuVO menuVO = dao.getPermission(map2);

		if (menuVO != null) {
			getPermission = true;
		} else {
			getPermission = false;
		}

		return getPermission;
	}
}
