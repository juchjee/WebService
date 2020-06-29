package egovframework.cmmn.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import devpia.dextupload.DEXTUploadException;
import devpia.dextupload.FileItem;
import devpia.dextupload.FileUpload;
import devpia.dextupload.image.ImageTool;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.IConstants;

/**
 * 데이터 입출력용 유틸리티 클래스
 */
public class FileUpLoad implements IConstants{

	protected static final Logger logger = LoggerFactory.getLogger(FileUpLoad.class);

	protected static String imageUploadPath = null;
	protected static String imagesUploadUrl = null;
	protected static String popUploadPath = null;
	protected static String popUploadUrl = null;
	protected static String docUploadPath = null;
	protected static String docUploadUrl = null;

	private EgovMessageSource egovMessageSource;
	private FileUpload fileUpload;

	public FileUpLoad(HttpServletRequest request, HttpServletResponse response) {
		if(imageUploadPath == null){
			imageUploadPath = IMAGE_UPLOAD_PATH.replaceAll("\\\\", "/");
			imagesUploadUrl = (PROPERTY_ROOT_URI + IMAGES_UPLOAD_URL).replaceAll("\\\\", "/");
		}

		if(popUploadPath == null){
			popUploadPath = POP_UPLOAD_PATH.replaceAll("\\\\", "/");
			popUploadUrl = (PROPERTY_ROOT_URI + POP_UPLOAD_URL).replaceAll("\\\\", "/");
		}
		if(docUploadPath == null){
			docUploadPath = DOC_UPLOAD_PATH.replaceAll("\\\\", "/");
			docUploadUrl = (PROPERTY_ROOT_URI + DOC_UPLOAD_URL).replaceAll("\\\\", "/");
		}
		
		WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		egovMessageSource = (EgovMessageSource) wac.getBean("egovMessageSource");
		fileUpload = new FileUpload(request, response);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String uploadName, int imageMaxWidthOrHeight) throws Exception {
		return imgFileUpload(savePath, new String[]{uploadName}, new int[]{imageMaxWidthOrHeight}, true);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String uploadName) throws Exception {
		return imgFileUpload(savePath, new String[]{uploadName}, null, true);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String[] uploadName, int imageMaxWidthOrHeight) throws Exception {
		return imgFileUpload(savePath, uploadName, new int[]{imageMaxWidthOrHeight}, true);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String[] uploadName) throws Exception {
		return imgFileUpload(savePath, uploadName, null, true);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String uploadName, int[] imageMaxWidthOrHeight) throws Exception {
		return imgFileUpload(savePath, new String[]{uploadName}, imageMaxWidthOrHeight, true);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String[] uploadName, int[] imageMaxWidthOrHeight) throws Exception {
		return imgFileUpload(savePath, uploadName, imageMaxWidthOrHeight, true);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String uploadName, String[] imageMaxWidthOrHeight) throws Exception {
		return imgFileUpload(savePath, new String[]{uploadName}, imageMaxWidthOrHeight);
	}

	public UnCamelMap<String, Object> imgFileUpload(String savePath, String[] uploadName, String[] imageMaxWidthOrHeight) throws Exception {
		int[] imageMaxWidthOrHeightI = new int[imageMaxWidthOrHeight.length];
		for (int i = 0; i < imageMaxWidthOrHeightI.length; i++) {
			imageMaxWidthOrHeightI[i] = CommonUtil.nvl(imageMaxWidthOrHeight[i], -1);
		}
		return imgFileUpload(savePath, uploadName, imageMaxWidthOrHeightI, true);
	}

