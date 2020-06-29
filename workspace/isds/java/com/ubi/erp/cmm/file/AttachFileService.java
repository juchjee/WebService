package com.ubi.erp.cmm.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ubi.erp.cmm.util.JsonUtil;
import com.ubi.erp.cmm.util.PropertyUtil;
import com.ubi.erp.cmm.util.StringUtil;
import com.ubi.erp.cmm.util.UbiBizException;

@Service
public class AttachFileService {

	private AttachFileDao attachFileDao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		attachFileDao = sqlSession.getMapper(AttachFileDao.class);
	}

	public List<AttachFile> selAttachFileList(AttachFile attachFile) {
		return attachFileDao.selAttachFileList(attachFile);
	}

	public AttachFile getAttachFile(AttachFile attachFile) {
		return attachFileDao.getAttachFile(attachFile);
	}

	public String prcsAttachFile(String fileId, List<AttachFile> fileList) {
		if (!fileList.isEmpty()) {
			if ("".equals(fileId)) { // 기존 파일 아이디가 없는 경우 파일 마스터 추가
				fileId = UUID.randomUUID().toString();

				// 마스터 테이블 데이터 추가
				AttachFile attachFile = new AttachFile();
				attachFile.setFileId(fileId);
				attachFile.setCreator("");
				attachFile.setEditor("");
				attachFileDao.insAttachFileMt(attachFile);
			}

			// 첨부파일 갯수만큼 디테일 추가
			for (AttachFile attachFile : fileList) {
				attachFile.setFileId(fileId);
				attachFile.setCreator("");
				attachFile.setEditor("");
				attachFileDao.insAttachFileDt(attachFile);
			}
		}

		return fileId;
	}

	public void deleteAttachFile(AttachFile attachFile) {
		List<AttachFile> targetList = selAttachFileList(attachFile);

		for (AttachFile target : targetList) {
			deleteAttachFilePath(target);
		}

		attachFileDao.delAttachFileDt(attachFile);
		attachFileDao.delAttachFileMt(attachFile);
	}

	public void deleteAttachFilePath(AttachFile attachFile) {
		File targetFile = new File(PropertyUtil.getString("attach.basedir") + attachFile.getFilePath());
		targetFile.delete();
	}

	public List<AttachFile> uploadAttachFile(String saveDir, HttpServletRequest request, HttpServletResponse response) throws IOException {
		File uploadDir = new File(saveDir);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		ArrayList<AttachFile> list = new ArrayList<AttachFile>();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultiValueMap<String, MultipartFile> multiValueMap = multipartRequest.getMultiFileMap();

		List<MultipartFile> files = multiValueMap.get("attachFile");
		for (MultipartFile file : files) {
			if (!file.isEmpty()) {
				fileFunc(saveDir, list, file);
			}
		}
		return list;
	}

	public void fileFunc(String saveDir, List<AttachFile> list, MultipartFile file) throws IOException {
		long limitSize = Long.parseLong(PropertyUtil.getString("attach.uploadSize"));

		if (limitSize > file.getSize()) {
			String fileName = file.getOriginalFilename();
			String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
			String onlyName = fileName.substring(0, fileName.lastIndexOf("."));
			String saveFilename = fileName;

			// 파일명이 중복되는 경우 변경처리
			if (new File(saveDir + "/" + fileName).exists()) {
				int fileSeq = 1;
				while (isFileExists(saveDir, onlyName, fileSeq, ext)) {
					fileSeq++;
				}
				saveFilename = onlyName + "_" + fileSeq + "." + ext;
			}

			// 실제 파일 업로드
			file.transferTo(new File(saveDir + "/" + saveFilename));

			AttachFile attachFile = new AttachFile();
			attachFile.setFileOrgNm(fileName);
			attachFile.setFileSaveNm(saveFilename);
			attachFile.setFileSize("" + file.getSize());
			attachFile.setFilePath(saveDir.replaceAll(PropertyUtil.getString("attach.basedir"), "") + "/" + saveFilename);
			attachFile.setFileExt(ext);
			list.add(attachFile);
		} else {
			throw new UbiBizException("파일업로드 용량초과");
		}
	}

	public void uploadFile(String saveDir, String realFileName, MultipartFile file) throws IOException {
		File uploadDir = new File(saveDir);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		long limitSize = Long.parseLong(PropertyUtil.getString("attach.uploadSize"));

		if (limitSize > file.getSize()) {
			file.transferTo(new File(saveDir + "/" + realFileName));
		} else {
			throw new UbiBizException("파일업로드 용량초과");
		}
	}

	public boolean isFileExists(String saveDir, String onlyName, int fileSeq, String ext) {
		return new File(saveDir + "/" + onlyName + "_" + (fileSeq) + "." + ext).exists();
	}

	public TempData getNextTempData(String fmtId) {
		return attachFileDao.getNextTempData(fmtId);
	}

	public void insTempData(List<TempData> list) {
		for (TempData tempData : list) {
			attachFileDao.insTempData(tempData);
		}
	}

	public String fileSeq() {
		return attachFileDao.fileSeq();
	}

	public void deleteFile(String filePath, String fileName) {
		File deleteFile = new File(filePath, fileName);
		if (deleteFile.exists()) {
			deleteFile.delete();
		}
	}

	public Map<String, Object> excelUpload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String assignFilename = null;
		String assignFilePath = null;
		String jsonData = null;
		Map<String, Object> map = new HashMap<String, Object>();

		List<AttachFile> uploadFileList = this.uploadAttachFile(PropertyUtil.getString("attach.excel.tmpdir"), request, response);
		if (!uploadFileList.isEmpty()) {
			for (AttachFile file : uploadFileList) {
				assignFilePath = PropertyUtil.getString("attach.excel.tmpdir") + "/" + file.getFileSaveNm();
				assignFilename = file.getFileOrgNm();
			}
		}
		if (assignFilename.contains(".xlsx")) {
			map = xlsxUpload(assignFilePath, assignFilename, jsonData, uploadFileList);
			return map;
		} else {
			map = xlsUpload(assignFilePath, assignFilename, jsonData, uploadFileList);
			return map;
		}
	}

	@SuppressWarnings("unused")
	public Map<String, Object> xlsUpload(String assignFilePath, String assignFilename, String jsonData, List<AttachFile> uploadFileList) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			HSSFWorkbook wb = null;
			try {
				wb = new HSSFWorkbook(new FileInputStream(assignFilePath));
			} catch (FileNotFoundException fe) {
				fe.printStackTrace();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
			HSSFSheet sheet = wb.getSheetAt(0);

			int xlsRows = sheet.getPhysicalNumberOfRows(); // 엑셀파일의 데이터 행의 갯수 추출
			int xlsClms = 0; // 엑셀파일의 사용 컬럼 갯수 추출

			{
				// 헤더에서 값이 있는 컬럼까지만 데이터 조회
				HSSFRow row = sheet.getRow(0);
				HSSFCell cell = null;
				String value = "";

				int tmpXlsClms = row.getPhysicalNumberOfCells();
				for (int cntCol = 0; cntCol < tmpXlsClms; cntCol++) {
					cell = row.getCell(cntCol);
					value = "";

					try {
						switch (cell.getCellType()) {
						case 0: {
							value = "" + cell.getNumericCellValue();
							break;
						}
						case 1: {
							value = cell.getStringCellValue();
							break;
						}
						case 2: {
							value = "" + cell.getNumericCellValue();
							break;
						}
						default: {
							value = "";
							break;
						}
						}
					} catch (Exception e) {
						e.printStackTrace();
						value = "";
					}

					xlsClms++;
				}
			}

			String fmtId = assignFilename.substring(0, 4);
			int regIdx = this.getNextTempData(fmtId).getRegIdx();

			// 임시 데이터 셋팅
			List<TempData> tempDataList = new ArrayList<TempData>();
			List<Map<String, Object>> tmpList = new ArrayList<Map<String, Object>>();
			Map<String, Object> tmp = new HashMap<String, Object>();

			// 시트 읽기
			HSSFRow row = null;
			HSSFCell cell = null;
			String value = null;
			int columnValueCnt = 0;

			for (int cntRow = 1; cntRow < xlsRows; cntRow++) { // 0번째 행은 헤더이므로
																// 제외하고
																// 1부터
				tmp = new HashMap<String, Object>();

				// 엑셀의 행을 읽어오고, 해당 행의 열을 읽어서 값을 저장
				row = sheet.getRow(cntRow);
				columnValueCnt = 0;

				for (int cntCol = 0; cntCol < xlsClms; cntCol++) {
					cell = row.getCell(cntCol);
					value = "";
					if (cell != null) {
						try {
							switch (cell.getCellType()) {
							case 0: {
								value = "" + cell.getNumericCellValue();
								break;
							}
							case 1: {
								value = cell.getStringCellValue();
								break;
							}
							case 2: {
								value = "" + cell.getNumericCellValue();
								break;
							}
							default: {
								value = "";
								break;
							}
							}
						} catch (Exception e) {
							e.printStackTrace();
							value = "";
						}
					}

					tmp.put("clm" + (cntCol + 1), value);

					if (!"".equals(StringUtil.initStr(value, ""))) {
						columnValueCnt++;
					}
				}

				tmp.put("fmtId", fmtId);
				tmp.put("regIdx", regIdx);
				tmp.put("rowIdx", cntRow);

				if (columnValueCnt > 0) {
					tmpList.add(tmp);
				}
			}

			jsonData = new String(JsonUtil.parseToString(tmpList));
			ObjectMapper mapper = new ObjectMapper();
			tempDataList = mapper.readValue(jsonData, new TypeReference<ArrayList<TempData>>() {
			});

			this.insTempData(tempDataList); // 데이터 저장

			// 해당 첨부파일 삭제
			for (AttachFile file : uploadFileList) {
				this.deleteAttachFilePath(file);
			}

			map.put("V_FMT_ID", fmtId);
			map.put("V_REG_IDX", regIdx);
			map.put("columnCnt", columnValueCnt);

		} catch (JsonMappingException e) {
			Log.debug("jsonME:" + e);
		} catch (JsonParseException e) {
			Log.debug("jsonPE:" + e);
		} catch (FileNotFoundException e) {
			Log.debug("fileNFE:" + e);
		} catch (IOException e) {
			Log.debug("ioe:" + e);
		} catch (Exception e) {
			Log.debug("ex:" + e);
		}
		return map;
	}

	@SuppressWarnings("unused")
	public Map<String, Object> xlsxUpload(String assignFilePath, String assignFilename, String jsonData, List<AttachFile> uploadFileList) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			XSSFWorkbook wb = null;
			try {
				wb = new XSSFWorkbook(new FileInputStream(assignFilePath));
			} catch (FileNotFoundException fe) {
				fe.printStackTrace();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
			XSSFSheet sheet = wb.getSheetAt(0);

			int xlsRows = sheet.getPhysicalNumberOfRows(); // 엑셀파일의 데이터 행의 갯수 추출
			int xlsClms = 0; // 엑셀파일의 사용 컬럼 갯수 추출

			{
				// 헤더에서 값이 있는 컬럼까지만 데이터 조회
				XSSFRow row = sheet.getRow(0);
				XSSFCell cell = null;
				String value = "";

				int tmpXlsClms = row.getPhysicalNumberOfCells();
				for (int cntCol = 0; cntCol < tmpXlsClms; cntCol++) {
					cell = row.getCell(cntCol);
					value = "";

					try {
						switch (cell.getCellType()) {
						case 0: {
							value = "" + cell.getNumericCellValue();
							break;
						}
						case 1: {
							value = cell.getStringCellValue();
							break;
						}
						case 2: {
							value = "" + cell.getNumericCellValue();
							break;
						}
						default: {
							value = "";
							break;
						}
						}
					} catch (Exception e) {
						e.printStackTrace();
						value = "";
					}

					xlsClms++;
				}
			}

			String fmtId = assignFilename.substring(0, 4);
			int regIdx = this.getNextTempData(fmtId).getRegIdx();

			// 임시 데이터 셋팅
			List<TempData> tempDataList = new ArrayList<TempData>();
			List<Map<String, Object>> tmpList = new ArrayList<Map<String, Object>>();
			Map<String, Object> tmp = new HashMap<String, Object>();

			// 시트 읽기
			XSSFRow row = null;
			XSSFCell cell = null;
			String value = null;
			int columnValueCnt = 0;

			for (int cntRow = 1; cntRow < xlsRows; cntRow++) { // 0번째 행은 헤더이므로
																// 제외하고
																// 1부터
				tmp = new HashMap<String, Object>();

				// 엑셀의 행을 읽어오고, 해당 행의 열을 읽어서 값을 저장
				row = sheet.getRow(cntRow);
				columnValueCnt = 0;

				for (int cntCol = 0; cntCol < xlsClms; cntCol++) {
					cell = row.getCell(cntCol);
					value = "";
					if (cell != null) {
						try {
							switch (cell.getCellType()) {
							case 0: {
								value = "" + cell.getNumericCellValue();
								break;
							}
							case 1: {
								value = cell.getStringCellValue();
								break;
							}
							case 2: {
								value = "" + cell.getNumericCellValue();
								break;
							}
							default: {
								value = "";
								break;
							}
							}
						} catch (Exception e) {
							e.printStackTrace();
							value = "";
						}
					}

					tmp.put("clm" + (cntCol + 1), value);

					if (!"".equals(StringUtil.initStr(value, ""))) {
						columnValueCnt++;
					}
				}

				tmp.put("fmtId", fmtId);
				tmp.put("regIdx", regIdx);
				tmp.put("rowIdx", cntRow);

				if (columnValueCnt > 0) {
					tmpList.add(tmp);
				}
			}

			jsonData = new String(JsonUtil.parseToString(tmpList));
			ObjectMapper mapper = new ObjectMapper();
			tempDataList = mapper.readValue(jsonData, new TypeReference<ArrayList<TempData>>() {
			});

			this.insTempData(tempDataList); // 데이터 저장

			// 해당 첨부파일 삭제
			for (AttachFile file : uploadFileList) {
				this.deleteAttachFilePath(file);
			}

			map.put("V_FMT_ID", fmtId);
			map.put("V_REG_IDX", regIdx);
			map.put("columnCnt", columnValueCnt);

		} catch (JsonMappingException e) {
			Log.debug("jsonME:" + e);
		} catch (JsonParseException e) {
			Log.debug("jsonPE:" + e);
		} catch (FileNotFoundException e) {
			Log.debug("fileNFE:" + e);
		} catch (IOException e) {
			Log.debug("ioe:" + e);
		} catch (Exception e) {
			Log.debug("ex:" + e);
		}

		return map;
	}

	public List<TempData> tempExcelData(TempData tempData) {
		return attachFileDao.tempExcelData(tempData);
	}

	public void deleteTempExcelData(TempData tempData) {
		attachFileDao.deleteTempExcelData(tempData);
	}
}