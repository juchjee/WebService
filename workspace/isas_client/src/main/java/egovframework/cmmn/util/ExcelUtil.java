package egovframework.cmmn.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFCreationHelper;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;

/**
 * 엑셀파일 생성
 * @author vary
 *
 */
@SuppressWarnings("deprecation")
public class ExcelUtil {

	private HSSFWorkbook wb = new HSSFWorkbook();
	private HSSFSheet sheet = null;
	private String title = "";
	private String[] header = null;
	private String[] colNames = null;
	private int[] colTypesI = null;
	private boolean[] colTypesB = null;// number : true, date : false, 그외 null
	private int cellCount = 0;//컬럼 갯수
	private int rows = 0;
	private List<int[]> mergedRegionList = new ArrayList<int[]>();

	public ExcelUtil(String title, String[] header, String[] colNames, String[] colTypes){
		int headerCnt = header.length;
		int colNamesCnt = colNames.length;
		this.title = title;
		this.colNames = colNames;
		this.colTypesI = new int[colNamesCnt];
		this.colTypesB =  new boolean[colNamesCnt];
		if(colTypes != null && colTypes.length == colNamesCnt){
			for (int i = 0; i < colNamesCnt; i++) {
				String type = colTypes[i].toLowerCase();
				if("number".indexOf(type) > -1 || "int".indexOf(type) > -1 || "float".indexOf(type) > -1){
					this.colTypesI[i] = Cell.CELL_TYPE_NUMERIC;
					this.colTypesB[i] = true;
				}else if("bool".indexOf(type) > -1){
					this.colTypesI[i] = Cell.CELL_TYPE_BOOLEAN;
				}else if("date".indexOf(type) > -1){
					this.colTypesI[i] = Cell.CELL_TYPE_NUMERIC;
					this.colTypesB[i] = false;
				}else{
					this.colTypesI[i] = Cell.CELL_TYPE_STRING;
				}
			}
		}
		if(headerCnt != colNamesCnt && headerCnt < colNamesCnt){
			cellCount = colNamesCnt;
			this.header = new String[colNamesCnt];
			for (int i = 0; i < colNamesCnt; i++) {
				if(i < headerCnt){
					this.header[i] = header[i];
				}else{
					this.header[i] = colNames[i];
				}
			}
		}else{
			cellCount = headerCnt;
			this.header = header;
		}
		//쉬트 및 폰트 지정
		this.sheet = this.wb.createSheet();
		this.sheet.setGridsPrinted(true);
		this.sheet.setFitToPage(true);
		this.sheet.setDisplayGuts(true);
		//쉬트 이름 주기
		this.wb.setSheetName(0, title);
	}

	public void createTitle(){
		this.addRow();
		//타이틀 라인 구성
		HSSFCellStyle titleCellStyle = getStyle("title", wb, true);
		HSSFRow titleRow = this.sheet.createRow(this.rows);
		HSSFCell cell = null;
		for (int i = 0; i < cellCount; i++) {
			cell = titleRow.createCell(i);
			if(i == 0) cell.setCellValue(title);
			else cell.setCellValue("");
			cell.setCellStyle(titleCellStyle);
		}
		this.mergedRegionList.add(new int[]{this.rows, this.rows++, 0, cellCount - 1});
	}

