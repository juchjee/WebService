package egovframework.cmmn;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.SEED128;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import site.comm.service.impl.CommService;

/**
 * Dom Xml Helper
 *
 * @author vary
 *
 */
@SuppressWarnings("unchecked")
public class DomXmlHelper{

	private static final Logger logger = LoggerFactory.getLogger(DomXmlHelper.class);

	/**
	공급지정보 조회
	http://ship.epost.go.kr/api.GetOfficeInfo.jparcel?key=test&regData=980e605c405a3264e00acbb0a341902c
	종추적API 서비스인
	테스트URL :http://biz.epost.go.kr/KpostPortal/openapi?regkey=test&target=trace&query=1234567890123
	접수(픽업요청)
	http://ship.epost.go.kr/api.InsertOrder.jparcel?key=test&regData=980e605c405a3264e00acbb0a341902c
	접수확인
	http://ship.epost.go.kr/api.GetResInfo.jparcel?key=test&regData=980e605c405a3264e00acbb0a341902c
	계약승인 번호 조회
	http://ship.epost.go.kr/api.GetApprNo.jparcel?key=test&regData=980e605c405a3264e00acbb0a341902c
	고객번호 조회
	http://ship.epost.go.kr/api.GetCustNo.jparcel?key=test&regData=980e605c405a3264e00acbb0a341902c
	*/

	/*접수(픽업요청), 종추적, 공급지정보 조회*/
	private static final String[] urls = {
			"http://ship.epost.go.kr/api.InsertOrder.jparcel"
			, "http://biz.epost.go.kr/KpostPortal/openapi"
			, "http://ship.epost.go.kr/api.GetOfficeInfo.jparcel"
			, "http://ship.epost.go.kr/api.GetApprNo.jparcel"
			, "http://ship.epost.go.kr/api.GetCustNo.jparcel"
		};

	private static Map<String, String> userMap = new HashMap<String, String>();
	{
		DomXmlHelper.userMap.put("memberID", "cbtis2004");
	}

	private URL url = null;
	private SEED128 seed = null;
	private Map<String, Object> sourceMap = null;
	private List<Map<String, Object>> sourceList = null;
	private boolean sourceIsList = false;
	private boolean isMkObj = false;

	private String siteId = null;
	private String sitePw = null;
	private String strUrl = null;
	/**
	 * 0:접수(픽업요청), 1:종추적, 2:공급지정보 조회, 3:계약승인번호 조회, 4:고객번호 조회
	 */
	private int intUrl = -1;

