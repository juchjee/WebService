package egovframework.cmmn.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.EgovProperties;

/**
 * @author vary
 *
 */
public class Net{

	private static final Logger logger = LoggerFactory.getLogger(Net.class);

	private static final String USER_AGENT = "Mozilla/5.0";

	/**
	 * admin was와 Front was 상호 통신을 할때 서로 가 보낸 건지르 확인하기 위한 키값
	 */
	private static final String MESSAGE_URL = EgovProperties.getSiteProperty("FrontUrl") + "/ISDS/receiveMessage.action";

	/**
	 * admin was와 Front was 상호 통신을 할때 서로 가 보낸 건지르 확인하기 위한 키값
	 */
	private static final String MESSAGE_TOKEN = EgovProperties.getSiteProperty("messageToken");

	public void sendMessage(String callName){
		sendMessage(null, callName);
	}

	public void sendMessage(Map<String, String> messageMap, String callName){
		URL url;
		HttpURLConnection con = null;
		OutputStream out = null;
		BufferedReader in = null;
		StringBuilder reverseSB = new StringBuilder();

		reverseSB.append("token=" + MESSAGE_TOKEN);
		if(callName != null)reverseSB.append("&callName=" + callName);
		if(messageMap != null){
			for (Entry<String, String> entry : messageMap.entrySet()) {
				reverseSB.append("&" + entry.getKey());
				reverseSB.append("=" + entry.getValue());
			}
		}
		reverseSB.trimToSize();
		String stringToReverse = reverseSB.toString();
		try {
			url = new URL(MESSAGE_URL);
			con = (HttpURLConnection) url.openConnection();
			con.setConnectTimeout(20000);
			con.setReadTimeout(15000);
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", USER_AGENT);
			// For POST only - START
			con.setDoOutput(true);
			out = con.getOutputStream();
			out.write(stringToReverse.getBytes());
			out.flush();
			out.close();
			// For POST only - END
			int responseCode = con.getResponseCode();
			logger.info("POST Response Code :: " + responseCode);
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
	        	logger.error("POST request not worked");
	        }
		}catch (MalformedURLException e) {
			logger.error("MalformedURLException", e);
		} catch (UnsupportedEncodingException e) {
			logger.error("UnsupportedEncodingException", e);
		} catch (IOException e) {
			logger.error("IOException", e);
		}finally{
			if(con != null) con.disconnect();
		}
	}
}
