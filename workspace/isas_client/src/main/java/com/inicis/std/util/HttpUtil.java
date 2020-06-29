package com.inicis.std.util;

import java.util.Iterator;
import java.util.Map;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HostConfiguration;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpUtil {

	protected static final Logger log = LoggerFactory.getLogger(HttpUtil.class);

	private HttpClient client;
	private PostMethod postMethod;
	private HostConfiguration hostConf;

	private String contentType = "application/x-www-form-urlencoded; text/html; charset=euc-kr";
	private String charsetName = "KSC5601";

	private static int CONNECTION_TIMEOUT = 5000;
	private static int RECEIVE_TIMEOUT = 25000;

	@SuppressWarnings("rawtypes")
	public String processHTTP(Map requestMap, String actionURL) throws Exception {
		int statusCode = 0;
		String result = null;

		log.info("REQUEST URL  : " + actionURL);
		log.info("REQUEST PARAM: " + requestMap.toString());
		try {
			this.hostConf = new HostConfiguration();
			this.client = new HttpClient();
			this.client.getHttpConnectionManager().getParams().setConnectionTimeout(CONNECTION_TIMEOUT);
			this.client.getHttpConnectionManager().getParams().setSoTimeout(RECEIVE_TIMEOUT);
			this.postMethod = new PostMethod(actionURL);
			this.postMethod.setRequestHeader("Content-Type", contentType);
			this.postMethod.setRequestHeader("Cache-Control", "no-cache");
			this.hostConf.setHost(this.postMethod.getURI().getHost(), this.postMethod.getURI().getPort());
			NameValuePair[] params = makeParam(requestMap);
			this.postMethod.setRequestBody(params);
			try {
				statusCode = this.client.executeMethod(this.postMethod);
			} catch (Exception ex) {
				ex.printStackTrace();
				throw ex;
			}
			Header[] arrayOfHeader;
			int j = (arrayOfHeader = this.postMethod.getResponseHeaders()).length;
			for (int i = 0; i < j; i++) {
				Header header = arrayOfHeader[i];
				log.debug(header.getName() + "=" + header.getValue());
			}
			if (statusCode == 200) {
				result = this.postMethod.getResponseBodyAsString();
				log.info("RESPONSE DATA: " + result.trim());
				return result.trim();
			}
			throw new HttpException("" + statusCode);
		} catch (Exception ex) {
			log.error("REQUEST URL  : " + actionURL + "\nREQUEST PARAM: " + requestMap.toString() + "\nRESPONSE DATA: " + result);
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				if (this.postMethod != null) {
					this.postMethod.releaseConnection();
				}
			} catch (Exception ex) {
				log.error("release connection error", ex);
				this.postMethod = null;
			}
			try {
				if (this.client != null) {
					this.client.getHttpConnectionManager().getConnection(this.hostConf).close();
				}
			} catch (Exception ex) {
				log.error("connection close error", ex);
			}
		}
	}

	@SuppressWarnings("rawtypes")
	public NameValuePair[] makeParam(Map requestMap) throws Exception {
		int hashSize = requestMap.size();

		Iterator keyset = requestMap.keySet().iterator();
		NameValuePair[] params = new NameValuePair[hashSize];

		String key = "";
		for (int i = 0; i < hashSize; i++) {
			key = (String) keyset.next();
			params[i] = new NameValuePair(key, new String(((String) requestMap.get(key)).getBytes(), charsetName));
		}
		return params;
	}

	/**
	 * Content-Type
	 * @return
	 */
	public HostConfiguration getHostConf() {
		return hostConf;
	}

	/**
	 * Content-Type
	 * @param hostConf
	 */
	public void setHostConf(HostConfiguration hostConf) {
		this.hostConf = hostConf;
	}

	/**
	 *
	 * @return
	 */
	public String getCharsetName() {
		return charsetName;
	}

	/**
	 * @param charsetName
	 */
	public void setCharsetName(String charsetName) {
		this.charsetName = charsetName;
	}
}
