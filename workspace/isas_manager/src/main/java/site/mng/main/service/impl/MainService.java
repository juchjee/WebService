package site.mng.main.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("MainService")
public class MainService extends BaseService{

	/** MainDAO */
	@Resource(name = "MainDAO")
	private MainDAO mainDAO;


}