	@SuppressWarnings("unchecked")
	public UnCamelMap<String, Object> imgFileUpload(String savePath, String[] uploadName, int[] imageMaxWidthOrHeight, boolean isSubDirectoryPathByDateType) throws Exception {
		UnCamelMap<String, Object> params = new UnCamelMap<String, Object>();
		savePath = savePathFilter(savePath);
		String strPath = imageUploadPath + savePath;
		String subDir = "";
		if(isSubDirectoryPathByDateType){
			subDir = DirectoryPathManager.getDirectoryPathByDateType(DirectoryPathManager.DIR_DATE_TYPE.DATE_POLICY_YYYY_MM);
			subDir = subDir.replaceAll("\\\\", "/");
		}
		try {
			// 정품 혹은 평가판의 만료일을 판단하기 위한 라이센스 파일의 위치를 지정합니다.
			fileUpload.setLicenseFilePath(DEXTUPLOADJ_CONFIG);
			fileUpload.setAutoMakeFolder(true);
			fileUpload.setMaxFileLength(FILE_MAX_SIZE);
			fileUpload.setMaxTotalLength(FILE_MAX_SIZE_TOTAL);
			fileUpload.UploadStart(strPath + subDir);
			params.putAll(fileUpload.getParameterMap());
			for (int i = 0; i < uploadName.length; i++) {
				//getFileItemValues(uploadName)을 사용해서 중복된 모든 파일 아이템을 가져온다.
				FileItem[] value = null;
				try {
					value = fileUpload.getFileItemValues(uploadName[i]);
				} catch (Exception ex) {
					logger.info("Exception", ex);
				}
				if(value == null) continue;
				List<Map<String, Object>> saveFileList = new ArrayList<Map<String, Object>>();
				for (int j = 0; j < value.length; j++){
					if(value[j] != null && value[j].IsUploaded()){
						String originalFileName = FilenameUtils.getName(value[j].getFileName());
						String fileName = RandomStringUtils.randomAlphabetic(10) + System.currentTimeMillis() + "." + StringUtils.lowerCase(StringUtils.substringAfterLast(originalFileName, "."));
						value[j].SaveAs(strPath + subDir, fileName, true);
						int imageMaxWidthOrHeightI = -1;
						String SavePath = value[j].getLastSavedFilePath();
						if(imageMaxWidthOrHeight != null){
							ImageTool image = ImageTool.getImageTool(new File(SavePath));
							String[] aPaths = SavePath.split("[.]", 2);
							int imageOrgWidth = image.getWidth();
							int imageOrgHeight = image.getHeight();
							imageMaxWidthOrHeightI = imageMaxWidthOrHeight[0];
							if(imageMaxWidthOrHeight.length == value.length){
								imageMaxWidthOrHeightI = imageMaxWidthOrHeight[j];
							}
							if(imageOrgWidth > imageMaxWidthOrHeightI || imageOrgHeight > imageMaxWidthOrHeightI){
								int newWidth = 0;
								int newHeight = 0;
								if(imageOrgWidth >= imageOrgHeight){
									newHeight = (imageMaxWidthOrHeightI * imageOrgHeight) / imageOrgWidth;
									newWidth = imageMaxWidthOrHeightI;
								}else{
									newWidth = (imageMaxWidthOrHeightI * imageOrgWidth) / imageOrgHeight;
									newHeight = imageMaxWidthOrHeightI;
								}
								image.setSize(newWidth, newHeight);
								SavePath = aPaths[0] + "_" + imageMaxWidthOrHeightI + "." + aPaths[1];
								image.SaveImageToJPEG(SavePath);
							}
						}
						saveFileList.add(getFileMap(originalFileName, uploadName[i], SavePath, imageMaxWidthOrHeightI));
					}
				}
				if(saveFileList.size() > 0){
					params.put(uploadName[i] + "List", saveFileList);
				}
			}
		} catch (DEXTUploadException duex) {
			logger.info("DEXTUploadException", duex);
		}catch (Exception ex) {
			logger.info("Exception", ex);
		}finally {
			// 종료 시에 반드시 자원을 해제해야 한다.
			// 그렇지 않으면 임시 파일이 삭제되지 않고 남을 수 있다.
			fileUpload.dispose();
		}
		logger.info("MultiPart RequestParams : " + CommonUtil.mapToJsonString(params));
		return params;
	}


	public  List<UnCamelMap<String, Object>> setImageSize(Map<String, String> imageMap, String[] imageMaxWidthOrHeight) throws Exception {
		int[] imageMaxWidthOrHeightI = new int[imageMaxWidthOrHeight.length];
		for (int i = 0; i < imageMaxWidthOrHeightI.length; i++) {
			imageMaxWidthOrHeightI[i] = CommonUtil.nvl(imageMaxWidthOrHeight[i], -1);
		}
		return setImageSize(imageMap,  imageMaxWidthOrHeightI);
	}

