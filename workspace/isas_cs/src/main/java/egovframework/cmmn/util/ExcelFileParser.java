package egovframework.cmmn.util;

import java.io.FileInputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 엑셀파일 파싱
 * xls / xlsx 파일을 파싱해서 리스트 <맵> 형태로 만든다.
 * @author vary
 *
 */
public class ExcelFileParser {

	protected static final Logger logger = LoggerFactory.getLogger(ExcelFileParser.class);

	private Map<String, Object> params = null;
	private String uploadName = null;

	public ExcelFileParser(Map<String, Object> paramMap, String uploadName){
		this.params = paramMap;
		this.uploadName = uploadName;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, List<?>>> xmlParsing() throws Exception{
		List<Map<String, String>> fileList = (List<Map<String, String>>)params.get(uploadName + "List");
		List<Map<String, List<?>>> reXmlList = new ArrayList<Map<String, List<?>>>();//시트갯수만큼의 리스트에 헤드와 컨텐스를 담아서 리턴
		Workbook workbook = null;
		// 반드시 파일업로드 이후에 실행 되어야 함(setAttachFlieUpload 메소드 호출 후)
		FileInputStream inputStream = null;
		for(Map<String, String> filePath : fileList){
			try{
				inputStream = new FileInputStream(filePath.get("aPath"));
				workbook = WorkbookFactory.create(inputStream);
				int sheetCnt = workbook.getNumberOfSheets();
				loggerInfo("시트수 : " + sheetCnt);
				for(int sIdx = 0; sIdx < sheetCnt; sIdx++){
					// sheet 정보 취득
					reXmlList.add(getSheetToMap(workbook.getSheetAt(sIdx)));
				}
			}catch(Exception ex){
				loggererror("Exception", ex);
				throw ex;
			} finally {
				try {
					if(inputStream != null){
						inputStream.close();
						inputStream = null;
					}
				} catch (Exception ex) {
					loggererror("Exception", ex);
					throw ex;
				}
			}
		}
		return reXmlList;
	}

	protected Map<String, List<?>> getSheetToMap(Sheet sheet){
		Map<String, List<?>> sheetMap = new HashMap<>();
		// sheet에서 rows수 취득
		int rowCnt = sheet.getPhysicalNumberOfRows();
		// sheet에서 column명 취득
		if(rowCnt > 0){
			List<String> colNames = new ArrayList<>();//head name
			int cellCnt = sheet.getRow(0).getPhysicalNumberOfCells();
			for(int cIdx = 0; cIdx < cellCnt; cIdx++){
				colNames.add(sheet.getRow(0).getCell(cIdx).getStringCellValue());
			}
			sheetMap.put("head", colNames);
			List<Map<String, Object>> rowList = new ArrayList<Map<String, Object>>();
			for(int rIdx = 1; rIdx < rowCnt; rIdx ++){
				Row row = sheet.getRow(rIdx);
				if(row != null){
					rowList.add(getRowToMap(row, cellCnt, colNames));
				}
			}
			sheetMap.put("content", rowList);
		}
		return sheetMap;
	}

	protected Map<String, Object> getRowToMap(Row row, int cellCnt, List<String> colNames){
		Map<String, Object> reRowMap = new HashMap<>();
		Cell cell = null;
		for(int cIdx = 0; cIdx < cellCnt; cIdx++){
			cell = row.getCell(cIdx);
			String value = null;
			if(cell != null){
				if(cell.getCellType() == XSSFCell.CELL_TYPE_FORMULA){//수식
					value = cell.getCellFormula();
				}else if(cell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN){
					value = "" + cell.getBooleanCellValue();
				}else if(cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC){
					if(HSSFDateUtil.isCellDateFormatted(cell)){
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						value = formatter.format(cell.getDateCellValue());
					}else{
						DecimalFormat df = new DecimalFormat("####.##");
						value = df.format(cell.getNumericCellValue());
					}
				}else if(cell.getCellType() == XSSFCell.CELL_TYPE_STRING){
					value = cell.getStringCellValue();
				}else if(cell.getCellType() == XSSFCell.CELL_TYPE_BLANK){
					value = null;
				}else if(cell.getCellType() == XSSFCell.CELL_TYPE_ERROR){
					value = "" + cell.getErrorCellValue();
				}else {
					value = cell.getStringCellValue();
				}
			}
			reRowMap.put(colNames.get(cIdx), value);
		}
		return reRowMap;
	}

	protected void loggererror(String masseg, Object exception){
		logger.error(masseg, exception);
	}

	protected void loggerInfo(String masseg){
		logger.info(masseg);
	}
}
