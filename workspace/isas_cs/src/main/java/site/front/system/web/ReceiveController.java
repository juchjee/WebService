package site.front.system.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.ehcache.EhCacheCache;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CaregoryService;


@Controller
public class ReceiveController extends BaseController{

	/** CaregoryService */
	@Resource(name = "CaregoryService")
	private CaregoryService caregoryService;

	@Autowired
	CacheManager cacheManager;

	/**
	 * admin 서버로 부터 메세지 수신
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(ISDS_URL + "receiveMessage.action")
	public String resetCategoryList(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model){
		Map<String, String> map = new HashMap<String, String>();
		try {
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String callName = CommonUtil.nvl(paramMap.get("CALL_NAME"));
			String token = CommonUtil.nvl(paramMap.get("TOKEN"));
			boolean isNextServerCall = false;
			logger.info(callName);
			if(MESSAGE_TOKEN.equals(token) && !"".equals(callName)){
				if("resetCategoryList".equals(callName)){
					EhCacheCache caregoryCache = (EhCacheCache) cacheManager.getCache("ListCache");
					caregoryCache.evict("getCategoryListFRONT");//캐쉬 삭제
					caregoryService.getCategoryList("FRONT");
					if("".equals(CommonUtil.nvl(paramMap.get("IS_SERVICE")))){
						isNextServerCall = true;
					}
				}
			}
			// Port
			if(isNextServerCall){
				String[] serverIPs = propertyService.getStringArray("frontIPs");
				if(serverIPs != null && serverIPs.length > 1){
					String thisServerIP = InetAddress.getLocalHost().getHostAddress();
					int serverPort = request.getLocalPort();
					if(serverPort > 0 && serverPort != 80){
						thisServerIP = thisServerIP+":"+serverPort;
					}
					for (int i = 0; i < serverIPs.length; i++) {
						String serverIP = serverIPs[i];
						String[] serverIpPort = serverIP.split(":");
						if(serverIpPort.length == 2 && "80".equals(serverIpPort[1])){
							serverIP = serverIpPort[0];
						}
						if(!thisServerIP.equals(serverIP)){//현재 was를 제외한 다른 was에도 메세지 전달
							sendNextServerMessage(callName, serverIP);
						}
					}
				}
			}
			map.put("message", "ok");
			model.addAttribute("outData", CommonUtil.mapToJsonString(map));
		} catch (Exception e) {
			map.put("message", "ERROR");
			model.addAttribute("outData", CommonUtil.mapToJsonString(map));
		}
		return "common/out";
	}

	private static void sendNextServerMessage(String callName, String serverIP){
		HttpURLConnection con = null;
		String strUrl = "http://"+serverIP+PROPERTY_ROOT_URI+ISDS_URL+"receiveMessage.action";
		try {
			String stringToReverse = "TOKEN="+MESSAGE_TOKEN+"&CALL_NAME="+callName+"&IS_SERVICE=Y";
			URL url = new URL(strUrl);
			BufferedReader in = null;
			con = (HttpURLConnection) url.openConnection();
			con.setConnectTimeout(10000);
			con.setReadTimeout(5000);
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", "Mozilla/5.0");
			// For POST only - START
			con.setDoOutput(true);
			OutputStream out = con.getOutputStream();
			out.write(stringToReverse.getBytes());
			out.flush();
			out.close();
			out = null;
			// For POST only - END
			int responseCode = con.getResponseCode();
	        if (responseCode == HttpURLConnection.HTTP_OK) { //success
	            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuffer response = new StringBuffer();
	            while ((inputLine = in.readLine()) != null) {
	                response.append(inputLine);
	            }
	            in.close();
	            // print result
	            logger.info(response.toString());
	        } else {
	        	logger.error("[ERROR SERVER Cache Clean] serverIP : "+serverIP + " POST request not worked");
	        }
		}catch (MalformedURLException e) {
			logger.error("[ERROR SERVER Cache Clean] serverIP : "+serverIP, e);
		} catch (UnsupportedEncodingException e) {
			logger.error("[ERROR SERVER Cache Clean] serverIP : "+serverIP, e);
		} catch (IOException e) {
			logger.error("[ERROR SERVER Cache Clean] serverIP : "+serverIP, e);
		}finally{
			if(con != null) con.disconnect();
		}
	}

}