	public void createHeader(){
		this.addRow();
		// 제목 라인 구성
		//HSSFCellStyle headerCellStyle = getStyle("header", wb);
		HSSFCellStyle headerCellStyleBold = getStyle("header", wb, true);
		// 제목들
		HSSFRow headerRow = this.sheet.createRow(this.rows++);
		HSSFCell cell = null;
		for (int i = 0; i < cellCount; i++) {
			cell = headerRow.createCell(i);
			cell.setCellValue(header[i]);
			cell.setCellStyle(headerCellStyleBold);
			/*if(header[i].indexOf("<strong>") == -1){
				cell.setCellValue(header[i]);
				cell.setCellStyle(headerCellStyle);
			}else{
				cell.setCellValue(header[i].replaceAll("<strong>", "").replaceAll("</strong>", ""));
				cell.setCellStyle(headerCellStyleBold);
			}*/
		}
	}
	public void createContent(String[] contents, String[] cellSaligns, String[] cellsFormats) throws Exception {
		// 내용 라인 구성
		Map<String, HSSFCellStyle> stylesMap = new HashMap<String, HSSFCellStyle>();
		stylesMap.put("center", getStyle("content", wb));
		stylesMap.put("left", getStyle("textLeft", wb));
		stylesMap.put("right", getStyle("textRight", wb));
		HSSFCell cell = null;
		HSSFRow row = null;
		if(contents.length > 0){
			for (int i = 0, h = contents.length, k = this.colNames.length; i < h; i++) {
				row = this.sheet.createRow(this.rows);
				String[] tempItem = contents[i].split("▤", k);
				for (int j = 0; j < k; j++) {
					cell = row.createCell(j);
					if(!"".equals(tempItem[j]) && this.colTypesI[j] == Cell.CELL_TYPE_NUMERIC){
						if(this.colTypesB[j]){
							cell.setCellType(this.colTypesI[j]);
							cell.setCellValue(CommonUtil.nvlDouble(tempItem[j]));
							cell.setCellStyle(stylesMap.get(cellSaligns[j]));
						}else{
							if(!"".equals(cellsFormats[j])){
								HSSFCellStyle cellStyle = stylesMap.get(cellSaligns[j]);
								HSSFCreationHelper createHelper = wb.getCreationHelper();
								cellStyle.setDataFormat(createHelper.createDataFormat().getFormat(cellsFormats[j]));
								Date date = CommonUtil.toDate(tempItem[j], cellsFormats[j], new Date());
								cell.setCellValue(date);
								cell.setCellStyle(cellStyle);
							}else{
								cell.setCellType(this.colTypesI[j]);
								cell.setCellValue(tempItem[j]);
								cell.setCellStyle(stylesMap.get(cellSaligns[j]));
							}
						}
					}else{
						cell.setCellType(this.colTypesI[j]);
						cell.setCellValue(tempItem[j]);
						cell.setCellStyle(stylesMap.get(cellSaligns[j]));
					}
				}
				++this.rows;
			}
		}
	}

	public void outExcel(HttpServletResponse response) throws Exception{
		// autuSizeColumn after setColumnWidth setting!!
		for (int i = 0; i < cellCount; i++) {
			this.sheet.autoSizeColumn(i);
			int size = (this.sheet.getColumnWidth(i));
			if(size > 30000) this.sheet.setColumnWidth(i, 30000);
			else this.sheet.setColumnWidth(i, size + 512);
		}
		if(CommonUtil.getSize(this.mergedRegionList) > 0){
			for (int[] mergedDatas : this.mergedRegionList) {
				this.sheet.addMergedRegion(new CellRangeAddress(mergedDatas[0], mergedDatas[1], mergedDatas[2], mergedDatas[3]));
			}
		}
		response.setContentType("application/vnd.ms-excel;charset=utf-8");
		response.setHeader("Content-Disposition", "attachment;filename=" + new String((title).getBytes("KSC5601"), "8859_1") + "_" + new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new Date()) + ".xls");
		wb.write(response.getOutputStream());
	}

	public void addRow(){
		this.sheet.createRow(this.rows);//여백 한줄
		this.mergedRegionList.add(new int[]{this.rows, this.rows++, 0, cellCount - 1});
	}

	private HSSFCellStyle getStyle(String name, HSSFWorkbook wb) {
		return getStyle(name, wb, false);
	}

	private HSSFCellStyle getStyle(String name, HSSFWorkbook wb, boolean isBold) {
		HSSFCellStyle cellStyle = wb.createCellStyle();
		if("title".equals(name)){
			cellStyle.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE);
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		}else{
			cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			if("header".equals(name)){
				cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
				cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			}else{
				cellStyle.setFillForegroundColor(HSSFColor.WHITE.index);
				cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				if("content".equals(name)){
					cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				}else if("textLeft".equals(name)){
					cellStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				}else if("textRight".equals(name)){
					cellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				}
				cellStyle.setWrapText(true);
			}
		}
		if(isBold){
			HSSFFont font = wb.createFont();
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			cellStyle.setFont(font);
		}
		return cellStyle;
	}

}