	public DomXmlHelper(CommService commService) throws Exception{
		CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "EPOST");
		this.siteId = siteCode.getString("siteId");
		this.sitePw = siteCode.getString("sitePw");
	}

	public DomXmlHelper(String siteId, String sitePw) throws Exception{
		this.siteId = siteId;
		this.sitePw = sitePw;
	}

	/**
	 * @param intUrl 0:접수(픽업요청), 1:종추적
	 * @param commService
	 * @param map
	 * @throws Exception
	 */
	public void contXmlHelper(int intUrl, Map<String, Object> map) throws Exception {
		this.sourceIsList = false;
		this.sourceMap = map;
		DomXmlHelperInit(intUrl);
		send(map);
	}

	/**
	 * @param intUrl 0:접수(픽업요청), 1:종추적
	 * @param commService
	 * @param list
	 * @throws Exception
	 */
	public void contXmlHelper(int intUrl, List<Map<String, Object>> list) throws Exception {
		this.sourceIsList = true;
		this.sourceList = list;
		DomXmlHelperInit(intUrl);
		int cnt = CommonUtil.getSize(list);
		if(cnt == 0) return;
		for (int i = 0; i < cnt; i++) {
			send(list.get(i));
		}
	}

	private void DomXmlHelperInit(int intUrl) throws Exception {
		this.seed = new SEED128();
		this.intUrl = intUrl;
		this.strUrl = DomXmlHelper.urls[intUrl];
		this.url = new URL(this.strUrl);
	}

	private void send(Map<String, Object> paramMap) throws Exception{
		StringBuilder reverseSB = new StringBuilder();
		if(paramMap != null){
			CamelMap<String, Object> paramCamelMap = new CamelMap<>(paramMap);
			if(this.intUrl == 1){//종추적
				paramCamelMap.put("REGKEY", this.siteId);
				paramCamelMap.put("TARGET", "trace");
			}else if(this.intUrl == 0){//접수(픽업요청)
				paramCamelMap.put("CUST_NO", this.get("custNo"));
				paramCamelMap.put("OFFICE_SER", this.get("officeSer"));
				paramCamelMap.put("ORD_COMP_NM", this.get("ordCompNm"));
				paramCamelMap.put("APPR_NO", this.get("apprNo"));
			}
			for (Entry<String, Object> entry : paramCamelMap.entrySet()) {
				if(reverseSB.length() > 0){
					reverseSB.append("&");
				}
				reverseSB.append(entry.getKey());
				reverseSB.append("=" + entry.getValue());
			}
		}
		reverseSB.trimToSize();
		String stringToReverse = reverseSB.toString();

		if(this.intUrl != 1){//종추적은 암호화 필요 없음
			stringToReverse = "key=" + siteId + "&regData=" + seed.getEncryptData(this.sitePw, stringToReverse);
		}
		sendData(stringToReverse, paramMap);
	}

	private void sendData(String stringToReverse, Map<String, Object> paramMap){
		OutputStreamWriter writer = null;
		BufferedReader in = null;
		HttpURLConnection con = null;
		try {
			logger.info(url.toString() + "?" + stringToReverse);
			con = (HttpURLConnection) url.openConnection();
			con.setDoOutput(true);
			con.setConnectTimeout(12000);
			con.setReadTimeout(10000);
			con.setRequestMethod("POST");
			writer = new OutputStreamWriter(con.getOutputStream());
			writer.write(stringToReverse);
			writer.flush();
			writer.close();
			if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				try {
		            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		            StringBuilder responseSB = new StringBuilder();
		            String inputLine;
		            while ((inputLine = in.readLine()) != null) {
		            	responseSB.append(inputLine);
		            }
		            in.close();
		            responseSB.trimToSize();
		            String recvXmlStr = responseSB.toString();
		            logger.info(recvXmlStr);
		            paramMap.put("recvXmlStr", recvXmlStr);
		            in = null;
				} catch (IOException e) {
					if(in != null) in.close();
				}
	        } else {
	        	logger.error("request not worked.");
	        }
		} catch (IOException e) {
			logger.error("IOException.", e);
		}finally{
			if(writer != null){
				try {
					writer.close();
				} catch (IOException e) {
					logger.error("writer close.", e);
				}
			}
			if(con != null) con.disconnect();
		}
	}

	public String getXmlStr(){
		if(sourceIsList){
			JSONArray ja = new JSONArray();
			for (Map<String, Object> map : sourceList) {
				String recvXmlStr = CommonUtil.nvlTrim(map.get("recvXmlStr"));
				if(!"".equals(recvXmlStr)){
					ja.put(recvXmlStr);
				}
			}
			return ja.toString();
		}else{
			return CommonUtil.nvlTrim(sourceMap.get("recvXmlStr"));
		}
	}

	public Object getObjct(){
		if(sourceIsList){
			if(!isMkObj){
				for (Map<String, Object> map : sourceList) {
					parseXml(map);
				}
				isMkObj = true;
			}
			return sourceList;
		}else{
			if(!isMkObj){
				parseXml(sourceMap);
				isMkObj = true;
			}
			return sourceMap;
		}
	}

	public Map<String, Object> getMap(){
		Map<String, Object> reMap = new HashMap<>();
		if(sourceIsList){
			return reMap;
		}
		String recvXmlStr = CommonUtil.nvlTrim(sourceMap.get("recvXmlStr"));
		if("".equals(recvXmlStr)){
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("ERROR_CODE", "ERR-999");
			errorMap.put("MESSAGE", "통신 이상으로 데이터 받아 오지 못함.");
			Map<String, Object> xsyncMap = new HashMap<>();
			xsyncMap.put("error", errorMap);
			reMap.put("xsync", xsyncMap);
			reMap.put("isSuccess", "false");
		}else{
			reMap.putAll(JsonHelper.toMap(XML.toJSONObject(recvXmlStr)));
			if(recvXmlStr.indexOf("<error>") > -1){
				reMap.put("isSuccess", "false");
			}else{
				reMap.put("isSuccess", "true");
			}
		}
		return reMap;
	}

	private void parseXml(Map<String, Object> sourceMap){
		String recvXmlStr = CommonUtil.nvlTrim(sourceMap.get("recvXmlStr"));
		if(!"".equals(recvXmlStr)){
			JSONObject jsonObject = XML.toJSONObject(recvXmlStr);
			sourceMap.put("recvJsonObj", jsonObject);
			sourceMap.put("recvMapObj", new HashMap<String, Object>(JsonHelper.toMap(jsonObject)));
			if(recvXmlStr.indexOf("<error>") > -1){
				sourceMap.put("isSuccess", "false");
			}else{
				sourceMap.put("isSuccess", "true");
			}
		}
	}

	public String getObjStr(){
		Object sourceObj = getObjct();
		StringBuilder objStr = new StringBuilder();
		if(sourceIsList){
			for (Map<String, Object> map : (List<Map<String, Object>>) sourceObj) {
				objStr.append((map.get("recvJsonObj")).toString());
			}
		}else{
			objStr.append((((Map<String, Object>) sourceObj).get("recvJsonObj")).toString());
		}
		objStr.trimToSize();
		return objStr.toString();
	}

	/**
	 * @param key - custNo : 고객번호, officeSer : 공급지코드, ordCompNm : 공급지명, apprNo : 우체국 고객번호
	 * @return
	 * @throws Exception
	 */
	public String get(String key) throws Exception{
		String reValue = userMap.get(key);
		if(reValue == null){
			initUserMap();
			return userMap.get(key);
		}
		return reValue;
	}

	public void cleanUserMap(){
		Map<String, String> _userMap = DomXmlHelper.userMap;
		String memberID = _userMap.get("memberID");
		_userMap.clear();
		_userMap.put("memberID", memberID);
	}

	//2:공급지정보 조회, 3:계약승인번호 조회, 4:고객번호 조회
	private void initUserMap() throws Exception{
		Map<String, String> _userMap = DomXmlHelper.userMap;
		String custNo = _userMap.get("custNo");
		String apprNo = _userMap.get("apprNo");
		String ordCompNm = _userMap.get("ordCompNm");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(custNo == null){
			paramMap.put("MEMBER_I_D", _userMap.get("memberID"));
			DomXmlHelper domXmlHelper4 = new DomXmlHelper(siteId, sitePw);
			domXmlHelper4.contXmlHelper(4, paramMap);
			Map<String, Object> sourceObj4 = (Map<String, Object>) domXmlHelper4.getObjct();
			Map<String, Object> officeInfoMap4 = (Map<String, Object>) sourceObj4.get("recvMapObj");
			HashMap<String, Object> officeInfoRoot4 = (HashMap<String, Object>) officeInfoMap4.get("xsync");
			custNo = CommonUtil.nvlTrim(officeInfoRoot4.get("custNo"));
			for (Entry<String, Object> entry : officeInfoRoot4.entrySet()) {
				_userMap.put(entry.getKey(), CommonUtil.nvlTrim(entry.getValue()));
			}
		}
		if("".equals(custNo)){
			logger.error("custNo not find.");
		}
		if(apprNo == null){
			paramMap.clear();
			paramMap.put("CUST_NO", custNo);
			DomXmlHelper domXmlHelper3 = new DomXmlHelper(siteId, sitePw);
			domXmlHelper3.contXmlHelper(3, paramMap);
			Map<String, Object> sourceObj3 = (Map<String, Object>) domXmlHelper3.getObjct();
			Map<String, Object> officeInfoMap3 = (Map<String, Object>) sourceObj3.get("recvMapObj");
			Map<String, Object> officeInfoRoot3 = (Map<String, Object>) officeInfoMap3.get("xsync");
			HashMap<String, Object> contractInfo3 = (HashMap<String, Object>) officeInfoRoot3.get("contractInfo");
			apprNo = CommonUtil.nvlTrim(contractInfo3.get("apprNo"));
			for (Entry<String, Object> entry : contractInfo3.entrySet()) {
				_userMap.put(entry.getKey(), CommonUtil.nvlTrim(entry.getValue()));
			}
		}
		if(ordCompNm == null){
			paramMap.put("CUST_NO", custNo);
			DomXmlHelper domXmlHelper2 = new DomXmlHelper(siteId, sitePw);
			domXmlHelper2.contXmlHelper(2, paramMap);
			Map<String, Object> sourceObj2 = (Map<String, Object>) domXmlHelper2.getObjct();
			Map<String, Object> officeInfoMap2 = (Map<String, Object>) sourceObj2.get("recvMapObj");
			Map<String, Object> officeInfoRoot2 = (Map<String, Object>) officeInfoMap2.get("xsync");
			HashMap<String, Object> officeInfo2 = (HashMap<String, Object>) officeInfoRoot2.get("officeInfo");
			ordCompNm = CommonUtil.nvlTrim(officeInfo2.get("officeNm"));
			for (Entry<String, Object> entry : officeInfo2.entrySet()) {
				_userMap.put(entry.getKey(), CommonUtil.nvlTrim(entry.getValue()));
			}
			_userMap.put("ordCompNm", ordCompNm);
		}
	}

	public Map<String, String> getUserMap() {
		return DomXmlHelper.userMap;
	}
}