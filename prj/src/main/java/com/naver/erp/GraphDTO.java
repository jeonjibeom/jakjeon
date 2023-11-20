package com.naver.erp;

import lombok.Data;

@Data
public class GraphDTO {

	private String keyword ="삼성전자";
	private String recentKeyword;

	
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getRecentKeyword() {
		return recentKeyword;
	}

	public void setRecentKeyword(String recentKeyword) {
		this.recentKeyword = recentKeyword;
	}
	
	

	
}
