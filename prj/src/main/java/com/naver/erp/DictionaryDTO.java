package com.naver.erp;

import lombok.Data;

@Data
public class DictionaryDTO {

	
	private String STOCK_DIC_NAME;
	private String STOCK_DIC;
	private String keyword;
	
	private int selectPageNo;
	private int rowCntPerPage;
	private int begin_rowNo;
	private int end_rowNo;
	
	
	
	public String getSTOCK_DIC_NAME() {
		return STOCK_DIC_NAME;
	}
	public void setSTOCK_DIC_NAME(String sTOCK_DIC_NAME) {
		STOCK_DIC_NAME = sTOCK_DIC_NAME;
	}
	public String getSTOCK_DIC() {
		return STOCK_DIC;
	}
	public void setSTOCK_DIC(String sTOCK_DIC) {
		STOCK_DIC = sTOCK_DIC;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	public int getBegin_rowNo() {
		return begin_rowNo;
	}
	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}
	public int getEnd_rowNo() {
		return end_rowNo;
	}
	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}
	
	
	
	
}