	public  List<UnCamelMap<String, Object>> setImageSize(Map<String, String> imageMap, int imageMaxWidthOrHeight) throws Exception {

		return setImageSize(imageMap,   new int[]{imageMaxWidthOrHeight});
	}

	public List<UnCamelMap<String, Object>> setImageSize(Map<String, String> imageMap, int[] imageSizes){
		List<UnCamelMap<String, Object>> reImageList = null;
		if(imageMap != null && imageSizes != null){
			reImageList = new ArrayList<>();
			String fName = imageMap.get("ATTCH_FILE_NM");
			String domName = imageMap.get("DOM_NAME");
			String aPath = imageMap.get("ATTCH_ABSOLUTE_PATH");
			String[] aPaths = aPath.split("[.]", 2);
			for (int i = 0; i < imageSizes.length; i++) {
				int imageSize = imageSizes[i];
				File file = new File(aPath);
				String savePath = aPath;
				try {
					ImageTool image = ImageTool.getImageTool(file);
					int imageWidth = image.getWidth();
					int imageHeight = image.getHeight();
					if(imageWidth > imageSize || imageHeight > imageSize){
						if(imageWidth >= imageHeight){
							imageHeight = (imageSize * imageHeight) / imageWidth;
							imageWidth = imageSize;
						}else{
							imageWidth = (imageSize * imageWidth) / imageHeight;
							imageHeight = imageSize;
						}
						image.setSize(imageWidth, imageHeight);
						savePath = aPaths[0] + "_" + imageSize + "." + aPaths[1];
						image.SaveImageToJPEG(savePath);
					}
					reImageList.add(getFileMap(fName, domName, savePath, imageSize));
				} catch (DEXTUploadException e) {
					logger.error(aPath + " DEXTUploadException");
				} catch (IOException e) {
					logger.error("IOException");
				}
			}
		}
		return reImageList;
	}

