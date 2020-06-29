package egovframework.cmmn.web;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;

import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.MessageBox;
import egovframework.cmmn.vo.LoginVO;
import egovframework.rte.fdl.cmmn.trace.LeaveaTrace;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommProcedureService;
import site.comm.service.impl.CommService;

/**
 * @author vary
 * 비즈니스로직을 수행하는 기본 클래스. 생성되는 Controller 들은 이 클래스를 상속받아서 구현하도록 한다.
 */
public class BaseController implements IConstants{

	protected static final Logger logger = LoggerFactory.getLogger("Controller");

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	/** 공통 Procedure 서비스 */
	@Resource(name = "CommProcedureService")
	protected CommProcedureService commProcedureService;

	/** SitePropertyService */
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    protected EgovMessageSource egovMessageSource;

    /** TRACE */
    @Resource(name="leaveaTrace")
    protected LeaveaTrace leaveaTrace;

	/**
	 * Controller 초기화
	 * @param model
	 */
	protected void init(ModelMap model) throws Exception{
		LoginVO loginVO = getLoginVO();
		if (loginVO == null) {//로그인 여부
			model.addAttribute("isLogIn", false);//로그인 여부
		}else{
			model.addAttribute("isLogIn", true);//로그인 여부
			model.addAttribute("custCd", loginVO.getCustCd());
			model.addAttribute("drvNo", loginVO.getDrvNo());
			model.addAttribute("drvNm", loginVO.getDrvNm());
		}
	}


	protected UnCamelMap<String, Object> init(Map<String, Object> commandMap) throws Exception{
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		return paramMap;
	}

	protected UnCamelMap<String, Object> init(MultiValueMap<String, Object> multiValueMap) throws Exception{
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(multiValueMap);
		return paramMap;
	}

	protected UnCamelMap<String, Object> init(Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);
		return init(commandMap);
	}

	protected UnCamelMap<String, Object> init(MultiValueMap<String, Object> multiValueMap, ModelMap model) throws Exception{
		init(model);
		return init(multiValueMap);
	}

	/**
	 * 로그인 여부
	 * @return
	 */
	protected boolean isLogIn(){
		return EgovUserDetailsHelper.isAuthenticated();
	}

	/**
	 * 관리자 정보
	 * @return
	 */
	protected LoginVO getLoginVO(){
		return (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
	}

	/**
	 * 에러정보 설정 후 에러페이지 리턴
	 * @param key
	 * @param values
	 * @param e
	 * @return
	 */
	protected String setErrorMessage(String key, Object[] values, Exception e, String jspName, ModelMap modelMap) {
		try {
			String _messageStr = egovMessageSource.getMessage(key, values);
			setMessageBox(new MessageBox(key, _messageStr, e), modelMap);
			if(jspName == null || "".equals(jspName)){
				return "common/error";
			}else{
				return jspName;
			}
		} catch (Exception ex) {
			logger.error("Exception", ex);
			return "common/error";
		}
	}

	/**
	 * 메시지 설정. 메시지박스를 띄우고 메인 윈도우를 해당 경로로 이동하고 팝업을 닫는다.
	 * @param message 보여줄 메시지
	 * @param path 처리후 이동할 경로
	 * @return
	 */
	protected String messageClose(String message, String path, ModelMap modelMap) {
		setMessage(message, "location", path, modelMap);
		return "common/closeRedirectOpener";
	}

	/**
	 * 메시지 설정. 메시지박스를 띄우고 해당 경로로 이동한다.
	 * @param message 보여줄 메시지
	 * @param path 처리후 이동할 경로
	 * @return
	 */
	protected String messageRedirect(String message, String path, ModelMap modelMap) {
		setMessage(message, "location", path, modelMap);
		return "common/messageRedirect";
	}

	/**
	 * 메시지 설정. 메시지박스를 띄우고 스크립트 실행
	 * @param message 보여줄 메시지
	 * @param action 처리후 함수 실행
	 * @return
	 */
	protected String messageAction(String message, String action, ModelMap modelMap) {
		setMessage(message, "action", action, modelMap);
		return "common/messageRedirect";
	}

	/**
	 * 메시지 설정. 메시지박스를 띄우고 부모창 해당 경로로 이동한다.
	 * @param message 보여줄 메시지
	 * @param path 처리후 이동할 경로
	 * @return
	 */
	protected String messageCloseRedirect(String message, String path, ModelMap modelMap) {
		setMessage(message, "location", path, modelMap);
		return "common/closeRedirect";
	}

	/**
	 * 메시지 설정. 메시지박스를 띄우고 부모창 해당 경로로 이동한다.
	 * @param message 보여줄 메시지
	 * @param path 처리후 이동할 경로
	 * @return
	 */
	protected String messageCloseParentRedirect(String message, String path, ModelMap modelMap) {
		setMessage(message, "location", path, modelMap);
		return "common/closeParentRedirect";
	}

	/**
	 * 메시지 설정
	 * @param message
	 */
	protected void setMessage(String message, String scriptKey, String scriptValue, ModelMap modelMap) {
		setMessage("alert.message", message, scriptKey, scriptValue, modelMap);
	}

	/**
	 * 메시지 설정
	 * @param message
	 */
	protected void setMessage(String key, String message, String scriptKey, String scriptValue, ModelMap modelMap) {
		setMessageBox(new MessageBox(key, message), modelMap);
		String _scriptKey = CommonUtil.nvl(scriptKey);
		String _scriptValue = CommonUtil.nvl(scriptValue);
		if(!"".equals(_scriptKey) && !"".equals(_scriptValue) && modelMap != null){
			if("location".equals(_scriptKey)){
				_scriptValue = CommonUtil.chkLocation(_scriptValue);
			}
			modelMap.put(_scriptKey, _scriptValue);
		}

	}


	/**
	 * CODE 시퀀스 받아 오기
	 * @param codeName
	 * @return
	 * @throws Exception
	 */
	protected Object getPrCode(String codeName) throws Exception{
		return commProcedureService.getProcedureToObject("PR_CODE", codeName);
	}

	/**
	 *  시퀀스 받아 오기
	 * @param codeName
	 * @return
	 * @throws Exception
	 */
	protected Object getPrSeq(String seqName) throws Exception{
		return commProcedureService.getProcedureToObject("PR_SEQUENCE", seqName);
	}

	/**
	 * 쿠폰발행코드 받아 오기
	 * @param codeName
	 * @return
	 * @throws Exception
	 */
	protected Object getPrCopnIsuCode(String copnCd) throws Exception{
		return commProcedureService.getProcedureToObject("PR_COPN_ISU_CODE", copnCd);
	}

	protected void setMessageBox(MessageBox messageBox, ModelMap modelMap) {
		modelMap.put(MESSAGE_BOX_KEY, messageBox);
	}

}
