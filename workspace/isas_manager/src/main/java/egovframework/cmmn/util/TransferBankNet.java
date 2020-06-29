package egovframework.cmmn.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author vary
 *
 */
public class TransferBankNet{

	private static final Logger logger = LoggerFactory.getLogger(TransferBankNet.class);

	private static final String USER_AGENT = "Mozilla/5.0";
	private static String ACTION_URL = "";

	public TransferBankNet(String actionUrl){
		ACTION_URL = actionUrl;
	}

	public String sendMessage(Map<String, String> messageMap){
		URL url;
		HttpURLConnection con = null;
		//OutputStream out = null;
		BufferedReader in = null;
		StringBuilder reverseSB = new StringBuilder();
		int i = 0;

		if(messageMap != null){
			for (Entry<String, String> entry : messageMap.entrySet()) {
				if(i == 0){
					reverseSB.append("?" + entry.getKey());
				}else{
					reverseSB.append("&" + entry.getKey());
				}
				reverseSB.append("=" + entry.getValue());
				i++;
			}
		}
		reverseSB.trimToSize();
		String stringToReverse = reverseSB.toString();
		try {
			url = new URL(ACTION_URL+stringToReverse);
			con = (HttpURLConnection) url.openConnection();
			con.setConnectTimeout(10000);
			con.setReadTimeout(5000);
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", USER_AGENT);
			// For POST only - START
/*			con.setDoOutput(true);
			out = con.getOutputStream();
			out.write(stringToReverse.getBytes());
			out.flush();
			out.close();
			// For POST only - END
*/			int responseCode = con.getResponseCode();
			logger.debug("GET Response Code :: " + responseCode);
	        if (responseCode == HttpURLConnection.HTTP_OK) { //success
	            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuffer response = new StringBuffer();
	            while ((inputLine = in.readLine()) != null) {
	                response.append(inputLine);
	            }
	            in.close();
	            // print result
	            return response.toString();
	        } else {
	        	return "-101;GET request not worked.";
	        }
		}catch (MalformedURLException e) {
			return "-102;MalformedURLException. " + e.getMessage();
		} catch (UnsupportedEncodingException e) {
			return "-103;UnsupportedEncodingException. " + e.getMessage();
		} catch (IOException e) {
			return "-104;IOException. " + e.getMessage();
		}finally{
			if(con != null) con.disconnect();
		}
	}
}