	private UnCamelMap<String, Object> getFileMap(String attchFileNm, String domName, String savedFilePath, int imageSize){
		if(CommonUtil.nvl(attchFileNm).equals("") && CommonUtil.nvl(savedFilePath).equals("")){
			return null;
		}
		String attchAbsolutePath = savedFilePath.replaceAll("\\\\", "/");
		String attchRealFileNm = attchAbsolutePath.substring(attchAbsolutePath.lastIndexOf("/")+1, attchAbsolutePath.length());
		String attchFilePath = attchAbsolutePath.replace(imageUploadPath, imagesUploadUrl).replace(popUploadPath, popUploadUrl).replace(docUploadPath, docUploadUrl);
		UnCamelMap<String, Object> unCamelMap = new UnCamelMap<String, Object>();
		unCamelMap.put("ATTCH_ABSOLUTE_PATH", attchAbsolutePath);//서버상의 파일 경로
		unCamelMap.put("ATTCH_REAL_FILE_NM", attchRealFileNm);//파일 저장된 이름
		unCamelMap.put("ATTCH_FILE_PATH", attchFilePath);//웹상의 파일 경로
		unCamelMap.put("ATTCH_FILE_NM", attchFileNm);//오리지널 파일 이름
		unCamelMap.put("DOM_NAME", domName);//인풋 박스 이름
		if(imageSize > 0){
			unCamelMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchAbsolutePath.replace("_"+imageSize+".", "."));//사이즈 변경 전  파일 이름
			unCamelMap.put("MAX_SIZE", "" + imageSize);
		}else{
			unCamelMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchAbsolutePath);//사이즈 변경 전  파일 이름
			unCamelMap.put("MAX_SIZE", "");
		}

		return unCamelMap;
	}

	public UnCamelMap<String, Object> excelFileUpload(String savePath, String uploadName) throws Exception {
		return fileUpload(DOC_UPLOAD_PATH, savePath, new String[]{uploadName}, true);
	}

	public UnCamelMap<String, Object> docFileUpload(String savePath, String[] uploadName) throws Exception {
		return fileUpload(DOC_UPLOAD_PATH, savePath, uploadName, true);
	}

	public UnCamelMap<String, Object> docFileUpload(String savePath, String[] uploadName, boolean isSubDirectoryPathByDateType) throws Exception {
		return fileUpload(DOC_UPLOAD_PATH, savePath, uploadName, isSubDirectoryPathByDateType);
	}

	public UnCamelMap<String, Object> popFileUpload(String savePath, String[] uploadName) throws Exception {

		return fileUpload(POP_UPLOAD_PATH, savePath, uploadName, true);
	}

	public UnCamelMap<String, Object> popFileUpload(String savePath, String[] uploadName, boolean isSubDirectoryPathByDateType) throws Exception {
		return fileUpload(POP_UPLOAD_PATH, savePath, uploadName, isSubDirectoryPathByDateType);
	}

	@SuppressWarnings("unchecked")
	private UnCamelMap<String, Object> fileUpload(String uploadPath, String savePath, String[] uploadName, boolean isSubDirectoryPathByDateType) throws Exception {
		savePath = savePathFilter(savePath);
		String strPath = uploadPath + savePath;
		String subDir = "";
		UnCamelMap<String, Object> params = new UnCamelMap<String, Object>();
		if(isSubDirectoryPathByDateType){
			subDir = DirectoryPathManager.getDirectoryPathByDateType(DirectoryPathManager.DIR_DATE_TYPE.DATE_POLICY_YYYY_MM);
			subDir = subDir.replaceAll("\\\\", "/");
		}
		try {
			// 정품 혹은 평가판의 만료일을 판단하기 위한 라이센스 파일의 위치를 지정합니다.
			fileUpload.setLicenseFilePath(DEXTUPLOADJ_CONFIG);
			fileUpload.setAutoMakeFolder(true);

			fileUpload.setMaxFileLength(FILE_MAX_SIZE);
			fileUpload.setMaxTotalLength(FILE_MAX_SIZE_TOTAL);

			fileUpload.UploadStart(strPath + subDir);
			params.putAll(fileUpload.getParameterMap());
			for (int i = 0; i < uploadName.length; i++) {
				List<UnCamelMap<String, Object>> saveFileList = new ArrayList<UnCamelMap<String, Object>>();
				//getFileItemValues(uploadName)을 사용해서 중복된 모든 파일 아이템을 가져온다.
				FileItem[] value = fileUpload.getFileItemValues(uploadName[i]);
				for (int j = 0; j < value.length; j++){
					if(value[j] != null && value[j].IsUploaded()){
						String originalFileName = FilenameUtils.getName(value[j].getFileName());
						String fileName = RandomStringUtils.randomAlphabetic(10) + System.currentTimeMillis() + "." + StringUtils.lowerCase(StringUtils.substringAfterLast(originalFileName, "."));
						value[j].SaveAs(strPath + subDir, fileName, true);
						saveFileList.add(getFileMap(originalFileName, uploadName[i], value[j].getLastSavedFilePath(), -1));
					}
				}
				if(saveFileList.size() > 0){
					params.put(uploadName[i] + "List", saveFileList);
				}
			}
		}catch (DEXTUploadException duex) {
			logger.info(duex.getMessage());
		}catch (Exception ex) {
			logger.info(ex.getMessage());
		}finally {
			// 종료 시에 반드시 자원을 해제해야 한다.
			// 그렇지 않으면 임시 파일이 삭제되지 않고 남을 수 있다.
			fileUpload.dispose();
		}
		return params;
	}

	private String getMessage(String code) {
		return egovMessageSource.getMessage(code);
	}

	private String savePathFilter(String savePath){
		String reSavePath = CommonUtil.nvl(savePath);
		if("".equals(reSavePath)){
			return reSavePath;
		}
		if (reSavePath.startsWith("/")) {
			reSavePath = StringUtils.removeStart(reSavePath, "/");
		}
		if (reSavePath.startsWith("\\")) {
			reSavePath = StringUtils.removeStart(reSavePath, "\\");
		}
		if (reSavePath.endsWith("/")) {
			reSavePath = StringUtils.removeEnd(reSavePath, "/");
		}
		if (reSavePath.endsWith("\\")) {
			reSavePath = StringUtils.removeEnd(reSavePath, "\\");
		}
		return reSavePath + "/";
	}

	/**
	 * 네이버 에디터에서 에디터 페이지안의 이미지를 저장
	 * @param savePath
	 * @param uploadName
	 * @param imageMaxWidth
	 * @return
	 * @throws Exception
	 */
	public String editImgFileUpload(String savePath, String uploadName, int imageMaxWidth) throws Exception {
		return editImgFileUpload(savePath, uploadName, imageMaxWidth, true);
	}

	/**
	 * 네이버 에디터에서 에디터 페이지안의 이미지를 저장
	 * @param savePath
	 * @param uploadName
	 * @param imageMaxWidth
	 * @param isSubDirectoryPathByDateType
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String editImgFileUpload(String savePath, String uploadName, int imageMaxWidth, boolean isSubDirectoryPathByDateType){
		savePath = savePathFilter(savePath);
		String strPath = imageUploadPath + savePath;
		String subDir = "";
		String return1="";
		String return2="";
		String return3="";
		if(isSubDirectoryPathByDateType){
			subDir = DirectoryPathManager.getDirectoryPathByDateType(DirectoryPathManager.DIR_DATE_TYPE.DATE_POLICY_YYYY_MM);
			subDir = subDir.replaceAll("\\\\", "/");
		}
		try {
			// 정품 혹은 평가판의 만료일을 판단하기 위한 라이센스 파일의 위치를 지정합니다.
			fileUpload.setLicenseFilePath(DEXTUPLOADJ_CONFIG);
			fileUpload.setAutoMakeFolder(true);

			fileUpload.setMaxFileLength(FILE_MAX_SIZE);
			fileUpload.setMaxTotalLength(FILE_MAX_SIZE_TOTAL);

			fileUpload.UploadStart(strPath + subDir);
			//getFileItemValues(uploadName)을 사용해서 중복된 모든 파일 아이템을 가져온다.
			FileItem[] value = fileUpload.getFileItemValues(uploadName);
			for (int j = 0; j < value.length; j++){
				if(value[j] != null){
					if(value[j].IsUploaded()){
						String originalFileName = FilenameUtils.getName(value[j].getFileName());
						String fileName = RandomStringUtils.randomAlphabetic(10) + System.currentTimeMillis() + "." + StringUtils.lowerCase(StringUtils.substringAfterLast(originalFileName, "."));
						value[j].SaveAs(strPath + subDir, fileName, true);
						String SavePath = value[j].getLastSavedFilePath();
						ImageTool image = ImageTool.getImageTool(new File(SavePath));
						int imageOrgWidth = image.getWidth();
						if(imageOrgWidth > imageMaxWidth){
				        	int imageOrgHeight = image.getHeight();
			            	imageOrgHeight = imageOrgHeight/(imageOrgWidth / imageMaxWidth);
							image.setSize(imageMaxWidth, imageOrgHeight);
							String[] aPaths = SavePath.split("[.]", 2);
							SavePath = aPaths[0] + "_" + imageMaxWidth + "." + aPaths[1];
							image.SaveImageToJPEG(SavePath);
						}
						String[] filePaths = SavePath.replaceAll("\\\\", "/").split(imageUploadPath);
						String filePath = imagesUploadUrl + filePaths[1];
						return3 = "&bNewLine=true&sFileName="+value[j].getFileName()+"&sFileURL="+filePath;
					}else{
						return3 = "&errstr=" + getMessage("fail.file.upload.msg");
					}
				}
			}
		}catch (DEXTUploadException duex) {
			return3 = "&errstr=" + duex.getMessage();
		}catch (Exception ex) {
			return3 = "&errstr=" + ex.getMessage();
		}finally {
			// 종료 시에 반드시 자원을 해제해야 한다.
			// 그렇지 않으면 임시 파일이 삭제되지 않고 남을 수 있다.
			try {
				fileUpload.dispose();
			} catch (IOException e) {
				logger.error("IOException ", e);
			} catch (DEXTUploadException e) {
				logger.error("DEXTUploadException ", e);
			}
		}
		Map<String, Object> params = fileUpload.getParameterMap();

		for (Entry<String, Object> entry : params.entrySet()) {
			String key = entry.getKey();
			if(key.equals(CALL_BACK)){
				String[] values = (String[]) entry.getValue();
				return1 = values[0];
			}else if(key.equals(CALLBACK_FUNC)){
				String[] values = (String[]) entry.getValue();
				return2 = "?" + CALLBACK_FUNC + "=" + values[0];
			}
		}
		return "redirect:" + return1 + return2 + return3;
	}
}
