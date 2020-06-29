package com.ubi.erp.cmm.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.util.Log;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownLoadUtil extends AbstractView {

	public final static int BUFFER_SIZE = 8192;

	public DownLoadUtil() {
		setContentType("applicaiton/download;charset=utf-8");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		File file = (File) model.get("downloadFile");

		response.setContentType(getContentType());
		response.setContentLength((int) file.length());

		String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");

		response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;

		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			Log.debug(e);
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e2) {
					Log.debug(e2);
				}
			}
		}
		out.flush();
	}
}
