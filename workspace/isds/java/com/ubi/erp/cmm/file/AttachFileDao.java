package com.ubi.erp.cmm.file;

import java.util.List;

import org.apache.ibatis.annotations.Param;


public interface AttachFileDao
{
	List<AttachFile> selAttachFileList(AttachFile attachFile);

	AttachFile getAttachFile(AttachFile attachFile);
	
	void insAttachFileMt(AttachFile attachFile);

	void insAttachFileDt(AttachFile attachFile);

	void delAttachFileMt(AttachFile attachFile);

	void delAttachFileDt(AttachFile attachFile);

	TempData getNextTempData(@Param("fmtId") String fmtId);

	void insTempData(TempData tempData);
	
	String fileSeq();

	List<TempData> tempExcelData(TempData tempData);

	void deleteTempExcelData(TempData tempData);
}