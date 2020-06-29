package site.front.view.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ViewService")
public class ViewService extends EgovAbstractServiceImpl{

	/** ViewDAO */
	@Resource(name = "ViewDAO")
	private ViewDAO viewDAO;



}
