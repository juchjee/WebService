package com.ubi.erp.cmm.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ubi.erp.cmm.util.PropertyUtil;

@Service
public class ImageUploadService {

	private String saveFileName;

	public String uploadImgFile(String saveDir, HttpServletRequest request, HttpServletResponse response) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultiValueMap<String, MultipartFile> multiValueMap = multipartRequest.getMultiFileMap();

		File uploadDir = new File(saveDir);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		List<MultipartFile> files = multiValueMap.get("fileName");
		for (MultipartFile file : files) {
			if (!file.isEmpty()) {
				long limitSize = Long.parseLong(PropertyUtil.getString("attach.uploadSize"));
				if (limitSize > file.getSize()) {
					String fileName = file.getOriginalFilename();
					String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
					String onlyName = fileName.substring(0, fileName.lastIndexOf("."));
					saveFileName = fileName;
					// 파일명이 중복되는 경우 변경처리
					if (new File(saveDir + "/" + fileName).exists()) {
						int fileSeq = 1;
						while (isFileExists(saveDir, onlyName, fileSeq, ext)) {
							fileSeq++;
						}
						saveFileName = onlyName + "_" + fileSeq + "." + ext;
					}
					// 실제 파일 업로드
					file.transferTo(new File(saveDir + "/" + saveFileName));
				}
			}
		}
		return saveFileName;
	};

	public void deleteImgFile(String delDir, String imgPath) {
		File targetFile = new File(delDir, imgPath);
		if (targetFile.exists()) {
			targetFile.delete();
		}
	}

	public boolean isFileExists(String saveDir, String onlyName, int fileSeq, String ext) {
		return new File(saveDir + "/" + onlyName + "_" + (fileSeq) + "." + ext).exists();
	}

	public void getImage(HttpServletResponse response, String context, String getCode) throws IOException {
		response.setContentType("image/jpeg");
		String blankDir = "attach.basedir";
		File file = new File(PropertyUtil.getString(context) + "/" + getCode);
		FileInputStream fis = null;
		OutputStream os = null;

		try {
			fis = new FileInputStream(file);
			os = response.getOutputStream();
			IOUtils.copy(fis, os);
		} catch (FileNotFoundException ex) {
			file = new File(PropertyUtil.getString(blankDir) + "/blank.jpg");
			fis = new FileInputStream(file);
			os = response.getOutputStream();
			IOUtils.copy(fis, os);
		} finally {
			if (fis != null)
				fis.close();
			if (os != null)
				os.close();
		}
	}

}
